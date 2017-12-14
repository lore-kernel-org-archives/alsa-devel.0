From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: rawmidi: Avoid racy info ioctl via ctl
	device
Date: Thu, 14 Dec 2017 16:52:15 +0100
Message-ID: <20171214155215.22116-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 87C35267ADD
 for <alsa-devel@alsa-project.org>; Thu, 14 Dec 2017 16:52:18 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 06C3EAEAC
 for <alsa-devel@alsa-project.org>; Thu, 14 Dec 2017 15:52:18 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The rawmidi also allows to obtaining the information via ioctl of ctl
API.  It means that user can issue an ioctl to the rawmidi device even
when it's being removed as long as the control device is present.
Although the code has some protection via the global register_mutex,
its range is limited to the search of the corresponding rawmidi
object, and the mutex is already unlocked at accessing the rawmidi
object.  This may lead to a use-after-free.

For avoiding it, this patch widens the application of register_mutex
to the whole snd_rawmidi_info_select() function.  We have another
mutex per rawmidi object, but this operation isn't very hot path, so
it shouldn't matter from the performance POV.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/rawmidi.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index b3b353d72527..f055ca10bbc1 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -579,15 +579,14 @@ static int snd_rawmidi_info_user(struct snd_rawmidi_substream *substream,
 	return 0;
 }
 
-int snd_rawmidi_info_select(struct snd_card *card, struct snd_rawmidi_info *info)
+static int __snd_rawmidi_info_select(struct snd_card *card,
+				     struct snd_rawmidi_info *info)
 {
 	struct snd_rawmidi *rmidi;
 	struct snd_rawmidi_str *pstr;
 	struct snd_rawmidi_substream *substream;
 
-	mutex_lock(&register_mutex);
 	rmidi = snd_rawmidi_search(card, info->device);
-	mutex_unlock(&register_mutex);
 	if (!rmidi)
 		return -ENXIO;
 	if (info->stream < 0 || info->stream > 1)
@@ -603,6 +602,16 @@ int snd_rawmidi_info_select(struct snd_card *card, struct snd_rawmidi_info *info
 	}
 	return -ENXIO;
 }
+
+int snd_rawmidi_info_select(struct snd_card *card, struct snd_rawmidi_info *info)
+{
+	int ret;
+
+	mutex_lock(&register_mutex);
+	ret = __snd_rawmidi_info_select(card, info);
+	mutex_unlock(&register_mutex);
+	return ret;
+}
 EXPORT_SYMBOL(snd_rawmidi_info_select);
 
 static int snd_rawmidi_info_select_user(struct snd_card *card,
-- 
2.15.1
