From: Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH v3 0/4] Add support for es8388 on the rock2
Date: Fri, 20 Jan 2017 15:54:54 +0100
Message-ID: <ce2dca37-a9e2-4f1f-4990-ca38da3a6485@collabora.com>
References: <20170117081705.14107-1-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20170117081705.14107-1-romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hello,

Le 17/01/2017 =E0 09:17, Romain Perier a =E9crit :
> This set of patches adds a machine driver for rockchip boards that use
> ES8388 codecs. It also adds slave mode to the es8328 driver that
> currently only supported the master mode. Then, it adds the required DT
> definitions to link rockchip-i2s to the es8388 analog output.
>
> This work is based on the initial work that was done by Sjoerd Simons
> <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org> with some improvements, changes and more
> commits.
>
> Changes in v3:
>  - Cosmetic changes in rockchip_es8388.c
>  - Added missing email to MODULE_AUTHOR in rockchip_es8388.c
> Changes in v2:
>  - Fixed wrong use of the data structure i2c_device_id
>  - Fixed wrong dependencies for SND_SOC_ROCKCHIP_ES8388
>
> Romain Perier (4):
>   ASoC: es8328-i2c: Add compatible for ES8388
>   ASoC: es8328: Add support for slave mode
>   ASoC: rockchip: Add machine driver for ES8388 codecs
>   arm: dts: Add support for ES8388 to the Radxa Rock 2
>
>  Documentation/devicetree/bindings/sound/es8328.txt |   2 +-
>  .../devicetree/bindings/sound/rockchip-es8388.txt  |  28 +++
>  arch/arm/boot/dts/rk3288-rock2-square.dts          |  37 +++
>  sound/soc/codecs/es8328-i2c.c                      |   2 +
>  sound/soc/codecs/es8328.c                          |  28 ++-
>  sound/soc/rockchip/Kconfig                         |   9 +
>  sound/soc/rockchip/Makefile                        |   2 +
>  sound/soc/rockchip/rockchip_es8388.c               | 269 +++++++++++++++=
++++++
>  8 files changed, 370 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/rockchip-es83=
88.txt
>  create mode 100644 sound/soc/rockchip/rockchip_es8388.c

Please ignore this v3, I will re-submit it with some improvements.

Regards,

Romain
