From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] ALSA: constify snd_kcontrol_new structures
Date: Mon, 20 Feb 2017 00:18:09 +0530
Message-ID: <1487530089-6361-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 by alsa0.perex.cz (Postfix) with ESMTP id A9EFA26583C
 for <alsa-devel@alsa-project.org>; Sun, 19 Feb 2017 19:48:22 +0100 (CET)
Received: by mail-pg0-f65.google.com with SMTP id 1so2796485pgz.2
 for <alsa-devel@alsa-project.org>; Sun, 19 Feb 2017 10:48:22 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: julia.lawall@lip6.fr, perex@perex.cz, tiwai@suse.com, clemens@ladisch.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Declare snd_kcontrol_new structures as const as they are only passed as
an argument to the function snd_ctl_new1. This argument is of type
const, so snd_kcontrol_new structures having the same property can be
made const too.
Done using Coccinelle:

@r1 disable optional_qualifier @
identifier i;
position p;
@@
static struct snd_kcontrol_new i@p = {...};

@ok1@
identifier r1.i;
position p;
expression e1;
@@
snd_ctl_new1(&i@p,e1)

@bad@
position p!={r1.p,ok1.p};
identifier r1.i;
@@
i@p

@depends on !bad disable optional_qualifier@
identifier r1.i;
@@
+const
struct snd_kcontrol_new i;

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/pci/au88x0/au88x0_a3d.c    |  2 +-
 sound/pci/au88x0/au88x0_eq.c     |  6 +++---
 sound/pci/au88x0/au88x0_pcm.c    |  2 +-
 sound/pci/aw2/aw2-alsa.c         |  2 +-
 sound/pci/bt87x.c                |  6 +++---
 sound/pci/ca0106/ca0106_mixer.c  |  4 ++--
 sound/pci/cmipci.c               |  6 +++---
 sound/pci/cs4281.c               |  4 ++--
 sound/pci/echoaudio/echoaudio.c  | 26 +++++++++++++-------------
 sound/pci/emu10k1/emu10k1x.c     |  6 +++---
 sound/pci/emu10k1/emumixer.c     | 30 +++++++++++++++---------------
 sound/pci/emu10k1/emupcm.c       |  2 +-
 sound/pci/ens1370.c              |  4 ++--
 sound/pci/hda/hda_codec.c        |  4 ++--
 sound/pci/hda/patch_hdmi.c       |  2 +-
 sound/pci/ice1712/delta.c        |  2 +-
 sound/pci/ice1712/ews.c          |  4 ++--
 sound/pci/ice1712/ice1712.c      | 30 +++++++++++++++---------------
 sound/pci/ice1712/ice1724.c      | 20 ++++++++++----------
 sound/pci/lola/lola_mixer.c      |  2 +-
 sound/pci/lx6464es/lx6464es.c    |  2 +-
 sound/pci/mixart/mixart_mixer.c  |  6 +++---
 sound/pci/pcxhr/pcxhr_mix22.c    |  6 +++---
 sound/pci/pcxhr/pcxhr_mixer.c    | 22 +++++++++++-----------
 sound/pci/trident/trident_main.c | 22 +++++++++++-----------
 sound/pci/via82xx.c              |  6 +++---
 sound/pci/vx222/vx222_ops.c      |  4 ++--
 sound/pci/ymfpci/ymfpci_main.c   | 14 +++++++-------
 28 files changed, 123 insertions(+), 123 deletions(-)

diff --git a/sound/pci/au88x0/au88x0_a3d.c b/sound/pci/au88x0/au88x0_a3d.c
index ab0f873..7a4558a 100644
--- a/sound/pci/au88x0/au88x0_a3d.c
+++ b/sound/pci/au88x0/au88x0_a3d.c
@@ -846,7 +846,7 @@ static void vortex_a3d_translate_filter(a3d_atmos_t filter, int *params)
 	return changed;
 }
 
