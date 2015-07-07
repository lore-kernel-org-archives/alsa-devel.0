From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH 2/3] emu10k1: enable TAD mic out on Audigy
Date: Tue, 07 Jul 2015 21:53:15 +0200
Message-ID: <559C2E2B.5000503@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Michael Gernoth <michael@gernoth.net>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Enable TAD output on Audigy naming it "Phone Output",
to be consistent with TAD input which is called "Phone".

According to Creative doc
( http://support.creative.com/kb/ShowArticle.aspx?sid=3026 )
this should output just mic signal.

Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>
---
 sound/pci/emu10k1/emumixer.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/pci/emu10k1/emumixer.c b/sound/pci/emu10k1/emumixer.c
index f1cb7b3..567b5cb 100644
--- a/sound/pci/emu10k1/emumixer.c
+++ b/sound/pci/emu10k1/emumixer.c
@@ -1819,8 +1819,6 @@ int snd_emu10k1_mixer(struct snd_emu10k1 *emu,
 		 * the Philips ADC for 24bit capture */
 		"PCM Playback Switch",
 		"PCM Playback Volume",
-		"Master Mono Playback Switch",
-		"Master Mono Playback Volume",
 		"Master Playback Switch",
 		"Master Playback Volume",
 		"PCM Out Path & Mute",
@@ -1848,6 +1846,8 @@ int snd_emu10k1_mixer(struct snd_emu10k1 *emu,
 		/* "Wave Capture Volume", "PCM Capture Volume", */
 		"Wave Master Playback Volume", "Master Playback Volume",
 		"AMic Playback Volume", "Mic Playback Volume",
+		"Master Mono Playback Switch", "Phone Output Playback Switch",
+		"Master Mono Playback Volume", "Phone Output Playback Volume",
 		NULL
 	};
 	static char *audigy_rename_ctls_i2c_adc[] = {
@@ -1873,8 +1873,6 @@ int snd_emu10k1_mixer(struct snd_emu10k1 *emu,
 		 * the Philips ADC for 24bit capture */
 		"PCM Playback Switch",
 		"PCM Playback Volume",
-		"Master Mono Playback Switch",
-		"Master Mono Playback Volume",
 		"Capture Source",
 		"Capture Switch",
 		"Capture Volume",
@@ -1906,7 +1904,8 @@ int snd_emu10k1_mixer(struct snd_emu10k1 *emu,
 		"Aux Playback Volume", "Aux Capture Volume",
 		"Video Playback Switch", "Video Capture Switch",
 		"Video Playback Volume", "Video Capture Volume",
-
+		"Master Mono Playback Switch", "Phone Output Playback Switch",
+		"Master Mono Playback Volume", "Phone Output Playback Volume",
 		NULL
 	};
 
@@ -1941,6 +1940,9 @@ int snd_emu10k1_mixer(struct snd_emu10k1 *emu,
 			snd_ac97_write_cache(emu->ac97, AC97_MASTER, 0x0000);
 			/* set capture source to mic */
 			snd_ac97_write_cache(emu->ac97, AC97_REC_SEL, 0x0000);
+			/* set mono output (TAD) to mic */
+			snd_ac97_update_bits(emu->ac97, AC97_GENERAL_PURPOSE,
+				0x0200, 0x0200);
 			if (emu->card_capabilities->adc_1361t)
 				c = audigy_remove_ctls_1361t_adc;
 			else 
