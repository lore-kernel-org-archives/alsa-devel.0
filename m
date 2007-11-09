From: Jiri Olsa <olsajiri@gmail.com>
Subject: [PATCH] sound - remove dead config symbol from sound
	code
Date: Fri, 09 Nov 2007 10:47:10 +0100
Message-ID: <47342C9E.4030409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hu-out-0506.google.com (hu-out-0506.google.com [72.14.214.224])
	by alsa0.perex.cz (Postfix) with ESMTP id 0E90A24527
	for <alsa-devel@alsa-project.org>; Fri,  9 Nov 2007 10:47:15 +0100 (CET)
Received: by hu-out-0506.google.com with SMTP id 16so1754096hue
	for <alsa-devel@alsa-project.org>; Fri, 09 Nov 2007 01:47:14 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: kernel-janitors@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

remove dead config symbols from sound code
Signed-off-by: Jiri Olsa <olsajiri@gmail.com>

---
 include/sound/cs46xx.h        |    3 -
 include/sound/driver.h        |    4 --
 sound/pci/cs46xx/cs46xx_lib.c |   99 -----------------------------------------
 3 files changed, 0 insertions(+), 106 deletions(-)

diff --git a/include/sound/cs46xx.h b/include/sound/cs46xx.h
index 6b40ee6..e3005a6 100644
--- a/include/sound/cs46xx.h
+++ b/include/sound/cs46xx.h
@@ -1708,9 +1708,6 @@ struct snd_cs46xx {
 
 	struct gameport *gameport;
 
-#ifdef CONFIG_SND_CS46XX_DEBUG_GPIO
-	int current_gpio;
-#endif
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
 	struct mutex spos_mutex;
 
diff --git a/include/sound/driver.h b/include/sound/driver.h
index 5ccb6c5..1889929 100644
--- a/include/sound/driver.h
+++ b/include/sound/driver.h
@@ -38,10 +38,6 @@
 #define CONFIG_SND_MAJOR	116
 #endif
 
-#ifndef CONFIG_SND_DEBUG
-#undef CONFIG_SND_DEBUG_MEMORY
-#endif
-
 #ifdef ALSA_BUILD
 #include "adriver.h"
 #endif
diff --git a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
index 2c7bfc9..8c44fef 100644
--- a/sound/pci/cs46xx/cs46xx_lib.c
+++ b/sound/pci/cs46xx/cs46xx_lib.c
@@ -2084,71 +2084,6 @@ static int snd_cs46xx_spdif_stream_put(struct snd_kcontrol *kcontrol,
 #endif /* CONFIG_SND_CS46XX_NEW_DSP */
 
 
-#ifdef CONFIG_SND_CS46XX_DEBUG_GPIO
-static int snd_cs46xx_egpio_select_info(struct snd_kcontrol *kcontrol, 
-                                        struct snd_ctl_elem_info *uinfo)
-{
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
-	uinfo->count = 1;
-	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = 8;
-	return 0;
-}
-
-static int snd_cs46xx_egpio_select_get(struct snd_kcontrol *kcontrol, 
-                                       struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_cs46xx *chip = snd_kcontrol_chip(kcontrol);
-	ucontrol->value.integer.value[0] = chip->current_gpio;
-
-	return 0;
-}
-
-static int snd_cs46xx_egpio_select_put(struct snd_kcontrol *kcontrol, 
-                                       struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_cs46xx *chip = snd_kcontrol_chip(kcontrol);
-	int change = (chip->current_gpio != ucontrol->value.integer.value[0]);
-	chip->current_gpio = ucontrol->value.integer.value[0];
-
-	return change;
-}
-
-
-static int snd_cs46xx_egpio_get(struct snd_kcontrol *kcontrol, 
-                                       struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_cs46xx *chip = snd_kcontrol_chip(kcontrol);
-	int reg = kcontrol->private_value;
-
-	snd_printdd ("put: reg = %04x, gpio %02x\n",reg,chip->current_gpio);
-	ucontrol->value.integer.value[0] = 
-		(snd_cs46xx_peekBA0(chip, reg) & (1 << chip->current_gpio)) ? 1 : 0;
-  
-	return 0;
-}
-
-static int snd_cs46xx_egpio_put(struct snd_kcontrol *kcontrol, 
-                                       struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_cs46xx *chip = snd_kcontrol_chip(kcontrol);
-	int reg = kcontrol->private_value;
-	int val = snd_cs46xx_peekBA0(chip, reg);
-	int oldval = val;
-	snd_printdd ("put: reg = %04x, gpio %02x\n",reg,chip->current_gpio);
-
-	if (ucontrol->value.integer.value[0])
-		val |= (1 << chip->current_gpio);
-	else
-		val &= ~(1 << chip->current_gpio);
-
-	snd_cs46xx_pokeBA0(chip, reg,val);
-	snd_printdd ("put: val %08x oldval %08x\n",val,oldval);
-
-	return (oldval != val);
-}
-#endif /* CONFIG_SND_CS46XX_DEBUG_GPIO */
-
 static struct snd_kcontrol_new snd_cs46xx_controls[] __devinitdata = {
 {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
@@ -2241,40 +2176,6 @@ static struct snd_kcontrol_new snd_cs46xx_controls[] __devinitdata = {
 },
 
 #endif
-#ifdef CONFIG_SND_CS46XX_DEBUG_GPIO
-{
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name = "EGPIO select",
-	.info = snd_cs46xx_egpio_select_info,
-	.get = snd_cs46xx_egpio_select_get,
-	.put = snd_cs46xx_egpio_select_put,
-	.private_value = 0,
-},
-{
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name = "EGPIO Input/Output",
-	.info = snd_mixer_boolean_info,
-	.get = snd_cs46xx_egpio_get,
-	.put = snd_cs46xx_egpio_put,
-	.private_value = BA0_EGPIODR,
-},
-{
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name = "EGPIO CMOS/Open drain",
-	.info = snd_mixer_boolean_info,
-	.get = snd_cs46xx_egpio_get,
-	.put = snd_cs46xx_egpio_put,
-	.private_value = BA0_EGPIOPTR,
-},
-{
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name = "EGPIO On/Off",
-	.info = snd_mixer_boolean_info,
-	.get = snd_cs46xx_egpio_get,
-	.put = snd_cs46xx_egpio_put,
-	.private_value = BA0_EGPIOSR,
-},
-#endif
 };
 
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
