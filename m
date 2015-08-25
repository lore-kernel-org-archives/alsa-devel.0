From: Xing Zheng <zhengxing@rock-chips.com>
Subject: [RESEND PATCH v1 0/1] A misjudgement should be fixed
Date: Tue, 25 Aug 2015 15:52:41 +0800
Message-ID: <1440489162-28270-1-git-send-email-zhengxing@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dgreid@chromium.org, dianders@chromium.org, heiko@sntech.de, sonnyrao@chromium.org
Cc: linux-rockchip@lists.infradead.org, Xing Zheng <zhengxing@rock-chips.com>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


Hi,
Being careless, judge the return value of snd_soc_card_jack_new
is opposite, so it should be fixed.

Thanks.


Changes in v1:
Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
Reviewed-by: Dylan Reid <dgreid@chromium.org>

Xing Zheng (1):
  ASoC: rockchip: fix a misjudgement by return

 sound/soc/rockchip/rockchip_rt5645.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.7.9.5
