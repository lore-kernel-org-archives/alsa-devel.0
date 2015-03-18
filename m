From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 6/7 linux-next] ASoC: fsi: constify of_device_id array
Date: Wed, 18 Mar 2015 17:49:01 +0100
Message-ID: <1426697344-4884-7-git-send-email-fabf@skynet.be>
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
 sound/soc/sh/fsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index bb20550..b593e28 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -1882,7 +1882,7 @@ static void fsi_handler_init(struct fsi_priv *fsi,
 	}
 }
 
-static struct of_device_id fsi_of_match[];
+static const struct of_device_id fsi_of_match[];
 static int fsi_probe(struct platform_device *pdev)
 {
 	struct fsi_master *master;
@@ -2100,7 +2100,7 @@ static struct fsi_core fsi2_core = {
 	.b_mclk	= B_MST_CTLR,
 };
 
-static struct of_device_id fsi_of_match[] = {
+static const struct of_device_id fsi_of_match[] = {
 	{ .compatible = "renesas,sh_fsi",	.data = &fsi1_core},
 	{ .compatible = "renesas,sh_fsi2",	.data = &fsi2_core},
 	{},
-- 
1.9.1
