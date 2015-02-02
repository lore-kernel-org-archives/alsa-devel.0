From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 08/14] ALSA: rawmidi: Use rawmidi device file
	for kernel messages
Date: Mon,  2 Feb 2015 11:24:32 +0100
Message-ID: <1422872678-4815-9-git-send-email-tiwai@suse.de>
References: <1422872678-4815-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6EC6A2604F4
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 11:24:41 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E523BAD30
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 10:24:39 +0000 (UTC)
In-Reply-To: <1422872678-4815-1-git-send-email-tiwai@suse.de>
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

... instead of card's device.  This will be helpful to distinguish
errors from multiple rawmidi devices on a single card.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/rawmidi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index 932396c81035..bccbf7e375d6 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -57,11 +57,11 @@ static LIST_HEAD(snd_rawmidi_devices);
 static DEFINE_MUTEX(register_mutex);
 
 #define rmidi_err(rmidi, fmt, args...) \
-	dev_err((rmidi)->card->dev, fmt, ##args)
+	dev_err(&(rmidi)->dev, fmt, ##args)
 #define rmidi_warn(rmidi, fmt, args...) \
-	dev_warn((rmidi)->card->dev, fmt, ##args)
+	dev_warn(&(rmidi)->dev, fmt, ##args)
 #define rmidi_dbg(rmidi, fmt, args...) \
-	dev_dbg((rmidi)->card->dev, fmt, ##args)
+	dev_dbg(&(rmidi)->dev, fmt, ##args)
 
 static struct snd_rawmidi *snd_rawmidi_search(struct snd_card *card, int device)
 {
-- 
2.2.2
