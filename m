From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: ASoC : question about custom rate
Date: Tue, 09 Sep 2014 12:44:40 +0200
Message-ID: <540EDA18.5070309@metafoo.de>
References: <540EBDB8.20507@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-180.synserver.de (smtp-out-181.synserver.de
 [212.40.185.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 50841265335
 for <alsa-devel@alsa-project.org>; Tue,  9 Sep 2014 12:44:38 +0200 (CEST)
In-Reply-To: <540EBDB8.20507@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Flax <flatmax@flatmax.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 09/09/2014 10:43 AM, Matt Flax wrote:
> Hi there,
>
> I have an ASIC running on an ASoC with a custom rate @ 18750 Hz.
> I would like ALSA to report the correct rate.
>
> If I do nothing, then the following reports 16000 Hz :
> cat /proc/asound/card0/pcm0c/sub0/hw_params
>
> I have verified that the hardware is running at the expected 18750 Hz.
> I am wondering what/where is the correct place to setup the actual rate ?
>
> I am trying to set the rates at startup like so but ALSA will not work with
> the driver when I do this :
>
> static int implant_startup(struct snd_pcm_substream *substream, struct
> snd_soc_dai *dai)
> {
>      snd_pcm_hw_constraint_minmax(substream->runtime,
> SNDRV_PCM_HW_PARAM_RATE, 18750, 18750);


This is the correct approach. But it is quite likely that your I2S driver 
will set additional constraints (e.g. just 16k, 32k, etc.) that results in 
an empty list for the rate constraints. If the I2S driver works fine maybe 
change the constraints to only set a minimum and maximum rate instead of 
specific rates.

- Lars
