From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: soc_jack - add function to add
 jack zones and determine jack type
Date: Thu, 3 Feb 2011 15:16:28 +0000
Message-ID: <20110203151628.GB2576@opensource.wolfsonmicro.com>
References: <1296732343-22627-1-git-send-email-priya.harsha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 31073103828
	for <alsa-devel@alsa-project.org>; Thu,  3 Feb 2011 16:16:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1296732343-22627-1-git-send-email-priya.harsha@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Harsha Priya <priya.harsha@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 03, 2011 at 04:55:43PM +0530, Harsha Priya wrote:

> +/* struct snd_soc_jack_zone - Describes voltage zones of jack detection
> + *
> + * @adc_value_start: start range of voltage value in adc channel
> + *			when jack is pluggedin
> + * @adc_value_end: end range of voltage value in adc channel
> + *			when jack is pluggedin
> + * @jack_type: type of jack that is expected for this voltage
> + */
> +struct snd_soc_jack_zone {
> +	unsigned int adc_value_start;
> +	unsigned int adc_value_end;
> +	unsigned int jack_type;
> +	struct list_head list;
> +};

This is a lot better than the previous version but I think we do need to
include settling time support in here.  As I said before most hardware
used for this isn't specialised and won't have debounce support, and in
cases like detection of simple headphones on a headset jack the settling
time is essential in order to distinguish between that and a headset
with a microphone short button active.

I'd also like to change adc_value_x to be {min,max}_mv or something
similar for clarity, min and max are more obvious and using mv makes it
clear what units are being used and that we're not working in terms of
raw ADC values or similar.

> +static int snd_soc_validate_jack_type(int type)
> +{
> +	switch (type) {

I don't see the need for this and in any case...

> +	case SND_JACK_HEADPHONE:
> +	case SND_JACK_MICROPHONE:
> +	case SND_JACK_HEADSET:
> +	case SND_JACK_LINEOUT:
> +	case SND_JACK_MECHANICAL:
> +	case SND_JACK_VIDEOOUT:
> +	case SND_JACK_AVOUT:
> +		break;

...this doesn't cover things like buttons implemented by shorting
different resistances to ground.

> +int snd_soc_jack_get_type(struct snd_soc_jack *jack, int micbias_voltage)
> +{
> +	struct snd_soc_jack_zone *zone;
> +
> +	list_for_each_entry(zone, &jack->jack_zones, list) {
> +		if (micbias_voltage >= zone->adc_value_start &&
> +			micbias_voltage < zone->adc_value_end)
> +				return zone->jack_type;
> +	}
> +	return -ENODEV;

Returning 0 would be more helpful - that'd mean that you could just
report the result straight off.  However, as I said last time I do think
that we should be doing something more active to manage the detection
here.  That's pretty essential for anything time based.
