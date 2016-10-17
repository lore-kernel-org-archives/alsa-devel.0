From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] ASoC: rk3399_gru_sound: Fix non static symbol warning
Date: Mon, 17 Oct 2016 15:15:18 +0000
Message-ID: <1476717318-12684-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Heiko Stuebner <heiko@sntech.de>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fixes the following sparse warning:

sound/soc/rockchip/rk3399_gru_sound.c:41:14: warning:
 symbol 'rt5514_dmic_delay' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/rockchip/rk3399_gru_sound.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 9ed735a..0cbd235 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -38,7 +38,7 @@
 
 #define SOUND_FS	256
 
-unsigned int rt5514_dmic_delay;
+static unsigned int rt5514_dmic_delay;
 
 static struct snd_soc_jack rockchip_sound_jack;
