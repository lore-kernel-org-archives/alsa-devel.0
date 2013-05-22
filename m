From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: How to specify data format if playback/capture
 were different ?
Date: Wed, 22 May 2013 10:43:02 +0200
Message-ID: <519C8516.9050307@metafoo.de>
References: <87ppwl3v71.wl%kuninori.morimoto.gx@renesas.com>	<519B615B.5070409@metafoo.de>	<87y5b7ltcd.wl%kuninori.morimoto.gx@renesas.com>
 <87wqqrlswy.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-017.synserver.de (smtp-out-019.synserver.de
 [212.40.185.19])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BECC260306
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2013 10:43:17 +0200 (CEST)
In-Reply-To: <87wqqrlswy.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 05/22/2013 03:12 AM, Kuninori Morimoto wrote:
> 
> Hi again
> 
>>>> But, ak4554 case, data formats are
>>>>  playback : SND_SOC_DAIFMT_RIGHT_J
>>>>  capture  : SND_SOC_DAIFMT_LEFT_J
>>>> and, it can't exchange this data format.
>>>>
>>>> CPU driver should set these information for ak4554 when playback/capture.
>>>>
>>>> Then, how to specify these data format on ALSA SoC ?
>>>
>>> You can add two different DAIs one for playback one for capture. Then you
>>> can specify the format for each.
> 
> 1 more question.
> 
> On ak4554 side driver, I guess, it will be
> 
> struct snd_soc_dai_driver ak4554_playback_dai = {
> 	.name = "ak4554-playback",
> 	.playback = {
> 		...
> 	},
> }
> 
> struct snd_soc_dai_driver ak4554_captrure_dai = {
> 	.name = "ak4554-captrure",
> 	.capture = {
> 		...
> 	},
> };

You'll want to put both DAIs into an array which you can pass to
snd_soc_register_codec, but otherwise it looks ok.

> 
> But, ak4554 needs .symmetric_rates between playback <--> capture.
> Is it possible ?
> Or, am I misunderstanding ?

Yes, that won't work, you'd have to implement this by hand.

- Lars
