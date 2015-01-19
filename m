From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 10/18] ALSA: asihpi: Use setup_timer() and
	mod_timer()
Date: Mon, 19 Jan 2015 12:11:23 +0100
Message-ID: <1421665891-14475-11-git-send-email-tiwai@suse.de>
References: <1421665891-14475-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 724152606FE
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 12:11:37 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 3BCCAADB2
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 11:11:36 +0000 (UTC)
In-Reply-To: <1421665891-14475-1-git-send-email-tiwai@suse.de>
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

No functional change, refactoring with the standard helpers.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/asihpi/asihpi.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index 7a55fefed5c4..e5cd7be85355 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -540,9 +540,8 @@ static void snd_card_asihpi_pcm_timer_start(struct snd_pcm_substream *
 	expiry = HZ / 200;
 
 	expiry = max(expiry, 1); /* don't let it be zero! */
-	dpcm->timer.expires = jiffies + expiry;
+	mod_timer(&dpcm->timer, jiffies + expiry);
 	dpcm->respawn_timer = 1;
-	add_timer(&dpcm->timer);
 }
 
 static void snd_card_asihpi_pcm_timer_stop(struct snd_pcm_substream *substream)
@@ -1064,9 +1063,8 @@ static int snd_card_asihpi_playback_open(struct snd_pcm_substream *substream)
 	    If internal and other stream playing, can't switch
 	*/
 
-	init_timer(&dpcm->timer);
-	dpcm->timer.data = (unsigned long) dpcm;
-	dpcm->timer.function = snd_card_asihpi_timer_function;
+	setup_timer(&dpcm->timer, snd_card_asihpi_timer_function,
+		    (unsigned long) dpcm);
 	dpcm->substream = substream;
 	runtime->private_data = dpcm;
 	runtime->private_free = snd_card_asihpi_runtime_free;
@@ -1246,9 +1244,8 @@ static int snd_card_asihpi_capture_open(struct snd_pcm_substream *substream)
 	if (err)
 		return -EIO;
 
-	init_timer(&dpcm->timer);
-	dpcm->timer.data = (unsigned long) dpcm;
-	dpcm->timer.function = snd_card_asihpi_timer_function;
+	setup_timer(&dpcm->timer, snd_card_asihpi_timer_function,
+		    (unsigned long) dpcm);
 	dpcm->substream = substream;
 	runtime->private_data = dpcm;
 	runtime->private_free = snd_card_asihpi_runtime_free;
-- 
2.2.1
