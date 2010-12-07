From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 03/15] ASoC: twl6040: Add headset and
 handset mux controls
Date: Tue, 7 Dec 2010 13:22:18 +0000
Message-ID: <20101207132218.GJ4698@rakim.wolfsonmicro.main>
References: <1889FA7136B567478A67D4B0F85B0CCEA4CFBCC9@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0B5C9103A45
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 14:22:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1889FA7136B567478A67D4B0F85B0CCEA4CFBCC9@dlee06.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Olaya, Margarita" <magi.olaya@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 06, 2010 at 06:17:47PM -0600, Olaya, Margarita wrote:

> --- a/sound/soc/codecs/twl6040.c
> +++ b/sound/soc/codecs/twl6040.c
> @@ -82,19 +82,19 @@ static const u8 twl6040_reg[TWL6040_CACHEREGNUM] = {
>  	0x1B, /* TWL6040_LINEGAIN	0x0F	*/
>  	0x00, /* TWL6040_HSLCTL		0x10	*/
>  	0x00, /* TWL6040_HSRCTL		0x11	*/
> -	0x00, /* TWL6040_HSGAIN		0x12	*/
> -	0x00, /* TWL6040_EARCTL		0x13	*/
> +	0xFF, /* TWL6040_HSGAIN		0x12	*/
> +	0x1E, /* TWL6040_EARCTL		0x13	*/
>  	0x00, /* TWL6040_HFLCTL		0x14	*/
> -	0x00, /* TWL6040_HFLGAIN	0x15	*/
> +	0x1D, /* TWL6040_HFLGAIN	0x15	*/
>  	0x00, /* TWL6040_HFRCTL		0x16	*/
> -	0x00, /* TWL6040_HFRGAIN	0x17	*/
> +	0x1D, /* TWL6040_HFRGAIN	0x17	*/
>  	0x00, /* TWL6040_VIBCTLL	0x18	*/
>  	0x00, /* TWL6040_VIBDATL	0x19	*/
>  	0x00, /* TWL6040_VIBCTLR	0x1A	*/
>  	0x00, /* TWL6040_VIBDATR	0x1B	*/
>  	0x00, /* TWL6040_HKCTL1		0x1C	*/
>  	0x00, /* TWL6040_HKCTL2		0x1D	*/
> -	0x00, /* TWL6040_GPOCTL		0x1E	*/
> +	0x02, /* TWL6040_GPOCTL		0x1E	*/
>  	0x00, /* TWL6040_ALB		0x1F	*/
>  	0x00, /* TWL6040_DLB		0x20	*/
>  	0x00, /* not used		0x21	*/

This looks suspicous - are these not the chip register defaults, and if
they aren't are you sure that they will be suitable for all systems?  It
looks like it'd be system specific what sensible values for things like
gains would be?

I also don't immediately see anything in the driver which syncs the
cache with the hardware so it's not clear if the settings will always
take effect but I could be missing something.

>  static const struct soc_enum twl6040_enum[] = {
>  	SOC_ENUM_SINGLE(TWL6040_REG_MICLCTL, 3, 3, twl6040_amicl_texts),
>  	SOC_ENUM_SINGLE(TWL6040_REG_MICRCTL, 3, 3, twl6040_amicr_texts),
> +	SOC_ENUM_SINGLE(TWL6040_REG_HSLCTL, 5, 3, twl6040_hs_texts),
> +	SOC_ENUM_SINGLE(TWL6040_REG_HSRCTL, 5, 3, twl6040_hs_texts),
> +	SOC_ENUM_SINGLE(TWL6040_REG_HFLCTL, 2, 3, twl6040_hf_texts),
> +	SOC_ENUM_SINGLE(TWL6040_REG_HFRCTL, 2, 3, twl6040_hf_texts),

It'd be good to look at moving these into individual variables rather
than using the array if you're working on the code.
