From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] ASoC: rt5645: fixed section mismatch
Date: Tue, 28 Apr 2015 17:51:41 +0530
Message-ID: <1430223701-21569-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

while building as a module we are getting warning about
section mismatch.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 sound/soc/codecs/rt5645.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 14570b3..0ed79ca 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2684,7 +2684,7 @@ static int strago_quirk_cb(const struct dmi_system_id *id)
 	return 1;
 }
 
-static struct dmi_system_id dmi_platform_intel_braswell[] __initdata = {
+static struct dmi_system_id dmi_platform_intel_braswell[] = {
 	{
 		.ident = "Intel Strago",
 		.callback = strago_quirk_cb,
-- 
1.8.1.2
