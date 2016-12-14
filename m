From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: bytcr_rt5640: fallback
 mechanism if MCLK is not enabled
Date: Wed, 14 Dec 2016 16:08:45 -0600
Message-ID: <a565e81d-1488-df9f-5999-283c6d5d9789@linux.intel.com>
References: <1481654490-31846-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <20161214131948.e3gqnbauv7762jrf@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id C94C0267064
 for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2016 23:09:06 +0100 (CET)
In-Reply-To: <20161214131948.e3gqnbauv7762jrf@sirena.org.uk>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 12/14/16 7:19 AM, Mark Brown wrote:
> On Tue, Dec 13, 2016 at 12:41:30PM -0600, Pierre-Louis Bossart wrote:
>> Commit df1a2776a795 ("ASoC: Intel: bytcr_rt5640: add MCLK support")
>> was merged but the corresponding clock framework patches have not,
>> after being bumped from audio to clock to x86 domains. The missing
>> clock-related patches result in a regression starting with 4.9 with
>> the audio card not being created.
>
> When I asked about this previously you said that this only affected new
> boards?

see 
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-August/111865.html
all boards will be affected but newer boards never worked before. Only 
older BYT-T are affected by a regression. And given the hair-splitting 
debates on what constitutes pdata or what the locations of the PMC files 
should be I am no longer expecting a quick resolution. At this rate 
it'll take 9 months to program 2 registers.

>
>>  			dev_err(&pdev->dev,
>>  				"Failed to get MCLK from pmc_plt_clk_3: %ld\n",
>>  				PTR_ERR(priv->mclk));
>> -			return PTR_ERR(priv->mclk);
>> +
>> +			/* Fall back to bitclock only */
>> +			byt_rt5640_quirk &= ~BYT_RT5640_MCLK_EN;
>
> This is broken for probe deferral, I'd expect this to be explicitly
> checking for a no clock mapped error code (probably -ENOENT) rather than
> just ignoring all errors.

I don't understand the probe deferral concept here. Are you saying fall 
back to the bit clock mode if the status is -ENOENT and fail otherwise?
