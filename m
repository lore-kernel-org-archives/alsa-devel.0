From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: dapm: Fix uninitialized variable in snd_soc_dapm_get_enum_double()
Date: Mon, 11 Aug 2014 13:09:46 +0200
Message-ID: <53E8A47A.4030808@metafoo.de>
References: <1407511775-26479-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1407511775-26479-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 08/08/2014 05:29 PM, Geert Uytterhoeven wrote:
> If soc_dapm_read() fails, reg_val will be uninitialized, and bogus
> values will be written later:
>
> sound/soc/soc-dapm.c: In function 'snd_soc_dapm_get_enum_double':
> sound/soc/soc-dapm.c:2862:15: warning: 'reg_val' may be used uninitialized in this function [-Wmaybe-uninitialized]
>    unsigned int reg_val, val;
>                 ^
>
> Return early on error to fix this.
>
> Introduced by commit ce0fc93ae56e2ba50ff8c220d69e4e860e889320 ("ASoC:
> Add DAPM support at the component level").
> ---
> Is this correct? Please review.

Yes, thanks.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
