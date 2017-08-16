From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 3/3] ALSA: hda: make snd_kcontrol_new const
Date: Wed, 16 Aug 2017 14:14:11 +0530
Message-ID: <1502873051-28437-4-git-send-email-bhumirks@gmail.com>
References: <1502873051-28437-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502873051-28437-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, johannes@sipsolutions.net, perex@perex.cz, tiwai@suse.com, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Make these const as they are only passed as the 3rd argument to the
function snd_hda_gen_add_kctl, which is of type const.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/pci/hda/patch_analog.c   | 4 ++--
 sound/pci/hda/patch_sigmatel.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index e0fb8c6..7578573 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -505,7 +505,7 @@ static int ad1983_auto_smux_enum_put(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
-static struct snd_kcontrol_new ad1983_auto_smux_mixer = {
+static const struct snd_kcontrol_new ad1983_auto_smux_mixer = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "IEC958 Playback Source",
 	.info = ad1983_auto_smux_enum_info,
@@ -788,7 +788,7 @@ static int ad1988_auto_smux_enum_put(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
-static struct snd_kcontrol_new ad1988_auto_smux_mixer = {
+static const struct snd_kcontrol_new ad1988_auto_smux_mixer = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "IEC958 Playback Source",
 	.info = ad1988_auto_smux_enum_info,
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 6cefdf6..63d15b5 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -961,7 +961,7 @@ static int stac_smux_enum_put(struct snd_kcontrol *kcontrol,
 				     &spec->cur_smux[smux_idx]);
 }
 
-static struct snd_kcontrol_new stac_smux_mixer = {
+static const struct snd_kcontrol_new stac_smux_mixer = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "IEC958 Playback Source",
 	/* count set later */
-- 
1.9.1
