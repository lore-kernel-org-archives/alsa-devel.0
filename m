From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] ALSA: usb-audio: constify snd_kcontrol_new structures
Date: Wed, 12 Apr 2017 18:38:06 +0530
Message-ID: <1492002486-9021-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, clemens@ladisch.de, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Declare snd_kcontrol_new strcutures as const as they are only passed as
an argument to the function snd_ctl_new1. This argument is of type const,
so snd_kcontrol_new structures having this property can be made const too.
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
 sound/usb/midi.c  | 2 +-
 sound/usb/mixer.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 6e763bc..a35f414 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1922,7 +1922,7 @@ static int roland_load_put(struct snd_kcontrol *kcontrol,
 	return changed;
 }
 
-static struct snd_kcontrol_new roland_load_ctl = {
+static const struct snd_kcontrol_new roland_load_ctl = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "MIDI Input Mode",
 	.info = roland_load_info,
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 4703cae..082736c 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1172,7 +1172,7 @@ static struct snd_kcontrol_new usb_feature_unit_ctl = {
 };
 
 /* the read-only variant */
-static struct snd_kcontrol_new usb_feature_unit_ctl_ro = {
+static const struct snd_kcontrol_new usb_feature_unit_ctl_ro = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "", /* will be filled later manually */
 	.info = mixer_ctl_feature_info,
@@ -1745,7 +1745,7 @@ static int mixer_ctl_procunit_put(struct snd_kcontrol *kcontrol,
 }
 
 /* alsa control interface for processing/extension unit */
-static struct snd_kcontrol_new mixer_procunit_ctl = {
+static const struct snd_kcontrol_new mixer_procunit_ctl = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "", /* will be filled later */
 	.info = mixer_ctl_feature_info,
@@ -2033,7 +2033,7 @@ static int mixer_ctl_selector_put(struct snd_kcontrol *kcontrol,
 }
 
 /* alsa control interface for selector unit */
-static struct snd_kcontrol_new mixer_selectunit_ctl = {
+static const struct snd_kcontrol_new mixer_selectunit_ctl = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "", /* will be filled later */
 	.info = mixer_ctl_selector_info,
-- 
2.7.4
