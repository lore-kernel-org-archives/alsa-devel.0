From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 3/7 linux-next] ASoC: kirkwood: constify of_device_id array
Date: Wed, 18 Mar 2015 17:48:58 +0100
Message-ID: <1426697344-4884-4-git-send-email-fabf@skynet.be>
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
 sound/soc/kirkwood/kirkwood-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index d194830..3a36d60 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -643,7 +643,7 @@ static int kirkwood_i2s_dev_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_OF
-static struct of_device_id mvebu_audio_of_match[] = {
+static const struct of_device_id mvebu_audio_of_match[] = {
 	{ .compatible = "marvell,kirkwood-audio" },
 	{ .compatible = "marvell,dove-audio" },
 	{ .compatible = "marvell,armada370-audio" },
-- 
1.9.1
