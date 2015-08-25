From: Xing Zheng <zhengxing@rock-chips.com>
Subject: [RESEND PATCH v1] ASoC: rockchip: fix a misjudgement by return
Date: Tue, 25 Aug 2015 15:52:42 +0800
Message-ID: <1440489162-28270-2-git-send-email-zhengxing@rock-chips.com>
References: <1440489162-28270-1-git-send-email-zhengxing@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440489162-28270-1-git-send-email-zhengxing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dgreid@chromium.org, dianders@chromium.org, heiko@sntech.de, sonnyrao@chromium.org
Cc: linux-rockchip@lists.infradead.org, Xing Zheng <zhengxing@rock-chips.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Being careless, judge the return value of snd_soc_card_jack_new
is opposite, so it should be fixed.

---

Changes in v1:
Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
Reviewed-by: Dylan Reid <dgreid@chromium.org>

 sound/soc/rockchip/rockchip_rt5645.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_rt5645.c b/sound/soc/rockchip/rockchip_rt5645.c
index 3c6bb1e..adfe98c 100644
--- a/sound/soc/rockchip/rockchip_rt5645.c
+++ b/sound/soc/rockchip/rockchip_rt5645.c
@@ -118,7 +118,7 @@ static int rk_init(struct snd_soc_pcm_runtime *runtime)
 				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 				    SND_JACK_BTN_2 | SND_JACK_BTN_3,
 				    &headset_jack, NULL, 0);
-	if (!ret) {
+	if (ret) {
 		dev_err(card->dev, "New Headset Jack failed! (%d)\n", ret);
 		return ret;
 	}
-- 
1.7.9.5
