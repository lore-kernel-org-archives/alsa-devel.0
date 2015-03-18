From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 7/7 linux-next] ASoC: rsnd: constify of_device_id array
Date: Wed, 18 Mar 2015 17:49:02 +0100
Message-ID: <1426697344-4884-8-git-send-email-fabf@skynet.be>
References: <1426697344-4884-1-git-send-email-fabf@skynet.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426697344-4884-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Fabian Frederick <fabf@skynet.be>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

of_device_id is always used as const.
(See driver.of_match_table and open firmware functions)

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 sound/soc/sh/rcar/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index be03474..e9bac7c 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -107,7 +107,7 @@ static struct rsnd_of_data rsnd_of_data_gen2 = {
 	.flags = RSND_GEN2,
 };
 
-static struct of_device_id rsnd_of_match[] = {
+static const struct of_device_id rsnd_of_match[] = {
 	{ .compatible = "renesas,rcar_sound-gen1", .data = &rsnd_of_data_gen1 },
 	{ .compatible = "renesas,rcar_sound-gen2", .data = &rsnd_of_data_gen2 },
 	{},
-- 
1.9.1
