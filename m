From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 7/8] ASoC: tlv320aic3x: add initial usage
 of regulator framework to control avdd_dac
Date: Thu, 8 Oct 2009 14:38:43 +0100
Message-ID: <20091008133843.GG29176__43725.9303209887$1255009867$gmane$org@rakim.wolfsonmicro.main>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
	<1255003137-1034-8-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1255003137-1034-8-git-send-email-eduardo.valentin@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: ext Tony Lindgren <tony@atomide.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 08, 2009 at 02:58:56PM +0300, Eduardo Valentin wrote:

> This patch adds initial usage of regulator framework to control avdd_dac
> inside tlv320aic3x ASoC codec driver.

If you're going to do this you should add support for all the supplies
of the device, not just one of them.  The extra effort required is low
and it avoids compatibility problems when someone wants to set up other
supplies, causing existing boards to need to specify them.

> +	aic3x->regulator = regulator_get(&i2c->dev, "avdd_dac");
> +	if (IS_ERR(aic3x->regulator)) {
> +		dev_warn(&i2c->dev, "No regulator to supply avdd_dac."
> +					" Assuming always on.\n");

You shouldn't split error messages over multiple lines like this, it
breaks grepping to try to find where the message came from. 

I'd also rather see failure to get the regulator treated as a hard
error.  When the regulator API compiled out it is stubbed so that for
simple get/enable/disable/put usage it will return success but do
nothing.  If the regulator API is compiled in and we're not able to
acquire regulators there's a good chance that things will break (eg, due
to supplies being turned off because they appear to be unused) so
flagging the error immediately is less likely to result in runtime
fragility.

> +	/*
> +	 * REVISIT: Need to add proper code to put into sleep mode
> +	 * avdd_dac regulator. For now, just leave it on.
> +	 */
> +	if (aic3x->regulator) {
> +		int err;
> +
> +		err = regulator_enable(aic3x->regulator);
> +		if (err < 0)
> +			return err;
> +	}

The best way to handle this is to push the enable/disable into the bias
level configuration so that the regulators are enabled when the chip
goes off->standby and disabled during standby->off.  This will have the
same effect for the moment but will mean that we'll be able to add core
support for fully powering down the audio subsystem at runtime in the
future.
