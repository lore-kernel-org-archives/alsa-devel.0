From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] ALSA: ice1712: constify snd_kcontrol_new structures
Date: Wed, 17 May 2017 17:20:46 +0530
Message-ID: <1495021846-17254-1-git-send-email-bhumirks@gmail.com>
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
 sound/pci/ice1712/ice1712.c | 6 +++---
 sound/pci/ice1712/ice1724.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/ice1712/ice1712.c b/sound/pci/ice1712/ice1712.c
index 1d8612c..6b650ab 100644
--- a/sound/pci/ice1712/ice1712.c
+++ b/sound/pci/ice1712/ice1712.c
@@ -1401,7 +1401,7 @@ static struct snd_kcontrol_new snd_ice1712_multi_playback_ctrls[] = {
 	},
 };
 
-static struct snd_kcontrol_new snd_ice1712_multi_capture_analog_switch = {
+static const struct snd_kcontrol_new snd_ice1712_multi_capture_analog_switch = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "H/W Multi Capture Switch",
 	.info = snd_ice1712_pro_mixer_switch_info,
@@ -1420,7 +1420,7 @@ static const struct snd_kcontrol_new snd_ice1712_multi_capture_spdif_switch = {
 	.count = 2,
 };
 
-static struct snd_kcontrol_new snd_ice1712_multi_capture_analog_volume = {
+static const struct snd_kcontrol_new snd_ice1712_multi_capture_analog_volume = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
 		   SNDRV_CTL_ELEM_ACCESS_TLV_READ),
@@ -2165,7 +2165,7 @@ static int snd_ice1712_pro_route_spdif_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static struct snd_kcontrol_new snd_ice1712_mixer_pro_analog_route = {
+static const struct snd_kcontrol_new snd_ice1712_mixer_pro_analog_route = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "H/W Playback Route",
 	.info = snd_ice1712_pro_route_info,
diff --git a/sound/pci/ice1712/ice1724.c b/sound/pci/ice1712/ice1724.c
index 9cd6e55..7851881 100644
--- a/sound/pci/ice1712/ice1724.c
+++ b/sound/pci/ice1712/ice1724.c
@@ -2142,7 +2142,7 @@ static int snd_vt1724_pro_route_spdif_put(struct snd_kcontrol *kcontrol,
 					 digital_route_shift(idx));
 }
 
-static struct snd_kcontrol_new snd_vt1724_mixer_pro_analog_route =
+static const struct snd_kcontrol_new snd_vt1724_mixer_pro_analog_route =
 {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "H/W Playback Route",
-- 
2.7.4
