From: Tomer Barletz <barletz@gmail.com>
Subject: [PATCH] Fix logical-not-parentheses warning
Date: Sun,  2 Aug 2015 02:08:57 -0700
Message-ID: <1438506537-26743-1-git-send-email-barletz@gmail.com>
References: <s5hzj2ab1ye.wl-tiwai@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hzj2ab1ye.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: clemens@ladisch.de, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Tomer Barletz <barletz@gmail.com>
List-Id: alsa-devel@alsa-project.org

This fixes the following warning, that is seen with gcc 5.1:
warning: logical not is only applied to the left hand side of comparison [-Wlogical-not-parentheses].

Signed-off-by: Tomer Barletz <barletz@gmail.com>
---
 sound/pci/oxygen/oxygen_mixer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/oxygen/oxygen_mixer.c b/sound/pci/oxygen/oxygen_mixer.c
index 6492bca..4ca1266 100644
--- a/sound/pci/oxygen/oxygen_mixer.c
+++ b/sound/pci/oxygen/oxygen_mixer.c
@@ -88,7 +88,7 @@ static int dac_mute_put(struct snd_kcontrol *ctl,
 	int changed;
 
 	mutex_lock(&chip->mutex);
-	changed = !value->value.integer.value[0] != chip->dac_mute;
+	changed = (!value->value.integer.value[0]) != chip->dac_mute;
 	if (changed) {
 		chip->dac_mute = !value->value.integer.value[0];
 		chip->model.update_dac_mute(chip);
-- 
2.4.3
