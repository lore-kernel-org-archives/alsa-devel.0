From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/1] SOUND: azt3328, fix broken AZF_FMT_XLATE macro
Date: Sat, 22 Jan 2011 14:56:10 +0100
Message-ID: <1295704570-27015-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.de
Cc: jirislaby@gmail.com, perex@perex.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Andreas Mohr <andi@lisas.de>
List-Id: alsa-devel@alsa-project.org

Despite the AZF_FMT_XLATE macro looks totally weird and useless, it's
heavily broken (apart it also broke my parser).

The 'break' in the macro belongs to the do-while loop and not to the
switch. So it always falls through the all cases till the end.

Remove the do-while from the macro.

Also people should terminate statements with semicolons. So force
people to do so by removing the last one in the macro.

I vote for removing that crap completely because it makes the code
weird anyway -- you have to specify manually both of freq and bits
which is I would expect to be avoided exactly by such a macro.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Andreas Mohr <andi@lisas.de>
Cc: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/azt3328.c |   32 +++++++++++++++-----------------
 1 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/sound/pci/azt3328.c b/sound/pci/azt3328.c
index 6117595..134f55f 100644
--- a/sound/pci/azt3328.c
+++ b/sound/pci/azt3328.c
@@ -980,29 +980,27 @@ snd_azf3328_codec_setfmt(struct snd_azf3328_codec_data *codec,
 	snd_azf3328_dbgcallenter();
 	switch (bitrate) {
 #define AZF_FMT_XLATE(in_freq, out_bits) \
-	do { \
 		case AZF_FREQ_ ## in_freq: \
 			freq = SOUNDFORMAT_FREQ_ ## out_bits; \
-			break; \
-	} while (0);
-	AZF_FMT_XLATE(4000, SUSPECTED_4000)
-	AZF_FMT_XLATE(4800, SUSPECTED_4800)
+			break
+	AZF_FMT_XLATE(4000, SUSPECTED_4000);
+	AZF_FMT_XLATE(4800, SUSPECTED_4800);
 	/* the AZF3328 names it "5510" for some strange reason: */
-	AZF_FMT_XLATE(5512, 5510)
-	AZF_FMT_XLATE(6620, 6620)
-	AZF_FMT_XLATE(8000, 8000)
-	AZF_FMT_XLATE(9600, 9600)
-	AZF_FMT_XLATE(11025, 11025)
-	AZF_FMT_XLATE(13240, SUSPECTED_13240)
-	AZF_FMT_XLATE(16000, 16000)
-	AZF_FMT_XLATE(22050, 22050)
-	AZF_FMT_XLATE(32000, 32000)
+	AZF_FMT_XLATE(5512, 5510);
+	AZF_FMT_XLATE(6620, 6620);
+	AZF_FMT_XLATE(8000, 8000);
+	AZF_FMT_XLATE(9600, 9600);
+	AZF_FMT_XLATE(11025, 11025);
+	AZF_FMT_XLATE(13240, SUSPECTED_13240);
+	AZF_FMT_XLATE(16000, 16000);
+	AZF_FMT_XLATE(22050, 22050);
+	AZF_FMT_XLATE(32000, 32000);
 	default:
 		snd_printk(KERN_WARNING "unknown bitrate %d, assuming 44.1kHz!\n", bitrate);
 		/* fall-through */
-	AZF_FMT_XLATE(44100, 44100)
-	AZF_FMT_XLATE(48000, 48000)
-	AZF_FMT_XLATE(66200, SUSPECTED_66200)
+	AZF_FMT_XLATE(44100, 44100);
+	AZF_FMT_XLATE(48000, 48000);
+	AZF_FMT_XLATE(66200, SUSPECTED_66200);
 #undef AZF_FMT_XLATE
 	}
 	/* val = 0xff07; 3m27.993s (65301Hz; -> 64000Hz???) hmm, 66120, 65967, 66123 */
-- 
1.7.3.2
