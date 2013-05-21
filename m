From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: How to specify data format if playback/capture
 were different ?
Date: Tue, 21 May 2013 13:58:19 +0200
Message-ID: <519B615B.5070409@metafoo.de>
References: <87ppwl3v71.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-176.synserver.de (smtp-out-176.synserver.de
 [212.40.185.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 77F742619ED
 for <alsa-devel@alsa-project.org>; Tue, 21 May 2013 13:58:41 +0200 (CEST)
In-Reply-To: <87ppwl3v71.wl%kuninori.morimoto.gx@renesas.com>
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

On 05/21/2013 04:47 AM, Kuninori Morimoto wrote:
> 
> Hi Mark, and ALSA ML
> 
> Now, I'm creating ak4554 AD/DA.
> My question is about data format.
> 
> If my understand is correct,
> we can specify cpu/codec deivce data format by using
> 
> 	snd_soc_dai_set_fmt(dai, SND_SOC_DAIFMT_xxx);
> 
> But, ak4554 case, data formats are
>  playback : SND_SOC_DAIFMT_RIGHT_J
>  capture  : SND_SOC_DAIFMT_LEFT_J
> and, it can't exchange this data format.
> 
> CPU driver should set these information for ak4554 when playback/capture.
> 
> Then, how to specify these data format on ALSA SoC ?

You can add two different DAIs one for playback one for capture. Then you
can specify the format for each.

- Lars