-static struct snd_kcontrol_new vortex_a3d_kcontrol = {
+static const struct snd_kcontrol_new vortex_a3d_kcontrol = {
 	.iface = SNDRV_CTL_ELEM_IFACE_PCM,
 	.name = "Playback PCM advanced processing",
 	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
diff --git a/sound/pci/au88x0/au88x0_eq.c b/sound/pci/au88x0/au88x0_eq.c
index 9585c5c..b566b44 100644
--- a/sound/pci/au88x0/au88x0_eq.c
+++ b/sound/pci/au88x0/au88x0_eq.c
@@ -757,7 +757,7 @@ static void vortex_Eqlzr_shutdown(vortex_t * vortex)
 	return 1;		/* Allways changes */
 }
 
-static struct snd_kcontrol_new vortex_eqtoggle_kcontrol = {
+static const struct snd_kcontrol_new vortex_eqtoggle_kcontrol = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "EQ Enable",
 	.index = 0,
@@ -815,7 +815,7 @@ static void vortex_Eqlzr_shutdown(vortex_t * vortex)
 	return changed;
 }
 
-static struct snd_kcontrol_new vortex_eq_kcontrol = {
+static const struct snd_kcontrol_new vortex_eq_kcontrol = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "                        .",
 	.index = 0,
@@ -855,7 +855,7 @@ static void vortex_Eqlzr_shutdown(vortex_t * vortex)
 	return 0;
 }
 
-static struct snd_kcontrol_new vortex_levels_kcontrol = {
+static const struct snd_kcontrol_new vortex_levels_kcontrol = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "EQ Peaks",
 	.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
diff --git a/sound/pci/au88x0/au88x0_pcm.c b/sound/pci/au88x0/au88x0_pcm.c
index df5741a..335979a 100644
--- a/sound/pci/au88x0/au88x0_pcm.c
+++ b/sound/pci/au88x0/au88x0_pcm.c
@@ -601,7 +601,7 @@ static int snd_vortex_pcm_vol_put(struct snd_kcontrol *kcontrol,
 
 static const DECLARE_TLV_DB_MINMAX(vortex_pcm_vol_db_scale, -9600, 2400);
 
-static struct snd_kcontrol_new snd_vortex_pcm_vol = {
+static const struct snd_kcontrol_new snd_vortex_pcm_vol = {
 	.iface = SNDRV_CTL_ELEM_IFACE_PCM,
 	.name = "PCM Playback Volume",
 	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
diff --git a/sound/pci/aw2/aw2-alsa.c b/sound/pci/aw2/aw2-alsa.c
index 57bbb87..8356180 100644
--- a/sound/pci/aw2/aw2-alsa.c
+++ b/sound/pci/aw2/aw2-alsa.c
@@ -202,7 +202,7 @@ static int snd_aw2_control_switch_capture_put(struct snd_kcontrol *kcontrol,
 	.pointer = snd_aw2_pcm_pointer_capture,
 };
 
-static struct snd_kcontrol_new aw2_control = {
+static const struct snd_kcontrol_new aw2_control = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "PCM Capture Route",
 	.index = 0,
diff --git a/sound/pci/bt87x.c b/sound/pci/bt87x.c
index f2c0709..099efb0 100644
--- a/sound/pci/bt87x.c
+++ b/sound/pci/bt87x.c
@@ -598,7 +598,7 @@ static int snd_bt87x_capture_volume_put(struct snd_kcontrol *kcontrol,
 	return changed;
 }
 
-static struct snd_kcontrol_new snd_bt87x_capture_volume = {
+static const struct snd_kcontrol_new snd_bt87x_capture_volume = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Capture Volume",
 	.info = snd_bt87x_capture_volume_info,
@@ -634,7 +634,7 @@ static int snd_bt87x_capture_boost_put(struct snd_kcontrol *kcontrol,
 	return changed;
 }
 
-static struct snd_kcontrol_new snd_bt87x_capture_boost = {
+static const struct snd_kcontrol_new snd_bt87x_capture_boost = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Capture Boost",
 	.info = snd_bt87x_capture_boost_info,
@@ -676,7 +676,7 @@ static int snd_bt87x_capture_source_put(struct snd_kcontrol *kcontrol,
 	return changed;
 }
 
-static struct snd_kcontrol_new snd_bt87x_capture_source = {
+static const struct snd_kcontrol_new snd_bt87x_capture_source = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Capture Source",
 	.info = snd_bt87x_capture_source_info,
diff --git a/sound/pci/ca0106/ca0106_mixer.c b/sound/pci/ca0106/ca0106_mixer.c
index 025805c..b4d3415 100644
--- a/sound/pci/ca0106/ca0106_mixer.c
+++ b/sound/pci/ca0106/ca0106_mixer.c
@@ -301,7 +301,7 @@ static int snd_ca0106_capture_mic_line_in_put(struct snd_kcontrol *kcontrol,
         return change;
 }
 
-static struct snd_kcontrol_new snd_ca0106_capture_mic_line_in =
+static const struct snd_kcontrol_new snd_ca0106_capture_mic_line_in =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =		"Shared Mic/Line in Capture Switch",
@@ -310,7 +310,7 @@ static int snd_ca0106_capture_mic_line_in_put(struct snd_kcontrol *kcontrol,
 	.put =		snd_ca0106_capture_mic_line_in_put
 };
 
-static struct snd_kcontrol_new snd_ca0106_capture_line_in_side_out =
+static const struct snd_kcontrol_new snd_ca0106_capture_line_in_side_out =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =		"Shared Line in/Side out Capture Switch",
diff --git a/sound/pci/cmipci.c b/sound/pci/cmipci.c
index aeedc27..227c9d3 100644
--- a/sound/pci/cmipci.c
+++ b/sound/pci/cmipci.c
@@ -1045,7 +1045,7 @@ static int snd_cmipci_spdif_default_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_cmipci_spdif_default =
+static const struct snd_kcontrol_new snd_cmipci_spdif_default =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
 	.name =		SNDRV_CTL_NAME_IEC958("",PLAYBACK,DEFAULT),
@@ -1072,7 +1072,7 @@ static int snd_cmipci_spdif_mask_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_cmipci_spdif_mask =
+static const struct snd_kcontrol_new snd_cmipci_spdif_mask =
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ,
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
@@ -1119,7 +1119,7 @@ static int snd_cmipci_spdif_stream_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_cmipci_spdif_stream =
+static const struct snd_kcontrol_new snd_cmipci_spdif_stream =
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_INACTIVE,
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
diff --git a/sound/pci/cs4281.c b/sound/pci/cs4281.c
index 8f0f5f2..470c773 100644
--- a/sound/pci/cs4281.c
+++ b/sound/pci/cs4281.c
@@ -1055,7 +1055,7 @@ static int snd_cs4281_put_volume(struct snd_kcontrol *kcontrol,
 
 static const DECLARE_TLV_DB_SCALE(db_scale_dsp, -4650, 150, 0);
 
-static struct snd_kcontrol_new snd_cs4281_fm_vol = 
+static const struct snd_kcontrol_new snd_cs4281_fm_vol =
 {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Synth Playback Volume",
@@ -1066,7 +1066,7 @@ static int snd_cs4281_put_volume(struct snd_kcontrol *kcontrol,
 	.tlv = { .p = db_scale_dsp },
 };
 
-static struct snd_kcontrol_new snd_cs4281_pcm_vol = 
+static const struct snd_kcontrol_new snd_cs4281_pcm_vol =
 {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "PCM Stream Playback Volume",
diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index 9370717..d15ecf9 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -1039,7 +1039,7 @@ static int snd_echo_output_gain_put(struct snd_kcontrol *kcontrol,
 
 #ifdef ECHOCARD_HAS_LINE_OUT_GAIN
 /* On the Mia this one controls the line-out volume */
-static struct snd_kcontrol_new snd_echo_line_output_gain = {
+static const struct snd_kcontrol_new snd_echo_line_output_gain = {
 	.name = "Line Playback Volume",
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
@@ -1050,7 +1050,7 @@ static int snd_echo_output_gain_put(struct snd_kcontrol *kcontrol,
 	.tlv = {.p = db_scale_output_gain},
 };
 #else
-static struct snd_kcontrol_new snd_echo_pcm_output_gain = {
+static const struct snd_kcontrol_new snd_echo_pcm_output_gain = {
 	.name = "PCM Playback Volume",
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_TLV_READ,
@@ -1120,7 +1120,7 @@ static int snd_echo_input_gain_put(struct snd_kcontrol *kcontrol,
 
 static const DECLARE_TLV_DB_SCALE(db_scale_input_gain, -2500, 50, 0);
 
-static struct snd_kcontrol_new snd_echo_line_input_gain = {
+static const struct snd_kcontrol_new snd_echo_line_input_gain = {
 	.name = "Line Capture Volume",
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_TLV_READ,
@@ -1184,7 +1184,7 @@ static int snd_echo_output_nominal_put(struct snd_kcontrol *kcontrol,
 	return changed;
 }
 
-static struct snd_kcontrol_new snd_echo_output_nominal_level = {
+static const struct snd_kcontrol_new snd_echo_output_nominal_level = {
 	.name = "Line Playback Switch (-10dBV)",
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.info = snd_echo_output_nominal_info,
@@ -1250,7 +1250,7 @@ static int snd_echo_input_nominal_put(struct snd_kcontrol *kcontrol,
 	return changed;
 }
 
-static struct snd_kcontrol_new snd_echo_intput_nominal_level = {
+static const struct snd_kcontrol_new snd_echo_intput_nominal_level = {
 	.name = "Line Capture Switch (-10dBV)",
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.info = snd_echo_input_nominal_info,
@@ -1477,7 +1477,7 @@ static int snd_echo_digital_mode_put(struct snd_kcontrol *kcontrol,
 	return changed;
 }
 
-static struct snd_kcontrol_new snd_echo_digital_mode_switch = {
+static const struct snd_kcontrol_new snd_echo_digital_mode_switch = {
 	.name = "Digital mode Switch",
 	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
 	.info = snd_echo_digital_mode_info,
@@ -1527,7 +1527,7 @@ static int snd_echo_spdif_mode_put(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_echo_spdif_mode_switch = {
+static const struct snd_kcontrol_new snd_echo_spdif_mode_switch = {
 	.name = "S/PDIF mode Switch",
 	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
 	.info = snd_echo_spdif_mode_info,
@@ -1600,7 +1600,7 @@ static int snd_echo_clock_source_put(struct snd_kcontrol *kcontrol,
 	return changed;
 }
 
-static struct snd_kcontrol_new snd_echo_clock_source_switch = {
+static const struct snd_kcontrol_new snd_echo_clock_source_switch = {
 	.name = "Sample Clock Source",
 	.iface = SNDRV_CTL_ELEM_IFACE_PCM,
 	.info = snd_echo_clock_source_info,
@@ -1643,7 +1643,7 @@ static int snd_echo_phantom_power_put(struct snd_kcontrol *kcontrol,
 	return changed;
 }
 
-static struct snd_kcontrol_new snd_echo_phantom_power_switch = {
+static const struct snd_kcontrol_new snd_echo_phantom_power_switch = {
 	.name = "Phantom power Switch",
 	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
 	.info = snd_echo_phantom_power_info,
@@ -1686,7 +1686,7 @@ static int snd_echo_automute_put(struct snd_kcontrol *kcontrol,
 	return changed;
 }
 
-static struct snd_kcontrol_new snd_echo_automute_switch = {
+static const struct snd_kcontrol_new snd_echo_automute_switch = {
 	.name = "Digital Capture Switch (automute)",
 	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
 	.info = snd_echo_automute_info,
@@ -1713,7 +1713,7 @@ static int snd_echo_vumeters_switch_put(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
-static struct snd_kcontrol_new snd_echo_vumeters_switch = {
+static const struct snd_kcontrol_new snd_echo_vumeters_switch = {
 	.name = "VU-meters Switch",
 	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
 	.access = SNDRV_CTL_ELEM_ACCESS_WRITE,
@@ -1751,7 +1751,7 @@ static int snd_echo_vumeters_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_echo_vumeters = {
+static const struct snd_kcontrol_new snd_echo_vumeters = {
 	.name = "VU-meters",
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.access = SNDRV_CTL_ELEM_ACCESS_READ |
@@ -1804,7 +1804,7 @@ static int snd_echo_channels_info_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_echo_channels_info = {
+static const struct snd_kcontrol_new snd_echo_channels_info = {
 	.name = "Channels info",
 	.iface = SNDRV_CTL_ELEM_IFACE_HWDEP,
 	.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
diff --git a/sound/pci/emu10k1/emu10k1x.c b/sound/pci/emu10k1/emu10k1x.c
index 921037e..f45612e 100644
--- a/sound/pci/emu10k1/emu10k1x.c
+++ b/sound/pci/emu10k1/emu10k1x.c
@@ -1112,7 +1112,7 @@ static int snd_emu10k1x_shared_spdif_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_emu10k1x_shared_spdif =
+static const struct snd_kcontrol_new snd_emu10k1x_shared_spdif =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =		"Analog/Digital Output Jack",
@@ -1171,7 +1171,7 @@ static int snd_emu10k1x_spdif_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_emu10k1x_spdif_mask_control =
+static const struct snd_kcontrol_new snd_emu10k1x_spdif_mask_control =
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ,
 	.iface =        SNDRV_CTL_ELEM_IFACE_PCM,
@@ -1181,7 +1181,7 @@ static int snd_emu10k1x_spdif_put(struct snd_kcontrol *kcontrol,
 	.get =          snd_emu10k1x_spdif_get_mask
 };
 
-static struct snd_kcontrol_new snd_emu10k1x_spdif_control =
+static const struct snd_kcontrol_new snd_emu10k1x_spdif_control =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
 	.name =         SNDRV_CTL_NAME_IEC958("",PLAYBACK,DEFAULT),
diff --git a/sound/pci/emu10k1/emumixer.c b/sound/pci/emu10k1/emumixer.c
index 076b117..b2219a7 100644
--- a/sound/pci/emu10k1/emumixer.c
+++ b/sound/pci/emu10k1/emumixer.c
@@ -795,7 +795,7 @@ static int snd_emu1010_internal_clock_put(struct snd_kcontrol *kcontrol,
         return change;
 }
 
-static struct snd_kcontrol_new snd_emu1010_internal_clock =
+static const struct snd_kcontrol_new snd_emu1010_internal_clock =
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READWRITE,
 	.iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
@@ -847,7 +847,7 @@ static int snd_emu1010_optical_out_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_emu1010_optical_out = {
+static const struct snd_kcontrol_new snd_emu1010_optical_out = {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READWRITE,
 	.iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =         "Optical Output Mode",
@@ -898,7 +898,7 @@ static int snd_emu1010_optical_in_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_emu1010_optical_in = {
+static const struct snd_kcontrol_new snd_emu1010_optical_in = {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READWRITE,
 	.iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =         "Optical Input Mode",
@@ -978,7 +978,7 @@ static int snd_audigy_i2c_capture_source_put(struct snd_kcontrol *kcontrol,
         return change;
 }
 
-static struct snd_kcontrol_new snd_audigy_i2c_capture_source =
+static const struct snd_kcontrol_new snd_audigy_i2c_capture_source =
 {
 		.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name =		"Capture Source",
@@ -1177,7 +1177,7 @@ static int snd_emu10k1_spdif_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_emu10k1_spdif_mask_control =
+static const struct snd_kcontrol_new snd_emu10k1_spdif_mask_control =
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ,
 	.iface =        SNDRV_CTL_ELEM_IFACE_PCM,
@@ -1187,7 +1187,7 @@ static int snd_emu10k1_spdif_put(struct snd_kcontrol *kcontrol,
 	.get =          snd_emu10k1_spdif_get_mask
 };
 
-static struct snd_kcontrol_new snd_emu10k1_spdif_control =
+static const struct snd_kcontrol_new snd_emu10k1_spdif_control =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
 	.name =         SNDRV_CTL_NAME_IEC958("",PLAYBACK,DEFAULT),
@@ -1293,7 +1293,7 @@ static int snd_emu10k1_send_routing_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_emu10k1_send_routing_control =
+static const struct snd_kcontrol_new snd_emu10k1_send_routing_control =
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_INACTIVE,
 	.iface =        SNDRV_CTL_ELEM_IFACE_PCM,
@@ -1364,7 +1364,7 @@ static int snd_emu10k1_send_volume_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_emu10k1_send_volume_control =
+static const struct snd_kcontrol_new snd_emu10k1_send_volume_control =
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_INACTIVE,
 	.iface =        SNDRV_CTL_ELEM_IFACE_PCM,
@@ -1429,7 +1429,7 @@ static int snd_emu10k1_attn_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_emu10k1_attn_control =
+static const struct snd_kcontrol_new snd_emu10k1_attn_control =
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_INACTIVE,
 	.iface =        SNDRV_CTL_ELEM_IFACE_PCM,
@@ -1501,7 +1501,7 @@ static int snd_emu10k1_efx_send_routing_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_emu10k1_efx_send_routing_control =
+static const struct snd_kcontrol_new snd_emu10k1_efx_send_routing_control =
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_INACTIVE,
 	.iface =        SNDRV_CTL_ELEM_IFACE_PCM,
@@ -1568,7 +1568,7 @@ static int snd_emu10k1_efx_send_volume_put(struct snd_kcontrol *kcontrol,
 }
 
 
-static struct snd_kcontrol_new snd_emu10k1_efx_send_volume_control =
+static const struct snd_kcontrol_new snd_emu10k1_efx_send_volume_control =
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_INACTIVE,
 	.iface =        SNDRV_CTL_ELEM_IFACE_PCM,
@@ -1626,7 +1626,7 @@ static int snd_emu10k1_efx_attn_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_emu10k1_efx_attn_control =
+static const struct snd_kcontrol_new snd_emu10k1_efx_attn_control =
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_INACTIVE,
 	.iface =        SNDRV_CTL_ELEM_IFACE_PCM,
@@ -1691,7 +1691,7 @@ static int snd_emu10k1_shared_spdif_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_emu10k1_shared_spdif =
+static const struct snd_kcontrol_new snd_emu10k1_shared_spdif =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =		"SB Live Analog/Digital Output Jack",
@@ -1700,7 +1700,7 @@ static int snd_emu10k1_shared_spdif_put(struct snd_kcontrol *kcontrol,
 	.put =		snd_emu10k1_shared_spdif_put
 };
 
-static struct snd_kcontrol_new snd_audigy_shared_spdif =
+static const struct snd_kcontrol_new snd_audigy_shared_spdif =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =		"Audigy Analog/Digital Output Jack",
@@ -1738,7 +1738,7 @@ static int snd_audigy_capture_boost_put(struct snd_kcontrol *kcontrol,
 	return snd_ac97_update(emu->ac97, AC97_REC_GAIN, val);
 }
 
-static struct snd_kcontrol_new snd_audigy_capture_boost =
+static const struct snd_kcontrol_new snd_audigy_capture_boost =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =		"Mic Extra Boost",
diff --git a/sound/pci/emu10k1/emupcm.c b/sound/pci/emu10k1/emupcm.c
index 37be1e1..ef1cf53 100644
--- a/sound/pci/emu10k1/emupcm.c
+++ b/sound/pci/emu10k1/emupcm.c
@@ -1542,7 +1542,7 @@ static int snd_emu10k1_pcm_efx_voices_mask_put(struct snd_kcontrol *kcontrol, st
 	return change;
 }
 
-static struct snd_kcontrol_new snd_emu10k1_pcm_efx_voices_mask = {
+static const struct snd_kcontrol_new snd_emu10k1_pcm_efx_voices_mask = {
 	.iface = SNDRV_CTL_ELEM_IFACE_PCM,
 	.name = "Captured FX8010 Outputs",
 	.info = snd_emu10k1_pcm_efx_voices_mask_info,
diff --git a/sound/pci/ens1370.c b/sound/pci/ens1370.c
index 51736c2..ae09baa 100644
--- a/sound/pci/ens1370.c
+++ b/sound/pci/ens1370.c
@@ -1530,7 +1530,7 @@ static int snd_es1373_rear_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_ens1373_rear =
+static const struct snd_kcontrol_new snd_ens1373_rear =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =		"AC97 2ch->4ch Copy Switch",
@@ -1575,7 +1575,7 @@ static int snd_es1373_line_put(struct snd_kcontrol *kcontrol,
 	return changed;
 }
 
-static struct snd_kcontrol_new snd_ens1373_line =
+static const struct snd_kcontrol_new snd_ens1373_line =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =		"Line In->Rear Out Switch",
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 9913be8..bf491eb 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1897,7 +1897,7 @@ static int vmaster_mute_mode_put(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
-static struct snd_kcontrol_new vmaster_mute_mode = {
+static const struct snd_kcontrol_new vmaster_mute_mode = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Mute-LED Mode",
 	.info = vmaster_mute_mode_info,
@@ -2637,7 +2637,7 @@ static int spdif_share_sw_put(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new spdif_share_sw = {
+static const struct snd_kcontrol_new spdif_share_sw = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "IEC958 Default PCM Playback Switch",
 	.info = snd_ctl_boolean_mono_info,
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index cf9bc042..59e0fed 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -354,7 +354,7 @@ static int hdmi_eld_ctl_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new eld_bytes_ctl = {
+static const struct snd_kcontrol_new eld_bytes_ctl = {
 	.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
 	.iface = SNDRV_CTL_ELEM_IFACE_PCM,
 	.name = "ELD",
diff --git a/sound/pci/ice1712/delta.c b/sound/pci/ice1712/delta.c
index 3bfdc78..da5f37b 100644
--- a/sound/pci/ice1712/delta.c
+++ b/sound/pci/ice1712/delta.c
@@ -432,7 +432,7 @@ static int snd_ice1712_delta1010lt_wordclock_status_get(struct snd_kcontrol *kco
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_ice1712_delta1010lt_wordclock_status =
+static const struct snd_kcontrol_new snd_ice1712_delta1010lt_wordclock_status =
 {
 	.access =	(SNDRV_CTL_ELEM_ACCESS_READ),
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
diff --git a/sound/pci/ice1712/ews.c b/sound/pci/ice1712/ews.c
index 5cb587c..ec07136 100644
--- a/sound/pci/ice1712/ews.c
+++ b/sound/pci/ice1712/ews.c
@@ -719,7 +719,7 @@ static int snd_ice1712_ews88mt_input_sense_put(struct snd_kcontrol *kcontrol, st
 	return ndata != data;
 }
 
-static struct snd_kcontrol_new snd_ice1712_ews88mt_input_sense = {
+static const struct snd_kcontrol_new snd_ice1712_ews88mt_input_sense = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Input Sensitivity Switch",
 	.info = snd_ice1712_ewx_io_sense_info,
@@ -728,7 +728,7 @@ static int snd_ice1712_ews88mt_input_sense_put(struct snd_kcontrol *kcontrol, st
 	.count = 8,
 };
 
-static struct snd_kcontrol_new snd_ice1712_ews88mt_output_sense = {
+static const struct snd_kcontrol_new snd_ice1712_ews88mt_output_sense = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Output Sensitivity Switch",
 	.info = snd_ice1712_ewx_io_sense_info,
diff --git a/sound/pci/ice1712/ice1712.c b/sound/pci/ice1712/ice1712.c
index b4aa4c1..1d8612c 100644
--- a/sound/pci/ice1712/ice1712.c
+++ b/sound/pci/ice1712/ice1712.c
@@ -279,7 +279,7 @@ static int snd_ice1712_digmix_route_ac97_put(struct snd_kcontrol *kcontrol, stru
 	return val != nval;
 }
 
-static struct snd_kcontrol_new snd_ice1712_mixer_digmix_route_ac97 = {
+static const struct snd_kcontrol_new snd_ice1712_mixer_digmix_route_ac97 = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Digital Mixer To AC97",
 	.info = snd_ice1712_digmix_route_ac97_info,
@@ -1410,7 +1410,7 @@ static int snd_ice1712_pro_mixer_volume_put(struct snd_kcontrol *kcontrol, struc
 	.private_value = 10,
 };
 
-static struct snd_kcontrol_new snd_ice1712_multi_capture_spdif_switch = {
+static const struct snd_kcontrol_new snd_ice1712_multi_capture_spdif_switch = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = SNDRV_CTL_NAME_IEC958("Multi ", CAPTURE, SWITCH),
 	.info = snd_ice1712_pro_mixer_switch_info,
@@ -1432,7 +1432,7 @@ static int snd_ice1712_pro_mixer_volume_put(struct snd_kcontrol *kcontrol, struc
 	.tlv = { .p = db_scale_playback }
 };
 
-static struct snd_kcontrol_new snd_ice1712_multi_capture_spdif_volume = {
+static const struct snd_kcontrol_new snd_ice1712_multi_capture_spdif_volume = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = SNDRV_CTL_NAME_IEC958("Multi ", CAPTURE, VOLUME),
 	.info = snd_ice1712_pro_mixer_volume_info,
@@ -1630,7 +1630,7 @@ static int snd_ice1712_eeprom_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_ice1712_eeprom = {
+static const struct snd_kcontrol_new snd_ice1712_eeprom = {
 	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
 	.name = "ICE1712 EEPROM",
 	.access = SNDRV_CTL_ELEM_ACCESS_READ,
@@ -1666,7 +1666,7 @@ static int snd_ice1712_spdif_default_put(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_ice1712_spdif_default =
+static const struct snd_kcontrol_new snd_ice1712_spdif_default =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
 	.name =         SNDRV_CTL_NAME_IEC958("", PLAYBACK, DEFAULT),
@@ -1717,7 +1717,7 @@ static int snd_ice1712_spdif_maskp_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_ice1712_spdif_maskc =
+static const struct snd_kcontrol_new snd_ice1712_spdif_maskc =
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ,
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
@@ -1726,7 +1726,7 @@ static int snd_ice1712_spdif_maskp_get(struct snd_kcontrol *kcontrol,
 	.get =		snd_ice1712_spdif_maskc_get,
 };
 
-static struct snd_kcontrol_new snd_ice1712_spdif_maskp =
+static const struct snd_kcontrol_new snd_ice1712_spdif_maskp =
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ,
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
@@ -1753,7 +1753,7 @@ static int snd_ice1712_spdif_stream_put(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_ice1712_spdif_stream =
+static const struct snd_kcontrol_new snd_ice1712_spdif_stream =
 {
 	.access =	(SNDRV_CTL_ELEM_ACCESS_READWRITE |
 			 SNDRV_CTL_ELEM_ACCESS_INACTIVE),
@@ -1878,7 +1878,7 @@ static int snd_ice1712_pro_internal_clock_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_ice1712_pro_internal_clock = {
+static const struct snd_kcontrol_new snd_ice1712_pro_internal_clock = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Multi Track Internal Clock",
 	.info = snd_ice1712_pro_internal_clock_info,
@@ -1943,7 +1943,7 @@ static int snd_ice1712_pro_internal_clock_default_put(struct snd_kcontrol *kcont
 	return change;
 }
 
-static struct snd_kcontrol_new snd_ice1712_pro_internal_clock_default = {
+static const struct snd_kcontrol_new snd_ice1712_pro_internal_clock_default = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Multi Track Internal Clock Default",
 	.info = snd_ice1712_pro_internal_clock_default_info,
@@ -1974,7 +1974,7 @@ static int snd_ice1712_pro_rate_locking_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_ice1712_pro_rate_locking = {
+static const struct snd_kcontrol_new snd_ice1712_pro_rate_locking = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Multi Track Rate Locking",
 	.info = snd_ice1712_pro_rate_locking_info,
@@ -2005,7 +2005,7 @@ static int snd_ice1712_pro_rate_reset_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_ice1712_pro_rate_reset = {
+static const struct snd_kcontrol_new snd_ice1712_pro_rate_reset = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Multi Track Rate Reset",
 	.info = snd_ice1712_pro_rate_reset_info,
@@ -2173,7 +2173,7 @@ static int snd_ice1712_pro_route_spdif_put(struct snd_kcontrol *kcontrol,
 	.put = snd_ice1712_pro_route_analog_put,
 };
 
-static struct snd_kcontrol_new snd_ice1712_mixer_pro_spdif_route = {
+static const struct snd_kcontrol_new snd_ice1712_mixer_pro_spdif_route = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = SNDRV_CTL_NAME_IEC958("", PLAYBACK, NONE) "Route",
 	.info = snd_ice1712_pro_route_info,
@@ -2215,7 +2215,7 @@ static int snd_ice1712_pro_volume_rate_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_ice1712_mixer_pro_volume_rate = {
+static const struct snd_kcontrol_new snd_ice1712_mixer_pro_volume_rate = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Multi Track Volume Rate",
 	.info = snd_ice1712_pro_volume_rate_info,
@@ -2248,7 +2248,7 @@ static int snd_ice1712_pro_peak_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_ice1712_mixer_pro_peak = {
+static const struct snd_kcontrol_new snd_ice1712_mixer_pro_peak = {
 	.iface = SNDRV_CTL_ELEM_IFACE_PCM,
 	.name = "Multi Track Peak",
 	.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
diff --git a/sound/pci/ice1712/ice1724.c b/sound/pci/ice1712/ice1724.c
index e5c52ed..cb9446e 100644
--- a/sound/pci/ice1712/ice1724.c
+++ b/sound/pci/ice1712/ice1724.c
@@ -1598,7 +1598,7 @@ static int snd_vt1724_eeprom_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_vt1724_eeprom = {
+static const struct snd_kcontrol_new snd_vt1724_eeprom = {
 	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
 	.name = "ICE1724 EEPROM",
 	.access = SNDRV_CTL_ELEM_ACCESS_READ,
@@ -1711,7 +1711,7 @@ static int snd_vt1724_spdif_default_put(struct snd_kcontrol *kcontrol,
 	return val != old;
 }
 
-static struct snd_kcontrol_new snd_vt1724_spdif_default =
+static const struct snd_kcontrol_new snd_vt1724_spdif_default =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
 	.name =         SNDRV_CTL_NAME_IEC958("", PLAYBACK, DEFAULT),
@@ -1743,7 +1743,7 @@ static int snd_vt1724_spdif_maskp_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_vt1724_spdif_maskc =
+static const struct snd_kcontrol_new snd_vt1724_spdif_maskc =
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ,
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
@@ -1752,7 +1752,7 @@ static int snd_vt1724_spdif_maskp_get(struct snd_kcontrol *kcontrol,
 	.get =		snd_vt1724_spdif_maskc_get,
 };
 
-static struct snd_kcontrol_new snd_vt1724_spdif_maskp =
+static const struct snd_kcontrol_new snd_vt1724_spdif_maskp =
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ,
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
@@ -1789,7 +1789,7 @@ static int snd_vt1724_spdif_sw_put(struct snd_kcontrol *kcontrol,
 	return old != val;
 }
 
-static struct snd_kcontrol_new snd_vt1724_spdif_switch =
+static const struct snd_kcontrol_new snd_vt1724_spdif_switch =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	/* FIXME: the following conflict with IEC958 Playback Route */
@@ -1964,7 +1964,7 @@ static int snd_vt1724_pro_internal_clock_put(struct snd_kcontrol *kcontrol,
 	return old_rate != new_rate;
 }
 
-static struct snd_kcontrol_new snd_vt1724_pro_internal_clock = {
+static const struct snd_kcontrol_new snd_vt1724_pro_internal_clock = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Multi Track Internal Clock",
 	.info = snd_vt1724_pro_internal_clock_info,
@@ -1995,7 +1995,7 @@ static int snd_vt1724_pro_rate_locking_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_vt1724_pro_rate_locking = {
+static const struct snd_kcontrol_new snd_vt1724_pro_rate_locking = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Multi Track Rate Locking",
 	.info = snd_vt1724_pro_rate_locking_info,
@@ -2026,7 +2026,7 @@ static int snd_vt1724_pro_rate_reset_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_vt1724_pro_rate_reset = {
+static const struct snd_kcontrol_new snd_vt1724_pro_rate_reset = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Multi Track Rate Reset",
 	.info = snd_vt1724_pro_rate_reset_info,
@@ -2151,7 +2151,7 @@ static int snd_vt1724_pro_route_spdif_put(struct snd_kcontrol *kcontrol,
 	.put = snd_vt1724_pro_route_analog_put,
 };
 
-static struct snd_kcontrol_new snd_vt1724_mixer_pro_spdif_route = {
+static const struct snd_kcontrol_new snd_vt1724_mixer_pro_spdif_route = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = SNDRV_CTL_NAME_IEC958("", PLAYBACK, NONE) "Route",
 	.info = snd_vt1724_pro_route_info,
@@ -2187,7 +2187,7 @@ static int snd_vt1724_pro_peak_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_vt1724_mixer_pro_peak = {
+static const struct snd_kcontrol_new snd_vt1724_mixer_pro_peak = {
 	.iface = SNDRV_CTL_ELEM_IFACE_PCM,
 	.name = "Multi Track Peak",
 	.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
diff --git a/sound/pci/lola/lola_mixer.c b/sound/pci/lola/lola_mixer.c
index e7fe15d..cb25acf 100644
--- a/sound/pci/lola/lola_mixer.c
+++ b/sound/pci/lola/lola_mixer.c
@@ -645,7 +645,7 @@ static int lola_input_src_put(struct snd_kcontrol *kcontrol,
 	return lola_set_src_config(chip, mask, true);
 }
 
-static struct snd_kcontrol_new lola_input_src_mixer = {
+static const struct snd_kcontrol_new lola_input_src_mixer = {
 	.name = "Digital SRC Capture Switch",
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.info = lola_input_src_info,
diff --git a/sound/pci/lx6464es/lx6464es.c b/sound/pci/lx6464es/lx6464es.c
index c0f0c34..f9c3e86 100644
--- a/sound/pci/lx6464es/lx6464es.c
+++ b/sound/pci/lx6464es/lx6464es.c
@@ -899,7 +899,7 @@ static int lx_control_playback_put(struct snd_kcontrol *kcontrol,
 	return changed;
 }
 
-static struct snd_kcontrol_new lx_control_playback_switch = {
+static const struct snd_kcontrol_new lx_control_playback_switch = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "PCM Playback Switch",
 	.index = 0,
diff --git a/sound/pci/mixart/mixart_mixer.c b/sound/pci/mixart/mixart_mixer.c
index 51e5349..4a4616a 100644
--- a/sound/pci/mixart/mixart_mixer.c
+++ b/sound/pci/mixart/mixart_mixer.c
@@ -448,7 +448,7 @@ static int mixart_audio_sw_put(struct snd_kcontrol *kcontrol, struct snd_ctl_ele
 	return changed;
 }
 
-static struct snd_kcontrol_new mixart_control_output_switch = {
+static const struct snd_kcontrol_new mixart_control_output_switch = {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =         "Master Playback Switch",
 	.info =         mixart_sw_info,		/* shared */
@@ -1024,7 +1024,7 @@ static int mixart_monitor_vol_put(struct snd_kcontrol *kcontrol, struct snd_ctl_
 	return changed;
 }
 
-static struct snd_kcontrol_new mixart_control_monitor_vol = {
+static const struct snd_kcontrol_new mixart_control_monitor_vol = {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
 		   SNDRV_CTL_ELEM_ACCESS_TLV_READ),
@@ -1091,7 +1091,7 @@ static int mixart_monitor_sw_put(struct snd_kcontrol *kcontrol, struct snd_ctl_e
 	return (changed != 0);
 }
 
-static struct snd_kcontrol_new mixart_control_monitor_sw = {
+static const struct snd_kcontrol_new mixart_control_monitor_sw = {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =         "Monitoring Switch",
 	.info =         mixart_sw_info,		/* shared */
diff --git a/sound/pci/pcxhr/pcxhr_mix22.c b/sound/pci/pcxhr/pcxhr_mix22.c
index 6a56e53..8b4d028 100644
--- a/sound/pci/pcxhr/pcxhr_mix22.c
+++ b/sound/pci/pcxhr/pcxhr_mix22.c
@@ -744,7 +744,7 @@ static int hr222_mic_vol_put(struct snd_kcontrol *kcontrol,
 	return changed;
 }
 
-static struct snd_kcontrol_new hr222_control_mic_level = {
+static const struct snd_kcontrol_new hr222_control_mic_level = {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.access =	(SNDRV_CTL_ELEM_ACCESS_READWRITE |
 			 SNDRV_CTL_ELEM_ACCESS_TLV_READ),
@@ -794,7 +794,7 @@ static int hr222_mic_boost_put(struct snd_kcontrol *kcontrol,
 	return changed;
 }
 
-static struct snd_kcontrol_new hr222_control_mic_boost = {
+static const struct snd_kcontrol_new hr222_control_mic_boost = {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.access =	(SNDRV_CTL_ELEM_ACCESS_READWRITE |
 			 SNDRV_CTL_ELEM_ACCESS_TLV_READ),
@@ -836,7 +836,7 @@ static int hr222_phantom_power_put(struct snd_kcontrol *kcontrol,
 	return changed;
 }
 
-static struct snd_kcontrol_new hr222_phantom_power_switch = {
+static const struct snd_kcontrol_new hr222_phantom_power_switch = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "Phantom Power Switch",
 	.info = hr222_phantom_power_info,
diff --git a/sound/pci/pcxhr/pcxhr_mixer.c b/sound/pci/pcxhr/pcxhr_mixer.c
index 63136c4..36875df 100644
--- a/sound/pci/pcxhr/pcxhr_mixer.c
+++ b/sound/pci/pcxhr/pcxhr_mixer.c
@@ -235,7 +235,7 @@ static int pcxhr_audio_sw_put(struct snd_kcontrol *kcontrol,
 	return changed;
 }
 
-static struct snd_kcontrol_new pcxhr_control_output_switch = {
+static const struct snd_kcontrol_new pcxhr_control_output_switch = {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =		"Master Playback Switch",
 	.info =		pcxhr_sw_info,		/* shared */
@@ -460,7 +460,7 @@ static int pcxhr_pcm_sw_put(struct snd_kcontrol *kcontrol,
 	return changed;
 }
 
-static struct snd_kcontrol_new pcxhr_control_pcm_switch = {
+static const struct snd_kcontrol_new pcxhr_control_pcm_switch = {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =		"PCM Playback Switch",
 	.count =	PCXHR_PLAYBACK_STREAMS,
@@ -509,7 +509,7 @@ static int pcxhr_monitor_vol_put(struct snd_kcontrol *kcontrol,
 	return changed;
 }
 
-static struct snd_kcontrol_new pcxhr_control_monitor_vol = {
+static const struct snd_kcontrol_new pcxhr_control_monitor_vol = {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.access =	(SNDRV_CTL_ELEM_ACCESS_READWRITE |
 			 SNDRV_CTL_ELEM_ACCESS_TLV_READ),
@@ -562,7 +562,7 @@ static int pcxhr_monitor_sw_put(struct snd_kcontrol *kcontrol,
 	return (changed != 0);
 }
 
-static struct snd_kcontrol_new pcxhr_control_monitor_sw = {
+static const struct snd_kcontrol_new pcxhr_control_monitor_sw = {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =         "Monitoring Playback Switch",
 	.info =         pcxhr_sw_info,		/* shared */
@@ -697,7 +697,7 @@ static int pcxhr_audio_src_put(struct snd_kcontrol *kcontrol,
 	return ret;
 }
 
-static struct snd_kcontrol_new pcxhr_control_audio_src = {
+static const struct snd_kcontrol_new pcxhr_control_audio_src = {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =		"Capture Source",
 	.info =		pcxhr_audio_src_info,
@@ -798,7 +798,7 @@ static int pcxhr_clock_type_put(struct snd_kcontrol *kcontrol,
 	return ret;
 }
 
-static struct snd_kcontrol_new pcxhr_control_clock_type = {
+static const struct snd_kcontrol_new pcxhr_control_clock_type = {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =		"Clock Mode",
 	.info =		pcxhr_clock_type_info,
@@ -842,7 +842,7 @@ static int pcxhr_clock_rate_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new pcxhr_control_clock_rate = {
+static const struct snd_kcontrol_new pcxhr_control_clock_rate = {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ,
 	.iface =	SNDRV_CTL_ELEM_IFACE_CARD,
 	.name =		"Clock Rates",
@@ -1017,14 +1017,14 @@ static int pcxhr_iec958_put(struct snd_kcontrol *kcontrol,
 	return changed;
 }
 
-static struct snd_kcontrol_new pcxhr_control_playback_iec958_mask = {
+static const struct snd_kcontrol_new pcxhr_control_playback_iec958_mask = {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ,
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
 	.name =		SNDRV_CTL_NAME_IEC958("",PLAYBACK,MASK),
 	.info =		pcxhr_iec958_info,
 	.get =		pcxhr_iec958_mask_get
 };
-static struct snd_kcontrol_new pcxhr_control_playback_iec958 = {
+static const struct snd_kcontrol_new pcxhr_control_playback_iec958 = {
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
 	.name =         SNDRV_CTL_NAME_IEC958("",PLAYBACK,DEFAULT),
 	.info =         pcxhr_iec958_info,
@@ -1033,14 +1033,14 @@ static int pcxhr_iec958_put(struct snd_kcontrol *kcontrol,
 	.private_value = 0 /* playback */
 };
 
-static struct snd_kcontrol_new pcxhr_control_capture_iec958_mask = {
+static const struct snd_kcontrol_new pcxhr_control_capture_iec958_mask = {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ,
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
 	.name =		SNDRV_CTL_NAME_IEC958("",CAPTURE,MASK),
 	.info =		pcxhr_iec958_info,
 	.get =		pcxhr_iec958_mask_get
 };
-static struct snd_kcontrol_new pcxhr_control_capture_iec958 = {
+static const struct snd_kcontrol_new pcxhr_control_capture_iec958 = {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ,
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
 	.name =         SNDRV_CTL_NAME_IEC958("",CAPTURE,DEFAULT),
diff --git a/sound/pci/trident/trident_main.c b/sound/pci/trident/trident_main.c
index 92ad2d7..64d3b8e 100644
--- a/sound/pci/trident/trident_main.c
+++ b/sound/pci/trident/trident_main.c
@@ -2356,7 +2356,7 @@ static int snd_trident_spdif_control_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_trident_spdif_control =
+static const struct snd_kcontrol_new snd_trident_spdif_control =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =         SNDRV_CTL_NAME_IEC958("",PLAYBACK,SWITCH),
@@ -2419,7 +2419,7 @@ static int snd_trident_spdif_default_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_trident_spdif_default =
+static const struct snd_kcontrol_new snd_trident_spdif_default =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
 	.name =         SNDRV_CTL_NAME_IEC958("",PLAYBACK,DEFAULT),
@@ -2452,7 +2452,7 @@ static int snd_trident_spdif_mask_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_trident_spdif_mask =
+static const struct snd_kcontrol_new snd_trident_spdif_mask =
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ,
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
@@ -2514,7 +2514,7 @@ static int snd_trident_spdif_stream_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_trident_spdif_stream =
+static const struct snd_kcontrol_new snd_trident_spdif_stream =
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_INACTIVE,
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
@@ -2564,7 +2564,7 @@ static int snd_trident_ac97_control_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_trident_ac97_rear_control =
+static const struct snd_kcontrol_new snd_trident_ac97_rear_control =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =         "Rear Path",
@@ -2622,7 +2622,7 @@ static int snd_trident_vol_control_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_trident_vol_music_control =
+static const struct snd_kcontrol_new snd_trident_vol_music_control =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =         "Music Playback Volume",
@@ -2633,7 +2633,7 @@ static int snd_trident_vol_control_put(struct snd_kcontrol *kcontrol,
 	.tlv = { .p = db_scale_gvol },
 };
 
-static struct snd_kcontrol_new snd_trident_vol_wave_control =
+static const struct snd_kcontrol_new snd_trident_vol_wave_control =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =         "Wave Playback Volume",
@@ -2700,7 +2700,7 @@ static int snd_trident_pcm_vol_control_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_trident_pcm_vol_control =
+static const struct snd_kcontrol_new snd_trident_pcm_vol_control =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =         "PCM Front Playback Volume",
@@ -2764,7 +2764,7 @@ static int snd_trident_pcm_pan_control_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_trident_pcm_pan_control =
+static const struct snd_kcontrol_new snd_trident_pcm_pan_control =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =         "PCM Pan Playback Control",
@@ -2821,7 +2821,7 @@ static int snd_trident_pcm_rvol_control_put(struct snd_kcontrol *kcontrol,
 
 static const DECLARE_TLV_DB_SCALE(db_scale_crvol, -3175, 25, 1);
 
-static struct snd_kcontrol_new snd_trident_pcm_rvol_control =
+static const struct snd_kcontrol_new snd_trident_pcm_rvol_control =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =         "PCM Reverb Playback Volume",
@@ -2877,7 +2877,7 @@ static int snd_trident_pcm_cvol_control_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_trident_pcm_cvol_control =
+static const struct snd_kcontrol_new snd_trident_pcm_cvol_control =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =         "PCM Chorus Playback Volume",
diff --git a/sound/pci/via82xx.c b/sound/pci/via82xx.c
index 2d8c14e..d078e86 100644
--- a/sound/pci/via82xx.c
+++ b/sound/pci/via82xx.c
@@ -1683,7 +1683,7 @@ static int snd_via8233_dxs3_spdif_put(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_via8233_dxs3_spdif_control = {
+static const struct snd_kcontrol_new snd_via8233_dxs3_spdif_control = {
 	.name = SNDRV_CTL_NAME_IEC958("Output ",NONE,SWITCH),
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.info = snd_via8233_dxs3_spdif_info,
@@ -1772,7 +1772,7 @@ static int snd_via8233_pcmdxs_volume_put(struct snd_kcontrol *kcontrol,
 
 static const DECLARE_TLV_DB_SCALE(db_scale_dxs, -4650, 150, 1);
 
-static struct snd_kcontrol_new snd_via8233_pcmdxs_volume_control = {
+static const struct snd_kcontrol_new snd_via8233_pcmdxs_volume_control = {
 	.name = "PCM Playback Volume",
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
@@ -1783,7 +1783,7 @@ static int snd_via8233_pcmdxs_volume_put(struct snd_kcontrol *kcontrol,
 	.tlv = { .p = db_scale_dxs }
 };
 
-static struct snd_kcontrol_new snd_via8233_dxs_volume_control = {
+static const struct snd_kcontrol_new snd_via8233_dxs_volume_control = {
 	.iface = SNDRV_CTL_ELEM_IFACE_PCM,
 	.device = 0,
 	/* .subdevice set later */
diff --git a/sound/pci/vx222/vx222_ops.c b/sound/pci/vx222/vx222_ops.c
index af83b3b..5911233 100644
--- a/sound/pci/vx222/vx222_ops.c
+++ b/sound/pci/vx222/vx222_ops.c
@@ -945,7 +945,7 @@ static int vx_mic_level_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_v
 	return 0;
 }
 
-static struct snd_kcontrol_new vx_control_input_level = {
+static const struct snd_kcontrol_new vx_control_input_level = {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.access =	(SNDRV_CTL_ELEM_ACCESS_READWRITE |
 			 SNDRV_CTL_ELEM_ACCESS_TLV_READ),
@@ -956,7 +956,7 @@ static int vx_mic_level_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_v
 	.tlv = { .p = db_scale_mic },
 };
 
-static struct snd_kcontrol_new vx_control_mic_level = {
+static const struct snd_kcontrol_new vx_control_mic_level = {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.access =	(SNDRV_CTL_ELEM_ACCESS_READWRITE |
 			 SNDRV_CTL_ELEM_ACCESS_TLV_READ),
diff --git a/sound/pci/ymfpci/ymfpci_main.c b/sound/pci/ymfpci/ymfpci_main.c
index ffee284..fe4ba46 100644
--- a/sound/pci/ymfpci/ymfpci_main.c
+++ b/sound/pci/ymfpci/ymfpci_main.c
@@ -1316,7 +1316,7 @@ static int snd_ymfpci_spdif_default_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_ymfpci_spdif_default =
+static const struct snd_kcontrol_new snd_ymfpci_spdif_default =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
 	.name =         SNDRV_CTL_NAME_IEC958("",PLAYBACK,DEFAULT),
@@ -1344,7 +1344,7 @@ static int snd_ymfpci_spdif_mask_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_ymfpci_spdif_mask =
+static const struct snd_kcontrol_new snd_ymfpci_spdif_mask =
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ,
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
@@ -1391,7 +1391,7 @@ static int snd_ymfpci_spdif_stream_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_ymfpci_spdif_stream =
+static const struct snd_kcontrol_new snd_ymfpci_spdif_stream =
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_INACTIVE,
 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
@@ -1439,7 +1439,7 @@ static int snd_ymfpci_drec_source_put(struct snd_kcontrol *kcontrol, struct snd_
 	return reg != old_reg;
 }
 
-static struct snd_kcontrol_new snd_ymfpci_drec_source = {
+static const struct snd_kcontrol_new snd_ymfpci_drec_source = {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READWRITE,
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name =		"Direct Recording Source",
@@ -1609,7 +1609,7 @@ static int snd_ymfpci_put_dup4ch(struct snd_kcontrol *kcontrol, struct snd_ctl_e
 	return change;
 }
 
-static struct snd_kcontrol_new snd_ymfpci_dup4ch = {
+static const struct snd_kcontrol_new snd_ymfpci_dup4ch = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "4ch Duplication",
 	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
@@ -1712,7 +1712,7 @@ static int snd_ymfpci_gpio_sw_put(struct snd_kcontrol *kcontrol, struct snd_ctl_
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_ymfpci_rear_shared = {
+static const struct snd_kcontrol_new snd_ymfpci_rear_shared = {
 	.name = "Shared Rear/Line-In Switch",
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.info = snd_ymfpci_gpio_sw_info,
@@ -1776,7 +1776,7 @@ static int snd_ymfpci_pcm_vol_put(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static struct snd_kcontrol_new snd_ymfpci_pcm_volume = {
+static const struct snd_kcontrol_new snd_ymfpci_pcm_volume = {
 	.iface = SNDRV_CTL_ELEM_IFACE_PCM,
 	.name = "PCM Playback Volume",
 	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
-- 
1.9.1
