From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: [PATCH] sound: pci: ice1712: wm8776.c:  Remove some unused functions
Date: Sat, 20 Dec 2014 17:46:02 +0100
Message-ID: <1419093962-8789-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Removes some functions that are not used anywhere:
snd_wm8776_set_master_mode() snd_wm8776_set_adc_if() snd_wm8776_set_dac_if()

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 sound/pci/ice1712/wm8776.c |   15 ---------------
 sound/pci/ice1712/wm8776.h |    3 ---
 2 files changed, 18 deletions(-)

diff --git a/sound/pci/ice1712/wm8776.c b/sound/pci/ice1712/wm8776.c
index e66c0da..ebd2fe4 100644
--- a/sound/pci/ice1712/wm8776.c
+++ b/sound/pci/ice1712/wm8776.c
@@ -452,21 +452,6 @@ void snd_wm8776_resume(struct snd_wm8776 *wm)
 		snd_wm8776_write(wm, i, wm->regs[i]);
 }
 
-void snd_wm8776_set_dac_if(struct snd_wm8776 *wm, u16 dac)
-{
-	snd_wm8776_write(wm, WM8776_REG_DACIFCTRL, dac);
-}
-
-void snd_wm8776_set_adc_if(struct snd_wm8776 *wm, u16 adc)
-{
-	snd_wm8776_write(wm, WM8776_REG_ADCIFCTRL, adc);
-}
-
-void snd_wm8776_set_master_mode(struct snd_wm8776 *wm, u16 mode)
-{
-	snd_wm8776_write(wm, WM8776_REG_MSTRCTRL, mode);
-}
-
 void snd_wm8776_set_power(struct snd_wm8776 *wm, u16 power)
 {
 	snd_wm8776_write(wm, WM8776_REG_PWRDOWN, power);
diff --git a/sound/pci/ice1712/wm8776.h b/sound/pci/ice1712/wm8776.h
index 93a2d69..42acef0 100644
--- a/sound/pci/ice1712/wm8776.h
+++ b/sound/pci/ice1712/wm8776.h
@@ -216,9 +216,6 @@ struct snd_wm8776 {
 
 void snd_wm8776_init(struct snd_wm8776 *wm);
 void snd_wm8776_resume(struct snd_wm8776 *wm);
-void snd_wm8776_set_dac_if(struct snd_wm8776 *wm, u16 dac);
-void snd_wm8776_set_adc_if(struct snd_wm8776 *wm, u16 adc);
-void snd_wm8776_set_master_mode(struct snd_wm8776 *wm, u16 mode);
 void snd_wm8776_set_power(struct snd_wm8776 *wm, u16 power);
 void snd_wm8776_volume_restore(struct snd_wm8776 *wm);
 int snd_wm8776_build_controls(struct snd_wm8776 *wm);
-- 
1.7.10.4
