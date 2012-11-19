From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 347/493] sound: remove use of __devinitdata
Date: Mon, 19 Nov 2012 13:24:56 -0500
Message-ID: <1353349642-3677-347-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from viridian.itc.virginia.edu (viridian.itc.virginia.edu
 [128.143.12.139])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B045261735
 for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2012 19:28:19 +0100 (CET)
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: gregkh@linuxfoundation.org
Cc: alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>, Jaya Kumar <jayakumar.alsa@gmail.com>
List-Id: alsa-devel@alsa-project.org

CONFIG_HOTPLUG is going away as an option so __devinitdata is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Russell King <linux@arm.linux.org.uk> 
Cc: Jaroslav Kysela <perex@perex.cz> 
Cc: Takashi Iwai <tiwai@suse.de> 
Cc: Clemens Ladisch <clemens@ladisch.de> 
Cc: Jaya Kumar <jayakumar.alsa@gmail.com> 
Cc: Daniel Mack <zonque@gmail.com> 
Cc: alsa-devel@alsa-project.org 
---
 sound/arm/aaci.c                         |  2 +-
 sound/atmel/ac97c.c                      |  2 +-
 sound/drivers/aloop.c                    |  2 +-
 sound/drivers/mts64.c                    | 14 ++++-----
 sound/drivers/pcsp/pcsp_mixer.c          |  4 +--
 sound/isa/ad1816a/ad1816a.c              |  2 +-
 sound/isa/ad1816a/ad1816a_lib.c          |  2 +-
 sound/isa/als100.c                       |  2 +-
 sound/isa/azt2320.c                      |  2 +-
 sound/isa/cmi8330.c                      |  6 ++--
 sound/isa/opti9xx/miro.c                 | 16 +++++-----
 sound/mips/hal2.c                        |  4 +--
 sound/mips/sgio2audio.c                  | 14 ++++-----
 sound/oss/ad1848.c                       |  2 +-
 sound/pci/ak4531_codec.c                 |  2 +-
 sound/pci/ali5451/ali5451.c              |  2 +-
 sound/pci/atiixp.c                       |  6 ++--
 sound/pci/au88x0/au88x0_a3d.c            |  2 +-
 sound/pci/au88x0/au88x0_eq.c             |  8 ++---
 sound/pci/au88x0/au88x0_pcm.c            |  4 +--
 sound/pci/aw2/aw2-alsa.c                 |  2 +-
 sound/pci/azt3328.c                      |  4 +--
 sound/pci/bt87x.c                        |  4 +--
 sound/pci/ca0106/ca0106_mixer.c          | 15 +++++----
 sound/pci/cmipci.c                       | 20 ++++++------
 sound/pci/cs46xx/cs46xx_lib.c            |  4 +--
 sound/pci/cs5535audio/cs5535audio.c      |  2 +-
 sound/pci/cs5535audio/cs5535audio_olpc.c |  2 +-
 sound/pci/ctxfi/ctatc.c                  |  6 ++--
 sound/pci/ctxfi/cthw20k1.c               |  2 +-
 sound/pci/ctxfi/cthw20k2.c               |  2 +-
 sound/pci/echoaudio/echoaudio.c          | 30 +++++++++---------
 sound/pci/emu10k1/emu10k1x.c             |  2 +-
 sound/pci/emu10k1/emumixer.c             | 18 +++++------
 sound/pci/emu10k1/p16v.c                 |  2 +-
 sound/pci/ens1370.c                      | 14 ++++-----
 sound/pci/es1968.c                       |  4 +--
 sound/pci/fm801.c                        |  4 +--
 sound/pci/hda/hda_intel.c                |  8 ++---
 sound/pci/ice1712/amp.c                  |  2 +-
 sound/pci/ice1712/aureon.c               | 20 ++++++------
 sound/pci/ice1712/delta.c                | 38 +++++++++++------------
 sound/pci/ice1712/ews.c                  | 24 +++++++--------
 sound/pci/ice1712/hoontech.c             |  6 ++--
 sound/pci/ice1712/ice1712.c              | 42 +++++++++++++-------------
 sound/pci/ice1712/ice1724.c              | 30 +++++++++---------
 sound/pci/ice1712/juli.c                 | 13 ++++----
 sound/pci/ice1712/maya44.c               |  8 ++---
 sound/pci/ice1712/phase.c                | 14 ++++-----
 sound/pci/ice1712/pontis.c               |  6 ++--
 sound/pci/ice1712/prodigy192.c           |  8 ++---
 sound/pci/ice1712/prodigy_hifi.c         | 12 ++++----
 sound/pci/ice1712/psc724.c               |  4 +--
 sound/pci/ice1712/quartet.c              | 13 ++++----
 sound/pci/ice1712/revo.c                 | 22 +++++++-------
 sound/pci/ice1712/se.c                   |  8 ++---
 sound/pci/ice1712/vt1720_mobo.c          |  6 ++--
 sound/pci/ice1712/wtm.c                  |  6 ++--
 sound/pci/intel8x0.c                     | 16 +++++-----
 sound/pci/intel8x0m.c                    |  4 +--
 sound/pci/lola/lola_mixer.c              |  8 ++---
 sound/pci/lx6464es/lx6464es.c            |  2 +-
 sound/pci/maestro3.c                     |  8 ++---
 sound/pci/nm256/nm256.c                  |  2 +-
 sound/pci/sonicvibes.c                   |  6 ++--
 sound/pci/trident/trident_main.c         | 22 +++++++-------
 sound/pci/via82xx.c                      | 12 ++++----
 sound/pci/ymfpci/ymfpci_main.c           | 16 +++++-----
 sound/ppc/awacs.c                        | 52 ++++++++++++++++----------------
 sound/ppc/burgundy.c                     | 20 ++++++------
 sound/ppc/pmac.c                         |  2 +-
 sound/ppc/tumbler.c                      | 12 ++++----
 sound/sh/aica.c                          |  4 +--
 sound/soc/au1x/db1200.c                  |  2 +-
 sound/soc/fsl/mpc5200_psc_ac97.c         |  2 +-
 sound/soc/fsl/mpc5200_psc_i2s.c          |  2 +-
 sound/soc/tegra/tegra30_ahub.c           |  2 +-
 sound/sparc/amd7930.c                    |  2 +-
 sound/sparc/cs4231.c                     |  2 +-
 sound/sparc/dbri.c                       |  2 +-
 sound/spi/at73c213.c                     |  2 +-
 sound/usb/6fire/control.c                |  6 ++--
 sound/usb/caiaq/control.c                |  2 +-
 83 files changed, 366 insertions(+), 369 deletions(-)

diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index 5ea9724..e54a83e 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -786,7 +786,7 @@ static int aaci_resume(struct amba_device *dev)
 #endif
 
 
