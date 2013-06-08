From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH] ASoC: wm8962: Restore device state after
 reset in runtime resume
Date: Sat, 8 Jun 2013 13:34:58 +0800
Message-ID: <20130608053457.GE19153@MrMyself>
References: <1370619797-17503-1-git-send-email-broonie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 by alsa0.perex.cz (Postfix) with ESMTP id 37CDC261635
 for <alsa-devel@alsa-project.org>; Sat,  8 Jun 2013 07:47:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1370619797-17503-1-git-send-email-broonie@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@linaro.org>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 07, 2013 at 04:43:17PM +0100, Mark Brown wrote:
> +	/* SYSCLK defaults to on; make sure it is off so we can safely
> +	 * write to registers if the device is declocked.
> +	 */
> +	regmap_update_bits(wm8962->regmap, WM8962_CLOCKING2,
> +			   WM8962_SYSCLK_ENA, 0);

I think it's really nice to disable SYSCLK_ENA here and let soc-dapm
load it up since there's DAPM SUPPLY registered for SYSCLK_ENA bit.
Please keep this line here. Thank you.


> +
> +	/* Ensure we have soft control over all registers */
> +	regmap_update_bits(wm8962->regmap, WM8962_CLOCKING2,
> +			   WM8962_CLKREG_OVD, WM8962_CLKREG_OVD);
> +

On our board this works finely, because our board uses GPIO5 as DMIC_DAT
function which is suggested by WM8962 datasheet in APPLICATIONS chapter,
so this case need to set CLKREG_OVD bit. But there is another case, the
original one, also the driver currently considers, that is, GPIO5 actually
controls SYSCLK source by its input electric level(logical 0 and 1).
Pls check the note in WM8962 datasheet, MCLK_SRC bit of R8 (Clocking 2).

And I have to say that WM8962 is so sophisticatedly designed that this
CLKREG_OVD bit is pretty hard for software to perfectly control. But my
previous patch, at least at the idea of GP5_FN checking before setting
CLKREG_OVD bit, does not break the SYSCLK source controlling function.
Even if it might be not a qualified one, I think we can still figure out
a better solution based on that patch.



> +	/* Ensure that the oscillator and PLLs are disabled */
> +	regmap_update_bits(wm8962->regmap, WM8962_PLL2,
> +			   WM8962_OSC_ENA | WM8962_PLL2_ENA | WM8962_PLL3_ENA,
> +			   0);
> +

Not sure if this is gonna be nice, because I have not seen any other
place enabling either of these three bits if users need one of them.



------------------------------------------------------------------------

Allow me to start one more question about power up here, Since we are
solving all the resume initial issue in one patch.

I have a concern about an applied patch:
commit 52c0eee33 "Don't duplicate bias level management"

This patch removed BIAS generator powering up code. But I found that,
at least on our i.MX6 SabreSD board with WM8962 as audio CODEC, these
BIAS bits are not being updated by soc-core before starting playback,
then "wm8962 0-001a: DC servo timed out" error msg will occur. I checked
the regmap of WM8962 and found these bits, STARTUP_BIAS_ENA bit in R28
for example, are still remaining reset value 0x0 -- disabled.

However, if I revert that patch, with my machine driver and my board
I can play euphonious music as before. (I'm now mainly using Kernel 3.5)

I traced the soc-core by searching 'idle_bias_off' and didn't found any
power-codec-up code in that file. Maybe I'm still missing some parts,
so could you please tell me is there anything wrong on my side?

Thank you.
And sorry if I opened the Pandora Box because I just asked too many
questions :(
