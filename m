From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: Hooking a TI CODEC to a i.MX27 MCU
Date: Thu, 3 Jun 2010 12:14:56 +0100
Message-ID: <20100603111455.GF10031@sirena.org.uk>
References: <20100525004126.GA10968@www.longlandclan.yi.org>
	<20100525022646.GA18030@www.longlandclan.yi.org>
	<1274806007.4728.3.camel@gnutoo-desktop>
	<20100526132129.GA13644@www.longlandclan.yi.org>
	<20100527004702.GA22091@sirena.org.uk>
	<20100528020621.GA12531@www.longlandclan.yi.org>
	<4BFF5AC7.3060409@eukrea.com>
	<20100601033023.GA24820@www.longlandclan.yi.org>
	<20100601050731.GB24820@www.longlandclan.yi.org>
	<20100601113224.GA14493@www.longlandclan.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B044B243C2
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jun 2010 13:15:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100601113224.GA14493@www.longlandclan.yi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stuart Longland <redhatter@gentoo.org>
Cc: alsa-devel@alsa-project.org, Eric B?nard <eric@eukrea.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 01, 2010 at 09:32:38PM +1000, Stuart Longland wrote:

I know this isn't a proper submission but a few comments below.  This
looks like it'd be relatively easy to get submitted by stripping out a
lot of the commented out code and custom interfaces (like the DA7210
driver).

> The CODEC driver claims total control of the I2C device, and therefore
> makes it impossible to alter registers using i2c-tools.  However, as a
> work-around; I have provided read/write access to the registers via
> sysfs... we use the AIC3204 attached to I2C bus 0; the CODEC therefore
> lives under:

> 	/sys/bus/i2c/devices/0-0018

> There are two files:
> 	- regsel:	Takes or reports back the 16-bit register
> 			address in hexadecimal
> 	- regdata:	Reads or writes the value of the register

ASoC already provides register read/write access via debugfs as
standard, there's no need to implement this.

> struct aic3204_setup_data {
> 	unsigned int gpio_func[2];
> };

This would normally be platform data in a file in include/sound so it
can be set by the architecture code when the device is registered.

> /* TODO: PLL */
> /* #define ENABLE_PLL */

> /* SYSFS Interface -- we should move this to debugfs */
> static ssize_t aic3204_show_regsel(struct device *dev,
> 		struct device_attribute *attr, char *buf);
> static ssize_t aic3204_store_regsel(struct device *dev,
> 		struct device_attribute *attr, const char *buf, size_t count);
> static ssize_t aic3204_show_regdata(struct device *dev,
> 		struct device_attribute *attr, char *buf);
> static ssize_t aic3204_store_regdata(struct device *dev,
> 		struct device_attribute *attr, const char *buf, size_t count);
> static DEVICE_ATTR(regsel, S_IWUSR | S_IRUGO,
> 		aic3204_show_regsel, aic3204_store_regsel);
> static DEVICE_ATTR(regdata, S_IWUSR | S_IRUGO,
> 		aic3204_show_regdata, aic3204_store_regdata);

As I said above this is redundant and can be removed.

> #if 0
> 	printk( KERN_INFO "%s: pg %d reg %d[%04x] => %02x\n",
> 			__func__, reg >> 8, reg & 0xff, reg, value[0] );
> #endif

dev_dbg().

> }
> 
> /*
>  * Perform a read/modify/write cycle on a register.
>  *
>  * This is a shorthand function, it reads the specified register, masks out the
>  * bits in and_mask, applies bits in or_mask, then writes out the result to the
>  * register.
>  *
>  * It returns the modified value; or a negative error code.
>  */

There's a standard snd_soc_update_bits() function in ASoC.

> /*
>  * All input lines are connected when !0xf and disconnected with 0xf bit field,
>  * so we have to use specific dapm_put call for input mixer
>  */

Could you explain in more detial what this is doing?  I'm not
immediately seeing what this is doing but I suspect it might be a value
mux?

> #if 0

Just drop if 0ed sections.

> #define LDAC_ENUM	0
> #define RDAC_ENUM	1
> #define LHPCOM_ENUM	2
> #define RHPCOM_ENUM	3
> #define LINE1L_ENUM	4
> #define LINE1R_ENUM	5
> #define LINE2L_ENUM	6
> #define LINE2R_ENUM	7
> #define ADC_HPF_ENUM	8
> 
> static const struct soc_enum aic3204_enum[] = {
> 	SOC_ENUM_SINGLE(DAC_LINE_MUX, 6, 3, aic3204_left_dac_mux),

Use individually named variables rather than a table for legibility.

> 	/* Turn on ADC or DAC */
> 	if ( substream->stream == SNDRV_PCM_STREAM_PLAYBACK ) {
> 		aic3204_write(codec, AIC3204_DACS1,
> 				AIC3204_DACS1_LDAC_UP |
> 				AIC3204_DACS1_RDAC_UP |
> 				AIC3204_DACS1_LDACD_LEFT |
> 				AIC3204_DACS1_RDACD_RIGHT |
> 				AIC3204_DACS1_SOFT_DIS );

DAPM ought to be figuring this out for you...

> 	/* This all needs to be done elsewhere */

Yes.

> void aic3204_set_headset_detection(struct snd_soc_codec *codec, int detect,
> 				 int headset_debounce, int button_debounce)
> {
> #if 0

There's standard ASoC jack detection which this should integrate with.

> #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
> /*
>  * AIC3204 2 wire address can be up to 4 devices with device addresses
>  * 0x18, 0x19, 0x1A, 0x1B
>  */
> 
> /*
>  * If the i2c layer weren't so broken, we could pass this kind of data
>  * around
>  */
> static int aic3204_i2c_probe(struct i2c_client *i2c,
> 			   const struct i2c_device_id *id)

Use standard device model registration - the driver you were basing this
on has been converted now...
