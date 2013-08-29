From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/5] ASoC: Add ADAU1361/ADAU1761 audio
	CODEC support
Date: Thu, 29 Aug 2013 10:02:47 +0200
Message-ID: <521F0027.5010002@metafoo.de>
References: <1377703214-23234-1-git-send-email-lars@metafoo.de>
 <1377703214-23234-2-git-send-email-lars@metafoo.de>
 <20130828172400.GM10783@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-004.synserver.de (smtp-out-004.synserver.de
 [212.40.185.4]) by alsa0.perex.cz (Postfix) with ESMTP id 04975261670
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2013 10:01:12 +0200 (CEST)
In-Reply-To: <20130828172400.GM10783@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 08/28/2013 07:24 PM, Mark Brown wrote:
> On Wed, Aug 28, 2013 at 05:20:10PM +0200, Lars-Peter Clausen wrote:
> 
>> +static const char * const adau1761_bias_select_text[] = {
>> +	"Normal operation", "Enhanced performance", "Power saving",
>> +};
>> +
>> +static const char * const adau1761_bias_select_extreme_text[] = {
>> +	"Normal operation", "Extreme power saving", "Enhanced performance",
>> +	"Power saving",
>> +};
> 
> Not a requirement and perhaps it has no effect but these seem like they
> ought to integrate with the bias level configuration - since only the
> clocks seem to be managed by set_bias_level() the driver could
> presumably save a bit of power by dropping down to the minimal power
> consumption bias while the device is idle.  This is what the STANDBY to
> ON transition is all about.

Hm, I'm not sure if it makes a difference since all the components have
individual power control bits that are managed by DAPM. I would expect the
bias current setting to only make a difference if the component is actually
powered up. I'll check with the designers, but I think this can still be
improved later on if it turns out that it saves power.

> 
>> +static const struct snd_kcontrol_new adau1761_jack_detect_controls[] = {
>> +	SOC_SINGLE("Jack Detect Switch", ADAU1761_DIGMIC_JACKDETECT, 4, 1, 0),
>> +};
> 
> Why is this a user visible control and not using the jack detection
> framework support?
> 

The CODEC unfortunately does not support reporting the jack state. All it
can do is mute the speaker output in hardware if something is plugged into
the headphone jack. The switch allows the users to control whether the
output should be auto-muted or not.
