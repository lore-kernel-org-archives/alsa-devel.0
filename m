From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH - BT and FM audio for zoom2 1/2]
	Add	clock-only codec to provide McBSP clock source.
Date: Mon, 3 Aug 2009 12:01:46 +0100
Message-ID: <20090803110146.GB5959@sirena.org.uk>
References: <1249273755-32620-1-git-send-email-sean.mcneil@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1249273755-32620-1-git-send-email-sean.mcneil@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: sean.mcneil@ti.com
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org, peter.ujfalusi@nokia.com
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 03, 2009 at 11:29:14AM +0700, sean.mcneil@ti.com wrote:
> From: Sean McNeil <sean.mcneil@ti.com>

> Signed-off-by: Sean McNeil <sean.mcneil@ti.com>

Please always CC the maintainers for patches you're submitting; it's
also helpful if you include the name of the thng you're patching in the
subject.  In this case you're not actually adding a new CODEC, you're
updating the TWL4030 driver - I've added Peter Ujfalusi to the CCs.

A more detailed changelog explaining what exactly you're doing is also
needed here - you're making rather a lot of fairly invasive changes to
the driver and it's a bit hard to know what they're supposed to be and
check them without more detail.  I'm having a hard time figuring out
what the patch is really intended do and why you've done it this way.  I
*think* you're trying to enhance the TDM mode support in the driver but
it's really not clear.

It would be a lot easier easier to follow if you were to split this into
a series of changes.  I'd suggest starting off a series with pure code
motion pathes that deal with the restructuring of the code that you're
doing then add further patches on top of those which implement the new
behaviour you're trying to add.

You'll also need to rebase your changes against the current version of
the driver - at least some of the changes in here appear to implement
support for the four channel mode which is already supported by the
driver.  You can find the most current version of the driver here (a
for-2.6.33 will appear as the next merge window opens):

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.32

Some other comments below, mostly coding style.

> --- a/sound/soc/codecs/twl4030.c
> +++ b/sound/soc/codecs/twl4030.c
> @@ -56,7 +56,7 @@ static const u8 twl4030_reg[TWL4030_CACHEREGNUM] = {
>  	0x00, /* REG_AVTXL2PGA		(0xC)	*/
>  	0x00, /* REG_AVTXR2PGA		(0xD)	*/
>  	0x01, /* REG_AUDIO_IF		(0xE)	*/
> -	0x00, /* REG_VOICE_IF		(0xF)	*/
> +	0x04, /* REG_VOICE_IF		(0xF)	*/

What is the purpose of this change - how will it affect other TWL4030
platforms?

>  struct twl4030_priv {
> +	struct mutex mutex;
> +
> +	unsigned int extClock;
>  	unsigned int bypass_state;

Please use the standard Linux naming convention for variables (as the
other variables here do).

>  
> -	if (twl4030->configured) {
> +	if (!list_empty(&twl4030->config_list)) {
>  		printk(KERN_ERR "twl4030 operation mode cannot be "
>  			"changed on-the-fly\n");

Don't split strings over multiple lines - it makes it harder for someone
to find the source of the error by grepping the source.

> +}
> +EXPORT_SYMBOL_GPL(twl4030_set_rate);

This is a fairly big change and really needs to have been called out in
the changlog.  How will this change impact existing machine drivers?

> @@ -2056,6 +2307,7 @@ static struct snd_soc_dai_ops twl4030_dai_ops = {
>  	.startup	= twl4030_startup,
>  	.shutdown	= twl4030_shutdown,
>  	.hw_params	= twl4030_hw_params,
> +	.hw_free = twl4030_hw_free,

Please indent new code in the same way as the code it's modifying.

>  static int __init twl4030_modinit(void)
>  {
> -	return snd_soc_register_dais(&twl4030_dai[0], ARRAY_SIZE(twl4030_dai));
> +	return snd_soc_register_dais(twl4030_dai, ARRAY_SIZE(twl4030_dai));
>  }
>  module_init(twl4030_modinit);

This sort of coding style change should go in as a patch by itself.
