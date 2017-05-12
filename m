From: Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: [PATCH v3 0/3] Add support for es8323 and hdmi audio to the firefly-rk3288
Date: Fri, 12 May 2017 15:22:20 +0200
Message-ID: <20170512132227.24916-5-romain.perier@collabora.com>
References: <20170512132227.24916-1-romain.perier@collabora.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170512132227.24916-1-romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This set of patches enables support for the es8323 codecs on the
firefly-rk3288. It adds the required DT definitions to link rockchip-i2s
to the es8388 analog output. As the support for HDMI audio is also
built-in in the corresponding ASoC machine driver, HDMI audio output is
also enabled.

Changes in v3:
 - Synced DT with the one of the Rock2, the properties have been
   lexically re-ordered in the right order, I have splitted the
   headphone pinctrl in two: phone_ctl and hp_det
Changes in v2:
 - Adapted DT for the firefly-rk3288 to the ASoC machine driver
   rk3288-hdmi-analog
 - Added patch 02/03 to this series
 - Re-wrote this cover letter

Romain Perier (3):
  SoC: es8328-i2c: Add compatible for ES8323
  arm: dts: rockchip: Don't set otp-gpio pinctrl by default in
    rk3288.dtsi
  arm: dts: Add support for ES8323 to the Firefly-RK3288

 Documentation/devicetree/bindings/sound/es8328.txt |  5 ++-
 arch/arm/boot/dts/rk3288-evb.dtsi                  |  4 +++
 arch/arm/boot/dts/rk3288-firefly.dtsi              | 38 ++++++++++++++++++++++
 arch/arm/boot/dts/rk3288-veyron.dtsi               |  4 +++
 arch/arm/boot/dts/rk3288.dtsi                      |  4 ---
 sound/soc/codecs/es8328-i2c.c                      |  2 ++
 6 files changed, 52 insertions(+), 5 deletions(-)

-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
