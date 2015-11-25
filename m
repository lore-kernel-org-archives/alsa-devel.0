From: Caesar Wang <wxt@rock-chips.com>
Subject: Re: [PATCH] ASoC: rockchip: Fix incorrect VDW value for 24 bit
Date: Wed, 25 Nov 2015 17:03:13 +0800
Message-ID: <56557951.7070401@rock-chips.com>
References: <1448441651-444-1-git-send-email-sjoerd.simons@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448441651-444-1-git-send-email-sjoerd.simons@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi,

=E5=9C=A8 2015=E5=B9=B411=E6=9C=8825=E6=97=A5 16:54, Sjoerd Simons =E5=86=
=99=E9=81=93:
> Correct valid data word register value for 24 bit data width. The
> bit value should be 10 (aka 0x2), not 0x10.
>
> This fixes playback of 24 bit audio.
>
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
>
> ---
>
>   sound/soc/rockchip/rockchip_spdif.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/sound/soc/rockchip/rockchip_spdif.h b/sound/soc/rockchip=
/rockchip_spdif.h
> index 07f86a2..921b409 100644
> --- a/sound/soc/rockchip/rockchip_spdif.h
> +++ b/sound/soc/rockchip/rockchip_spdif.h
> @@ -28,9 +28,9 @@
>   #define SPDIF_CFGR_VDW(x)	(x << SPDIF_CFGR_VDW_SHIFT)
>   #define SDPIF_CFGR_VDW_MASK	(0xf << SPDIF_CFGR_VDW_SHIFT)
>  =20
> -#define SPDIF_CFGR_VDW_16	SPDIF_CFGR_VDW(0x00)
> -#define SPDIF_CFGR_VDW_20	SPDIF_CFGR_VDW(0x01)
> -#define SPDIF_CFGR_VDW_24	SPDIF_CFGR_VDW(0x10)
> +#define SPDIF_CFGR_VDW_16	SPDIF_CFGR_VDW(0x0)
> +#define SPDIF_CFGR_VDW_20	SPDIF_CFGR_VDW(0x1)
> +#define SPDIF_CFGR_VDW_24	SPDIF_CFGR_VDW(0x2)

Yep,
 From the TRM says: (RK3288/RK3368...)

VDW
Valid data width
00: 16bit
01: 20bit
10: 24bit
11: reserved
=2E...

So feel free add my tag:

Reviewed-by: Caesar Wang <wxt@rock-chips.com>


>  =20
>   /*
>    * DMACR


--=20
caesar wang | software engineer | wxt@rock-chip.com
