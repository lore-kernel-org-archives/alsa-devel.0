From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 3/3] ALSA: ASoC: cs4271: add optional soft
	reset workaround
Date: Wed, 05 Dec 2012 14:59:37 +0100
Message-ID: <50BF5349.2040901@gmail.com>
References: <1354271337-15113-1-git-send-email-zonque@gmail.com>
 <1354271337-15113-3-git-send-email-zonque@gmail.com>
 <20121202040200.GI17981@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
 [209.85.212.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 266B32650D0
 for <alsa-devel@alsa-project.org>; Wed,  5 Dec 2012 14:59:40 +0100 (CET)
Received: by mail-wi0-f169.google.com with SMTP id hq12so1790313wib.2
 for <alsa-devel@alsa-project.org>; Wed, 05 Dec 2012 05:59:39 -0800 (PST)
In-Reply-To: <20121202040200.GI17981@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Alexander Sverdlin <subaparts@yandex.ru>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On 02.12.2012 05:02, Mark Brown wrote:
> On Fri, Nov 30, 2012 at 11:28:57AM +0100, Daniel Mack wrote:
> 
>> +	Note that this is not needed in case the clocks are stable
>> +	throughout the entire runtime of the codec.
> 
> That's really quite rare for embeded systems, though - normally at least
> the LRCLK is going to be enabled only when there's audio. 

I agree, but I don't know which system the original driver was written
for. As it seems to work there, I didn't want to unconditionally
introduce this new reset command.

>> +static int cs4271_startup(struct snd_pcm_substream *subs,
>> +			   struct snd_soc_dai *codec_dai)
>> +{
>> +	int ret;
>> +	struct snd_soc_codec *codec = codec_dai->codec;
>> +	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
>> +
>> +	if (!cs4271->enable_soft_reset)
>> +		return 0;
>> +
>> +	/*
>> +	 * Put the codec in soft reset and back again in case it's not
>> +	 * currently streaming data. This way of bringing the codec in
>> +	 * sync to the current clocks is not explicitly documented in
>> +	 * the data sheet, but it seems to work fine.
>> +	 */
> 
> Since startup() is called before hw_params() you might well find even an
> active LRCLK is going to change underneath the driver here...

Hmm ok, so you're saying this quirk should go in hwparams() then?



Thanks,
Daniel
