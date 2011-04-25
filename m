From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 1/2] ARM: EXYNOS4: Add PCM audio support for WM8994
Date: Mon, 25 Apr 2011 21:40:23 +0530
Message-ID: <BANLkTik2uTae-V1MQ_Owj_jC=x14W4HgwA@mail.gmail.com>
References: <1303714472-2391-1-git-send-email-sbkim73@samsung.com>
	<1303714472-2391-3-git-send-email-sbkim73@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1303714472-2391-3-git-send-email-sbkim73@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sangbeom Kim <sbkim73@samsung.com>
Cc: alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, kgene.kim@samsung.com
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 25, 2011 at 12:24 PM, Sangbeom Kim <sbkim73@samsung.com> wr=
ote:

> --- a/arch/arm/plat-samsung/include/plat/audio.h
> +++ b/arch/arm/plat-samsung/include/plat/audio.h
> @@ -36,6 +36,8 @@ struct samsung_i2s {
> =C2=A0*/
> =C2=A0#define QUIRK_NO_MUXPSR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0(1 << 2)
> =C2=A0#define QUIRK_NEED_RSTCLR =C2=A0 =C2=A0 =C2=A0(1 << 3)
> +/* If the PCM block has no internal prescalar or MUX */
> +#define QUIRK_NO_DIV =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 << 4)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Quirks of the I2S controller */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 quirks;

I think the I2S and PCM configuration don't share enough.
So maybe a separate 'struct samsung_pcm' is warranted here.
Also, if new SoC PCM blocks are going to _not_ have the divider
may be it's a good idea to make that as 'norm' and having divider
as a 'quirk' ?  That way, new code wouldn't have to bother adding
the quirk every time.

-j