-static struct ac97_pcm ac97_defs[] __devinitdata = {
+static struct ac97_pcm ac97_defs[] = {
 	[0] = {	/* Front PCM */
 		.exclusive = 1,
 		.r = {
diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index ebe992b..7b5664f 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -728,7 +728,7 @@ static irqreturn_t atmel_ac97c_interrupt(int irq, void *dev)
 	return retval;
 }
 
-static struct ac97_pcm at91_ac97_pcm_defs[] __devinitdata = {
+static struct ac97_pcm at91_ac97_pcm_defs[] = {
 	/* Playback */
 	{
 		.exclusive = 1,
diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 93c19e0..542a5b7 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -949,7 +949,7 @@ static int loopback_channels_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new loopback_controls[]  __devinitdata = {
+static struct snd_kcontrol_new loopback_controls[]  = {
 {
 	.iface =        SNDRV_CTL_ELEM_IFACE_PCM,
 	.name =         "PCM Rate Shift 100000",
diff --git a/sound/drivers/mts64.c b/sound/drivers/mts64.c
index 2cbacb4..f1d463e 100644
--- a/sound/drivers/mts64.c
+++ b/sound/drivers/mts64.c
@@ -483,7 +483,7 @@ __out:
 	return changed;
 }
 
-static struct snd_kcontrol_new mts64_ctl_smpte_switch __devinitdata = {
+static struct snd_kcontrol_new mts64_ctl_smpte_switch = {
 	.iface = SNDRV_CTL_ELEM_IFACE_RAWMIDI,
 	.name  = "SMPTE Playback Switch",
 	.index = 0,
@@ -556,7 +556,7 @@ static int snd_mts64_ctl_smpte_time_put(struct snd_kcontrol *kctl,
 	return changed;
 }
 
-static struct snd_kcontrol_new mts64_ctl_smpte_time_hours __devinitdata = {
+static struct snd_kcontrol_new mts64_ctl_smpte_time_hours = {
 	.iface = SNDRV_CTL_ELEM_IFACE_RAWMIDI,
 	.name  = "SMPTE Time Hours",
 	.index = 0,
@@ -567,7 +567,7 @@ static struct snd_kcontrol_new mts64_ctl_smpte_time_hours __devinitdata = {
 	.put  = snd_mts64_ctl_smpte_time_put
 };
 
-static struct snd_kcontrol_new mts64_ctl_smpte_time_minutes __devinitdata = {
+static struct snd_kcontrol_new mts64_ctl_smpte_time_minutes = {
 	.iface = SNDRV_CTL_ELEM_IFACE_RAWMIDI,
 	.name  = "SMPTE Time Minutes",
 	.index = 0,
@@ -578,7 +578,7 @@ static struct snd_kcontrol_new mts64_ctl_smpte_time_minutes __devinitdata = {
 	.put  = snd_mts64_ctl_smpte_time_put
 };
 
-static struct snd_kcontrol_new mts64_ctl_smpte_time_seconds __devinitdata = {
+static struct snd_kcontrol_new mts64_ctl_smpte_time_seconds = {
 	.iface = SNDRV_CTL_ELEM_IFACE_RAWMIDI,
 	.name  = "SMPTE Time Seconds",
 	.index = 0,
@@ -589,7 +589,7 @@ static struct snd_kcontrol_new mts64_ctl_smpte_time_seconds __devinitdata = {
 	.put  = snd_mts64_ctl_smpte_time_put
 };
 
-static struct snd_kcontrol_new mts64_ctl_smpte_time_frames __devinitdata = {
+static struct snd_kcontrol_new mts64_ctl_smpte_time_frames = {
 	.iface = SNDRV_CTL_ELEM_IFACE_RAWMIDI,
 	.name  = "SMPTE Time Frames",
 	.index = 0,
@@ -651,7 +651,7 @@ static int snd_mts64_ctl_smpte_fps_put(struct snd_kcontrol *kctl,
 	return changed;
 }
 
-static struct snd_kcontrol_new mts64_ctl_smpte_fps __devinitdata = {
+static struct snd_kcontrol_new mts64_ctl_smpte_fps = {
 	.iface = SNDRV_CTL_ELEM_IFACE_RAWMIDI,
 	.name  = "SMPTE Fps",
 	.index = 0,
@@ -667,7 +667,7 @@ static int snd_mts64_ctl_create(struct snd_card *card,
 					  struct mts64 *mts) 
 {
 	int err, i;
-	static struct snd_kcontrol_new *control[] __devinitdata = {
+	static struct snd_kcontrol_new *control[] = {
 		&mts64_ctl_smpte_switch,
 		&mts64_ctl_smpte_time_hours,
 		&mts64_ctl_smpte_time_minutes,
diff --git a/sound/drivers/pcsp/pcsp_mixer.c b/sound/drivers/pcsp/pcsp_mixer.c
index 82bb082..3fa027e 100644
--- a/sound/drivers/pcsp/pcsp_mixer.c
+++ b/sound/drivers/pcsp/pcsp_mixer.c
@@ -119,12 +119,12 @@ static int pcsp_pcspkr_put(struct snd_kcontrol *kcontrol,
 	.put =		pcsp_##ctl_type##_put, \
 }
 
-static struct snd_kcontrol_new __devinitdata snd_pcsp_controls_pcm[] = {
+static struct snd_kcontrol_new snd_pcsp_controls_pcm[] = {
 	PCSP_MIXER_CONTROL(enable, "Master Playback Switch"),
 	PCSP_MIXER_CONTROL(treble, "BaseFRQ Playback Volume"),
 };
 
-static struct snd_kcontrol_new __devinitdata snd_pcsp_controls_spkr[] = {
+static struct snd_kcontrol_new snd_pcsp_controls_spkr[] = {
 	PCSP_MIXER_CONTROL(pcspkr, "Beep Playback Switch"),
 };
 
diff --git a/sound/isa/ad1816a/ad1816a.c b/sound/isa/ad1816a/ad1816a.c
index 2de24dd..f63bf61 100644
--- a/sound/isa/ad1816a/ad1816a.c
+++ b/sound/isa/ad1816a/ad1816a.c
@@ -217,7 +217,7 @@ static int snd_card_ad1816a_probe(int dev, struct pnp_card_link *pcard,
 	return 0;
 }
 
-static unsigned int __devinitdata ad1816a_devices;
+static unsigned int ad1816a_devices;
 
 static int snd_ad1816a_pnp_detect(struct pnp_card_link *card,
 					    const struct pnp_card_device_id *id)
diff --git a/sound/isa/ad1816a/ad1816a_lib.c b/sound/isa/ad1816a/ad1816a_lib.c
index 2d61df1..0716d9e 100644
--- a/sound/isa/ad1816a/ad1816a_lib.c
+++ b/sound/isa/ad1816a/ad1816a_lib.c
@@ -923,7 +923,7 @@ static const DECLARE_TLV_DB_SCALE(db_scale_6bit, -9450, 150, 0);
 static const DECLARE_TLV_DB_SCALE(db_scale_5bit_12db_max, -3450, 150, 0);
 static const DECLARE_TLV_DB_SCALE(db_scale_rec_gain, 0, 150, 0);
 
-static struct snd_kcontrol_new snd_ad1816a_controls[] __devinitdata = {
+static struct snd_kcontrol_new snd_ad1816a_controls[] = {
 AD1816A_DOUBLE("Master Playback Switch", AD1816A_MASTER_ATT, 15, 7, 1, 1),
 AD1816A_DOUBLE_TLV("Master Playback Volume", AD1816A_MASTER_ATT, 8, 0, 31, 1,
 		   db_scale_5bit),
diff --git a/sound/isa/als100.c b/sound/isa/als100.c
index 538f866..b282f007 100644
--- a/sound/isa/als100.c
+++ b/sound/isa/als100.c
@@ -286,7 +286,7 @@ static int snd_card_als100_probe(int dev,
 	return 0;
 }
 
-static unsigned int __devinitdata als100_devices;
+static unsigned int als100_devices;
 
 static int snd_als100_pnp_detect(struct pnp_card_link *card,
 					   const struct pnp_card_device_id *id)
diff --git a/sound/isa/azt2320.c b/sound/isa/azt2320.c
index da5ed43..19b1fee 100644
--- a/sound/isa/azt2320.c
+++ b/sound/isa/azt2320.c
@@ -264,7 +264,7 @@ static int snd_card_azt2320_probe(int dev,
 	return 0;
 }
 
-static unsigned int __devinitdata azt2320_devices;
+static unsigned int azt2320_devices;
 
 static int snd_azt2320_pnp_detect(struct pnp_card_link *card,
 					    const struct pnp_card_device_id *id)
diff --git a/sound/isa/cmi8330.c b/sound/isa/cmi8330.c
index 4c6e4eb..e294e22 100644
--- a/sound/isa/cmi8330.c
+++ b/sound/isa/cmi8330.c
@@ -193,7 +193,7 @@ MODULE_DEVICE_TABLE(pnp_card, snd_cmi8330_pnpids);
 #endif
 
 
-static struct snd_kcontrol_new snd_cmi8330_controls[] __devinitdata = {
+static struct snd_kcontrol_new snd_cmi8330_controls[] = {
 WSS_DOUBLE("Master Playback Volume", 0,
 		CMI8330_MASTVOL, CMI8330_MASTVOL, 4, 0, 15, 0),
 WSS_SINGLE("Loud Playback Switch", 0,
@@ -249,7 +249,7 @@ WSS_SINGLE(SNDRV_CTL_NAME_IEC958("Input ", PLAYBACK, SWITCH), 0,
 };
 
 #ifdef ENABLE_SB_MIXER
-static struct sbmix_elem cmi8330_sb_mixers[] __devinitdata = {
+static struct sbmix_elem cmi8330_sb_mixers[] = {
 SB_DOUBLE("SB Master Playback Volume", SB_DSP4_MASTER_DEV, (SB_DSP4_MASTER_DEV + 1), 3, 3, 31),
 SB_DOUBLE("Tone Control - Bass", SB_DSP4_BASS_DEV, (SB_DSP4_BASS_DEV + 1), 4, 4, 15),
 SB_DOUBLE("Tone Control - Treble", SB_DSP4_TREBLE_DEV, (SB_DSP4_TREBLE_DEV + 1), 4, 4, 15),
@@ -267,7 +267,7 @@ SB_DOUBLE("SB Playback Volume", SB_DSP4_OGAIN_DEV, (SB_DSP4_OGAIN_DEV + 1), 6, 6
 SB_SINGLE("SB Mic Auto Gain", SB_DSP4_MIC_AGC, 0, 1),
 };
 
-static unsigned char cmi8330_sb_init_values[][2] __devinitdata = {
+static unsigned char cmi8330_sb_init_values[][2] = {
 	{ SB_DSP4_MASTER_DEV + 0, 0 },
 	{ SB_DSP4_MASTER_DEV + 1, 0 },
 	{ SB_DSP4_PCM_DEV + 0, 0 },
diff --git a/sound/isa/opti9xx/miro.c b/sound/isa/opti9xx/miro.c
index 25418dd..f8747ab 100644
--- a/sound/isa/opti9xx/miro.c
+++ b/sound/isa/opti9xx/miro.c
@@ -587,7 +587,7 @@ static int snd_miro_put_double(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_miro_controls[] __devinitdata = {
+static struct snd_kcontrol_new snd_miro_controls[] = {
 MIRO_DOUBLE("Master Playback Volume", 0, ACI_GET_MASTER, ACI_SET_MASTER),
 MIRO_DOUBLE("Mic Playback Volume", 1, ACI_GET_MIC, ACI_SET_MIC),
 MIRO_DOUBLE("Line Playback Volume", 1, ACI_GET_LINE, ACI_SET_LINE),
@@ -599,7 +599,7 @@ MIRO_DOUBLE("Aux Playback Volume", 2, ACI_GET_LINE2, ACI_SET_LINE2),
 
 /* Equalizer with seven bands (only PCM20) 
    from -12dB up to +12dB on each band */
-static struct snd_kcontrol_new snd_miro_eq_controls[] __devinitdata = {
+static struct snd_kcontrol_new snd_miro_eq_controls[] = {
 MIRO_DOUBLE("Tone Control - 28 Hz", 0, ACI_GET_EQ1, ACI_SET_EQ1),
 MIRO_DOUBLE("Tone Control - 160 Hz", 0, ACI_GET_EQ2, ACI_SET_EQ2),
 MIRO_DOUBLE("Tone Control - 400 Hz", 0, ACI_GET_EQ3, ACI_SET_EQ3),
@@ -609,15 +609,15 @@ MIRO_DOUBLE("Tone Control - 6.3 kHz", 0, ACI_GET_EQ6, ACI_SET_EQ6),
 MIRO_DOUBLE("Tone Control - 16 kHz", 0, ACI_GET_EQ7, ACI_SET_EQ7),
 };
 
-static struct snd_kcontrol_new snd_miro_radio_control[] __devinitdata = {
+static struct snd_kcontrol_new snd_miro_radio_control[] = {
 MIRO_DOUBLE("Radio Playback Volume", 0, ACI_GET_LINE1, ACI_SET_LINE1),
 };
 
-static struct snd_kcontrol_new snd_miro_line_control[] __devinitdata = {
+static struct snd_kcontrol_new snd_miro_line_control[] = {
 MIRO_DOUBLE("Line Playback Volume", 2, ACI_GET_LINE1, ACI_SET_LINE1),
 };
 
-static struct snd_kcontrol_new snd_miro_preamp_control[] __devinitdata = {
+static struct snd_kcontrol_new snd_miro_preamp_control[] = {
 {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Mic Boost",
@@ -627,7 +627,7 @@ static struct snd_kcontrol_new snd_miro_preamp_control[] __devinitdata = {
 	.put = snd_miro_put_preamp,
 }};
 
-static struct snd_kcontrol_new snd_miro_amp_control[] __devinitdata = {
+static struct snd_kcontrol_new snd_miro_amp_control[] = {
 {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Line Boost",
@@ -637,7 +637,7 @@ static struct snd_kcontrol_new snd_miro_amp_control[] __devinitdata = {
 	.put = snd_miro_put_amp,
 }};
 
-static struct snd_kcontrol_new snd_miro_capture_control[] __devinitdata = {
+static struct snd_kcontrol_new snd_miro_capture_control[] = {
 {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "PCM Capture Switch",
@@ -647,7 +647,7 @@ static struct snd_kcontrol_new snd_miro_capture_control[] __devinitdata = {
 	.put = snd_miro_put_capture,
 }};
 
-static unsigned char aci_init_values[][2] __devinitdata = {
+static unsigned char aci_init_values[][2] = {
 	{ ACI_SET_MUTE, 0x00 },
 	{ ACI_SET_POWERAMP, 0x00 },
 	{ ACI_SET_PREAMP, 0x00 },
diff --git a/sound/mips/hal2.c b/sound/mips/hal2.c
index 0670a83..690e019 100644
--- a/sound/mips/hal2.c
+++ b/sound/mips/hal2.c
@@ -260,7 +260,7 @@ static int hal2_gain_put(struct snd_kcontrol *kcontrol,
 	return old != new;
 }
 
-static struct snd_kcontrol_new hal2_ctrl_headphone __devinitdata = {
+static struct snd_kcontrol_new hal2_ctrl_headphone = {
 	.iface          = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name           = "Headphone Playback Volume",
 	.access         = SNDRV_CTL_ELEM_ACCESS_READWRITE,
@@ -270,7 +270,7 @@ static struct snd_kcontrol_new hal2_ctrl_headphone __devinitdata = {
 	.put            = hal2_gain_put,
 };
 
-static struct snd_kcontrol_new hal2_ctrl_mic __devinitdata = {
+static struct snd_kcontrol_new hal2_ctrl_mic = {
 	.iface          = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name           = "Mic Capture Volume",
 	.access         = SNDRV_CTL_ELEM_ACCESS_READWRITE,
diff --git a/sound/mips/sgio2audio.c b/sound/mips/sgio2audio.c
index ff32a07..8b5ef60 100644
--- a/sound/mips/sgio2audio.c
+++ b/sound/mips/sgio2audio.c
@@ -237,7 +237,7 @@ static int sgio2audio_source_put(struct snd_kcontrol *kcontrol,
 }
 
 /* dac1/pcm0 mixer control */
-static struct snd_kcontrol_new sgio2audio_ctrl_pcm0 __devinitdata = {
+static struct snd_kcontrol_new sgio2audio_ctrl_pcm0 = {
 	.iface          = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name           = "PCM Playback Volume",
 	.index          = 0,
@@ -249,7 +249,7 @@ static struct snd_kcontrol_new sgio2audio_ctrl_pcm0 __devinitdata = {
 };
 
 /* dac2/pcm1 mixer control */
-static struct snd_kcontrol_new sgio2audio_ctrl_pcm1 __devinitdata = {
+static struct snd_kcontrol_new sgio2audio_ctrl_pcm1 = {
 	.iface          = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name           = "PCM Playback Volume",
 	.index          = 1,
@@ -261,7 +261,7 @@ static struct snd_kcontrol_new sgio2audio_ctrl_pcm1 __devinitdata = {
 };
 
 /* record level mixer control */
-static struct snd_kcontrol_new sgio2audio_ctrl_reclevel __devinitdata = {
+static struct snd_kcontrol_new sgio2audio_ctrl_reclevel = {
 	.iface          = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name           = "Capture Volume",
 	.access         = SNDRV_CTL_ELEM_ACCESS_READWRITE,
@@ -272,7 +272,7 @@ static struct snd_kcontrol_new sgio2audio_ctrl_reclevel __devinitdata = {
 };
 
 /* record level source control */
-static struct snd_kcontrol_new sgio2audio_ctrl_recsource __devinitdata = {
+static struct snd_kcontrol_new sgio2audio_ctrl_recsource = {
 	.iface          = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name           = "Capture Source",
 	.access         = SNDRV_CTL_ELEM_ACCESS_READWRITE,
@@ -282,7 +282,7 @@ static struct snd_kcontrol_new sgio2audio_ctrl_recsource __devinitdata = {
 };
 
 /* line mixer control */
-static struct snd_kcontrol_new sgio2audio_ctrl_line __devinitdata = {
+static struct snd_kcontrol_new sgio2audio_ctrl_line = {
 	.iface          = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name           = "Line Playback Volume",
 	.index          = 0,
@@ -294,7 +294,7 @@ static struct snd_kcontrol_new sgio2audio_ctrl_line __devinitdata = {
 };
 
 /* cd mixer control */
-static struct snd_kcontrol_new sgio2audio_ctrl_cd __devinitdata = {
+static struct snd_kcontrol_new sgio2audio_ctrl_cd = {
 	.iface          = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name           = "Line Playback Volume",
 	.index          = 1,
@@ -306,7 +306,7 @@ static struct snd_kcontrol_new sgio2audio_ctrl_cd __devinitdata = {
 };
 
 /* mic mixer control */
-static struct snd_kcontrol_new sgio2audio_ctrl_mic __devinitdata = {
+static struct snd_kcontrol_new sgio2audio_ctrl_mic = {
 	.iface          = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name           = "Mic Playback Volume",
 	.access         = SNDRV_CTL_ELEM_ACCESS_READWRITE,
diff --git a/sound/oss/ad1848.c b/sound/oss/ad1848.c
index 98d23bd..4918b71 100644
--- a/sound/oss/ad1848.c
+++ b/sound/oss/ad1848.c
@@ -2864,7 +2864,7 @@ static struct {
 	{NULL}
 };
 
-static struct isapnp_device_id id_table[] __devinitdata = {
+static struct isapnp_device_id id_table[] = {
 	{	ISAPNP_VENDOR('C','M','I'), ISAPNP_DEVICE(0x0001),
 		ISAPNP_VENDOR('@','@','@'), ISAPNP_FUNCTION(0x0001), 0 },
         {       ISAPNP_ANY_ID, ISAPNP_ANY_ID,
diff --git a/sound/pci/ak4531_codec.c b/sound/pci/ak4531_codec.c
index d3e5cf1..34b6cdf 100644
--- a/sound/pci/ak4531_codec.c
+++ b/sound/pci/ak4531_codec.c
@@ -274,7 +274,7 @@ static const DECLARE_TLV_DB_SCALE(db_scale_master, -6200, 200, 0);
 static const DECLARE_TLV_DB_SCALE(db_scale_mono, -2800, 400, 0);
 static const DECLARE_TLV_DB_SCALE(db_scale_input, -5000, 200, 0);
 
-static struct snd_kcontrol_new snd_ak4531_controls[] __devinitdata = {
+static struct snd_kcontrol_new snd_ak4531_controls[] = {
 
 AK4531_DOUBLE_TLV("Master Playback Switch", 0,
 		  AK4531_LMASTER, AK4531_RMASTER, 7, 7, 1, 1,
diff --git a/sound/pci/ali5451/ali5451.c b/sound/pci/ali5451/ali5451.c
index 7691659..b611059 100644
--- a/sound/pci/ali5451/ali5451.c
+++ b/sound/pci/ali5451/ali5451.c
@@ -1832,7 +1832,7 @@ static int snd_ali5451_spdif_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_ali5451_mixer_spdif[] __devinitdata = {
+static struct snd_kcontrol_new snd_ali5451_mixer_spdif[] = {
 	/* spdif aplayback switch */
 	/* FIXME: "IEC958 Playback Switch" may conflict with one on ac97_codec */
 	ALI5451_SPDIF(SNDRV_CTL_NAME_IEC958("Output ",NONE,SWITCH), 0, 0),
diff --git a/sound/pci/atiixp.c b/sound/pci/atiixp.c
index 132c151..a4ea06f 100644
--- a/sound/pci/atiixp.c
+++ b/sound/pci/atiixp.c
@@ -296,7 +296,7 @@ static DEFINE_PCI_DEVICE_TABLE(snd_atiixp_ids) = {
 
 MODULE_DEVICE_TABLE(pci, snd_atiixp_ids);
 
-static struct snd_pci_quirk atiixp_quirks[] __devinitdata = {
+static struct snd_pci_quirk atiixp_quirks[] = {
 	SND_PCI_QUIRK(0x105b, 0x0c81, "Foxconn RC4107MA-RS2", 0),
 	SND_PCI_QUIRK(0x15bd, 0x3100, "DFI RS482", 0),
 	{ } /* terminator */
@@ -1183,7 +1183,7 @@ static struct snd_pcm_ops snd_atiixp_spdif_ops = {
 	.pointer =	snd_atiixp_pcm_pointer,
 };
 
-static struct ac97_pcm atiixp_pcm_defs[] __devinitdata = {
+static struct ac97_pcm atiixp_pcm_defs[] = {
 	/* front PCM */
 	{
 		.exclusive = 1,
@@ -1390,7 +1390,7 @@ static irqreturn_t snd_atiixp_interrupt(int irq, void *dev_id)
  * ac97 mixer section
  */
 
-static struct ac97_quirk ac97_quirks[] __devinitdata = {
+static struct ac97_quirk ac97_quirks[] = {
 	{
 		.subvendor = 0x103c,
 		.subdevice = 0x006b,
diff --git a/sound/pci/au88x0/au88x0_a3d.c b/sound/pci/au88x0/au88x0_a3d.c
index a00faa0..5bab436 100644
--- a/sound/pci/au88x0/au88x0_a3d.c
+++ b/sound/pci/au88x0/au88x0_a3d.c
@@ -845,7 +845,7 @@ snd_vortex_a3d_filter_put(struct snd_kcontrol *kcontrol,
 	return changed;
 }
 
-static struct snd_kcontrol_new vortex_a3d_kcontrol __devinitdata = {
+static struct snd_kcontrol_new vortex_a3d_kcontrol = {
 	.iface = SNDRV_CTL_ELEM_IFACE_PCM,
 	.name = "Playback PCM advanced processing",
 	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
diff --git a/sound/pci/au88x0/au88x0_eq.c b/sound/pci/au88x0/au88x0_eq.c
index 0ddf004a..ad46be4 100644
--- a/sound/pci/au88x0/au88x0_eq.c
+++ b/sound/pci/au88x0/au88x0_eq.c
@@ -757,7 +757,7 @@ snd_vortex_eqtoggle_put(struct snd_kcontrol *kcontrol,
 	return 1;		/* Allways changes */
 }
 
-static struct snd_kcontrol_new vortex_eqtoggle_kcontrol __devinitdata = {
+static struct snd_kcontrol_new vortex_eqtoggle_kcontrol = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "EQ Enable",
 	.index = 0,
@@ -815,7 +815,7 @@ snd_vortex_eq_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucon
 	return changed;
 }
 
-static struct snd_kcontrol_new vortex_eq_kcontrol __devinitdata = {
+static struct snd_kcontrol_new vortex_eq_kcontrol = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "                        .",
 	.index = 0,
@@ -854,7 +854,7 @@ snd_vortex_peaks_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *u
 	return 0;
 }
 
-static struct snd_kcontrol_new vortex_levels_kcontrol __devinitdata = {
+static struct snd_kcontrol_new vortex_levels_kcontrol = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "EQ Peaks",
 	.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
@@ -863,7 +863,7 @@ static struct snd_kcontrol_new vortex_levels_kcontrol __devinitdata = {
 };
 
 /* EQ band gain labels. */
-static char *EqBandLabels[10] __devinitdata = {
+static char *EqBandLabels[10] = {
 	"EQ0 31Hz\0",
 	"EQ1 63Hz\0",
 	"EQ2 125Hz\0",
diff --git a/sound/pci/au88x0/au88x0_pcm.c b/sound/pci/au88x0/au88x0_pcm.c
index c7d6b35..a4184bb 100644
--- a/sound/pci/au88x0/au88x0_pcm.c
+++ b/sound/pci/au88x0/au88x0_pcm.c
@@ -516,7 +516,7 @@ static int snd_vortex_spdif_put(struct snd_kcontrol *kcontrol, struct snd_ctl_el
 }
 
 /* spdif controls */
-static struct snd_kcontrol_new snd_vortex_mixer_spdif[] __devinitdata = {
+static struct snd_kcontrol_new snd_vortex_mixer_spdif[] = {
 	{
 		.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
 		.name =		SNDRV_CTL_NAME_IEC958("",PLAYBACK,DEFAULT),
@@ -598,7 +598,7 @@ static int snd_vortex_pcm_vol_put(struct snd_kcontrol *kcontrol,
 
 static const DECLARE_TLV_DB_MINMAX(vortex_pcm_vol_db_scale, -9600, 2400);
 
-static struct snd_kcontrol_new snd_vortex_pcm_vol __devinitdata = {
+static struct snd_kcontrol_new snd_vortex_pcm_vol = {
 	.iface = SNDRV_CTL_ELEM_IFACE_PCM,
 	.name = "PCM Playback Volume",
 	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
diff --git a/sound/pci/aw2/aw2-alsa.c b/sound/pci/aw2/aw2-alsa.c
index 4189705..c1f35e4 100644
--- a/sound/pci/aw2/aw2-alsa.c
+++ b/sound/pci/aw2/aw2-alsa.c
@@ -202,7 +202,7 @@ static struct snd_pcm_ops snd_aw2_capture_ops = {
 	.pointer = snd_aw2_pcm_pointer_capture,
 };
 
-static struct snd_kcontrol_new aw2_control __devinitdata = {
+static struct snd_kcontrol_new aw2_control = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "PCM Capture Route",
 	.index = 0,
diff --git a/sound/pci/azt3328.c b/sound/pci/azt3328.c
index 5e4031b..8c3502d 100644
--- a/sound/pci/azt3328.c
+++ b/sound/pci/azt3328.c
@@ -1170,7 +1170,7 @@ snd_azf3328_put_mixer_enum(struct snd_kcontrol *kcontrol,
 	return (nreg != oreg);
 }
 
-static struct snd_kcontrol_new snd_azf3328_mixer_controls[] __devinitdata = {
+static struct snd_kcontrol_new snd_azf3328_mixer_controls[] = {
 	AZF3328_MIXER_SWITCH("Master Playback Switch", IDX_MIXER_PLAY_MASTER, 15, 1),
 	AZF3328_MIXER_VOL_STEREO("Master Playback Volume", IDX_MIXER_PLAY_MASTER, 0x1f, 1),
 	AZF3328_MIXER_SWITCH("PCM Playback Switch", IDX_MIXER_WAVEOUT, 15, 1),
@@ -1228,7 +1228,7 @@ static struct snd_kcontrol_new snd_azf3328_mixer_controls[] __devinitdata = {
 #endif
 };
 
-static u16 __devinitdata snd_azf3328_init_values[][2] = {
+static u16 snd_azf3328_init_values[][2] = {
         { IDX_MIXER_PLAY_MASTER,	MIXER_MUTE_MASK|0x1f1f },
         { IDX_MIXER_MODEMOUT,		MIXER_MUTE_MASK|0x1f1f },
 	{ IDX_MIXER_BASSTREBLE,		0x0000 },
diff --git a/sound/pci/bt87x.c b/sound/pci/bt87x.c
index 6cfb4ee..354ec5a 100644
--- a/sound/pci/bt87x.c
+++ b/sound/pci/bt87x.c
@@ -164,7 +164,7 @@ struct snd_bt87x_board {
 	unsigned no_digital:1;	/* No digital input */
 };
 
-static __devinitdata struct snd_bt87x_board snd_bt87x_boards[] = {
+static struct snd_bt87x_board snd_bt87x_boards[] = {
 	[SND_BT87X_BOARD_UNKNOWN] = {
 		.dig_rate = 32000, /* just a guess */
 	},
@@ -822,7 +822,7 @@ MODULE_DEVICE_TABLE(pci, snd_bt87x_ids);
  * (DVB cards use the audio function to transfer MPEG data) */
 static struct {
 	unsigned short subvendor, subdevice;
-} blacklist[] __devinitdata = {
+} blacklist[] = {
 	{0x0071, 0x0101}, /* Nebula Electronics DigiTV */
 	{0x11bd, 0x001c}, /* Pinnacle PCTV Sat */
 	{0x11bd, 0x0026}, /* Pinnacle PCTV SAT CI */
diff --git a/sound/pci/ca0106/ca0106_mixer.c b/sound/pci/ca0106/ca0106_mixer.c
index 2d040ef..dac09e6 100644
--- a/sound/pci/ca0106/ca0106_mixer.c
+++ b/sound/pci/ca0106/ca0106_mixer.c
@@ -325,7 +325,7 @@ static int snd_ca0106_capture_mic_line_in_put(struct snd_kcontrol *kcontrol,
         return change;
 }
 
-static struct snd_kcontrol_new snd_ca0106_capture_mic_line_in __devinitdata =
+static struct snd_kcontrol_new snd_ca0106_capture_mic_line_in =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =		"Shared Mic/Line in Capture Switch",
@@ -334,7 +334,7 @@ static struct snd_kcontrol_new snd_ca0106_capture_mic_line_in __devinitdata =
 	.put =		snd_ca0106_capture_mic_line_in_put
 };
 
-static struct snd_kcontrol_new snd_ca0106_capture_line_in_side_out __devinitdata =
+static struct snd_kcontrol_new snd_ca0106_capture_line_in_side_out =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =		"Shared Line in/Side out Capture Switch",
@@ -588,7 +588,7 @@ static int spi_mute_put(struct snd_kcontrol *kcontrol,
 	.private_value = ((chid) << 8) | (reg)			\
 }
 
-static struct snd_kcontrol_new snd_ca0106_volume_ctls[] __devinitdata = {
+static struct snd_kcontrol_new snd_ca0106_volume_ctls[] = {
 	CA_VOLUME("Analog Front Playback Volume",
 		  CONTROL_FRONT_CHANNEL, PLAYBACK_VOLUME2),
         CA_VOLUME("Analog Rear Playback Volume",
@@ -669,7 +669,7 @@ static struct snd_kcontrol_new snd_ca0106_volume_ctls[] __devinitdata = {
 	.private_value = chid					\
 }
 
-static struct snd_kcontrol_new snd_ca0106_volume_i2c_adc_ctls[] __devinitdata = {
+static struct snd_kcontrol_new snd_ca0106_volume_i2c_adc_ctls[] = {
         I2C_VOLUME("Phone Capture Volume", 0),
         I2C_VOLUME("Mic Capture Volume", 1),
         I2C_VOLUME("Line in Capture Volume", 2),
@@ -773,10 +773,9 @@ static int rename_ctl(struct snd_card *card, const char *src, const char *dst)
 		}							\
 	} while (0)
 
-static __devinitdata
-DECLARE_TLV_DB_SCALE(snd_ca0106_master_db_scale, -6375, 25, 1);
+static DECLARE_TLV_DB_SCALE(snd_ca0106_master_db_scale, -6375, 25, 1);
 
-static char *slave_vols[] __devinitdata = {
+static char *slave_vols[] = {
 	"Analog Front Playback Volume",
         "Analog Rear Playback Volume",
 	"Analog Center/LFE Playback Volume",
@@ -789,7 +788,7 @@ static char *slave_vols[] __devinitdata = {
 	NULL
 };
 
-static char *slave_sws[] __devinitdata = {
+static char *slave_sws[] = {
 	"Analog Front Playback Switch",
 	"Analog Rear Playback Switch",
 	"Analog Center/LFE Playback Switch",
diff --git a/sound/pci/cmipci.c b/sound/pci/cmipci.c
index 86ca0ab..d67209a 100644
--- a/sound/pci/cmipci.c
+++ b/sound/pci/cmipci.c
@@ -1045,7 +1045,7 @@ static int snd_cmipci_spdif_default_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_cmipci_spdif_default __devinitdata =
+static struct snd_kcontrol_new snd_cmipci_spdif_default =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
 	.name =		SNDRV_CTL_NAME_IEC958("",PLAYBACK,DEFAULT),
@@ -1072,7 +1072,7 @@ static int snd_cmipci_spdif_mask_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_cmipci_spdif_mask __devinitdata =
+static struct snd_kcontrol_new snd_cmipci_spdif_mask =
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ,
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
@@ -1119,7 +1119,7 @@ static int snd_cmipci_spdif_stream_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_cmipci_spdif_stream __devinitdata =
+static struct snd_kcontrol_new snd_cmipci_spdif_stream =
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_INACTIVE,
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
@@ -2290,7 +2290,7 @@ static int snd_cmipci_put_native_mixer_sensitive(struct snd_kcontrol *kcontrol,
 }
 
 
-static struct snd_kcontrol_new snd_cmipci_mixers[] __devinitdata = {
+static struct snd_kcontrol_new snd_cmipci_mixers[] = {
 	CMIPCI_SB_VOL_STEREO("Master Playback Volume", SB_DSP4_MASTER_DEV, 3, 31),
 	CMIPCI_MIXER_SW_MONO("3D Control - Switch", CM_REG_MIXER1, CM_X3DEN_SHIFT, 0),
 	CMIPCI_SB_VOL_STEREO("PCM Playback Volume", SB_DSP4_PCM_DEV, 3, 31),
@@ -2601,7 +2601,7 @@ static int snd_cmipci_mic_in_mode_put(struct snd_kcontrol *kcontrol,
 }
 
 /* both for CM8338/8738 */
-static struct snd_kcontrol_new snd_cmipci_mixer_switches[] __devinitdata = {
+static struct snd_kcontrol_new snd_cmipci_mixer_switches[] = {
 	DEFINE_MIXER_SWITCH("Four Channel Mode", fourch),
 	{
 		.name = "Line-In Mode",
@@ -2613,11 +2613,11 @@ static struct snd_kcontrol_new snd_cmipci_mixer_switches[] __devinitdata = {
 };
 
 /* for non-multichannel chips */
-static struct snd_kcontrol_new snd_cmipci_nomulti_switch __devinitdata =
+static struct snd_kcontrol_new snd_cmipci_nomulti_switch =
 DEFINE_MIXER_SWITCH("Exchange DAC", exchange_dac);
 
 /* only for CM8738 */
-static struct snd_kcontrol_new snd_cmipci_8738_mixer_switches[] __devinitdata = {
+static struct snd_kcontrol_new snd_cmipci_8738_mixer_switches[] = {
 #if 0 /* controlled in pcm device */
 	DEFINE_MIXER_SWITCH("IEC958 In Record", spdif_in),
 	DEFINE_MIXER_SWITCH("IEC958 Out", spdif_out),
@@ -2639,14 +2639,14 @@ static struct snd_kcontrol_new snd_cmipci_8738_mixer_switches[] __devinitdata =
 };
 
 /* only for model 033/037 */
-static struct snd_kcontrol_new snd_cmipci_old_mixer_switches[] __devinitdata = {
+static struct snd_kcontrol_new snd_cmipci_old_mixer_switches[] = {
 	DEFINE_MIXER_SWITCH("IEC958 Mix Analog", spdif_dac_out),
 	DEFINE_MIXER_SWITCH("IEC958 In Phase Inverse", spdi_phase),
 	DEFINE_MIXER_SWITCH("IEC958 In Select", spdif_in_sel1),
 };
 
 /* only for model 039 or later */
-static struct snd_kcontrol_new snd_cmipci_extra_mixer_switches[] __devinitdata = {
+static struct snd_kcontrol_new snd_cmipci_extra_mixer_switches[] = {
 	DEFINE_MIXER_SWITCH("IEC958 In Select", spdif_in_sel2),
 	DEFINE_MIXER_SWITCH("IEC958 In Phase Inverse", spdi_phase2),
 	{
@@ -2659,7 +2659,7 @@ static struct snd_kcontrol_new snd_cmipci_extra_mixer_switches[] __devinitdata =
 };
 
 /* card control switches */
-static struct snd_kcontrol_new snd_cmipci_modem_switch __devinitdata =
+static struct snd_kcontrol_new snd_cmipci_modem_switch =
 DEFINE_CARD_SWITCH("Modem", modem);
 
 
diff --git a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
index c43feb0..d1a58a2 100644
--- a/sound/pci/cs46xx/cs46xx_lib.c
+++ b/sound/pci/cs46xx/cs46xx_lib.c
@@ -2092,7 +2092,7 @@ static int snd_cs46xx_spdif_stream_put(struct snd_kcontrol *kcontrol,
 #endif /* CONFIG_SND_CS46XX_NEW_DSP */
 
 
-static struct snd_kcontrol_new snd_cs46xx_controls[] __devinitdata = {
+static struct snd_kcontrol_new snd_cs46xx_controls[] = {
 {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "DAC Volume",
@@ -3477,7 +3477,7 @@ struct cs_card_type
 	void (*mixer_init)(struct snd_cs46xx *);
 };
 
-static struct cs_card_type __devinitdata cards[] = {
+static struct cs_card_type cards[] = {
 	{
 		.vendor = 0x1489,
 		.id = 0x7001,
diff --git a/sound/pci/cs5535audio/cs5535audio.c b/sound/pci/cs5535audio/cs5535audio.c
index fa953e2..cf188b2 100644
--- a/sound/pci/cs5535audio/cs5535audio.c
+++ b/sound/pci/cs5535audio/cs5535audio.c
@@ -43,7 +43,7 @@ static char *ac97_quirk;
 module_param(ac97_quirk, charp, 0444);
 MODULE_PARM_DESC(ac97_quirk, "AC'97 board specific workarounds.");
 
-static struct ac97_quirk ac97_quirks[] __devinitdata = {
+static struct ac97_quirk ac97_quirks[] = {
 #if 0 /* Not yet confirmed if all 5536 boards are HP only */
 	{
 		.subvendor = PCI_VENDOR_ID_AMD, 
diff --git a/sound/pci/cs5535audio/cs5535audio_olpc.c b/sound/pci/cs5535audio/cs5535audio_olpc.c
index 149e21e..6a98019 100644
--- a/sound/pci/cs5535audio/cs5535audio_olpc.c
+++ b/sound/pci/cs5535audio/cs5535audio_olpc.c
@@ -114,7 +114,7 @@ static int olpc_mic_put(struct snd_kcontrol *kctl, struct snd_ctl_elem_value *v)
 	return 1;
 }
 
-static struct snd_kcontrol_new olpc_cs5535audio_ctls[] __devinitdata = {
+static struct snd_kcontrol_new olpc_cs5535audio_ctls[] = {
 {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "DC Mode Enable",
diff --git a/sound/pci/ctxfi/ctatc.c b/sound/pci/ctxfi/ctatc.c
index 92054e7..4becd663 100644
--- a/sound/pci/ctxfi/ctatc.c
+++ b/sound/pci/ctxfi/ctatc.c
@@ -38,7 +38,7 @@
 			    | (0x10 << 16) \
 			    | ((IEC958_AES3_CON_FS_48000) << 24))
 
-static struct snd_pci_quirk __devinitdata subsys_20k1_list[] = {
+static struct snd_pci_quirk subsys_20k1_list[] = {
 	SND_PCI_QUIRK(PCI_VENDOR_ID_CREATIVE, 0x0022, "SB055x", CTSB055X),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_CREATIVE, 0x002f, "SB055x", CTSB055X),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_CREATIVE, 0x0029, "SB073x", CTSB073X),
@@ -48,7 +48,7 @@ static struct snd_pci_quirk __devinitdata subsys_20k1_list[] = {
 	{ } /* terminator */
 };
 
-static struct snd_pci_quirk __devinitdata subsys_20k2_list[] = {
+static struct snd_pci_quirk subsys_20k2_list[] = {
 	SND_PCI_QUIRK(PCI_VENDOR_ID_CREATIVE, PCI_SUBDEVICE_ID_CREATIVE_SB0760,
 		      "SB0760", CTSB0760),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_CREATIVE, PCI_SUBDEVICE_ID_CREATIVE_SB1270,
@@ -1614,7 +1614,7 @@ static int atc_resume(struct ct_atc *atc)
 }
 #endif
 
-static struct ct_atc atc_preset __devinitdata = {
+static struct ct_atc atc_preset = {
 	.map_audio_buffer = ct_map_audio_buffer,
 	.unmap_audio_buffer = ct_unmap_audio_buffer,
 	.pcm_playback_prepare = atc_pcm_playback_prepare,
diff --git a/sound/pci/ctxfi/cthw20k1.c b/sound/pci/ctxfi/cthw20k1.c
index 65a0169..6ac40be 100644
--- a/sound/pci/ctxfi/cthw20k1.c
+++ b/sound/pci/ctxfi/cthw20k1.c
@@ -2171,7 +2171,7 @@ static void hw_write_pci(struct hw *hw, u32 reg, u32 data)
 		&container_of(hw, struct hw20k1, hw)->reg_pci_lock, flags);
 }
 
-static struct hw ct20k1_preset __devinitdata = {
+static struct hw ct20k1_preset = {
 	.irq = -1,
 
 	.card_init = hw_card_init,
diff --git a/sound/pci/ctxfi/cthw20k2.c b/sound/pci/ctxfi/cthw20k2.c
index 3f2a3ad..b143886 100644
--- a/sound/pci/ctxfi/cthw20k2.c
+++ b/sound/pci/ctxfi/cthw20k2.c
@@ -2237,7 +2237,7 @@ static void hw_write_20kx(struct hw *hw, u32 reg, u32 data)
 	writel(data, (void *)(hw->mem_base + reg));
 }
 
-static struct hw ct20k2_preset __devinitdata = {
+static struct hw ct20k2_preset = {
 	.irq = -1,
 
 	.card_init = hw_card_init,
diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index 3ba1585..f4400ba 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -1050,7 +1050,7 @@ static int snd_echo_output_gain_put(struct snd_kcontrol *kcontrol,
 
 #ifdef ECHOCARD_HAS_LINE_OUT_GAIN
 /* On the Mia this one controls the line-out volume */
-static struct snd_kcontrol_new snd_echo_line_output_gain __devinitdata = {
+static struct snd_kcontrol_new snd_echo_line_output_gain = {
 	.name = "Line Playback Volume",
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
@@ -1061,7 +1061,7 @@ static struct snd_kcontrol_new snd_echo_line_output_gain __devinitdata = {
 	.tlv = {.p = db_scale_output_gain},
 };
 #else
-static struct snd_kcontrol_new snd_echo_pcm_output_gain __devinitdata = {
+static struct snd_kcontrol_new snd_echo_pcm_output_gain = {
 	.name = "PCM Playback Volume",
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_TLV_READ,
@@ -1131,7 +1131,7 @@ static int snd_echo_input_gain_put(struct snd_kcontrol *kcontrol,
 
 static const DECLARE_TLV_DB_SCALE(db_scale_input_gain, -2500, 50, 0);
 
-static struct snd_kcontrol_new snd_echo_line_input_gain __devinitdata = {
+static struct snd_kcontrol_new snd_echo_line_input_gain = {
 	.name = "Line Capture Volume",
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_TLV_READ,
@@ -1195,7 +1195,7 @@ static int snd_echo_output_nominal_put(struct snd_kcontrol *kcontrol,
 	return changed;
 }
 
-static struct snd_kcontrol_new snd_echo_output_nominal_level __devinitdata = {
+static struct snd_kcontrol_new snd_echo_output_nominal_level = {
 	.name = "Line Playback Switch (-10dBV)",
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.info = snd_echo_output_nominal_info,
@@ -1261,7 +1261,7 @@ static int snd_echo_input_nominal_put(struct snd_kcontrol *kcontrol,
 	return changed;
 }
 
-static struct snd_kcontrol_new snd_echo_intput_nominal_level __devinitdata = {
+static struct snd_kcontrol_new snd_echo_intput_nominal_level = {
 	.name = "Line Capture Switch (-10dBV)",
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.info = snd_echo_input_nominal_info,
@@ -1327,7 +1327,7 @@ static int snd_echo_mixer_put(struct snd_kcontrol *kcontrol,
 	return changed;
 }
 
-static struct snd_kcontrol_new snd_echo_monitor_mixer __devinitdata = {
+static struct snd_kcontrol_new snd_echo_monitor_mixer = {
 	.name = "Monitor Mixer Volume",
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_TLV_READ,
@@ -1395,7 +1395,7 @@ static int snd_echo_vmixer_put(struct snd_kcontrol *kcontrol,
 	return changed;
 }
 
-static struct snd_kcontrol_new snd_echo_vmixer __devinitdata = {
+static struct snd_kcontrol_new snd_echo_vmixer = {
 	.name = "VMixer Volume",
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_TLV_READ,
@@ -1490,7 +1490,7 @@ static int snd_echo_digital_mode_put(struct snd_kcontrol *kcontrol,
 	return changed;
 }
 
-static struct snd_kcontrol_new snd_echo_digital_mode_switch __devinitdata = {
+static struct snd_kcontrol_new snd_echo_digital_mode_switch = {
 	.name = "Digital mode Switch",
 	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
 	.info = snd_echo_digital_mode_info,
@@ -1547,7 +1547,7 @@ static int snd_echo_spdif_mode_put(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_echo_spdif_mode_switch __devinitdata = {
+static struct snd_kcontrol_new snd_echo_spdif_mode_switch = {
 	.name = "S/PDIF mode Switch",
 	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
 	.info = snd_echo_spdif_mode_info,
@@ -1626,7 +1626,7 @@ static int snd_echo_clock_source_put(struct snd_kcontrol *kcontrol,
 	return changed;
 }
 
-static struct snd_kcontrol_new snd_echo_clock_source_switch __devinitdata = {
+static struct snd_kcontrol_new snd_echo_clock_source_switch = {
 	.name = "Sample Clock Source",
 	.iface = SNDRV_CTL_ELEM_IFACE_PCM,
 	.info = snd_echo_clock_source_info,
@@ -1669,7 +1669,7 @@ static int snd_echo_phantom_power_put(struct snd_kcontrol *kcontrol,
 	return changed;
 }
 
-static struct snd_kcontrol_new snd_echo_phantom_power_switch __devinitdata = {
+static struct snd_kcontrol_new snd_echo_phantom_power_switch = {
 	.name = "Phantom power Switch",
 	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
 	.info = snd_echo_phantom_power_info,
@@ -1712,7 +1712,7 @@ static int snd_echo_automute_put(struct snd_kcontrol *kcontrol,
 	return changed;
 }
 
-static struct snd_kcontrol_new snd_echo_automute_switch __devinitdata = {
+static struct snd_kcontrol_new snd_echo_automute_switch = {
 	.name = "Digital Capture Switch (automute)",
 	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
 	.info = snd_echo_automute_info,
@@ -1739,7 +1739,7 @@ static int snd_echo_vumeters_switch_put(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
-static struct snd_kcontrol_new snd_echo_vumeters_switch __devinitdata = {
+static struct snd_kcontrol_new snd_echo_vumeters_switch = {
 	.name = "VU-meters Switch",
 	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
 	.access = SNDRV_CTL_ELEM_ACCESS_WRITE,
@@ -1780,7 +1780,7 @@ static int snd_echo_vumeters_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_echo_vumeters __devinitdata = {
+static struct snd_kcontrol_new snd_echo_vumeters = {
 	.name = "VU-meters",
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.access = SNDRV_CTL_ELEM_ACCESS_READ |
@@ -1836,7 +1836,7 @@ static int snd_echo_channels_info_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_echo_channels_info __devinitdata = {
+static struct snd_kcontrol_new snd_echo_channels_info = {
 	.name = "Channels info",
 	.iface = SNDRV_CTL_ELEM_IFACE_HWDEP,
 	.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
diff --git a/sound/pci/emu10k1/emu10k1x.c b/sound/pci/emu10k1/emu10k1x.c
index 45c7acb..9c618c2 100644
--- a/sound/pci/emu10k1/emu10k1x.c
+++ b/sound/pci/emu10k1/emu10k1x.c
@@ -1115,7 +1115,7 @@ static int snd_emu10k1x_shared_spdif_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_emu10k1x_shared_spdif __devinitdata =
+static struct snd_kcontrol_new snd_emu10k1x_shared_spdif =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =		"Analog/Digital Output Jack",
diff --git a/sound/pci/emu10k1/emumixer.c b/sound/pci/emu10k1/emumixer.c
index 00ff418..ec991da 100644
--- a/sound/pci/emu10k1/emumixer.c
+++ b/sound/pci/emu10k1/emumixer.c
@@ -510,7 +510,7 @@ static int snd_emu1010_input_source_put(struct snd_kcontrol *kcontrol,
 	.private_value = chid					\
 }
 
-static struct snd_kcontrol_new snd_emu1010_output_enum_ctls[] __devinitdata = {
+static struct snd_kcontrol_new snd_emu1010_output_enum_ctls[] = {
 	EMU1010_SOURCE_OUTPUT("Dock DAC1 Left Playback Enum", 0),
 	EMU1010_SOURCE_OUTPUT("Dock DAC1 Right Playback Enum", 1),
 	EMU1010_SOURCE_OUTPUT("Dock DAC2 Left Playback Enum", 2),
@@ -539,7 +539,7 @@ static struct snd_kcontrol_new snd_emu1010_output_enum_ctls[] __devinitdata = {
 
 
 /* 1616(m) cardbus */
-static struct snd_kcontrol_new snd_emu1616_output_enum_ctls[] __devinitdata = {
+static struct snd_kcontrol_new snd_emu1616_output_enum_ctls[] = {
 	EMU1010_SOURCE_OUTPUT("Dock DAC1 Left Playback Enum", 0),
 	EMU1010_SOURCE_OUTPUT("Dock DAC1 Right Playback Enum", 1),
 	EMU1010_SOURCE_OUTPUT("Dock DAC2 Left Playback Enum", 2),
@@ -571,7 +571,7 @@ static struct snd_kcontrol_new snd_emu1616_output_enum_ctls[] __devinitdata = {
 	.private_value = chid					\
 }
 
-static struct snd_kcontrol_new snd_emu1010_input_enum_ctls[] __devinitdata = {
+static struct snd_kcontrol_new snd_emu1010_input_enum_ctls[] = {
 	EMU1010_SOURCE_INPUT("DSP 0 Capture Enum", 0),
 	EMU1010_SOURCE_INPUT("DSP 1 Capture Enum", 1),
 	EMU1010_SOURCE_INPUT("DSP 2 Capture Enum", 2),
@@ -639,7 +639,7 @@ static int snd_emu1010_adc_pads_put(struct snd_kcontrol *kcontrol, struct snd_ct
 	.private_value = chid					\
 }
 
-static struct snd_kcontrol_new snd_emu1010_adc_pads[] __devinitdata = {
+static struct snd_kcontrol_new snd_emu1010_adc_pads[] = {
 	EMU1010_ADC_PADS("ADC1 14dB PAD Audio Dock Capture Switch", EMU_HANA_DOCK_ADC_PAD1),
 	EMU1010_ADC_PADS("ADC2 14dB PAD Audio Dock Capture Switch", EMU_HANA_DOCK_ADC_PAD2),
 	EMU1010_ADC_PADS("ADC3 14dB PAD Audio Dock Capture Switch", EMU_HANA_DOCK_ADC_PAD3),
@@ -687,7 +687,7 @@ static int snd_emu1010_dac_pads_put(struct snd_kcontrol *kcontrol, struct snd_ct
 	.private_value = chid					\
 }
 
-static struct snd_kcontrol_new snd_emu1010_dac_pads[] __devinitdata = {
+static struct snd_kcontrol_new snd_emu1010_dac_pads[] = {
 	EMU1010_DAC_PADS("DAC1 Audio Dock 14dB PAD Playback Switch", EMU_HANA_DOCK_DAC_PAD1),
 	EMU1010_DAC_PADS("DAC2 Audio Dock 14dB PAD Playback Switch", EMU_HANA_DOCK_DAC_PAD2),
 	EMU1010_DAC_PADS("DAC3 Audio Dock 14dB PAD Playback Switch", EMU_HANA_DOCK_DAC_PAD3),
@@ -989,7 +989,7 @@ static int snd_audigy_i2c_volume_put(struct snd_kcontrol *kcontrol,
 }
 
 
-static struct snd_kcontrol_new snd_audigy_i2c_volume_ctls[] __devinitdata = {
+static struct snd_kcontrol_new snd_audigy_i2c_volume_ctls[] = {
 	I2C_VOLUME("Mic Capture Volume", 0),
 	I2C_VOLUME("Line Capture Volume", 0)
 };
@@ -1621,7 +1621,7 @@ static int snd_emu10k1_shared_spdif_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_emu10k1_shared_spdif __devinitdata =
+static struct snd_kcontrol_new snd_emu10k1_shared_spdif =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =		"SB Live Analog/Digital Output Jack",
@@ -1630,7 +1630,7 @@ static struct snd_kcontrol_new snd_emu10k1_shared_spdif __devinitdata =
 	.put =		snd_emu10k1_shared_spdif_put
 };
 
-static struct snd_kcontrol_new snd_audigy_shared_spdif __devinitdata =
+static struct snd_kcontrol_new snd_audigy_shared_spdif =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =		"Audigy Analog/Digital Output Jack",
@@ -1668,7 +1668,7 @@ static int snd_audigy_capture_boost_put(struct snd_kcontrol *kcontrol,
 	return snd_ac97_update(emu->ac97, AC97_REC_GAIN, val);
 }
 
-static struct snd_kcontrol_new snd_audigy_capture_boost __devinitdata =
+static struct snd_kcontrol_new snd_audigy_capture_boost =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =		"Analog Capture Boost",
diff --git a/sound/pci/emu10k1/p16v.c b/sound/pci/emu10k1/p16v.c
index 3f08dd7..7e2025c 100644
--- a/sound/pci/emu10k1/p16v.c
+++ b/sound/pci/emu10k1/p16v.c
@@ -854,7 +854,7 @@ static const DECLARE_TLV_DB_SCALE(snd_p16v_db_scale1, -5175, 25, 1);
 	.private_value = ((xreg) | ((xhl) << 8)) \
 }
 
-static struct snd_kcontrol_new p16v_mixer_controls[] __devinitdata = {
+static struct snd_kcontrol_new p16v_mixer_controls[] = {
 	P16V_VOL("HD Analog Front Playback Volume", PLAYBACK_VOLUME_MIXER9, 0),
 	P16V_VOL("HD Analog Rear Playback Volume", PLAYBACK_VOLUME_MIXER10, 1),
 	P16V_VOL("HD Analog Center/LFE Playback Volume", PLAYBACK_VOLUME_MIXER9, 1),
diff --git a/sound/pci/ens1370.c b/sound/pci/ens1370.c
index 5ed22dc..2e42aab 100644
--- a/sound/pci/ens1370.c
+++ b/sound/pci/ens1370.c
@@ -1484,7 +1484,7 @@ static int snd_es1371_spdif_put(struct snd_kcontrol *kcontrol,
 
 
 /* spdif controls */
-static struct snd_kcontrol_new snd_es1371_mixer_spdif[] __devinitdata = {
+static struct snd_kcontrol_new snd_es1371_mixer_spdif[] = {
 	ES1371_SPDIF(SNDRV_CTL_NAME_IEC958("",PLAYBACK,SWITCH)),
 	{
 		.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
@@ -1546,7 +1546,7 @@ static int snd_es1373_rear_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_ens1373_rear __devinitdata =
+static struct snd_kcontrol_new snd_ens1373_rear =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =		"AC97 2ch->4ch Copy Switch",
@@ -1591,7 +1591,7 @@ static int snd_es1373_line_put(struct snd_kcontrol *kcontrol,
 	return changed;
 }
 
-static struct snd_kcontrol_new snd_ens1373_line __devinitdata =
+static struct snd_kcontrol_new snd_ens1373_line =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =		"Line In->Rear Out Switch",
@@ -1625,7 +1625,7 @@ static int es1371_quirk_lookup(struct ensoniq *ensoniq,
 	return 0;
 }
 
-static struct es1371_quirk es1371_spdif_present[] __devinitdata = {
+static struct es1371_quirk es1371_spdif_present[] = {
 	{ .vid = PCI_VENDOR_ID_ENSONIQ, .did = PCI_DEVICE_ID_ENSONIQ_CT5880, .rev = CT5880REV_CT5880_C },
 	{ .vid = PCI_VENDOR_ID_ENSONIQ, .did = PCI_DEVICE_ID_ENSONIQ_CT5880, .rev = CT5880REV_CT5880_D },
 	{ .vid = PCI_VENDOR_ID_ENSONIQ, .did = PCI_DEVICE_ID_ENSONIQ_CT5880, .rev = CT5880REV_CT5880_E },
@@ -1634,7 +1634,7 @@ static struct es1371_quirk es1371_spdif_present[] __devinitdata = {
 	{ .vid = PCI_ANY_ID, .did = PCI_ANY_ID }
 };
 
-static struct snd_pci_quirk ens1373_line_quirk[] __devinitdata = {
+static struct snd_pci_quirk ens1373_line_quirk[] = {
 	SND_PCI_QUIRK_ID(0x1274, 0x2000), /* GA-7DXR */
 	SND_PCI_QUIRK_ID(0x1458, 0xa000), /* GA-8IEXP */
 	{ } /* end */
@@ -1749,7 +1749,7 @@ static int snd_ensoniq_control_put(struct snd_kcontrol *kcontrol,
  * ENS1370 mixer
  */
 
-static struct snd_kcontrol_new snd_es1370_controls[2] __devinitdata = {
+static struct snd_kcontrol_new snd_es1370_controls[2] = {
 ENSONIQ_CONTROL("PCM 0 Output also on Line-In Jack", ES_1370_XCTL0),
 ENSONIQ_CONTROL("Mic +5V bias", ES_1370_XCTL1)
 };
@@ -1960,7 +1960,7 @@ static int snd_ensoniq_dev_free(struct snd_device *device)
 }
 
 #ifdef CHIP1371
-static struct snd_pci_quirk es1371_amplifier_hack[] __devinitdata = {
+static struct snd_pci_quirk es1371_amplifier_hack[] = {
 	SND_PCI_QUIRK_ID(0x107b, 0x2150),	/* Gateway Solo 2150 */
 	SND_PCI_QUIRK_ID(0x13bd, 0x100c),	/* EV1938 on Mebius PC-MJ100V */
 	SND_PCI_QUIRK_ID(0x1102, 0x5938),	/* Targa Xtender300 */
diff --git a/sound/pci/es1968.c b/sound/pci/es1968.c
index 076e461..71629cd 100644
--- a/sound/pci/es1968.c
+++ b/sound/pci/es1968.c
@@ -2650,7 +2650,7 @@ struct ess_device_list {
 	unsigned short vendor;	/* subsystem vendor id */
 };
 
-static struct ess_device_list pm_whitelist[] __devinitdata = {
+static struct ess_device_list pm_whitelist[] = {
 	{ TYPE_MAESTRO2E, 0x0e11 },	/* Compaq Armada */
 	{ TYPE_MAESTRO2E, 0x1028 },
 	{ TYPE_MAESTRO2E, 0x103c },
@@ -2661,7 +2661,7 @@ static struct ess_device_list pm_whitelist[] __devinitdata = {
 	{ TYPE_MAESTRO2, 0x125d },	/* a PCI card, e.g. SF64-PCE2 */
 };
 
-static struct ess_device_list mpu_blacklist[] __devinitdata = {
+static struct ess_device_list mpu_blacklist[] = {
 	{ TYPE_MAESTRO2, 0x125d },
 };
 
diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index aa18b03..446fc99 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -984,7 +984,7 @@ static const DECLARE_TLV_DB_SCALE(db_scale_dsp, -3450, 150, 0);
 
 #define FM801_CONTROLS ARRAY_SIZE(snd_fm801_controls)
 
-static struct snd_kcontrol_new snd_fm801_controls[] __devinitdata = {
+static struct snd_kcontrol_new snd_fm801_controls[] = {
 FM801_DOUBLE_TLV("Wave Playback Volume", FM801_PCM_VOL, 0, 8, 31, 1,
 		 db_scale_dsp),
 FM801_SINGLE("Wave Playback Switch", FM801_PCM_VOL, 15, 1, 1),
@@ -1005,7 +1005,7 @@ FM801_SINGLE("FM Playback Switch", FM801_FM_VOL, 15, 1, 1),
 
 #define FM801_CONTROLS_MULTI ARRAY_SIZE(snd_fm801_controls_multi)
 
-static struct snd_kcontrol_new snd_fm801_controls_multi[] __devinitdata = {
+static struct snd_kcontrol_new snd_fm801_controls_multi[] = {
 FM801_SINGLE("AC97 2ch->4ch Copy Switch", FM801_CODEC_CTRL, 7, 1, 0),
 FM801_SINGLE("AC97 18-bit Switch", FM801_CODEC_CTRL, 10, 1, 0),
 FM801_SINGLE(SNDRV_CTL_NAME_IEC958("",CAPTURE,SWITCH), FM801_I2S_MODE, 8, 1, 0),
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 716d233..2a3b9e4 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -600,7 +600,7 @@ enum {
 #define DELAYED_INITDATA_MARK
 #else
 #define DELAYED_INIT_MARK
-#define DELAYED_INITDATA_MARK	__devinitdata
+#define DELAYED_INITDATA_MARK
 #endif
 
 static char *driver_short_names[] DELAYED_INITDATA_MARK = {
@@ -2939,7 +2939,7 @@ static bool check_hdmi_disabled(struct pci_dev *pci)
 /*
  * white/black-listing for position_fix
  */
-static struct snd_pci_quirk position_fix_list[] __devinitdata = {
+static struct snd_pci_quirk position_fix_list[] = {
 	SND_PCI_QUIRK(0x1028, 0x01cc, "Dell D820", POS_FIX_LPIB),
 	SND_PCI_QUIRK(0x1028, 0x01de, "Dell Precision 390", POS_FIX_LPIB),
 	SND_PCI_QUIRK(0x103c, 0x306d, "HP dv3", POS_FIX_LPIB),
@@ -2994,7 +2994,7 @@ static int check_position_fix(struct azx *chip, int fix)
 /*
  * black-lists for probe_mask
  */
-static struct snd_pci_quirk probe_mask_list[] __devinitdata = {
+static struct snd_pci_quirk probe_mask_list[] = {
 	/* Thinkpad often breaks the controller communication when accessing
 	 * to the non-working (or non-existing) modem codec slot.
 	 */
@@ -3043,7 +3043,7 @@ static void check_probe_mask(struct azx *chip, int dev)
 /*
  * white/black-list for enable_msi
  */
-static struct snd_pci_quirk msi_black_list[] __devinitdata = {
+static struct snd_pci_quirk msi_black_list[] = {
 	SND_PCI_QUIRK(0x1043, 0x81f2, "ASUS", 0), /* Athlon64 X2 + nvidia */
 	SND_PCI_QUIRK(0x1043, 0x81f6, "ASUS", 0), /* nvidia */
 	SND_PCI_QUIRK(0x1043, 0x822d, "ASUS", 0), /* Athlon64 X2 + nvidia MCP55 */
diff --git a/sound/pci/ice1712/amp.c b/sound/pci/ice1712/amp.c
index 943cf4b..2f9b934 100644
--- a/sound/pci/ice1712/amp.c
+++ b/sound/pci/ice1712/amp.c
@@ -77,7 +77,7 @@ static int snd_vt1724_amp_add_controls(struct snd_ice1712 *ice)
 
 
 /* entry point */
-struct snd_ice1712_card_info snd_vt1724_amp_cards[] __devinitdata = {
+struct snd_ice1712_card_info snd_vt1724_amp_cards[] = {
 	{
 		.subvendor = VT1724_SUBDEVICE_AV710,
 		.name = "Chaintech AV-710",
diff --git a/sound/pci/ice1712/aureon.c b/sound/pci/ice1712/aureon.c
index 8d16da9..55902ec 100644
--- a/sound/pci/ice1712/aureon.c
+++ b/sound/pci/ice1712/aureon.c
@@ -1433,7 +1433,7 @@ static int aureon_oversampling_put(struct snd_kcontrol *kcontrol, struct snd_ctl
  * mixers
  */
 
-static struct snd_kcontrol_new aureon_dac_controls[] __devinitdata = {
+static struct snd_kcontrol_new aureon_dac_controls[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Master Playback Switch",
@@ -1548,7 +1548,7 @@ static struct snd_kcontrol_new aureon_dac_controls[] __devinitdata = {
 	}
 };
 
-static struct snd_kcontrol_new wm_controls[] __devinitdata = {
+static struct snd_kcontrol_new wm_controls[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "PCM Playback Switch",
@@ -1614,7 +1614,7 @@ static struct snd_kcontrol_new wm_controls[] __devinitdata = {
 	}
 };
 
-static struct snd_kcontrol_new ac97_controls[] __devinitdata = {
+static struct snd_kcontrol_new ac97_controls[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "AC97 Playback Switch",
@@ -1719,7 +1719,7 @@ static struct snd_kcontrol_new ac97_controls[] __devinitdata = {
 	}
 };
 
-static struct snd_kcontrol_new universe_ac97_controls[] __devinitdata = {
+static struct snd_kcontrol_new universe_ac97_controls[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "AC97 Playback Switch",
@@ -1851,7 +1851,7 @@ static struct snd_kcontrol_new universe_ac97_controls[] __devinitdata = {
 
 };
 
-static struct snd_kcontrol_new cs8415_controls[] __devinitdata = {
+static struct snd_kcontrol_new cs8415_controls[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = SNDRV_CTL_NAME_IEC958("", CAPTURE, SWITCH),
@@ -2174,7 +2174,7 @@ static int aureon_init(struct snd_ice1712 *ice)
  * hence the driver needs to sets up it properly.
  */
 
-static unsigned char aureon51_eeprom[] __devinitdata = {
+static unsigned char aureon51_eeprom[] = {
 	[ICE_EEP2_SYSCONF]     = 0x0a,	/* clock 512, spdif-in/ADC, 3DACs */
 	[ICE_EEP2_ACLINK]      = 0x80,	/* I2S */
 	[ICE_EEP2_I2S]         = 0xfc,	/* vol, 96k, 24bit, 192k */
@@ -2190,7 +2190,7 @@ static unsigned char aureon51_eeprom[] __devinitdata = {
 	[ICE_EEP2_GPIO_STATE2] = 0x00,
 };
 
-static unsigned char aureon71_eeprom[] __devinitdata = {
+static unsigned char aureon71_eeprom[] = {
 	[ICE_EEP2_SYSCONF]     = 0x0b,	/* clock 512, spdif-in/ADC, 4DACs */
 	[ICE_EEP2_ACLINK]      = 0x80,	/* I2S */
 	[ICE_EEP2_I2S]         = 0xfc,	/* vol, 96k, 24bit, 192k */
@@ -2207,7 +2207,7 @@ static unsigned char aureon71_eeprom[] __devinitdata = {
 };
 #define prodigy71_eeprom aureon71_eeprom
 
-static unsigned char aureon71_universe_eeprom[] __devinitdata = {
+static unsigned char aureon71_universe_eeprom[] = {
 	[ICE_EEP2_SYSCONF]     = 0x2b,	/* clock 512, mpu401, spdif-in/ADC,
 					 * 4DACs
 					 */
@@ -2225,7 +2225,7 @@ static unsigned char aureon71_universe_eeprom[] __devinitdata = {
 	[ICE_EEP2_GPIO_STATE2] = 0x00,
 };
 
-static unsigned char prodigy71lt_eeprom[] __devinitdata = {
+static unsigned char prodigy71lt_eeprom[] = {
 	[ICE_EEP2_SYSCONF]     = 0x4b,	/* clock 384, spdif-in/ADC, 4DACs */
 	[ICE_EEP2_ACLINK]      = 0x80,	/* I2S */
 	[ICE_EEP2_I2S]         = 0xfc,	/* vol, 96k, 24bit, 192k */
@@ -2243,7 +2243,7 @@ static unsigned char prodigy71lt_eeprom[] __devinitdata = {
 #define prodigy71xt_eeprom prodigy71lt_eeprom
 
 /* entry point */
-struct snd_ice1712_card_info snd_vt1724_aureon_cards[] __devinitdata = {
+struct snd_ice1712_card_info snd_vt1724_aureon_cards[] = {
 	{
 		.subvendor = VT1724_SUBDEVICE_AUREON51_SKY,
 		.name = "Terratec Aureon 5.1-Sky",
diff --git a/sound/pci/ice1712/delta.c b/sound/pci/ice1712/delta.c
index 1e8e5cf..ab2bca1 100644
--- a/sound/pci/ice1712/delta.c
+++ b/sound/pci/ice1712/delta.c
@@ -431,7 +431,7 @@ static int snd_ice1712_delta1010lt_wordclock_status_get(struct snd_kcontrol *kco
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_ice1712_delta1010lt_wordclock_status __devinitdata =
+static struct snd_kcontrol_new snd_ice1712_delta1010lt_wordclock_status =
 {
 	.access =	(SNDRV_CTL_ELEM_ACCESS_READ),
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
@@ -444,7 +444,7 @@ static struct snd_kcontrol_new snd_ice1712_delta1010lt_wordclock_status __devini
  * initialize the chips on M-Audio cards
  */
 
-static struct snd_akm4xxx akm_audiophile __devinitdata = {
+static struct snd_akm4xxx akm_audiophile = {
 	.type = SND_AK4528,
 	.num_adcs = 2,
 	.num_dacs = 2,
@@ -453,7 +453,7 @@ static struct snd_akm4xxx akm_audiophile __devinitdata = {
 	}
 };
 
-static struct snd_ak4xxx_private akm_audiophile_priv __devinitdata = {
+static struct snd_ak4xxx_private akm_audiophile_priv = {
 	.caddr = 2,
 	.cif = 0,
 	.data_mask = ICE1712_DELTA_AP_DOUT,
@@ -465,7 +465,7 @@ static struct snd_ak4xxx_private akm_audiophile_priv __devinitdata = {
 	.mask_flags = 0,
 };
 
-static struct snd_akm4xxx akm_delta410 __devinitdata = {
+static struct snd_akm4xxx akm_delta410 = {
 	.type = SND_AK4529,
 	.num_adcs = 2,
 	.num_dacs = 8,
@@ -474,7 +474,7 @@ static struct snd_akm4xxx akm_delta410 __devinitdata = {
 	}
 };
 
-static struct snd_ak4xxx_private akm_delta410_priv __devinitdata = {
+static struct snd_ak4xxx_private akm_delta410_priv = {
 	.caddr = 0,
 	.cif = 0,
 	.data_mask = ICE1712_DELTA_AP_DOUT,
@@ -486,7 +486,7 @@ static struct snd_ak4xxx_private akm_delta410_priv __devinitdata = {
 	.mask_flags = 0,
 };
 
-static struct snd_akm4xxx akm_delta1010lt __devinitdata = {
+static struct snd_akm4xxx akm_delta1010lt = {
 	.type = SND_AK4524,
 	.num_adcs = 8,
 	.num_dacs = 8,
@@ -496,7 +496,7 @@ static struct snd_akm4xxx akm_delta1010lt __devinitdata = {
 	}
 };
 
-static struct snd_ak4xxx_private akm_delta1010lt_priv __devinitdata = {
+static struct snd_ak4xxx_private akm_delta1010lt_priv = {
 	.caddr = 2,
 	.cif = 0, /* the default level of the CIF pin from AK4524 */
 	.data_mask = ICE1712_DELTA_1010LT_DOUT,
@@ -508,7 +508,7 @@ static struct snd_ak4xxx_private akm_delta1010lt_priv __devinitdata = {
 	.mask_flags = 0,
 };
 
-static struct snd_akm4xxx akm_delta66e __devinitdata = {
+static struct snd_akm4xxx akm_delta66e = {
 	.type = SND_AK4524,
 	.num_adcs = 4,
 	.num_dacs = 4,
@@ -518,7 +518,7 @@ static struct snd_akm4xxx akm_delta66e __devinitdata = {
 	}
 };
 
-static struct snd_ak4xxx_private akm_delta66e_priv __devinitdata = {
+static struct snd_ak4xxx_private akm_delta66e_priv = {
 	.caddr = 2,
 	.cif = 0, /* the default level of the CIF pin from AK4524 */
 	.data_mask = ICE1712_DELTA_66E_DOUT,
@@ -531,7 +531,7 @@ static struct snd_ak4xxx_private akm_delta66e_priv __devinitdata = {
 };
 
 
-static struct snd_akm4xxx akm_delta44 __devinitdata = {
+static struct snd_akm4xxx akm_delta44 = {
 	.type = SND_AK4524,
 	.num_adcs = 4,
 	.num_dacs = 4,
@@ -541,7 +541,7 @@ static struct snd_akm4xxx akm_delta44 __devinitdata = {
 	}
 };
 
-static struct snd_ak4xxx_private akm_delta44_priv __devinitdata = {
+static struct snd_ak4xxx_private akm_delta44_priv = {
 	.caddr = 2,
 	.cif = 0, /* the default level of the CIF pin from AK4524 */
 	.data_mask = ICE1712_DELTA_CODEC_SERIAL_DATA,
@@ -553,7 +553,7 @@ static struct snd_ak4xxx_private akm_delta44_priv __devinitdata = {
 	.mask_flags = 0,
 };
 
-static struct snd_akm4xxx akm_vx442 __devinitdata = {
+static struct snd_akm4xxx akm_vx442 = {
 	.type = SND_AK4524,
 	.num_adcs = 4,
 	.num_dacs = 4,
@@ -563,7 +563,7 @@ static struct snd_akm4xxx akm_vx442 __devinitdata = {
 	}
 };
 
-static struct snd_ak4xxx_private akm_vx442_priv __devinitdata = {
+static struct snd_ak4xxx_private akm_vx442_priv = {
 	.caddr = 2,
 	.cif = 0,
 	.data_mask = ICE1712_VX442_DOUT,
@@ -713,15 +713,15 @@ static int snd_ice1712_delta_init(struct snd_ice1712 *ice)
  * additional controls for M-Audio cards
  */
 
-static struct snd_kcontrol_new snd_ice1712_delta1010_wordclock_select __devinitdata =
+static struct snd_kcontrol_new snd_ice1712_delta1010_wordclock_select =
 ICE1712_GPIO(SNDRV_CTL_ELEM_IFACE_MIXER, "Word Clock Sync", 0, ICE1712_DELTA_WORD_CLOCK_SELECT, 1, 0);
-static struct snd_kcontrol_new snd_ice1712_delta1010lt_wordclock_select __devinitdata =
+static struct snd_kcontrol_new snd_ice1712_delta1010lt_wordclock_select =
 ICE1712_GPIO(SNDRV_CTL_ELEM_IFACE_MIXER, "Word Clock Sync", 0, ICE1712_DELTA_1010LT_WORDCLOCK, 0, 0);
-static struct snd_kcontrol_new snd_ice1712_delta1010_wordclock_status __devinitdata =
+static struct snd_kcontrol_new snd_ice1712_delta1010_wordclock_status =
 ICE1712_GPIO(SNDRV_CTL_ELEM_IFACE_MIXER, "Word Clock Status", 0, ICE1712_DELTA_WORD_CLOCK_STATUS, 1, SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE);
-static struct snd_kcontrol_new snd_ice1712_deltadio2496_spdif_in_select __devinitdata =
+static struct snd_kcontrol_new snd_ice1712_deltadio2496_spdif_in_select =
 ICE1712_GPIO(SNDRV_CTL_ELEM_IFACE_MIXER, "IEC958 Input Optical", 0, ICE1712_DELTA_SPDIF_INPUT_SELECT, 0, 0);
-static struct snd_kcontrol_new snd_ice1712_delta_spdif_in_status __devinitdata =
+static struct snd_kcontrol_new snd_ice1712_delta_spdif_in_status =
 ICE1712_GPIO(SNDRV_CTL_ELEM_IFACE_MIXER, "Delta IEC958 Input Status", 0, ICE1712_DELTA_SPDIF_IN_STAT, 1, SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE);
 
 
@@ -801,7 +801,7 @@ static int snd_ice1712_delta_add_controls(struct snd_ice1712 *ice)
 
 
 /* entry point */
-struct snd_ice1712_card_info snd_ice1712_delta_cards[] __devinitdata = {
+struct snd_ice1712_card_info snd_ice1712_delta_cards[] = {
 	{
 		.subvendor = ICE1712_SUBDEVICE_DELTA1010,
 		.name = "M Audio Delta 1010",
diff --git a/sound/pci/ice1712/ews.c b/sound/pci/ice1712/ews.c
index 65eaf99..bc2e701 100644
--- a/sound/pci/ice1712/ews.c
+++ b/sound/pci/ice1712/ews.c
@@ -343,7 +343,7 @@ static void ews88_setup_spdif(struct snd_ice1712 *ice, int rate)
 
 /*
  */
-static struct snd_akm4xxx akm_ews88mt __devinitdata = {
+static struct snd_akm4xxx akm_ews88mt = {
 	.num_adcs = 8,
 	.num_dacs = 8,
 	.type = SND_AK4524,
@@ -353,7 +353,7 @@ static struct snd_akm4xxx akm_ews88mt __devinitdata = {
 	}
 };
 
-static struct snd_ak4xxx_private akm_ews88mt_priv __devinitdata = {
+static struct snd_ak4xxx_private akm_ews88mt_priv = {
 	.caddr = 2,
 	.cif = 1, /* CIF high */
 	.data_mask = ICE1712_EWS88_SERIAL_DATA,
@@ -365,7 +365,7 @@ static struct snd_ak4xxx_private akm_ews88mt_priv __devinitdata = {
 	.mask_flags = 0,
 };
 
-static struct snd_akm4xxx akm_ewx2496 __devinitdata = {
+static struct snd_akm4xxx akm_ewx2496 = {
 	.num_adcs = 2,
 	.num_dacs = 2,
 	.type = SND_AK4524,
@@ -374,7 +374,7 @@ static struct snd_akm4xxx akm_ewx2496 __devinitdata = {
 	}
 };
 
-static struct snd_ak4xxx_private akm_ewx2496_priv __devinitdata = {
+static struct snd_ak4xxx_private akm_ewx2496_priv = {
 	.caddr = 2,
 	.cif = 1, /* CIF high */
 	.data_mask = ICE1712_EWS88_SERIAL_DATA,
@@ -386,7 +386,7 @@ static struct snd_ak4xxx_private akm_ewx2496_priv __devinitdata = {
 	.mask_flags = 0,
 };
 
-static struct snd_akm4xxx akm_6fire __devinitdata = {
+static struct snd_akm4xxx akm_6fire = {
 	.num_adcs = 6,
 	.num_dacs = 6,
 	.type = SND_AK4524,
@@ -395,7 +395,7 @@ static struct snd_akm4xxx akm_6fire __devinitdata = {
 	}
 };
 
-static struct snd_ak4xxx_private akm_6fire_priv __devinitdata = {
+static struct snd_ak4xxx_private akm_6fire_priv = {
 	.caddr = 2,
 	.cif = 1, /* CIF high */
 	.data_mask = ICE1712_6FIRE_SERIAL_DATA,
@@ -615,7 +615,7 @@ static int snd_ice1712_ewx_io_sense_put(struct snd_kcontrol *kcontrol, struct sn
 	return val != nval;
 }
 
-static struct snd_kcontrol_new snd_ice1712_ewx2496_controls[] __devinitdata = {
+static struct snd_kcontrol_new snd_ice1712_ewx2496_controls[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Input Sensitivity Switch",
@@ -723,7 +723,7 @@ static int snd_ice1712_ews88mt_input_sense_put(struct snd_kcontrol *kcontrol, st
 	return ndata != data;
 }
 
-static struct snd_kcontrol_new snd_ice1712_ews88mt_input_sense __devinitdata = {
+static struct snd_kcontrol_new snd_ice1712_ews88mt_input_sense = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Input Sensitivity Switch",
 	.info = snd_ice1712_ewx_io_sense_info,
@@ -732,7 +732,7 @@ static struct snd_kcontrol_new snd_ice1712_ews88mt_input_sense __devinitdata = {
 	.count = 8,
 };
 
-static struct snd_kcontrol_new snd_ice1712_ews88mt_output_sense __devinitdata = {
+static struct snd_kcontrol_new snd_ice1712_ews88mt_output_sense = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Output Sensitivity Switch",
 	.info = snd_ice1712_ewx_io_sense_info,
@@ -810,7 +810,7 @@ static int snd_ice1712_ews88d_control_put(struct snd_kcontrol *kcontrol, struct
   .private_value = xshift | (xinvert << 8),\
 }
 
-static struct snd_kcontrol_new snd_ice1712_ews88d_controls[] __devinitdata = {
+static struct snd_kcontrol_new snd_ice1712_ews88d_controls[] = {
 	EWS88D_CONTROL(SNDRV_CTL_ELEM_IFACE_MIXER, "IEC958 Input Optical", 0, 1, 0), /* inverted */
 	EWS88D_CONTROL(SNDRV_CTL_ELEM_IFACE_MIXER, "ADAT Output Optical", 1, 0, 0),
 	EWS88D_CONTROL(SNDRV_CTL_ELEM_IFACE_MIXER, "ADAT External Master Clock", 2, 0, 0),
@@ -947,7 +947,7 @@ static int snd_ice1712_6fire_select_input_put(struct snd_kcontrol *kcontrol, str
   .private_value = xshift | (xinvert << 8),\
 }
 
-static struct snd_kcontrol_new snd_ice1712_6fire_controls[] __devinitdata = {
+static struct snd_kcontrol_new snd_ice1712_6fire_controls[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Analog Input Select",
@@ -1029,7 +1029,7 @@ static int snd_ice1712_ews_add_controls(struct snd_ice1712 *ice)
 
 
 /* entry point */
-struct snd_ice1712_card_info snd_ice1712_ews_cards[] __devinitdata = {
+struct snd_ice1712_card_info snd_ice1712_ews_cards[] = {
 	{
 		.subvendor = ICE1712_SUBDEVICE_EWX2496,
 		.name = "TerraTec EWX24/96",
diff --git a/sound/pci/ice1712/hoontech.c b/sound/pci/ice1712/hoontech.c
index db1e852..59e37c5 100644
--- a/sound/pci/ice1712/hoontech.c
+++ b/sound/pci/ice1712/hoontech.c
@@ -269,7 +269,7 @@ static void stdsp24_ak4524_lock(struct snd_akm4xxx *ak, int chip)
 static int snd_ice1712_value_init(struct snd_ice1712 *ice)
 {
 	/* Hoontech STDSP24 with modified hardware */
-	static struct snd_akm4xxx akm_stdsp24_mv __devinitdata = {
+	static struct snd_akm4xxx akm_stdsp24_mv = {
 		.num_adcs = 2,
 		.num_dacs = 2,
 		.type = SND_AK4524,
@@ -278,7 +278,7 @@ static int snd_ice1712_value_init(struct snd_ice1712 *ice)
 		}
 	};
 
-	static struct snd_ak4xxx_private akm_stdsp24_mv_priv __devinitdata = {
+	static struct snd_ak4xxx_private akm_stdsp24_mv_priv = {
 		.caddr = 2,
 		.cif = 1, /* CIF high */
 		.data_mask = ICE1712_STDSP24_SERIAL_DATA,
@@ -328,7 +328,7 @@ static int snd_ice1712_ez8_init(struct snd_ice1712 *ice)
 
 
 /* entry point */
-struct snd_ice1712_card_info snd_ice1712_hoontech_cards[] __devinitdata = {
+struct snd_ice1712_card_info snd_ice1712_hoontech_cards[] = {
 	{
 		.subvendor = ICE1712_SUBDEVICE_STDSP24,
 		.name = "Hoontech SoundTrack Audio DSP24",
diff --git a/sound/pci/ice1712/ice1712.c b/sound/pci/ice1712/ice1712.c
index 31719d0..b6e9dda 100644
--- a/sound/pci/ice1712/ice1712.c
+++ b/sound/pci/ice1712/ice1712.c
@@ -279,7 +279,7 @@ static int snd_ice1712_digmix_route_ac97_put(struct snd_kcontrol *kcontrol, stru
 	return val != nval;
 }
 
-static struct snd_kcontrol_new snd_ice1712_mixer_digmix_route_ac97 __devinitdata = {
+static struct snd_kcontrol_new snd_ice1712_mixer_digmix_route_ac97 = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Digital Mixer To AC97",
 	.info = snd_ice1712_digmix_route_ac97_info,
@@ -1387,7 +1387,7 @@ static int snd_ice1712_pro_mixer_volume_put(struct snd_kcontrol *kcontrol, struc
 
 static const DECLARE_TLV_DB_SCALE(db_scale_playback, -14400, 150, 0);
 
-static struct snd_kcontrol_new snd_ice1712_multi_playback_ctrls[] __devinitdata = {
+static struct snd_kcontrol_new snd_ice1712_multi_playback_ctrls[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Multi Playback Switch",
@@ -1411,7 +1411,7 @@ static struct snd_kcontrol_new snd_ice1712_multi_playback_ctrls[] __devinitdata
 	},
 };
 
-static struct snd_kcontrol_new snd_ice1712_multi_capture_analog_switch __devinitdata = {
+static struct snd_kcontrol_new snd_ice1712_multi_capture_analog_switch = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "H/W Multi Capture Switch",
 	.info = snd_ice1712_pro_mixer_switch_info,
@@ -1420,7 +1420,7 @@ static struct snd_kcontrol_new snd_ice1712_multi_capture_analog_switch __devinit
 	.private_value = 10,
 };
 
-static struct snd_kcontrol_new snd_ice1712_multi_capture_spdif_switch __devinitdata = {
+static struct snd_kcontrol_new snd_ice1712_multi_capture_spdif_switch = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = SNDRV_CTL_NAME_IEC958("Multi ", CAPTURE, SWITCH),
 	.info = snd_ice1712_pro_mixer_switch_info,
@@ -1430,7 +1430,7 @@ static struct snd_kcontrol_new snd_ice1712_multi_capture_spdif_switch __devinitd
 	.count = 2,
 };
 
-static struct snd_kcontrol_new snd_ice1712_multi_capture_analog_volume __devinitdata = {
+static struct snd_kcontrol_new snd_ice1712_multi_capture_analog_volume = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
 		   SNDRV_CTL_ELEM_ACCESS_TLV_READ),
@@ -1442,7 +1442,7 @@ static struct snd_kcontrol_new snd_ice1712_multi_capture_analog_volume __devinit
 	.tlv = { .p = db_scale_playback }
 };
 
-static struct snd_kcontrol_new snd_ice1712_multi_capture_spdif_volume __devinitdata = {
+static struct snd_kcontrol_new snd_ice1712_multi_capture_spdif_volume = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = SNDRV_CTL_NAME_IEC958("Multi ", CAPTURE, VOLUME),
 	.info = snd_ice1712_pro_mixer_volume_info,
@@ -1639,7 +1639,7 @@ static int snd_ice1712_eeprom_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_ice1712_eeprom __devinitdata = {
+static struct snd_kcontrol_new snd_ice1712_eeprom = {
 	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
 	.name = "ICE1712 EEPROM",
 	.access = SNDRV_CTL_ELEM_ACCESS_READ,
@@ -1675,7 +1675,7 @@ static int snd_ice1712_spdif_default_put(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_ice1712_spdif_default __devinitdata =
+static struct snd_kcontrol_new snd_ice1712_spdif_default =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
 	.name =         SNDRV_CTL_NAME_IEC958("", PLAYBACK, DEFAULT),
@@ -1726,7 +1726,7 @@ static int snd_ice1712_spdif_maskp_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_ice1712_spdif_maskc __devinitdata =
+static struct snd_kcontrol_new snd_ice1712_spdif_maskc =
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ,
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
@@ -1735,7 +1735,7 @@ static struct snd_kcontrol_new snd_ice1712_spdif_maskc __devinitdata =
 	.get =		snd_ice1712_spdif_maskc_get,
 };
 
-static struct snd_kcontrol_new snd_ice1712_spdif_maskp __devinitdata =
+static struct snd_kcontrol_new snd_ice1712_spdif_maskp =
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ,
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
@@ -1762,7 +1762,7 @@ static int snd_ice1712_spdif_stream_put(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_ice1712_spdif_stream __devinitdata =
+static struct snd_kcontrol_new snd_ice1712_spdif_stream =
 {
 	.access =	(SNDRV_CTL_ELEM_ACCESS_READWRITE |
 			 SNDRV_CTL_ELEM_ACCESS_INACTIVE),
@@ -1893,7 +1893,7 @@ static int snd_ice1712_pro_internal_clock_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_ice1712_pro_internal_clock __devinitdata = {
+static struct snd_kcontrol_new snd_ice1712_pro_internal_clock = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Multi Track Internal Clock",
 	.info = snd_ice1712_pro_internal_clock_info,
@@ -1964,7 +1964,7 @@ static int snd_ice1712_pro_internal_clock_default_put(struct snd_kcontrol *kcont
 	return change;
 }
 
-static struct snd_kcontrol_new snd_ice1712_pro_internal_clock_default __devinitdata = {
+static struct snd_kcontrol_new snd_ice1712_pro_internal_clock_default = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Multi Track Internal Clock Default",
 	.info = snd_ice1712_pro_internal_clock_default_info,
@@ -1995,7 +1995,7 @@ static int snd_ice1712_pro_rate_locking_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_ice1712_pro_rate_locking __devinitdata = {
+static struct snd_kcontrol_new snd_ice1712_pro_rate_locking = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Multi Track Rate Locking",
 	.info = snd_ice1712_pro_rate_locking_info,
@@ -2026,7 +2026,7 @@ static int snd_ice1712_pro_rate_reset_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_ice1712_pro_rate_reset __devinitdata = {
+static struct snd_kcontrol_new snd_ice1712_pro_rate_reset = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Multi Track Rate Reset",
 	.info = snd_ice1712_pro_rate_reset_info,
@@ -2193,7 +2193,7 @@ static int snd_ice1712_pro_route_spdif_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_ice1712_mixer_pro_analog_route __devinitdata = {
+static struct snd_kcontrol_new snd_ice1712_mixer_pro_analog_route = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "H/W Playback Route",
 	.info = snd_ice1712_pro_route_info,
@@ -2201,7 +2201,7 @@ static struct snd_kcontrol_new snd_ice1712_mixer_pro_analog_route __devinitdata
 	.put = snd_ice1712_pro_route_analog_put,
 };
 
-static struct snd_kcontrol_new snd_ice1712_mixer_pro_spdif_route __devinitdata = {
+static struct snd_kcontrol_new snd_ice1712_mixer_pro_spdif_route = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = SNDRV_CTL_NAME_IEC958("", PLAYBACK, NONE) "Route",
 	.info = snd_ice1712_pro_route_info,
@@ -2243,7 +2243,7 @@ static int snd_ice1712_pro_volume_rate_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_ice1712_mixer_pro_volume_rate __devinitdata = {
+static struct snd_kcontrol_new snd_ice1712_mixer_pro_volume_rate = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Multi Track Volume Rate",
 	.info = snd_ice1712_pro_volume_rate_info,
@@ -2276,7 +2276,7 @@ static int snd_ice1712_pro_peak_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_ice1712_mixer_pro_peak __devinitdata = {
+static struct snd_kcontrol_new snd_ice1712_mixer_pro_peak = {
 	.iface = SNDRV_CTL_ELEM_IFACE_PCM,
 	.name = "Multi Track Peak",
 	.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
@@ -2291,7 +2291,7 @@ static struct snd_kcontrol_new snd_ice1712_mixer_pro_peak __devinitdata = {
 /*
  * list of available boards
  */
-static struct snd_ice1712_card_info *card_tables[] __devinitdata = {
+static struct snd_ice1712_card_info *card_tables[] = {
 	snd_ice1712_hoontech_cards,
 	snd_ice1712_delta_cards,
 	snd_ice1712_ews_cards,
@@ -2650,7 +2650,7 @@ static int snd_ice1712_create(struct snd_card *card,
  *
  */
 
-static struct snd_ice1712_card_info no_matched __devinitdata;
+static struct snd_ice1712_card_info no_matched;
 
 static int snd_ice1712_probe(struct pci_dev *pci,
 				       const struct pci_device_id *pci_id)
diff --git a/sound/pci/ice1712/ice1724.c b/sound/pci/ice1712/ice1724.c
index 30b5935..7551c34 100644
--- a/sound/pci/ice1712/ice1724.c
+++ b/sound/pci/ice1712/ice1724.c
@@ -1599,7 +1599,7 @@ static int snd_vt1724_eeprom_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_vt1724_eeprom __devinitdata = {
+static struct snd_kcontrol_new snd_vt1724_eeprom = {
 	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
 	.name = "ICE1724 EEPROM",
 	.access = SNDRV_CTL_ELEM_ACCESS_READ,
@@ -1712,7 +1712,7 @@ static int snd_vt1724_spdif_default_put(struct snd_kcontrol *kcontrol,
 	return val != old;
 }
 
-static struct snd_kcontrol_new snd_vt1724_spdif_default __devinitdata =
+static struct snd_kcontrol_new snd_vt1724_spdif_default =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
 	.name =         SNDRV_CTL_NAME_IEC958("", PLAYBACK, DEFAULT),
@@ -1744,7 +1744,7 @@ static int snd_vt1724_spdif_maskp_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_vt1724_spdif_maskc __devinitdata =
+static struct snd_kcontrol_new snd_vt1724_spdif_maskc =
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ,
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
@@ -1753,7 +1753,7 @@ static struct snd_kcontrol_new snd_vt1724_spdif_maskc __devinitdata =
 	.get =		snd_vt1724_spdif_maskc_get,
 };
 
-static struct snd_kcontrol_new snd_vt1724_spdif_maskp __devinitdata =
+static struct snd_kcontrol_new snd_vt1724_spdif_maskp =
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ,
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
@@ -1790,7 +1790,7 @@ static int snd_vt1724_spdif_sw_put(struct snd_kcontrol *kcontrol,
 	return old != val;
 }
 
-static struct snd_kcontrol_new snd_vt1724_spdif_switch __devinitdata =
+static struct snd_kcontrol_new snd_vt1724_spdif_switch =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	/* FIXME: the following conflict with IEC958 Playback Route */
@@ -1965,7 +1965,7 @@ static int snd_vt1724_pro_internal_clock_put(struct snd_kcontrol *kcontrol,
 	return old_rate != new_rate;
 }
 
-static struct snd_kcontrol_new snd_vt1724_pro_internal_clock __devinitdata = {
+static struct snd_kcontrol_new snd_vt1724_pro_internal_clock = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Multi Track Internal Clock",
 	.info = snd_vt1724_pro_internal_clock_info,
@@ -1996,7 +1996,7 @@ static int snd_vt1724_pro_rate_locking_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_vt1724_pro_rate_locking __devinitdata = {
+static struct snd_kcontrol_new snd_vt1724_pro_rate_locking = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Multi Track Rate Locking",
 	.info = snd_vt1724_pro_rate_locking_info,
@@ -2027,7 +2027,7 @@ static int snd_vt1724_pro_rate_reset_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_vt1724_pro_rate_reset __devinitdata = {
+static struct snd_kcontrol_new snd_vt1724_pro_rate_reset = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Multi Track Rate Reset",
 	.info = snd_vt1724_pro_rate_reset_info,
@@ -2149,7 +2149,7 @@ static int snd_vt1724_pro_route_spdif_put(struct snd_kcontrol *kcontrol,
 					 digital_route_shift(idx));
 }
 
-static struct snd_kcontrol_new snd_vt1724_mixer_pro_analog_route __devinitdata =
+static struct snd_kcontrol_new snd_vt1724_mixer_pro_analog_route =
 {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "H/W Playback Route",
@@ -2158,7 +2158,7 @@ static struct snd_kcontrol_new snd_vt1724_mixer_pro_analog_route __devinitdata =
 	.put = snd_vt1724_pro_route_analog_put,
 };
 
-static struct snd_kcontrol_new snd_vt1724_mixer_pro_spdif_route __devinitdata = {
+static struct snd_kcontrol_new snd_vt1724_mixer_pro_spdif_route = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = SNDRV_CTL_NAME_IEC958("", PLAYBACK, NONE) "Route",
 	.info = snd_vt1724_pro_route_info,
@@ -2194,7 +2194,7 @@ static int snd_vt1724_pro_peak_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_vt1724_mixer_pro_peak __devinitdata = {
+static struct snd_kcontrol_new snd_vt1724_mixer_pro_peak = {
 	.iface = SNDRV_CTL_ELEM_IFACE_PCM,
 	.name = "Multi Track Peak",
 	.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
@@ -2206,13 +2206,13 @@ static struct snd_kcontrol_new snd_vt1724_mixer_pro_peak __devinitdata = {
  *
  */
 
-static struct snd_ice1712_card_info no_matched __devinitdata;
+static struct snd_ice1712_card_info no_matched;
 
 
 /*
   ooAoo cards with no controls
 */
-static unsigned char ooaoo_sq210_eeprom[] __devinitdata = {
+static unsigned char ooaoo_sq210_eeprom[] = {
 	[ICE_EEP2_SYSCONF]     = 0x4c,	/* 49MHz crystal, no mpu401, no ADC,
 					   1xDACs */
 	[ICE_EEP2_ACLINK]      = 0x80,	/* I2S */
@@ -2232,7 +2232,7 @@ static unsigned char ooaoo_sq210_eeprom[] __devinitdata = {
 };
 
 
-static struct snd_ice1712_card_info snd_vt1724_ooaoo_cards[] __devinitdata = {
+static struct snd_ice1712_card_info snd_vt1724_ooaoo_cards[] = {
 	{
 		.name = "ooAoo SQ210a",
 		.model = "sq210a",
@@ -2242,7 +2242,7 @@ static struct snd_ice1712_card_info snd_vt1724_ooaoo_cards[] __devinitdata = {
 	{ } /* terminator */
 };
 
-static struct snd_ice1712_card_info *card_tables[] __devinitdata = {
+static struct snd_ice1712_card_info *card_tables[] = {
 	snd_vt1724_revo_cards,
 	snd_vt1724_amp_cards,
 	snd_vt1724_aureon_cards,
diff --git a/sound/pci/ice1712/juli.c b/sound/pci/ice1712/juli.c
index 0585e9c..881f38b 100644
--- a/sound/pci/ice1712/juli.c
+++ b/sound/pci/ice1712/juli.c
@@ -282,7 +282,7 @@ static const struct snd_akm4xxx_dac_channel juli_dac[] = {
 };
 
 
-static struct snd_akm4xxx akm_juli_dac __devinitdata = {
+static struct snd_akm4xxx akm_juli_dac = {
 	.type = SND_AK4358,
 	.num_dacs = 8,	/* DAC1 - analog out
 			   DAC2 - analog in monitor
@@ -357,7 +357,7 @@ static int juli_mute_put(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new juli_mute_controls[] __devinitdata = {
+static struct snd_kcontrol_new juli_mute_controls[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Master Playback Switch",
@@ -411,7 +411,7 @@ static struct snd_kcontrol_new juli_mute_controls[] __devinitdata = {
 	},
 };
 
-static char *slave_vols[] __devinitdata = {
+static char *slave_vols[] = {
 	PCM_VOLUME,
 	MONITOR_AN_IN_VOLUME,
 	MONITOR_DIG_IN_VOLUME,
@@ -419,8 +419,7 @@ static char *slave_vols[] __devinitdata = {
 	NULL
 };
 
-static __devinitdata
-DECLARE_TLV_DB_SCALE(juli_master_db_scale, -6350, 50, 1);
+static DECLARE_TLV_DB_SCALE(juli_master_db_scale, -6350, 50, 1);
 
 static struct snd_kcontrol *ctl_find(struct snd_card *card,
 		const char *name)
@@ -667,7 +666,7 @@ static int juli_init(struct snd_ice1712 *ice)
  * hence the driver needs to sets up it properly.
  */
 
-static unsigned char juli_eeprom[] __devinitdata = {
+static unsigned char juli_eeprom[] = {
 	[ICE_EEP2_SYSCONF]     = 0x2b,	/* clock 512, mpu401, 1xADC, 1xDACs,
 					   SPDIF in */
 	[ICE_EEP2_ACLINK]      = 0x80,	/* I2S */
@@ -686,7 +685,7 @@ static unsigned char juli_eeprom[] __devinitdata = {
 };
 
 /* entry point */
-struct snd_ice1712_card_info snd_vt1724_juli_cards[] __devinitdata = {
+struct snd_ice1712_card_info snd_vt1724_juli_cards[] = {
 	{
 		.subvendor = VT1724_SUBDEVICE_JULI,
 		.name = "ESI Juli@",
diff --git a/sound/pci/ice1712/maya44.c b/sound/pci/ice1712/maya44.c
index 9292ca1..1261031 100644
--- a/sound/pci/ice1712/maya44.c
+++ b/sound/pci/ice1712/maya44.c
@@ -454,7 +454,7 @@ static int maya_pb_route_put(struct snd_kcontrol *kcontrol,
  * controls to be added
  */
 
-static struct snd_kcontrol_new maya_controls[] __devinitdata = {
+static struct snd_kcontrol_new maya_controls[] = {
 	{
 		.name = "Crossmix Playback Volume",
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
@@ -692,7 +692,7 @@ static struct snd_pcm_hw_constraint_list dac_rates = {
 /*
  * chip addresses on I2C bus
  */
-static unsigned char wm8776_addr[2] __devinitdata = {
+static unsigned char wm8776_addr[2] = {
 	0x34, 0x36, /* codec 0 & 1 */
 };
 
@@ -742,7 +742,7 @@ static int maya44_init(struct snd_ice1712 *ice)
  * hence the driver needs to sets up it properly.
  */
 
-static unsigned char maya44_eeprom[] __devinitdata = {
+static unsigned char maya44_eeprom[] = {
 	[ICE_EEP2_SYSCONF]     = 0x45,
 		/* clock xin1=49.152MHz, mpu401, 2 stereo ADCs+DACs */
 	[ICE_EEP2_ACLINK]      = 0x80,
@@ -764,7 +764,7 @@ static unsigned char maya44_eeprom[] __devinitdata = {
 };
 
 /* entry point */
-struct snd_ice1712_card_info snd_vt1724_maya44_cards[] __devinitdata = {
+struct snd_ice1712_card_info snd_vt1724_maya44_cards[] = {
 	{
 		.subvendor = VT1724_SUBDEVICE_MAYA44,
 		.name = "ESI Maya44",
diff --git a/sound/pci/ice1712/phase.c b/sound/pci/ice1712/phase.c
index a9dbdd8..0011e04 100644
--- a/sound/pci/ice1712/phase.c
+++ b/sound/pci/ice1712/phase.c
@@ -102,13 +102,13 @@ static const unsigned char wm_vol[256] = {
 #define WM_VOL_MAX	(sizeof(wm_vol) - 1)
 #define WM_VOL_MUTE	0x8000
 
-static struct snd_akm4xxx akm_phase22 __devinitdata = {
+static struct snd_akm4xxx akm_phase22 = {
 	.type = SND_AK4524,
 	.num_dacs = 2,
 	.num_adcs = 2,
 };
 
-static struct snd_ak4xxx_private akm_phase22_priv __devinitdata = {
+static struct snd_ak4xxx_private akm_phase22_priv = {
 	.caddr =	2,
 	.cif =		1,
 	.data_mask =	1 << 4,
@@ -171,7 +171,7 @@ static int phase22_add_controls(struct snd_ice1712 *ice)
 	return 0;
 }
 
-static unsigned char phase22_eeprom[] __devinitdata = {
+static unsigned char phase22_eeprom[] = {
 	[ICE_EEP2_SYSCONF]     = 0x28,  /* clock 512, mpu 401,
 					spdif-in/1xADC, 1xDACs */
 	[ICE_EEP2_ACLINK]      = 0x80,	/* I2S */
@@ -188,7 +188,7 @@ static unsigned char phase22_eeprom[] __devinitdata = {
 	[ICE_EEP2_GPIO_STATE2] = 0x00,
 };
 
-static unsigned char phase28_eeprom[] __devinitdata = {
+static unsigned char phase28_eeprom[] = {
 	[ICE_EEP2_SYSCONF]     = 0x2b,  /* clock 512, mpu401,
 					spdif-in/1xADC, 4xDACs */
 	[ICE_EEP2_ACLINK]      = 0x80,	/* I2S */
@@ -769,7 +769,7 @@ static int phase28_oversampling_put(struct snd_kcontrol *kcontrol,
 static const DECLARE_TLV_DB_SCALE(db_scale_wm_dac, -12700, 100, 1);
 static const DECLARE_TLV_DB_SCALE(db_scale_wm_pcm, -6400, 50, 1);
 
-static struct snd_kcontrol_new phase28_dac_controls[] __devinitdata = {
+static struct snd_kcontrol_new phase28_dac_controls[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Master Playback Switch",
@@ -884,7 +884,7 @@ static struct snd_kcontrol_new phase28_dac_controls[] __devinitdata = {
 	}
 };
 
-static struct snd_kcontrol_new wm_controls[] __devinitdata = {
+static struct snd_kcontrol_new wm_controls[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "PCM Playback Switch",
@@ -942,7 +942,7 @@ static int phase28_add_controls(struct snd_ice1712 *ice)
 	return 0;
 }
 
-struct snd_ice1712_card_info snd_vt1724_phase_cards[] __devinitdata = {
+struct snd_ice1712_card_info snd_vt1724_phase_cards[] = {
 	{
 		.subvendor = VT1724_SUBDEVICE_PHASE22,
 		.name = "Terratec PHASE 22",
diff --git a/sound/pci/ice1712/pontis.c b/sound/pci/ice1712/pontis.c
index 8676d2f..5555eb4 100644
--- a/sound/pci/ice1712/pontis.c
+++ b/sound/pci/ice1712/pontis.c
@@ -549,7 +549,7 @@ static const DECLARE_TLV_DB_SCALE(db_scale_volume, -6400, 50, 1);
  * mixers
  */
 
-static struct snd_kcontrol_new pontis_controls[] __devinitdata = {
+static struct snd_kcontrol_new pontis_controls[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
@@ -804,7 +804,7 @@ static int pontis_init(struct snd_ice1712 *ice)
  * hence the driver needs to sets up it properly.
  */
 
-static unsigned char pontis_eeprom[] __devinitdata = {
+static unsigned char pontis_eeprom[] = {
 	[ICE_EEP2_SYSCONF]     = 0x08,	/* clock 256, mpu401, spdif-in/ADC, 1DAC */
 	[ICE_EEP2_ACLINK]      = 0x80,	/* I2S */
 	[ICE_EEP2_I2S]         = 0xf8,	/* vol, 96k, 24bit, 192k */
@@ -821,7 +821,7 @@ static unsigned char pontis_eeprom[] __devinitdata = {
 };
 
 /* entry point */
-struct snd_ice1712_card_info snd_vt1720_pontis_cards[] __devinitdata = {
+struct snd_ice1712_card_info snd_vt1720_pontis_cards[] = {
 	{
 		.subvendor = VT1720_SUBDEVICE_PONTIS_MS300,
 		.name = "Pontis MS300",
diff --git a/sound/pci/ice1712/prodigy192.c b/sound/pci/ice1712/prodigy192.c
index 3426acc..e610339 100644
--- a/sound/pci/ice1712/prodigy192.c
+++ b/sound/pci/ice1712/prodigy192.c
@@ -368,7 +368,7 @@ static const DECLARE_TLV_DB_SCALE(db_scale_adc, 0, 150, 0);
  * mixers
  */
 
-static struct snd_kcontrol_new stac_controls[] __devinitdata = {
+static struct snd_kcontrol_new stac_controls[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Master Playback Switch",
@@ -606,7 +606,7 @@ static int ak4114_input_sw_put(struct snd_kcontrol *kcontrol,
 }
 
 
-static struct snd_kcontrol_new ak4114_controls[] __devinitdata = {
+static struct snd_kcontrol_new ak4114_controls[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "MIODIO IEC958 Capture Input",
@@ -783,7 +783,7 @@ static int prodigy192_init(struct snd_ice1712 *ice)
  * hence the driver needs to sets up it properly.
  */
 
-static unsigned char prodigy71_eeprom[] __devinitdata = {
+static unsigned char prodigy71_eeprom[] = {
 	[ICE_EEP2_SYSCONF]     = 0x6a,	/* 49MHz crystal, mpu401,
 					 * spdif-in+ 1 stereo ADC,
 					 * 3 stereo DACs
@@ -807,7 +807,7 @@ static unsigned char prodigy71_eeprom[] __devinitdata = {
 
 
 /* entry point */
-struct snd_ice1712_card_info snd_vt1724_prodigy192_cards[] __devinitdata = {
+struct snd_ice1712_card_info snd_vt1724_prodigy192_cards[] = {
 	{
 		.subvendor = VT1724_SUBDEVICE_PRODIGY192VE,
 		.name = "Audiotrak Prodigy 192",
diff --git a/sound/pci/ice1712/prodigy_hifi.c b/sound/pci/ice1712/prodigy_hifi.c
index 931eb08..2261d1e 100644
--- a/sound/pci/ice1712/prodigy_hifi.c
+++ b/sound/pci/ice1712/prodigy_hifi.c
@@ -298,7 +298,7 @@ static int ak4396_dac_vol_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem
 static const DECLARE_TLV_DB_SCALE(db_scale_wm_dac, -12700, 100, 1);
 static const DECLARE_TLV_DB_LINEAR(ak4396_db_scale, TLV_DB_GAIN_MUTE, 0);
 
-static struct snd_kcontrol_new prodigy_hd2_controls[] __devinitdata = {
+static struct snd_kcontrol_new prodigy_hd2_controls[] = {
     {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
@@ -781,7 +781,7 @@ static int wm_chswap_put(struct snd_kcontrol *kcontrol,
  * mixers
  */
 
-static struct snd_kcontrol_new prodigy_hifi_controls[] __devinitdata = {
+static struct snd_kcontrol_new prodigy_hifi_controls[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
@@ -1151,7 +1151,7 @@ static int prodigy_hd2_init(struct snd_ice1712 *ice)
 }
 
 
-static unsigned char prodigy71hifi_eeprom[] __devinitdata = {
+static unsigned char prodigy71hifi_eeprom[] = {
 	0x4b,   /* SYSCONF: clock 512, spdif-in/ADC, 4DACs */
 	0x80,   /* ACLINK: I2S */
 	0xfc,   /* I2S: vol, 96k, 24bit, 192k */
@@ -1167,7 +1167,7 @@ static unsigned char prodigy71hifi_eeprom[] __devinitdata = {
 	0x00,   /* GPIO_STATE2 */
 };
 
-static unsigned char prodigyhd2_eeprom[] __devinitdata = {
+static unsigned char prodigyhd2_eeprom[] = {
 	0x4b,   /* SYSCONF: clock 512, spdif-in/ADC, 4DACs */
 	0x80,   /* ACLINK: I2S */
 	0xfc,   /* I2S: vol, 96k, 24bit, 192k */
@@ -1183,7 +1183,7 @@ static unsigned char prodigyhd2_eeprom[] __devinitdata = {
 	0x00,   /* GPIO_STATE2 */
 };
 
-static unsigned char fortissimo4_eeprom[] __devinitdata = {
+static unsigned char fortissimo4_eeprom[] = {
 	0x43,   /* SYSCONF: clock 512, ADC, 4DACs */	
 	0x80,   /* ACLINK: I2S */
 	0xfc,   /* I2S: vol, 96k, 24bit, 192k */
@@ -1200,7 +1200,7 @@ static unsigned char fortissimo4_eeprom[] __devinitdata = {
 };
 
 /* entry point */
-struct snd_ice1712_card_info snd_vt1724_prodigy_hifi_cards[] __devinitdata = {
+struct snd_ice1712_card_info snd_vt1724_prodigy_hifi_cards[] = {
 	{
 		.subvendor = VT1724_SUBDEVICE_PRODIGY_HIFI,
 		.name = "Audiotrak Prodigy 7.1 HiFi",
diff --git a/sound/pci/ice1712/psc724.c b/sound/pci/ice1712/psc724.c
index 1c15552..302ac6d 100644
--- a/sound/pci/ice1712/psc724.c
+++ b/sound/pci/ice1712/psc724.c
@@ -434,7 +434,7 @@ static void psc724_exit(struct snd_ice1712 *ice)
 }
 
 /* PSC724 has buggy EEPROM (no 96&192kHz, all FFh GPIOs), so override it here */
-static unsigned char psc724_eeprom[] __devinitdata = {
+static unsigned char psc724_eeprom[] = {
 	[ICE_EEP2_SYSCONF]	= 0x42,	/* 49.152MHz, 1 ADC, 3 DACs */
 	[ICE_EEP2_ACLINK]	= 0x80,	/* I2S */
 	[ICE_EEP2_I2S]		= 0xf0,	/* I2S volume, 96kHz, 24bit */
@@ -449,7 +449,7 @@ static unsigned char psc724_eeprom[] __devinitdata = {
 	[ICE_EEP2_GPIO_STATE2]	= 0x20,	/* unmuted, all WM8766 pins low */
 };
 
-struct snd_ice1712_card_info snd_vt1724_psc724_cards[] __devinitdata = {
+struct snd_ice1712_card_info snd_vt1724_psc724_cards[] = {
 	{
 		.subvendor = VT1724_SUBDEVICE_PSC724,
 		.name = "Philips PSC724 Ultimate Edge",
diff --git a/sound/pci/ice1712/quartet.c b/sound/pci/ice1712/quartet.c
index 1f02d0d..4ede02f 100644
--- a/sound/pci/ice1712/quartet.c
+++ b/sound/pci/ice1712/quartet.c
@@ -386,7 +386,7 @@ static const struct snd_akm4xxx_adc_channel qtet_adc[] = {
 	AK_CONTROL(PCM_34_CAPTURE_VOLUME, 2),
 };
 
-static struct snd_akm4xxx akm_qtet_dac __devinitdata = {
+static struct snd_akm4xxx akm_qtet_dac = {
 	.type = SND_AK4620,
 	.num_dacs = 4,	/* DAC1 - Output 12
 	*/
@@ -758,7 +758,7 @@ static int qtet_sw_put(struct snd_kcontrol *kcontrol,
 	.put = qtet_sw_put,\
 	.private_value = xpriv }
 
-static struct snd_kcontrol_new qtet_controls[] __devinitdata = {
+static struct snd_kcontrol_new qtet_controls[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Master Playback Switch",
@@ -795,14 +795,13 @@ static struct snd_kcontrol_new qtet_controls[] __devinitdata = {
 	QTET_CONTROL("Output 3/4 to Monitor 1/2", sw, OUT34_MON12),
 };
 
-static char *slave_vols[] __devinitdata = {
+static char *slave_vols[] = {
 	PCM_12_PLAYBACK_VOLUME,
 	PCM_34_PLAYBACK_VOLUME,
 	NULL
 };
 
-static __devinitdata
-DECLARE_TLV_DB_SCALE(qtet_master_db_scale, -6350, 50, 1);
+static DECLARE_TLV_DB_SCALE(qtet_master_db_scale, -6350, 50, 1);
 
 static struct snd_kcontrol *ctl_find(struct snd_card *card,
 		const char *name)
@@ -1095,7 +1094,7 @@ static int qtet_init(struct snd_ice1712 *ice)
 	return 0;
 }
 
-static unsigned char qtet_eeprom[] __devinitdata = {
+static unsigned char qtet_eeprom[] = {
 	[ICE_EEP2_SYSCONF]     = 0x28,	/* clock 256(24MHz), mpu401, 1xADC,
 					   1xDACs, SPDIF in */
 	[ICE_EEP2_ACLINK]      = 0x80,	/* I2S */
@@ -1116,7 +1115,7 @@ static unsigned char qtet_eeprom[] __devinitdata = {
 };
 
 /* entry point */
-struct snd_ice1712_card_info snd_vt1724_qtet_cards[] __devinitdata = {
+struct snd_ice1712_card_info snd_vt1724_qtet_cards[] = {
 	{
 		.subvendor = VT1724_SUBDEVICE_QTET,
 		.name = "Infrasonic Quartet",
diff --git a/sound/pci/ice1712/revo.c b/sound/pci/ice1712/revo.c
index f37d403..7641080 100644
--- a/sound/pci/ice1712/revo.c
+++ b/sound/pci/ice1712/revo.c
@@ -234,7 +234,7 @@ static const struct snd_akm4xxx_adc_channel revo51_adc[] = {
 	},
 };
 
-static struct snd_akm4xxx akm_revo_front __devinitdata = {
+static struct snd_akm4xxx akm_revo_front = {
 	.type = SND_AK4381,
 	.num_dacs = 2,
 	.ops = {
@@ -243,7 +243,7 @@ static struct snd_akm4xxx akm_revo_front __devinitdata = {
 	.dac_info = revo71_front,
 };
 
-static struct snd_ak4xxx_private akm_revo_front_priv __devinitdata = {
+static struct snd_ak4xxx_private akm_revo_front_priv = {
 	.caddr = 1,
 	.cif = 0,
 	.data_mask = VT1724_REVO_CDOUT,
@@ -255,7 +255,7 @@ static struct snd_ak4xxx_private akm_revo_front_priv __devinitdata = {
 	.mask_flags = 0,
 };
 
-static struct snd_akm4xxx akm_revo_surround __devinitdata = {
+static struct snd_akm4xxx akm_revo_surround = {
 	.type = SND_AK4355,
 	.idx_offset = 1,
 	.num_dacs = 6,
@@ -265,7 +265,7 @@ static struct snd_akm4xxx akm_revo_surround __devinitdata = {
 	.dac_info = revo71_surround,
 };
 
-static struct snd_ak4xxx_private akm_revo_surround_priv __devinitdata = {
+static struct snd_ak4xxx_private akm_revo_surround_priv = {
 	.caddr = 3,
 	.cif = 0,
 	.data_mask = VT1724_REVO_CDOUT,
@@ -277,7 +277,7 @@ static struct snd_ak4xxx_private akm_revo_surround_priv __devinitdata = {
 	.mask_flags = 0,
 };
 
-static struct snd_akm4xxx akm_revo51 __devinitdata = {
+static struct snd_akm4xxx akm_revo51 = {
 	.type = SND_AK4358,
 	.num_dacs = 8,
 	.ops = {
@@ -286,7 +286,7 @@ static struct snd_akm4xxx akm_revo51 __devinitdata = {
 	.dac_info = revo51_dac,
 };
 
-static struct snd_ak4xxx_private akm_revo51_priv __devinitdata = {
+static struct snd_ak4xxx_private akm_revo51_priv = {
 	.caddr = 2,
 	.cif = 0,
 	.data_mask = VT1724_REVO_CDOUT,
@@ -298,13 +298,13 @@ static struct snd_ak4xxx_private akm_revo51_priv __devinitdata = {
 	.mask_flags = 0,
 };
 
-static struct snd_akm4xxx akm_revo51_adc __devinitdata = {
+static struct snd_akm4xxx akm_revo51_adc = {
 	.type = SND_AK5365,
 	.num_adcs = 2,
 	.adc_info = revo51_adc,
 };
 
-static struct snd_ak4xxx_private akm_revo51_adc_priv __devinitdata = {
+static struct snd_ak4xxx_private akm_revo51_adc_priv = {
 	.caddr = 2,
 	.cif = 0,
 	.data_mask = VT1724_REVO_CDOUT,
@@ -345,7 +345,7 @@ static const struct snd_akm4xxx_dac_channel ap192_dac[] = {
 	AK_DAC("PCM Playback Volume", 2)
 };
 
-static struct snd_akm4xxx akm_ap192 __devinitdata = {
+static struct snd_akm4xxx akm_ap192 = {
 	.type = SND_AK4358,
 	.num_dacs = 2,
 	.ops = {
@@ -354,7 +354,7 @@ static struct snd_akm4xxx akm_ap192 __devinitdata = {
 	.dac_info = ap192_dac,
 };
 
-static struct snd_ak4xxx_private akm_ap192_priv __devinitdata = {
+static struct snd_ak4xxx_private akm_ap192_priv = {
 	.caddr = 2,
 	.cif = 0,
 	.data_mask = VT1724_REVO_CDOUT,
@@ -606,7 +606,7 @@ static int revo_add_controls(struct snd_ice1712 *ice)
 }
 
 /* entry point */
-struct snd_ice1712_card_info snd_vt1724_revo_cards[] __devinitdata = {
+struct snd_ice1712_card_info snd_vt1724_revo_cards[] = {
 	{
 		.subvendor = VT1724_SUBDEVICE_REVOLUTION71,
 		.name = "M Audio Revolution-7.1",
diff --git a/sound/pci/ice1712/se.c b/sound/pci/ice1712/se.c
index adff671..ffd894b 100644
--- a/sound/pci/ice1712/se.c
+++ b/sound/pci/ice1712/se.c
@@ -302,7 +302,7 @@ static void se200pci_WM8776_set_agc(struct snd_ice1712 *ice, unsigned int agc)
 static void se200pci_WM8776_init(struct snd_ice1712 *ice)
 {
 	int i;
-	static unsigned short __devinitdata default_values[] = {
+	static unsigned short default_values[] = {
 		0x100, 0x100, 0x100,
 		0x100, 0x100, 0x100,
 		0x000, 0x090, 0x000, 0x000,
@@ -722,7 +722,7 @@ static int se_add_controls(struct snd_ice1712 *ice)
 /*  entry point                                                             */
 /****************************************************************************/
 
-static unsigned char se200pci_eeprom[] __devinitdata = {
+static unsigned char se200pci_eeprom[] = {
 	[ICE_EEP2_SYSCONF]	= 0x4b,	/* 49.152Hz, spdif-in/ADC, 4DACs */
 	[ICE_EEP2_ACLINK]	= 0x80,	/* I2S */
 	[ICE_EEP2_I2S]		= 0x78,	/* 96k-ok, 24bit, 192k-ok */
@@ -741,7 +741,7 @@ static unsigned char se200pci_eeprom[] __devinitdata = {
 	[ICE_EEP2_GPIO_STATE2]	= 0x07, /* WM8766 ML/MC/MD */
 };
 
-static unsigned char se90pci_eeprom[] __devinitdata = {
+static unsigned char se90pci_eeprom[] = {
 	[ICE_EEP2_SYSCONF]	= 0x4b,	/* 49.152Hz, spdif-in/ADC, 4DACs */
 	[ICE_EEP2_ACLINK]	= 0x80,	/* I2S */
 	[ICE_EEP2_I2S]		= 0x78,	/* 96k-ok, 24bit, 192k-ok */
@@ -750,7 +750,7 @@ static unsigned char se90pci_eeprom[] __devinitdata = {
 	/* ALL GPIO bits are in input mode */
 };
 
-struct snd_ice1712_card_info snd_vt1724_se_cards[] __devinitdata = {
+struct snd_ice1712_card_info snd_vt1724_se_cards[] = {
 	{
 		.subvendor = VT1724_SUBDEVICE_SE200PCI,
 		.name = "ONKYO SE200PCI",
diff --git a/sound/pci/ice1712/vt1720_mobo.c b/sound/pci/ice1712/vt1720_mobo.c
index 87dfe9c..5dbb867 100644
--- a/sound/pci/ice1712/vt1720_mobo.c
+++ b/sound/pci/ice1712/vt1720_mobo.c
@@ -53,7 +53,7 @@ static int k8x800_add_controls(struct snd_ice1712 *ice)
 
 /* EEPROM image */
 
-static unsigned char k8x800_eeprom[] __devinitdata = {
+static unsigned char k8x800_eeprom[] = {
 	[ICE_EEP2_SYSCONF]     = 0x01,	/* clock 256, 1ADC, 2DACs */
 	[ICE_EEP2_ACLINK]      = 0x02,	/* ACLINK, packed */
 	[ICE_EEP2_I2S]         = 0x00,	/* - */
@@ -69,7 +69,7 @@ static unsigned char k8x800_eeprom[] __devinitdata = {
 	[ICE_EEP2_GPIO_STATE2] = 0x00,	/* - */
 };
 
-static unsigned char sn25p_eeprom[] __devinitdata = {
+static unsigned char sn25p_eeprom[] = {
 	[ICE_EEP2_SYSCONF]     = 0x01,	/* clock 256, 1ADC, 2DACs */
 	[ICE_EEP2_ACLINK]      = 0x02,	/* ACLINK, packed */
 	[ICE_EEP2_I2S]         = 0x00,	/* - */
@@ -87,7 +87,7 @@ static unsigned char sn25p_eeprom[] __devinitdata = {
 
 
 /* entry point */
-struct snd_ice1712_card_info snd_vt1720_mobo_cards[] __devinitdata = {
+struct snd_ice1712_card_info snd_vt1720_mobo_cards[] = {
 	{
 		.subvendor = VT1720_SUBDEVICE_K8X800,
 		.name = "Albatron K8X800 Pro II",
diff --git a/sound/pci/ice1712/wtm.c b/sound/pci/ice1712/wtm.c
index 967bd41..bcf30a3 100644
--- a/sound/pci/ice1712/wtm.c
+++ b/sound/pci/ice1712/wtm.c
@@ -383,7 +383,7 @@ static int stac9460_mic_sw_put(struct snd_kcontrol *kcontrol,
 /*
  * Control tabs
  */
-static struct snd_kcontrol_new stac9640_controls[] __devinitdata = {
+static struct snd_kcontrol_new stac9640_controls[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Master Playback Switch",
@@ -484,7 +484,7 @@ static int wtm_init(struct snd_ice1712 *ice)
 }
 
 
-static unsigned char wtm_eeprom[] __devinitdata = {
+static unsigned char wtm_eeprom[] = {
 	0x47,	/*SYSCONF: clock 192KHz, 4ADC, 8DAC */
 	0x80,	/* ACLINK : I2S */
 	0xf8,	/* I2S: vol; 96k, 24bit, 192k */
@@ -502,7 +502,7 @@ static unsigned char wtm_eeprom[] __devinitdata = {
 
 
 /*entry point*/
-struct snd_ice1712_card_info snd_vt1724_wtm_cards[] __devinitdata = {
+struct snd_ice1712_card_info snd_vt1724_wtm_cards[] = {
 	{
 		.subvendor = VT1724_SUBDEVICE_WTM,
 		.name = "ESI Waveterminal 192M",
diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index b6a5cfc..4074d4f 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -1564,7 +1564,7 @@ static int snd_intel8x0_pcm1(struct intel8x0 *chip, int device,
 	return 0;
 }
 
-static struct ich_pcm_table intel_pcms[] __devinitdata = {
+static struct ich_pcm_table intel_pcms[] = {
 	{
 		.playback_ops = &snd_intel8x0_playback_ops,
 		.capture_ops = &snd_intel8x0_capture_ops,
@@ -1601,7 +1601,7 @@ static struct ich_pcm_table intel_pcms[] __devinitdata = {
 	},
 };
 
-static struct ich_pcm_table nforce_pcms[] __devinitdata = {
+static struct ich_pcm_table nforce_pcms[] = {
 	{
 		.playback_ops = &snd_intel8x0_playback_ops,
 		.capture_ops = &snd_intel8x0_capture_ops,
@@ -1624,7 +1624,7 @@ static struct ich_pcm_table nforce_pcms[] __devinitdata = {
 	},
 };
 
-static struct ich_pcm_table ali_pcms[] __devinitdata = {
+static struct ich_pcm_table ali_pcms[] = {
 	{
 		.playback_ops = &snd_intel8x0_ali_playback_ops,
 		.capture_ops = &snd_intel8x0_ali_capture_ops,
@@ -1719,7 +1719,7 @@ static void snd_intel8x0_mixer_free_ac97(struct snd_ac97 *ac97)
 	chip->ac97[ac97->num] = NULL;
 }
 
-static struct ac97_pcm ac97_pcm_defs[] __devinitdata = {
+static struct ac97_pcm ac97_pcm_defs[] = {
 	/* front PCM */
 	{
 		.exclusive = 1,
@@ -1789,7 +1789,7 @@ static struct ac97_pcm ac97_pcm_defs[] __devinitdata = {
 	},
 };
 
-static struct ac97_quirk ac97_quirks[] __devinitdata = {
+static struct ac97_quirk ac97_quirks[] = {
         {
 		.subvendor = 0x0e11,
 		.subdevice = 0x000e,
@@ -2883,7 +2883,7 @@ static void intel8x0_measure_ac97_clock(struct intel8x0 *chip)
 	snd_ac97_update_power(chip->ac97[0], AC97_PCM_FRONT_DAC_RATE, 0);
 }
 
-static struct snd_pci_quirk intel8x0_clock_list[] __devinitdata = {
+static struct snd_pci_quirk intel8x0_clock_list[] = {
 	SND_PCI_QUIRK(0x0e11, 0x008a, "AD1885", 41000),
 	SND_PCI_QUIRK(0x1028, 0x00be, "AD1885", 44100),
 	SND_PCI_QUIRK(0x1028, 0x0177, "AD1980", 48000),
@@ -3227,7 +3227,7 @@ static int snd_intel8x0_create(struct snd_card *card,
 static struct shortname_table {
 	unsigned int id;
 	const char *s;
-} shortnames[] __devinitdata = {
+} shortnames[] = {
 	{ PCI_DEVICE_ID_INTEL_82801AA_5, "Intel 82801AA-ICH" },
 	{ PCI_DEVICE_ID_INTEL_82801AB_5, "Intel 82901AB-ICH0" },
 	{ PCI_DEVICE_ID_INTEL_82801BA_4, "Intel 82801BA-ICH2" },
@@ -3253,7 +3253,7 @@ static struct shortname_table {
 	{ 0, NULL },
 };
 
-static struct snd_pci_quirk spdif_aclink_defaults[] __devinitdata = {
+static struct snd_pci_quirk spdif_aclink_defaults[] = {
 	SND_PCI_QUIRK(0x147b, 0x1c1a, "ASUS KN8", 1),
 	{ } /* end */
 };
diff --git a/sound/pci/intel8x0m.c b/sound/pci/intel8x0m.c
index 32233ff..921521d 100644
--- a/sound/pci/intel8x0m.c
+++ b/sound/pci/intel8x0m.c
@@ -749,7 +749,7 @@ static int snd_intel8x0m_pcm1(struct intel8x0m *chip, int device,
 	return 0;
 }
 
-static struct ich_pcm_table intel_pcms[] __devinitdata = {
+static struct ich_pcm_table intel_pcms[] = {
 	{
 		.suffix = "Modem",
 		.playback_ops = &snd_intel8x0m_playback_ops,
@@ -1252,7 +1252,7 @@ static int snd_intel8x0m_create(struct snd_card *card,
 static struct shortname_table {
 	unsigned int id;
 	const char *s;
-} shortnames[] __devinitdata = {
+} shortnames[] = {
 	{ PCI_DEVICE_ID_INTEL_82801AA_6, "Intel 82801AA-ICH" },
 	{ PCI_DEVICE_ID_INTEL_82801AB_6, "Intel 82901AB-ICH0" },
 	{ PCI_DEVICE_ID_INTEL_82801BA_6, "Intel 82801BA-ICH2" },
diff --git a/sound/pci/lola/lola_mixer.c b/sound/pci/lola/lola_mixer.c
index 2191935..6a5b908 100644
--- a/sound/pci/lola/lola_mixer.c
+++ b/sound/pci/lola/lola_mixer.c
@@ -579,7 +579,7 @@ static int lola_analog_vol_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 	return 0;
 }
 
-static struct snd_kcontrol_new lola_analog_mixer __devinitdata = {
+static struct snd_kcontrol_new lola_analog_mixer = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
 		   SNDRV_CTL_ELEM_ACCESS_TLV_READ |
@@ -644,7 +644,7 @@ static int lola_input_src_put(struct snd_kcontrol *kcontrol,
 	return lola_set_src_config(chip, mask, true);
 }
 
-static struct snd_kcontrol_new lola_input_src_mixer __devinitdata = {
+static struct snd_kcontrol_new lola_input_src_mixer = {
 	.name = "Digital SRC Capture Switch",
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.info = lola_input_src_info,
@@ -726,7 +726,7 @@ static int lola_src_gain_put(struct snd_kcontrol *kcontrol,
 /* raw value: 0 = -84dB, 336 = 0dB, 408=18dB, incremented 1 for mute */
 static const DECLARE_TLV_DB_SCALE(lola_src_gain_tlv, -8425, 25, 1);
 
-static struct snd_kcontrol_new lola_src_gain_mixer __devinitdata = {
+static struct snd_kcontrol_new lola_src_gain_mixer = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
 		   SNDRV_CTL_ELEM_ACCESS_TLV_READ),
@@ -813,7 +813,7 @@ static int lola_dest_gain_put(struct snd_kcontrol *kcontrol,
 
 static const DECLARE_TLV_DB_SCALE(lola_dest_gain_tlv, -8425, 25, 1);
 
-static struct snd_kcontrol_new lola_dest_gain_mixer __devinitdata = {
+static struct snd_kcontrol_new lola_dest_gain_mixer = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
 		   SNDRV_CTL_ELEM_ACCESS_TLV_READ),
diff --git a/sound/pci/lx6464es/lx6464es.c b/sound/pci/lx6464es/lx6464es.c
index 62ff221..c9119ce 100644
--- a/sound/pci/lx6464es/lx6464es.c
+++ b/sound/pci/lx6464es/lx6464es.c
@@ -907,7 +907,7 @@ static int lx_control_playback_put(struct snd_kcontrol *kcontrol,
 	return changed;
 }
 
-static struct snd_kcontrol_new lx_control_playback_switch __devinitdata = {
+static struct snd_kcontrol_new lx_control_playback_switch = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "PCM Playback Switch",
 	.index = 0,
diff --git a/sound/pci/maestro3.c b/sound/pci/maestro3.c
index 7dc0cc8..986cd07 100644
--- a/sound/pci/maestro3.c
+++ b/sound/pci/maestro3.c
@@ -822,7 +822,7 @@ static DEFINE_PCI_DEVICE_TABLE(snd_m3_ids) = {
 
 MODULE_DEVICE_TABLE(pci, snd_m3_ids);
 
-static struct snd_pci_quirk m3_amp_quirk_list[] __devinitdata = {
+static struct snd_pci_quirk m3_amp_quirk_list[] = {
 	SND_PCI_QUIRK(0x0E11, 0x0094, "Compaq Evo N600c", 0x0c),
 	SND_PCI_QUIRK(0x10f7, 0x833e, "Panasonic CF-28", 0x0d),
 	SND_PCI_QUIRK(0x10f7, 0x833d, "Panasonic CF-72", 0x0d),
@@ -831,7 +831,7 @@ static struct snd_pci_quirk m3_amp_quirk_list[] __devinitdata = {
 	{ } /* END */
 };
 
-static struct snd_pci_quirk m3_irda_quirk_list[] __devinitdata = {
+static struct snd_pci_quirk m3_irda_quirk_list[] = {
 	SND_PCI_QUIRK(0x1028, 0x00b0, "Dell Inspiron 4000", 1),
 	SND_PCI_QUIRK(0x1028, 0x00a4, "Dell Inspiron 8000", 1),
 	SND_PCI_QUIRK(0x1028, 0x00e6, "Dell Inspiron 8100", 1),
@@ -839,7 +839,7 @@ static struct snd_pci_quirk m3_irda_quirk_list[] __devinitdata = {
 };
 
 /* hardware volume quirks */
-static struct snd_pci_quirk m3_hv_quirk_list[] __devinitdata = {
+static struct snd_pci_quirk m3_hv_quirk_list[] = {
 	/* Allegro chips */
 	SND_PCI_QUIRK(0x0E11, 0x002E, NULL, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD),
 	SND_PCI_QUIRK(0x0E11, 0x0094, NULL, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD),
@@ -917,7 +917,7 @@ static struct snd_pci_quirk m3_hv_quirk_list[] __devinitdata = {
 };
 
 /* HP Omnibook quirks */
-static struct snd_pci_quirk m3_omnibook_quirk_list[] __devinitdata = {
+static struct snd_pci_quirk m3_omnibook_quirk_list[] = {
 	SND_PCI_QUIRK_ID(0x103c, 0x0010), /* HP OmniBook 6000 */
 	SND_PCI_QUIRK_ID(0x103c, 0x0011), /* HP OmniBook 500 */
 	{ } /* END */
diff --git a/sound/pci/nm256/nm256.c b/sound/pci/nm256/nm256.c
index 6c06e85..6c3fd38 100644
--- a/sound/pci/nm256/nm256.c
+++ b/sound/pci/nm256/nm256.c
@@ -1635,7 +1635,7 @@ __error:
 
 enum { NM_BLACKLISTED, NM_RESET_WORKAROUND, NM_RESET_WORKAROUND_2 };
 
-static struct snd_pci_quirk nm256_quirks[] __devinitdata = {
+static struct snd_pci_quirk nm256_quirks[] = {
 	/* HP omnibook 4150 has cs4232 codec internally */
 	SND_PCI_QUIRK(0x103c, 0x0007, "HP omnibook 4150", NM_BLACKLISTED),
 	/* Reset workarounds to avoid lock-ups */
diff --git a/sound/pci/sonicvibes.c b/sound/pci/sonicvibes.c
index ead7218..f192476 100644
--- a/sound/pci/sonicvibes.c
+++ b/sound/pci/sonicvibes.c
@@ -1087,7 +1087,7 @@ static int snd_sonicvibes_put_double(struct snd_kcontrol *kcontrol, struct snd_c
 	return change;
 }
 
-static struct snd_kcontrol_new snd_sonicvibes_controls[] __devinitdata = {
+static struct snd_kcontrol_new snd_sonicvibes_controls[] = {
 SONICVIBES_DOUBLE("Capture Volume", 0, SV_IREG_LEFT_ADC, SV_IREG_RIGHT_ADC, 0, 0, 15, 0),
 SONICVIBES_DOUBLE("Aux Playback Switch", 0, SV_IREG_LEFT_AUX1, SV_IREG_RIGHT_AUX1, 7, 7, 1, 1),
 SONICVIBES_DOUBLE("Aux Playback Volume", 0, SV_IREG_LEFT_AUX1, SV_IREG_RIGHT_AUX1, 0, 0, 31, 1),
@@ -1188,7 +1188,7 @@ static void snd_sonicvibes_proc_init(struct sonicvibes * sonic)
  */
 
 #ifdef SUPPORT_JOYSTICK
-static struct snd_kcontrol_new snd_sonicvibes_game_control __devinitdata =
+static struct snd_kcontrol_new snd_sonicvibes_game_control =
 SONICVIBES_SINGLE("Joystick Speed", 0, SV_IREG_GAME_PORT, 1, 15, 0);
 
 static int snd_sonicvibes_create_gameport(struct sonicvibes *sonic)
@@ -1401,7 +1401,7 @@ static int snd_sonicvibes_create(struct snd_card *card,
  *  MIDI section
  */
 
-static struct snd_kcontrol_new snd_sonicvibes_midi_controls[] __devinitdata = {
+static struct snd_kcontrol_new snd_sonicvibes_midi_controls[] = {
 SONICVIBES_SINGLE("SonicVibes Wave Source RAM", 0, SV_IREG_WAVE_SOURCE, 0, 1, 0),
 SONICVIBES_SINGLE("SonicVibes Wave Source RAM+ROM", 0, SV_IREG_WAVE_SOURCE, 1, 1, 0),
 SONICVIBES_SINGLE("SonicVibes Onboard Synth", 0, SV_IREG_MPU401, 0, 1, 0),
diff --git a/sound/pci/trident/trident_main.c b/sound/pci/trident/trident_main.c
index 1bf070b..cdd9f81 100644
--- a/sound/pci/trident/trident_main.c
+++ b/sound/pci/trident/trident_main.c
@@ -2371,7 +2371,7 @@ static int snd_trident_spdif_control_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_trident_spdif_control __devinitdata =
+static struct snd_kcontrol_new snd_trident_spdif_control =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =         SNDRV_CTL_NAME_IEC958("",PLAYBACK,SWITCH),
@@ -2434,7 +2434,7 @@ static int snd_trident_spdif_default_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_trident_spdif_default __devinitdata =
+static struct snd_kcontrol_new snd_trident_spdif_default =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
 	.name =         SNDRV_CTL_NAME_IEC958("",PLAYBACK,DEFAULT),
@@ -2467,7 +2467,7 @@ static int snd_trident_spdif_mask_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_trident_spdif_mask __devinitdata =
+static struct snd_kcontrol_new snd_trident_spdif_mask =
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ,
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
@@ -2529,7 +2529,7 @@ static int snd_trident_spdif_stream_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_trident_spdif_stream __devinitdata =
+static struct snd_kcontrol_new snd_trident_spdif_stream =
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_INACTIVE,
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
@@ -2579,7 +2579,7 @@ static int snd_trident_ac97_control_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_trident_ac97_rear_control __devinitdata =
+static struct snd_kcontrol_new snd_trident_ac97_rear_control =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =         "Rear Path",
@@ -2637,7 +2637,7 @@ static int snd_trident_vol_control_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_trident_vol_music_control __devinitdata =
+static struct snd_kcontrol_new snd_trident_vol_music_control =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =         "Music Playback Volume",
@@ -2648,7 +2648,7 @@ static struct snd_kcontrol_new snd_trident_vol_music_control __devinitdata =
 	.tlv = { .p = db_scale_gvol },
 };
 
-static struct snd_kcontrol_new snd_trident_vol_wave_control __devinitdata =
+static struct snd_kcontrol_new snd_trident_vol_wave_control =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =         "Wave Playback Volume",
@@ -2715,7 +2715,7 @@ static int snd_trident_pcm_vol_control_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_trident_pcm_vol_control __devinitdata =
+static struct snd_kcontrol_new snd_trident_pcm_vol_control =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =         "PCM Front Playback Volume",
@@ -2779,7 +2779,7 @@ static int snd_trident_pcm_pan_control_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_trident_pcm_pan_control __devinitdata =
+static struct snd_kcontrol_new snd_trident_pcm_pan_control =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =         "PCM Pan Playback Control",
@@ -2836,7 +2836,7 @@ static int snd_trident_pcm_rvol_control_put(struct snd_kcontrol *kcontrol,
 
 static const DECLARE_TLV_DB_SCALE(db_scale_crvol, -3175, 25, 1);
 
-static struct snd_kcontrol_new snd_trident_pcm_rvol_control __devinitdata =
+static struct snd_kcontrol_new snd_trident_pcm_rvol_control =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =         "PCM Reverb Playback Volume",
@@ -2892,7 +2892,7 @@ static int snd_trident_pcm_cvol_control_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_trident_pcm_cvol_control __devinitdata =
+static struct snd_kcontrol_new snd_trident_pcm_cvol_control =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =         "PCM Chorus Playback Volume",
diff --git a/sound/pci/via82xx.c b/sound/pci/via82xx.c
index 7ac1fe2..5481695 100644
--- a/sound/pci/via82xx.c
+++ b/sound/pci/via82xx.c
@@ -1643,7 +1643,7 @@ static int snd_via8233_capture_source_put(struct snd_kcontrol *kcontrol,
 	return val != oval;
 }
 
-static struct snd_kcontrol_new snd_via8233_capture_source __devinitdata = {
+static struct snd_kcontrol_new snd_via8233_capture_source = {
 	.name = "Input Source Select",
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.info = snd_via8233_capture_source_info,
@@ -1683,7 +1683,7 @@ static int snd_via8233_dxs3_spdif_put(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_via8233_dxs3_spdif_control __devinitdata = {
+static struct snd_kcontrol_new snd_via8233_dxs3_spdif_control = {
 	.name = SNDRV_CTL_NAME_IEC958("Output ",NONE,SWITCH),
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.info = snd_via8233_dxs3_spdif_info,
@@ -1772,7 +1772,7 @@ static int snd_via8233_pcmdxs_volume_put(struct snd_kcontrol *kcontrol,
 
 static const DECLARE_TLV_DB_SCALE(db_scale_dxs, -4650, 150, 1);
 
-static struct snd_kcontrol_new snd_via8233_pcmdxs_volume_control __devinitdata = {
+static struct snd_kcontrol_new snd_via8233_pcmdxs_volume_control = {
 	.name = "PCM Playback Volume",
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
@@ -1783,7 +1783,7 @@ static struct snd_kcontrol_new snd_via8233_pcmdxs_volume_control __devinitdata =
 	.tlv = { .p = db_scale_dxs }
 };
 
-static struct snd_kcontrol_new snd_via8233_dxs_volume_control __devinitdata = {
+static struct snd_kcontrol_new snd_via8233_dxs_volume_control = {
 	.iface = SNDRV_CTL_ELEM_IFACE_PCM,
 	.device = 0,
 	/* .subdevice set later */
@@ -2452,7 +2452,7 @@ struct via823x_info {
 	char *name;
 	int type;
 };
-static struct via823x_info via823x_cards[] __devinitdata = {
+static struct via823x_info via823x_cards[] = {
 	{ VIA_REV_PRE_8233, "VIA 8233-Pre", TYPE_VIA8233 },
 	{ VIA_REV_8233C, "VIA 8233C", TYPE_VIA8233 },
 	{ VIA_REV_8233, "VIA 8233", TYPE_VIA8233 },
@@ -2466,7 +2466,7 @@ static struct via823x_info via823x_cards[] __devinitdata = {
  * auto detection of DXS channel supports.
  */
 
-static struct snd_pci_quirk dxs_whitelist[] __devinitdata = {
+static struct snd_pci_quirk dxs_whitelist[] = {
 	SND_PCI_QUIRK(0x1005, 0x4710, "Avance Logic Mobo", VIA_DXS_ENABLE),
 	SND_PCI_QUIRK(0x1019, 0x0996, "ESC Mobo", VIA_DXS_48K),
 	SND_PCI_QUIRK(0x1019, 0x0a81, "ECS K7VTA3 v8.0", VIA_DXS_NO_VRA),
diff --git a/sound/pci/ymfpci/ymfpci_main.c b/sound/pci/ymfpci/ymfpci_main.c
index b947594..c7b26de 100644
--- a/sound/pci/ymfpci/ymfpci_main.c
+++ b/sound/pci/ymfpci/ymfpci_main.c
@@ -1339,7 +1339,7 @@ static int snd_ymfpci_spdif_default_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_ymfpci_spdif_default __devinitdata =
+static struct snd_kcontrol_new snd_ymfpci_spdif_default =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
 	.name =         SNDRV_CTL_NAME_IEC958("",PLAYBACK,DEFAULT),
@@ -1367,7 +1367,7 @@ static int snd_ymfpci_spdif_mask_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_ymfpci_spdif_mask __devinitdata =
+static struct snd_kcontrol_new snd_ymfpci_spdif_mask =
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ,
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
@@ -1414,7 +1414,7 @@ static int snd_ymfpci_spdif_stream_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_ymfpci_spdif_stream __devinitdata =
+static struct snd_kcontrol_new snd_ymfpci_spdif_stream =
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_INACTIVE,
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
@@ -1462,7 +1462,7 @@ static int snd_ymfpci_drec_source_put(struct snd_kcontrol *kcontrol, struct snd_
 	return reg != old_reg;
 }
 
-static struct snd_kcontrol_new snd_ymfpci_drec_source __devinitdata = {
+static struct snd_kcontrol_new snd_ymfpci_drec_source = {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READWRITE,
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =		"Direct Recording Source",
@@ -1632,7 +1632,7 @@ static int snd_ymfpci_put_dup4ch(struct snd_kcontrol *kcontrol, struct snd_ctl_e
 	return change;
 }
 
-static struct snd_kcontrol_new snd_ymfpci_dup4ch __devinitdata = {
+static struct snd_kcontrol_new snd_ymfpci_dup4ch = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "4ch Duplication",
 	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
@@ -1641,7 +1641,7 @@ static struct snd_kcontrol_new snd_ymfpci_dup4ch __devinitdata = {
 	.put = snd_ymfpci_put_dup4ch,
 };
 
-static struct snd_kcontrol_new snd_ymfpci_controls[] __devinitdata = {
+static struct snd_kcontrol_new snd_ymfpci_controls[] = {
 {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Wave Playback Volume",
@@ -1735,7 +1735,7 @@ static int snd_ymfpci_gpio_sw_put(struct snd_kcontrol *kcontrol, struct snd_ctl_
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_ymfpci_rear_shared __devinitdata = {
+static struct snd_kcontrol_new snd_ymfpci_rear_shared = {
 	.name = "Shared Rear/Line-In Switch",
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.info = snd_ymfpci_gpio_sw_info,
@@ -1799,7 +1799,7 @@ static int snd_ymfpci_pcm_vol_put(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_ymfpci_pcm_volume __devinitdata = {
+static struct snd_kcontrol_new snd_ymfpci_pcm_volume = {
 	.iface = SNDRV_CTL_ELEM_IFACE_PCM,
 	.name = "PCM Playback Volume",
 	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
diff --git a/sound/ppc/awacs.c b/sound/ppc/awacs.c
index 667a067..78b2caa 100644
--- a/sound/ppc/awacs.c
+++ b/sound/ppc/awacs.c
@@ -477,7 +477,7 @@ static int snd_pmac_awacs_put_master_amp(struct snd_kcontrol *kcontrol,
 #define AMP_CH_SPK	0
 #define AMP_CH_HD	1
 
-static struct snd_kcontrol_new snd_pmac_awacs_amp_vol[] __devinitdata = {
+static struct snd_kcontrol_new snd_pmac_awacs_amp_vol[] = {
 	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	  .name = "Speaker Playback Volume",
 	  .info = snd_pmac_awacs_info_volume_amp,
@@ -514,7 +514,7 @@ static struct snd_kcontrol_new snd_pmac_awacs_amp_vol[] __devinitdata = {
 	},
 };
 
-static struct snd_kcontrol_new snd_pmac_awacs_amp_hp_sw __devinitdata = {
+static struct snd_kcontrol_new snd_pmac_awacs_amp_hp_sw = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Headphone Playback Switch",
 	.info = snd_pmac_boolean_stereo_info,
@@ -523,7 +523,7 @@ static struct snd_kcontrol_new snd_pmac_awacs_amp_hp_sw __devinitdata = {
 	.private_value = AMP_CH_HD,
 };
 
-static struct snd_kcontrol_new snd_pmac_awacs_amp_spk_sw __devinitdata = {
+static struct snd_kcontrol_new snd_pmac_awacs_amp_spk_sw = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Speaker Playback Switch",
 	.info = snd_pmac_boolean_stereo_info,
@@ -595,46 +595,46 @@ static int snd_pmac_screamer_mic_boost_put(struct snd_kcontrol *kcontrol,
 /*
  * lists of mixer elements
  */
-static struct snd_kcontrol_new snd_pmac_awacs_mixers[] __devinitdata = {
+static struct snd_kcontrol_new snd_pmac_awacs_mixers[] = {
 	AWACS_SWITCH("Master Capture Switch", 1, SHIFT_LOOPTHRU, 0),
 	AWACS_VOLUME("Master Capture Volume", 0, 4, 0),
 /*	AWACS_SWITCH("Unknown Playback Switch", 6, SHIFT_PAROUT0, 0), */
 };
 
-static struct snd_kcontrol_new snd_pmac_screamer_mixers_beige[] __devinitdata = {
+static struct snd_kcontrol_new snd_pmac_screamer_mixers_beige[] = {
 	AWACS_VOLUME("Master Playback Volume", 2, 6, 1),
 	AWACS_VOLUME("Play-through Playback Volume", 5, 6, 1),
 	AWACS_SWITCH("Line Capture Switch", 0, SHIFT_MUX_MIC, 0),
 	AWACS_SWITCH("CD Capture Switch", 0, SHIFT_MUX_LINE, 0),
 };
 
-static struct snd_kcontrol_new snd_pmac_screamer_mixers_lo[] __devinitdata = {
+static struct snd_kcontrol_new snd_pmac_screamer_mixers_lo[] = {
 	AWACS_VOLUME("Line out Playback Volume", 2, 6, 1),
 };
 
-static struct snd_kcontrol_new snd_pmac_screamer_mixers_imac[] __devinitdata = {
+static struct snd_kcontrol_new snd_pmac_screamer_mixers_imac[] = {
 	AWACS_VOLUME("Play-through Playback Volume", 5, 6, 1),
 	AWACS_SWITCH("CD Capture Switch", 0, SHIFT_MUX_CD, 0),
 };
 
-static struct snd_kcontrol_new snd_pmac_screamer_mixers_g4agp[] __devinitdata = {
+static struct snd_kcontrol_new snd_pmac_screamer_mixers_g4agp[] = {
 	AWACS_VOLUME("Line out Playback Volume", 2, 6, 1),
 	AWACS_VOLUME("Master Playback Volume", 5, 6, 1),
 	AWACS_SWITCH("CD Capture Switch", 0, SHIFT_MUX_CD, 0),
 	AWACS_SWITCH("Line Capture Switch", 0, SHIFT_MUX_MIC, 0),
 };
 
-static struct snd_kcontrol_new snd_pmac_awacs_mixers_pmac7500[] __devinitdata = {
+static struct snd_kcontrol_new snd_pmac_awacs_mixers_pmac7500[] = {
 	AWACS_VOLUME("Line out Playback Volume", 2, 6, 1),
 	AWACS_SWITCH("CD Capture Switch", 0, SHIFT_MUX_CD, 0),
 	AWACS_SWITCH("Line Capture Switch", 0, SHIFT_MUX_MIC, 0),
 };
 
-static struct snd_kcontrol_new snd_pmac_awacs_mixers_pmac5500[] __devinitdata = {
+static struct snd_kcontrol_new snd_pmac_awacs_mixers_pmac5500[] = {
 	AWACS_VOLUME("Headphone Playback Volume", 2, 6, 1),
 };
 
-static struct snd_kcontrol_new snd_pmac_awacs_mixers_pmac[] __devinitdata = {
+static struct snd_kcontrol_new snd_pmac_awacs_mixers_pmac[] = {
 	AWACS_VOLUME("Master Playback Volume", 2, 6, 1),
 	AWACS_SWITCH("CD Capture Switch", 0, SHIFT_MUX_CD, 0),
 };
@@ -642,34 +642,34 @@ static struct snd_kcontrol_new snd_pmac_awacs_mixers_pmac[] __devinitdata = {
 /* FIXME: is this correct order?
  * screamer (powerbook G3 pismo) seems to have different bits...
  */
-static struct snd_kcontrol_new snd_pmac_awacs_mixers2[] __devinitdata = {
+static struct snd_kcontrol_new snd_pmac_awacs_mixers2[] = {
 	AWACS_SWITCH("Line Capture Switch", 0, SHIFT_MUX_LINE, 0),
 	AWACS_SWITCH("Mic Capture Switch", 0, SHIFT_MUX_MIC, 0),
 };
 
-static struct snd_kcontrol_new snd_pmac_screamer_mixers2[] __devinitdata = {
+static struct snd_kcontrol_new snd_pmac_screamer_mixers2[] = {
 	AWACS_SWITCH("Line Capture Switch", 0, SHIFT_MUX_MIC, 0),
 	AWACS_SWITCH("Mic Capture Switch", 0, SHIFT_MUX_LINE, 0),
 };
 
-static struct snd_kcontrol_new snd_pmac_awacs_mixers2_pmac5500[] __devinitdata = {
+static struct snd_kcontrol_new snd_pmac_awacs_mixers2_pmac5500[] = {
 	AWACS_SWITCH("CD Capture Switch", 0, SHIFT_MUX_CD, 0),
 };
 
-static struct snd_kcontrol_new snd_pmac_awacs_master_sw __devinitdata =
+static struct snd_kcontrol_new snd_pmac_awacs_master_sw =
 AWACS_SWITCH("Master Playback Switch", 1, SHIFT_HDMUTE, 1);
 
-static struct snd_kcontrol_new snd_pmac_awacs_master_sw_imac __devinitdata =
+static struct snd_kcontrol_new snd_pmac_awacs_master_sw_imac =
 AWACS_SWITCH("Line out Playback Switch", 1, SHIFT_HDMUTE, 1);
 
-static struct snd_kcontrol_new snd_pmac_awacs_master_sw_pmac5500 __devinitdata =
+static struct snd_kcontrol_new snd_pmac_awacs_master_sw_pmac5500 =
 AWACS_SWITCH("Headphone Playback Switch", 1, SHIFT_HDMUTE, 1);
 
-static struct snd_kcontrol_new snd_pmac_awacs_mic_boost[] __devinitdata = {
+static struct snd_kcontrol_new snd_pmac_awacs_mic_boost[] = {
 	AWACS_SWITCH("Mic Boost Capture Switch", 0, SHIFT_GAINLINE, 0),
 };
 
-static struct snd_kcontrol_new snd_pmac_screamer_mic_boost[] __devinitdata = {
+static struct snd_kcontrol_new snd_pmac_screamer_mic_boost[] = {
 	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	  .name = "Mic Boost Capture Volume",
 	  .info = snd_pmac_screamer_mic_boost_info,
@@ -678,34 +678,34 @@ static struct snd_kcontrol_new snd_pmac_screamer_mic_boost[] __devinitdata = {
 	},
 };
 
-static struct snd_kcontrol_new snd_pmac_awacs_mic_boost_pmac7500[] __devinitdata =
+static struct snd_kcontrol_new snd_pmac_awacs_mic_boost_pmac7500[] =
 {
 	AWACS_SWITCH("Line Boost Capture Switch", 0, SHIFT_GAINLINE, 0),
 };
 
-static struct snd_kcontrol_new snd_pmac_screamer_mic_boost_beige[] __devinitdata =
+static struct snd_kcontrol_new snd_pmac_screamer_mic_boost_beige[] =
 {
 	AWACS_SWITCH("Line Boost Capture Switch", 0, SHIFT_GAINLINE, 0),
 	AWACS_SWITCH("CD Boost Capture Switch", 6, SHIFT_MIC_BOOST, 0),
 };
 
-static struct snd_kcontrol_new snd_pmac_screamer_mic_boost_imac[] __devinitdata =
+static struct snd_kcontrol_new snd_pmac_screamer_mic_boost_imac[] =
 {
 	AWACS_SWITCH("Line Boost Capture Switch", 0, SHIFT_GAINLINE, 0),
 	AWACS_SWITCH("Mic Boost Capture Switch", 6, SHIFT_MIC_BOOST, 0),
 };
 
-static struct snd_kcontrol_new snd_pmac_awacs_speaker_vol[] __devinitdata = {
+static struct snd_kcontrol_new snd_pmac_awacs_speaker_vol[] = {
 	AWACS_VOLUME("Speaker Playback Volume", 4, 6, 1),
 };
 
-static struct snd_kcontrol_new snd_pmac_awacs_speaker_sw __devinitdata =
+static struct snd_kcontrol_new snd_pmac_awacs_speaker_sw =
 AWACS_SWITCH("Speaker Playback Switch", 1, SHIFT_SPKMUTE, 1);
 
-static struct snd_kcontrol_new snd_pmac_awacs_speaker_sw_imac1 __devinitdata =
+static struct snd_kcontrol_new snd_pmac_awacs_speaker_sw_imac1 =
 AWACS_SWITCH("Speaker Playback Switch", 1, SHIFT_PAROUT1, 1);
 
-static struct snd_kcontrol_new snd_pmac_awacs_speaker_sw_imac2 __devinitdata =
+static struct snd_kcontrol_new snd_pmac_awacs_speaker_sw_imac2 =
 AWACS_SWITCH("Speaker Playback Switch", 1, SHIFT_PAROUT1, 0);
 
 
diff --git a/sound/ppc/burgundy.c b/sound/ppc/burgundy.c
index 6c76724..cb4f0a5 100644
--- a/sound/ppc/burgundy.c
+++ b/sound/ppc/burgundy.c
@@ -467,7 +467,7 @@ static int snd_pmac_burgundy_put_switch_b(struct snd_kcontrol *kcontrol,
 /*
  * Burgundy mixers
  */
-static struct snd_kcontrol_new snd_pmac_burgundy_mixers[] __devinitdata = {
+static struct snd_kcontrol_new snd_pmac_burgundy_mixers[] = {
 	BURGUNDY_VOLUME_W("Master Playback Volume", 0,
 			MASK_ADDR_BURGUNDY_MASTER_VOLUME, 8),
 	BURGUNDY_VOLUME_W("CD Capture Volume", 0,
@@ -495,7 +495,7 @@ static struct snd_kcontrol_new snd_pmac_burgundy_mixers[] __devinitdata = {
  */	BURGUNDY_SWITCH_B("PCM Capture Switch", 0,
 			MASK_ADDR_BURGUNDY_HOSTIFEH, 0x01, 0, 0)
 };
-static struct snd_kcontrol_new snd_pmac_burgundy_mixers_imac[] __devinitdata = {
+static struct snd_kcontrol_new snd_pmac_burgundy_mixers_imac[] = {
 	BURGUNDY_VOLUME_W("Line in Capture Volume", 0,
 			MASK_ADDR_BURGUNDY_VOLLINE, 16),
 	BURGUNDY_VOLUME_W("Mic Capture Volume", 0,
@@ -521,7 +521,7 @@ static struct snd_kcontrol_new snd_pmac_burgundy_mixers_imac[] __devinitdata = {
 	BURGUNDY_SWITCH_B("Mic Boost Capture Switch", 0,
 			MASK_ADDR_BURGUNDY_INPBOOST, 0x40, 0x80, 1)
 };
-static struct snd_kcontrol_new snd_pmac_burgundy_mixers_pmac[] __devinitdata = {
+static struct snd_kcontrol_new snd_pmac_burgundy_mixers_pmac[] = {
 	BURGUNDY_VOLUME_W("Line in Capture Volume", 0,
 			MASK_ADDR_BURGUNDY_VOLMIC, 16),
 	BURGUNDY_VOLUME_B("Line in Gain Capture Volume", 0,
@@ -537,33 +537,33 @@ static struct snd_kcontrol_new snd_pmac_burgundy_mixers_pmac[] __devinitdata = {
 /*	BURGUNDY_SWITCH_B("Line in Boost Capture Switch", 0,
  *		MASK_ADDR_BURGUNDY_INPBOOST, 0x40, 0x80, 1) */
 };
-static struct snd_kcontrol_new snd_pmac_burgundy_master_sw_imac __devinitdata =
+static struct snd_kcontrol_new snd_pmac_burgundy_master_sw_imac =
 BURGUNDY_SWITCH_B("Master Playback Switch", 0,
 	MASK_ADDR_BURGUNDY_MORE_OUTPUTENABLES,
 	BURGUNDY_OUTPUT_LEFT | BURGUNDY_LINEOUT_LEFT | BURGUNDY_HP_LEFT,
 	BURGUNDY_OUTPUT_RIGHT | BURGUNDY_LINEOUT_RIGHT | BURGUNDY_HP_RIGHT, 1);
-static struct snd_kcontrol_new snd_pmac_burgundy_master_sw_pmac __devinitdata =
+static struct snd_kcontrol_new snd_pmac_burgundy_master_sw_pmac =
 BURGUNDY_SWITCH_B("Master Playback Switch", 0,
 	MASK_ADDR_BURGUNDY_MORE_OUTPUTENABLES,
 	BURGUNDY_OUTPUT_INTERN
 	| BURGUNDY_OUTPUT_LEFT, BURGUNDY_OUTPUT_RIGHT, 1);
-static struct snd_kcontrol_new snd_pmac_burgundy_speaker_sw_imac __devinitdata =
+static struct snd_kcontrol_new snd_pmac_burgundy_speaker_sw_imac =
 BURGUNDY_SWITCH_B("Speaker Playback Switch", 0,
 	MASK_ADDR_BURGUNDY_MORE_OUTPUTENABLES,
 	BURGUNDY_OUTPUT_LEFT, BURGUNDY_OUTPUT_RIGHT, 1);
-static struct snd_kcontrol_new snd_pmac_burgundy_speaker_sw_pmac __devinitdata =
+static struct snd_kcontrol_new snd_pmac_burgundy_speaker_sw_pmac =
 BURGUNDY_SWITCH_B("Speaker Playback Switch", 0,
 	MASK_ADDR_BURGUNDY_MORE_OUTPUTENABLES,
 	BURGUNDY_OUTPUT_INTERN, 0, 0);
-static struct snd_kcontrol_new snd_pmac_burgundy_line_sw_imac __devinitdata =
+static struct snd_kcontrol_new snd_pmac_burgundy_line_sw_imac =
 BURGUNDY_SWITCH_B("Line out Playback Switch", 0,
 	MASK_ADDR_BURGUNDY_MORE_OUTPUTENABLES,
 	BURGUNDY_LINEOUT_LEFT, BURGUNDY_LINEOUT_RIGHT, 1);
-static struct snd_kcontrol_new snd_pmac_burgundy_line_sw_pmac __devinitdata =
+static struct snd_kcontrol_new snd_pmac_burgundy_line_sw_pmac =
 BURGUNDY_SWITCH_B("Line out Playback Switch", 0,
 	MASK_ADDR_BURGUNDY_MORE_OUTPUTENABLES,
 	BURGUNDY_OUTPUT_LEFT, BURGUNDY_OUTPUT_RIGHT, 1);
-static struct snd_kcontrol_new snd_pmac_burgundy_hp_sw_imac __devinitdata =
+static struct snd_kcontrol_new snd_pmac_burgundy_hp_sw_imac =
 BURGUNDY_SWITCH_B("Headphone Playback Switch", 0,
 	MASK_ADDR_BURGUNDY_MORE_OUTPUTENABLES,
 	BURGUNDY_HP_LEFT, BURGUNDY_HP_RIGHT, 1);
diff --git a/sound/ppc/pmac.c b/sound/ppc/pmac.c
index 792bf7b..c93fbbb 100644
--- a/sound/ppc/pmac.c
+++ b/sound/ppc/pmac.c
@@ -1146,7 +1146,7 @@ static int pmac_hp_detect_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new auto_mute_controls[] __devinitdata = {
+static struct snd_kcontrol_new auto_mute_controls[] = {
 	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	  .name = "Auto Mute Switch",
 	  .info = snd_pmac_boolean_mono_info,
diff --git a/sound/ppc/tumbler.c b/sound/ppc/tumbler.c
index 6dd2e47..b23354a 100644
--- a/sound/ppc/tumbler.c
+++ b/sound/ppc/tumbler.c
@@ -844,7 +844,7 @@ static int snapper_put_capture_source(struct snd_kcontrol *kcontrol,
 
 /*
  */
-static struct snd_kcontrol_new tumbler_mixers[] __devinitdata = {
+static struct snd_kcontrol_new tumbler_mixers[] = {
 	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	  .name = "Master Playback Volume",
 	  .info = tumbler_info_master_volume,
@@ -868,7 +868,7 @@ static struct snd_kcontrol_new tumbler_mixers[] __devinitdata = {
 	},
 };
 
-static struct snd_kcontrol_new snapper_mixers[] __devinitdata = {
+static struct snd_kcontrol_new snapper_mixers[] = {
 	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	  .name = "Master Playback Volume",
 	  .info = tumbler_info_master_volume,
@@ -901,7 +901,7 @@ static struct snd_kcontrol_new snapper_mixers[] __devinitdata = {
 	},
 };
 
-static struct snd_kcontrol_new tumbler_hp_sw __devinitdata = {
+static struct snd_kcontrol_new tumbler_hp_sw = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Headphone Playback Switch",
 	.info = snd_pmac_boolean_mono_info,
@@ -909,7 +909,7 @@ static struct snd_kcontrol_new tumbler_hp_sw __devinitdata = {
 	.put = tumbler_put_mute_switch,
 	.private_value = TUMBLER_MUTE_HP,
 };
-static struct snd_kcontrol_new tumbler_speaker_sw __devinitdata = {
+static struct snd_kcontrol_new tumbler_speaker_sw = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Speaker Playback Switch",
 	.info = snd_pmac_boolean_mono_info,
@@ -917,7 +917,7 @@ static struct snd_kcontrol_new tumbler_speaker_sw __devinitdata = {
 	.put = tumbler_put_mute_switch,
 	.private_value = TUMBLER_MUTE_AMP,
 };
-static struct snd_kcontrol_new tumbler_lineout_sw __devinitdata = {
+static struct snd_kcontrol_new tumbler_lineout_sw = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Line Out Playback Switch",
 	.info = snd_pmac_boolean_mono_info,
@@ -925,7 +925,7 @@ static struct snd_kcontrol_new tumbler_lineout_sw __devinitdata = {
 	.put = tumbler_put_mute_switch,
 	.private_value = TUMBLER_MUTE_LINE,
 };
-static struct snd_kcontrol_new tumbler_drc_sw __devinitdata = {
+static struct snd_kcontrol_new tumbler_drc_sw = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "DRC Switch",
 	.info = snd_pmac_boolean_mono_info,
diff --git a/sound/sh/aica.c b/sound/sh/aica.c
index a6de99f..1cbbf42 100644
--- a/sound/sh/aica.c
+++ b/sound/sh/aica.c
@@ -540,7 +540,7 @@ static int aica_pcmvolume_put(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
-static struct snd_kcontrol_new snd_aica_pcmswitch_control __devinitdata = {
+static struct snd_kcontrol_new snd_aica_pcmswitch_control = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "PCM Playback Switch",
 	.index = 0,
@@ -549,7 +549,7 @@ static struct snd_kcontrol_new snd_aica_pcmswitch_control __devinitdata = {
 	.put = aica_pcmswitch_put
 };
 
-static struct snd_kcontrol_new snd_aica_pcmvolume_control __devinitdata = {
+static struct snd_kcontrol_new snd_aica_pcmvolume_control = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "PCM Playback Volume",
 	.index = 0,
diff --git a/sound/soc/au1x/db1200.c b/sound/soc/au1x/db1200.c
index f319419..fdda99c 100644
--- a/sound/soc/au1x/db1200.c
+++ b/sound/soc/au1x/db1200.c
@@ -167,7 +167,7 @@ static struct snd_soc_card db1550_i2s_machine = {
 
 /*-------------------------  COMMON PART  ---------------------------*/
 
-static struct snd_soc_card *db1200_cards[] __devinitdata = {
+static struct snd_soc_card *db1200_cards[] = {
 	&db1200_ac97_machine,
 	&db1200_i2s_machine,
 	&db1300_ac97_machine,
diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc_ac97.c
index 8a7ec26..7ba4764 100644
--- a/sound/soc/fsl/mpc5200_psc_ac97.c
+++ b/sound/soc/fsl/mpc5200_psc_ac97.c
@@ -318,7 +318,7 @@ static int __devexit psc_ac97_of_remove(struct platform_device *op)
 }
 
 /* Match table for of_platform binding */
-static struct of_device_id psc_ac97_match[] __devinitdata = {
+static struct of_device_id psc_ac97_match[] = {
 	{ .compatible = "fsl,mpc5200-psc-ac97", },
 	{ .compatible = "fsl,mpc5200b-psc-ac97", },
 	{}
diff --git a/sound/soc/fsl/mpc5200_psc_i2s.c b/sound/soc/fsl/mpc5200_psc_i2s.c
index 328b9df..39ef9ad 100644
--- a/sound/soc/fsl/mpc5200_psc_i2s.c
+++ b/sound/soc/fsl/mpc5200_psc_i2s.c
@@ -213,7 +213,7 @@ static int __devexit psc_i2s_of_remove(struct platform_device *op)
 }
 
 /* Match table for of_platform binding */
-static struct of_device_id psc_i2s_match[] __devinitdata = {
+static struct of_device_id psc_i2s_match[] = {
 	{ .compatible = "fsl,mpc5200-psc-i2s", },
 	{ .compatible = "fsl,mpc5200b-psc-i2s", },
 	{}
diff --git a/sound/soc/tegra/tegra30_ahub.c b/sound/soc/tegra/tegra30_ahub.c
index ed812d2..b9c2008 100644
--- a/sound/soc/tegra/tegra30_ahub.c
+++ b/sound/soc/tegra/tegra30_ahub.c
@@ -299,7 +299,7 @@ static const char * const configlink_clocks[] __devinitconst = {
 	"spdif_in",
 };
 
-struct of_dev_auxdata ahub_auxdata[] __devinitdata = {
+struct of_dev_auxdata ahub_auxdata[] = {
 	OF_DEV_AUXDATA("nvidia,tegra30-i2s", 0x70080300, "tegra30-i2s.0", NULL),
 	OF_DEV_AUXDATA("nvidia,tegra30-i2s", 0x70080400, "tegra30-i2s.1", NULL),
 	OF_DEV_AUXDATA("nvidia,tegra30-i2s", 0x70080500, "tegra30-i2s.2", NULL),
diff --git a/sound/sparc/amd7930.c b/sound/sparc/amd7930.c
index 5809a94..6654ef1 100644
--- a/sound/sparc/amd7930.c
+++ b/sound/sparc/amd7930.c
@@ -854,7 +854,7 @@ static int snd_amd7930_put_volume(struct snd_kcontrol *kctl, struct snd_ctl_elem
 	return change;
 }
 
-static struct snd_kcontrol_new amd7930_controls[] __devinitdata = {
+static struct snd_kcontrol_new amd7930_controls[] = {
 	{
 		.iface		=	SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name		=	"Monitor Volume",
diff --git a/sound/sparc/cs4231.c b/sound/sparc/cs4231.c
index 102ad1e..0953402 100644
--- a/sound/sparc/cs4231.c
+++ b/sound/sparc/cs4231.c
@@ -1498,7 +1498,7 @@ static int snd_cs4231_put_double(struct snd_kcontrol *kcontrol,
   .private_value = (left_reg) | ((right_reg) << 8) | ((shift_left) << 16) | \
 		   ((shift_right) << 19) | ((mask) << 24) | ((invert) << 22) }
 
-static struct snd_kcontrol_new snd_cs4231_controls[] __devinitdata = {
+static struct snd_kcontrol_new snd_cs4231_controls[] = {
 CS4231_DOUBLE("PCM Playback Switch", 0, CS4231_LEFT_OUTPUT,
 		CS4231_RIGHT_OUTPUT, 7, 7, 1, 1),
 CS4231_DOUBLE("PCM Playback Volume", 0, CS4231_LEFT_OUTPUT,
diff --git a/sound/sparc/dbri.c b/sound/sparc/dbri.c
index 8763ba0..aca99ec 100644
--- a/sound/sparc/dbri.c
+++ b/sound/sparc/dbri.c
@@ -2409,7 +2409,7 @@ static int snd_cs4215_put_single(struct snd_kcontrol *kcontrol,
   .private_value = (entry) | ((shift) << 8) | ((mask) << 16) |	\
 			((invert) << 24) },
 
-static struct snd_kcontrol_new dbri_controls[] __devinitdata = {
+static struct snd_kcontrol_new dbri_controls[] = {
 	{
 	 .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	 .name  = "Playback Volume",
diff --git a/sound/spi/at73c213.c b/sound/spi/at73c213.c
index 7f39fa2..9d92ecb 100644
--- a/sound/spi/at73c213.c
+++ b/sound/spi/at73c213.c
@@ -665,7 +665,7 @@ static int snd_at73c213_aux_capture_volume_info(
 			| (mask << 24) | (invert << 22))		\
 }
 
-static struct snd_kcontrol_new snd_at73c213_controls[] __devinitdata = {
+static struct snd_kcontrol_new snd_at73c213_controls[] = {
 AT73C213_STEREO("Master Playback Volume", 0, DAC_LMPG, DAC_RMPG, 0, 0, 0x1f, 1),
 AT73C213_STEREO("Master Playback Switch", 0, DAC_LMPG, DAC_RMPG, 5, 5, 1, 1),
 AT73C213_STEREO("PCM Playback Volume", 0, DAC_LLOG, DAC_RLOG, 0, 0, 0x1f, 1),
diff --git a/sound/usb/6fire/control.c b/sound/usb/6fire/control.c
index 3492bd1..f6434c2 100644
--- a/sound/usb/6fire/control.c
+++ b/sound/usb/6fire/control.c
@@ -411,7 +411,7 @@ static int usb6fire_control_digital_thru_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct __devinitdata snd_kcontrol_new vol_elements[] = {
+static struct snd_kcontrol_new vol_elements[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Analog Playback Volume",
@@ -451,7 +451,7 @@ static struct __devinitdata snd_kcontrol_new vol_elements[] = {
 	{}
 };
 
-static struct __devinitdata snd_kcontrol_new mute_elements[] = {
+static struct snd_kcontrol_new mute_elements[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Analog Playback Switch",
@@ -485,7 +485,7 @@ static struct __devinitdata snd_kcontrol_new mute_elements[] = {
 	{}
 };
 
-static struct __devinitdata snd_kcontrol_new elements[] = {
+static struct snd_kcontrol_new elements[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Line/Phono Capture Route",
diff --git a/sound/usb/caiaq/control.c b/sound/usb/caiaq/control.c
index 8d6c308..ba9e7a4 100644
--- a/sound/usb/caiaq/control.c
+++ b/sound/usb/caiaq/control.c
@@ -137,7 +137,7 @@ static int control_put(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
-static struct snd_kcontrol_new kcontrol_template __devinitdata = {
+static struct snd_kcontrol_new kcontrol_template = {
 	.iface = SNDRV_CTL_ELEM_IFACE_HWDEP,
 	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
 	.index = 0,
-- 
1.8.0
