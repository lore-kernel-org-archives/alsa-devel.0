From: Colin King <colin.king@canonical.com>
Subject: [PATCH 3/5] ASoC: tlv320dac33: clean up indentation, remove extraneous tab
Date: Fri, 16 Nov 2018 15:06:34 +0000
Message-ID: <20181116150636.5226-3-colin.king@canonical.com>
References: <20181116150636.5226-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181116150636.5226-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

The goto statement is indented too much by one level, fix this by
removing the extraneous tab.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/tlv320dac33.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index a957eaeb7bc1..32907b1e20cf 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -394,7 +394,7 @@ static int dac33_hard_power(struct snd_soc_component *component, int power)
 		if (ret != 0) {
 			dev_err(component->dev,
 				"Failed to enable supplies: %d\n", ret);
-				goto exit;
+			goto exit;
 		}
 
 		if (dac33->power_gpio >= 0)
-- 
2.19.1
