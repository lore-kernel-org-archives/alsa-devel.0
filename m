From: Colin King <colin.king@canonical.com>
Subject: [PATCH 4/5] ASoC: arizona: fix indentation issue with return statement
Date: Fri, 16 Nov 2018 15:06:35 +0000
Message-ID: <20181116150636.5226-4-colin.king@canonical.com>
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

The return statement is indented incorrectly. Fix this by adding in
the missing tab.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/wm8998.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8998.c b/sound/soc/codecs/wm8998.c
index 61294c787f27..409bed30a4e4 100644
--- a/sound/soc/codecs/wm8998.c
+++ b/sound/soc/codecs/wm8998.c
@@ -60,7 +60,7 @@ static int wm8998_asrc_ev(struct snd_soc_dapm_widget *w,
 				dev_warn(component->dev,
 					 "Unsupported ASRC rate1 (%s)\n",
 					 arizona_sample_rate_val_to_name(val));
-			return -EINVAL;
+				return -EINVAL;
 			}
 			break;
 		default:
-- 
2.19.1
