From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: Add Baytrail byt-max98090
	machine driver
Date: Mon, 19 May 2014 10:56:11 +0300
Message-ID: <5379B91B.5010306@linux.intel.com>
References: <1400248684-21960-1-git-send-email-jarkko.nikula@linux.intel.com>
 <20140516185429.GR22111@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E270261AB6
 for <alsa-devel@alsa-project.org>; Mon, 19 May 2014 09:56:45 +0200 (CEST)
In-Reply-To: <20140516185429.GR22111@sirena.org.uk>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi

On 05/16/2014 09:54 PM, Mark Brown wrote:
>> +
>> +	/*
>> +	 * ASoC still uses legacy GPIOs so we look both GPIOs using
>> +	 * descriptors here, convert them to numbers and release the
>> +	 * acquired descriptors. Once ASoC switches over to GPIO descriptor
>> +	 * APIs we can pass them directly.
>> +	 */
> You could just add the required support to the framework...  it seems
> quicker and simpler.

Looks like Mika was already proposing it :-)
>> +	hp_desc = gpiod_get_index(card->dev->parent, NULL, 0);
>> +	if (IS_ERR(hp_desc))
>> +		return 0;
> This just eats errors, it's broken for deferred probe.

Indeed yes.
>> +	snd_soc_jack_report(jack, SND_JACK_LINEOUT | SND_JACK_LINEIN,
>> +			    SND_JACK_HEADSET | SND_JACK_LINEOUT |
>> +			    SND_JACK_LINEIN);
> Why is this here?

Hmm.. I'd guess either a left over from a test code or attempt to send a 
wrong initial jack state. I'll check.

>> +static int byt_max98090_remove(struct platform_device *pdev)
>> +{
>> +	struct snd_soc_card *soc_card = platform_get_drvdata(pdev);
>> +	struct byt_max98090_private *drv = snd_soc_card_get_drvdata(soc_card);
>> +
>> +	snd_soc_jack_free_gpios(&drv->jack, ARRAY_SIZE(hs_jack_gpios),
>> +				hs_jack_gpios);
>> +	snd_soc_card_set_drvdata(soc_card, NULL);
>> +	snd_soc_unregister_card(soc_card);
>> +	platform_set_drvdata(pdev, NULL);
> Setting the data to NULL on removal is just a waste of time and is done
> by the core anyway.
>
> You're freeing these in the device level remove path but allocating them
> in the ASoC level probe path.  They should be managed consistently.

Right, thanks for pointing, I was blind to see this.

Your other comments are valid to byt-rt5640 too. I'll update it also 
accordingly.

-- 
Jarkko
