From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] ASoC: rt5645: fix build warning
Date: Wed,  7 Oct 2015 17:52:12 +0530
Message-ID: <1444220532-14199-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

We were getting build warning about "Section mismatch".
dmi_platform_intel_broadwell is being referenced from the probe function
rt5645_i2c_probe(), but dmi_platform_intel_broadwell was marked with
__initdata.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 sound/soc/codecs/rt5645.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 4c4fe6b..89ba4ff 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3244,7 +3244,7 @@ static int buddy_quirk_cb(const struct dmi_system_id *id)
 	return 1;
 }
 
-static struct dmi_system_id dmi_platform_intel_broadwell[] __initdata = {
+static struct dmi_system_id dmi_platform_intel_broadwell[] = {
 	{
 		.ident = "Chrome Buddy",
 		.callback = buddy_quirk_cb,
-- 
1.9.1
