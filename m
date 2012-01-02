From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 1/3] ALSA: HDA: Fix master control for Cirrus
	Logic 421X
Date: Mon,  2 Jan 2012 12:40:15 +0100
Message-ID: <1325504417-7283-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 9BCF2246C0
	for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2012 12:40:26 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: stable@kernel.org, David Henningsson <david.henningsson@canonical.com>, tim.howe@cirrus.com
List-Id: alsa-devel@alsa-project.org

The control name "HP/Speakers" is non-standard, and since there is
only one DAC on this chip there is no need for a virtual master
anyway.

Cc: stable@kernel.org
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_cirrus.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index acfb645..9139558 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -1779,30 +1779,19 @@ static int build_cs421x_output(struct hda_codec *codec)
 	struct auto_pin_cfg *cfg = &spec->autocfg;
 	struct snd_kcontrol *kctl;
 	int err;
-	char *name = "HP/Speakers";
+	char *name = "Master";
 
 	fix_volume_caps(codec, dac);
-	if (!spec->vmaster_sw) {
-		err = add_vmaster(codec, dac);
-		if (err < 0)
-			return err;
-	}
 
 	err = add_mute(codec, name, 0,
 			HDA_COMPOSE_AMP_VAL(dac, 3, 0, HDA_OUTPUT), 0, &kctl);
 	if (err < 0)
 		return err;
-	err = snd_ctl_add_slave(spec->vmaster_sw, kctl);
-	if (err < 0)
-		return err;
 
 	err = add_volume(codec, name, 0,
 			HDA_COMPOSE_AMP_VAL(dac, 3, 0, HDA_OUTPUT), 0, &kctl);
 	if (err < 0)
 		return err;
-	err = snd_ctl_add_slave(spec->vmaster_vol, kctl);
-	if (err < 0)
-		return err;
 
 	if (cfg->speaker_outs) {
 		err = snd_hda_ctl_add(codec, 0,
-- 
1.7.5.4
