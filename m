From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC] ASoC: soc-pcm: Add support for
	unidirectional dai links
Date: Thu, 29 Aug 2013 12:53:41 +0200
Message-ID: <521F2835.4060109@metafoo.de>
References: <1377752099-21373-1-git-send-email-festevam@gmail.com>
 <20130829104742.GU10783@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-004.synserver.de (smtp-out-004.synserver.de
 [212.40.185.4]) by alsa0.perex.cz (Postfix) with ESMTP id DF126261706
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2013 12:52:09 +0200 (CEST)
In-Reply-To: <20130829104742.GU10783@sirena.org.uk>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@linaro.org, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 08/29/2013 12:47 PM, Mark Brown wrote:
> On Thu, Aug 29, 2013 at 01:54:59AM -0300, Fabio Estevam wrote:
> 
>> @@ -105,11 +105,13 @@ static struct snd_soc_dai_link mxs_sgtl5000_dai[] = {
>>  		.stream_name	= "HiFi Playback",
>>  		.codec_dai_name	= "sgtl5000",
>>  		.ops		= &mxs_sgtl5000_hifi_ops,
>> +		.playback_only	= true,
>>  	}, {
>>  		.name		= "HiFi Rx",
>>  		.stream_name	= "HiFi Capture",
>>  		.codec_dai_name	= "sgtl5000",
>>  		.ops		= &mxs_sgtl5000_hifi_ops,
>> +		.capture_only	= true,
>>  	},
> 
> This doesn't make much sense to me - it should be possible to tell from
> the capabilities of the two DAIs on the link if they support both
> playback and capture.  Or has the board wired up two bidirectional DAIs
> on each link for some reason?
> 

The MXS DAIs are unidirectional, but the direction can be configured at
runtime. The alternative here is to specify the direction at driver probe
time instead of in the dai_link.
