From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Subject: [PATCH] sound: pci: rme9652: Unneeded variable: "result".
Date: Thu, 11 Jul 2019 22:51:07 +0530
Message-ID: <20190711172107.GA5008@hari-Inspiron-1545>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Hariprasad Kelam <hariprasad.kelam@gmail.com>, Richard Fontana <rfontana@redhat.com>, Allison Randal <allison@lohutok.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch fixes below issue reported by coccicheck

sound/pci/rme9652/rme9652.c:2161:5-11: Unneeded variable: "result".
Return "0" on line 2167

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 sound/pci/rme9652/rme9652.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/rme9652/rme9652.c b/sound/pci/rme9652/rme9652.c
index cb9818a..4c851f8 100644
--- a/sound/pci/rme9652/rme9652.c
+++ b/sound/pci/rme9652/rme9652.c
@@ -2158,13 +2158,12 @@ static int snd_rme9652_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_rme9652 *rme9652 = snd_pcm_substream_chip(substream);
 	unsigned long flags;
-	int result = 0;
 
 	spin_lock_irqsave(&rme9652->lock, flags);
 	if (!rme9652->running)
 		rme9652_reset_hw_pointer(rme9652);
 	spin_unlock_irqrestore(&rme9652->lock, flags);
-	return result;
+	return 0;
 }
 
 static const struct snd_pcm_hardware snd_rme9652_playback_subinfo =
-- 
2.7.4
