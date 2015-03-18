From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 5/7 linux-next] ASoC: ak4554: constify of_device_id array
Date: Wed, 18 Mar 2015 17:49:00 +0100
Message-ID: <1426697344-4884-6-git-send-email-fabf@skynet.be>
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
 sound/soc/codecs/ak4554.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ak4554.c b/sound/soc/codecs/ak4554.c
index 16ce9f9..298dedc 100644
--- a/sound/soc/codecs/ak4554.c
+++ b/sound/soc/codecs/ak4554.c
@@ -84,7 +84,7 @@ static int ak4554_soc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id ak4554_of_match[] = {
+static const struct of_device_id ak4554_of_match[] = {
 	{ .compatible = "asahi-kasei,ak4554" },
 	{},
 };
-- 
1.9.1
