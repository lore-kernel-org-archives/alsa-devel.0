From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/8] ASoC: OMAP: RX-51 Machine driver and
 AIC34b_dummy driver
Date: Thu, 8 Oct 2009 14:11:16 +0100
Message-ID: <20091008131116.GB29176__5916.80804868719$1255007985$gmane$org@rakim.wolfsonmicro.main>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
	<1255003137-1034-3-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1255003137-1034-3-git-send-email-eduardo.valentin@nokia.com>
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

On Thu, Oct 08, 2009 at 02:58:51PM +0300, Eduardo Valentin wrote:
> From: Eduardo Valentin <eduardo.valentin@nokia.com>

> Introduce RX-51 Machine driver for ASoC and AIC34b_dummy (block B) i2c driver.

What is an "AIC34b_dummy (block B)"?  You probably want to split it out
into a separate patch.

> + * TODO:
> + * - Get rid of this driver, at least when ASoC v2 is merged and when
> + *   we can support multiple codec instances in tlv320aic3x.c driver.
> + *   This driver is hacked only for Nokia RX51 HW.

Could you please explain what the issue here is?  A description of the
hardware would go a long way here.

> +EXPORT_SYMBOL(aic34b_set_mic_bias);

EXPORT_SYMBOL_GPL().

> +static void rx51_set_eci_switches(int mode)
> +{
> +	switch (mode) {
> +	case 0: /* Bias off */
> +	case 1: /* Bias according to rx51_dapm_jack_bias */
> +	case 4: /* Bias on */
> +		/* Codec connected to mic/bias line */
> +		gpio_set_value(RX51_ECI_SWITCH_1_GPIO, 0);
> +		gpio_set_value(RX51_ECI_SWITCH_2_GPIO, 1);
> +		break;
> +	case 2:
> +		/* ECI INT#2 detect connected to mic/bias line */
> +		gpio_set_value(RX51_ECI_SWITCH_1_GPIO, 0);
> +		gpio_set_value(RX51_ECI_SWITCH_2_GPIO, 0);
> +		break;
> +	case 3:
> +		/* ECI RX/TX connected to mic/bias line */
> +		gpio_set_value(RX51_ECI_SWITCH_1_GPIO, 1);
> +		gpio_set_value(RX51_ECI_SWITCH_2_GPIO, 0);
> +		break;
> +	}

Some defines for the mode (instead of magic numbers) would be nice).

> +void rx51_jack_report(int status)
> +{
> +	snd_jack_report(rx51_jack, status);
> +}
> +EXPORT_SYMBOL(rx51_jack_report);

Why is this being exported?

> +enum {
> +       RX51_EXT_API_AIC34B,
> +};
> +#define SOC_RX51_EXT_SINGLE_TLV(xname, ext_api, max, tlv_array) \
> +{ \
> +	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
> +	.name = xname, \
> +	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
> +		  SNDRV_CTL_ELEM_ACCESS_READWRITE, \
> +	.tlv.p = (tlv_array), \
> +	.info = rx51_ext_info_volsw, \
> +	.get = rx51_ext_get_volsw, \
> +	.put = rx51_ext_put_volsw, \
> +	.private_value = (ext_api) << 26 | (max) << 16, \
> +}

This looks like it ought to be pushed down into some other driver?
