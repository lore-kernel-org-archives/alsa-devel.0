From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] ALSA: sound/isa: constify snd_kcontrol_new structures
Date: Wed, 17 May 2017 17:08:56 +0530
Message-ID: <1495021136-6999-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Declare snd_kcontrol_new structures as const as they are only passed an
argument to the function snd_ctl_new1. This argument is of type const,
so snd_kcontrol_new structures having this property can be made const.
Done using Coccinelle:

@r disable optional_qualifier@
identifier x;
position p;
@@
static struct snd_kcontrol_new x@p={...};

@ok@
identifier r.x;
position p;
@@
snd_ctl_new1(&x@p,...)

@bad@
position p != {r.p,ok.p};
identifier r.x;
@@
x@p

@depends on !bad disable optional_qualifier@
identifier r.x;
@@
+const
struct snd_kcontrol_new x;

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/isa/gus/gus_main.c | 2 +-
 sound/isa/gus/gus_pcm.c  | 4 ++--
 sound/isa/sb/sb16_csp.c  | 4 ++--
 sound/isa/sb/sb16_main.c | 2 +-
 sound/isa/sscape.c       | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/isa/gus/gus_main.c b/sound/isa/gus/gus_main.c
index 4490ee4..3cf9b13 100644
--- a/sound/isa/gus/gus_main.c
+++ b/sound/isa/gus/gus_main.c
@@ -82,7 +82,7 @@ static int snd_gus_joystick_put(struct snd_kcontrol *kcontrol, struct snd_ctl_el
 	return change;
 }
 
-static struct snd_kcontrol_new snd_gus_joystick_control = {
+static const struct snd_kcontrol_new snd_gus_joystick_control = {
 	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
 	.name = "Joystick Speed",
 	.info = snd_gus_joystick_info,
diff --git a/sound/isa/gus/gus_pcm.c b/sound/isa/gus/gus_pcm.c
index 0650599..33c1891 100644
--- a/sound/isa/gus/gus_pcm.c
+++ b/sound/isa/gus/gus_pcm.c
@@ -809,7 +809,7 @@ static int snd_gf1_pcm_volume_put(struct snd_kcontrol *kcontrol, struct snd_ctl_
 	return change;
 }
 
-static struct snd_kcontrol_new snd_gf1_pcm_volume_control =
+static const struct snd_kcontrol_new snd_gf1_pcm_volume_control =
 {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "PCM Playback Volume",
@@ -818,7 +818,7 @@ static struct snd_kcontrol_new snd_gf1_pcm_volume_control =
 	.put = snd_gf1_pcm_volume_put
 };
 
-static struct snd_kcontrol_new snd_gf1_pcm_volume_control1 =
+static const struct snd_kcontrol_new snd_gf1_pcm_volume_control1 =
 {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "GPCM Playback Volume",
diff --git a/sound/isa/sb/sb16_csp.c b/sound/isa/sb/sb16_csp.c
index 48da227..fa5780b 100644
--- a/sound/isa/sb/sb16_csp.c
+++ b/sound/isa/sb/sb16_csp.c
@@ -1029,7 +1029,7 @@ static int snd_sb_qsound_space_put(struct snd_kcontrol *kcontrol, struct snd_ctl
 	return change;
 }
 
-static struct snd_kcontrol_new snd_sb_qsound_switch = {
+static const struct snd_kcontrol_new snd_sb_qsound_switch = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "3D Control - Switch",
 	.info = snd_sb_qsound_switch_info,
@@ -1037,7 +1037,7 @@ static struct snd_kcontrol_new snd_sb_qsound_switch = {
 	.put = snd_sb_qsound_switch_put
 };
 
-static struct snd_kcontrol_new snd_sb_qsound_space = {
+static const struct snd_kcontrol_new snd_sb_qsound_space = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "3D Control - Space",
 	.info = snd_sb_qsound_space_info,
diff --git a/sound/isa/sb/sb16_main.c b/sound/isa/sb/sb16_main.c
index 8b2d6c6..4be1350 100644
--- a/sound/isa/sb/sb16_main.c
+++ b/sound/isa/sb/sb16_main.c
@@ -737,7 +737,7 @@ static int snd_sb16_dma_control_put(struct snd_kcontrol *kcontrol, struct snd_ct
 	return change;
 }
 
-static struct snd_kcontrol_new snd_sb16_dma_control = {
+static const struct snd_kcontrol_new snd_sb16_dma_control = {
 	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
 	.name = "16-bit DMA Allocation",
 	.info = snd_sb16_dma_control_info,
diff --git a/sound/isa/sscape.c b/sound/isa/sscape.c
index 54f5758a..1cd2908 100644
--- a/sound/isa/sscape.c
+++ b/sound/isa/sscape.c
@@ -671,7 +671,7 @@ static int sscape_midi_put(struct snd_kcontrol *kctl,
 	return change;
 }
 
-static struct snd_kcontrol_new midi_mixer_ctl = {
+static const struct snd_kcontrol_new midi_mixer_ctl = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "MIDI",
 	.info = sscape_midi_info,
-- 
2.7.4
