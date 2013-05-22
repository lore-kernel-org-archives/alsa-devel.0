From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: How to specify data format if playback/capture
 were different ?
Date: Wed, 22 May 2013 13:41:09 +0200
Message-ID: <519CAED5.3070201@metafoo.de>
References: <87ppwl3v71.wl%kuninori.morimoto.gx@renesas.com>
 <519B615B.5070409@metafoo.de>
 <87y5b7ltcd.wl%kuninori.morimoto.gx@renesas.com>
 <87wqqrlswy.wl%kuninori.morimoto.gx@renesas.com>
 <519C8516.9050307@metafoo.de>
 <87fvxfl7hx.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-036.synserver.de (smtp-out-036.synserver.de
 [212.40.185.36])
 by alsa0.perex.cz (Postfix) with ESMTP id C45BB260307
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2013 13:41:25 +0200 (CEST)
In-Reply-To: <87fvxfl7hx.wl%kuninori.morimoto.gx@renesas.com>
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

On 05/22/2013 10:54 AM, Kuninori Morimoto wrote:
> 
> Hi Lars
> 
>>> struct snd_soc_dai_driver ak4554_playback_dai = {
>>> 	.name = "ak4554-playback",
>>> 	.playback = {
>>> 		...
>>> 	},
>>> }
>>>
>>> struct snd_soc_dai_driver ak4554_captrure_dai = {
>>> 	.name = "ak4554-captrure",
>>> 	.capture = {
>>> 		...
>>> 	},
>>> };
>>
>> You'll want to put both DAIs into an array which you can pass to
>> snd_soc_register_codec, but otherwise it looks ok.
>>
>>>
>>> But, ak4554 needs .symmetric_rates between playback <--> capture.
>>> Is it possible ?
>>> Or, am I misunderstanding ?
>>
>> Yes, that won't work, you'd have to implement this by hand.
> 
> OK, I understand, thank you.
> 
> But do you know why snd_soc_dai_set_fmt() doesn't support
> "setting for playback/capture only" ?
> Historical reason or system reason ?

I think it is rather unusual that you want or need to set different formats
for capture and playback. Especially when BCLK and LRCLK are shared. That's
probably why it isn't supported yet.

- Lars
