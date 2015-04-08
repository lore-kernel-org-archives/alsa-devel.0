From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH 0/1] ASoC: max98090: add shutdown callback for max98090
Date: Wed,  8 Apr 2015 16:52:07 +0800
Message-ID: <1428483128-23498-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sonny Rao <sonnyrao@chromium.org>, Cheng-Yi Chiang <cychiang@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, zhengxing <zhengxing@rock-chips.com>, "jay.xu" <xjq@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, Caesar Wang <wxt@rock-chips.com>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Dylan Reid <dgreid@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Tushar Behera <tushar.b@samsung.com>
List-Id: alsa-devel@alsa-project.org


Tested on veyron devices,play music then shutdown device,here carefully
to speaker or headphone.



Caesar Wang (1):
  ASoC: max98090: add shutdown callback for max98090

 sound/soc/codecs/max98090.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

-- 
1.9.1
