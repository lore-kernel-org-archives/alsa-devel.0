From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: Separate dma driver for cpu_dais
Date: Thu, 18 Feb 2010 15:12:53 +0900
Message-ID: <4B7CDA65.6000301@samsung.com>
References: <1b68c6791002161839q705df04cmeda046736948c614@mail.gmail.com>
	<4B7B9387.1070506@samsung.com> <20100217105202.GB31765@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by alsa0.perex.cz (Postfix) with ESMTP id 8791F1038B2
	for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2010 07:12:57 +0100 (CET)
Received: from epmmp1 (mailout2.samsung.com [203.254.224.25])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KY0005IGX9H23@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Thu, 18 Feb 2010 15:12:54 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KY000B3SX9HZL@mmp1.samsung.com> for
	alsa-devel@alsa-project.org; Thu, 18 Feb 2010 15:12:53 +0900 (KST)
In-reply-to: <20100217105202.GB31765@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, jassi brar <jassisinghbrar@gmail.com>, kyungmin.park@samsung.com
List-Id: alsa-devel@alsa-project.org

On 2/17/2010 7:52 PM, Mark Brown wrote:
> On Wed, Feb 17, 2010 at 03:58:15PM +0900, Joonyoung Shim wrote:
> 
>> At the ASoC, is there a situation to share the dai(cpu or codec)?
>> If the dai is shared, i just think the ASoC core cannot support it.
> 
> I'm not sure what you mean by "sharing" the DAI - sharing between what?
> I think you mean using the same DAI in multiple dai_links but I'm not
> 100% sure?
> 

Yes, it is what i mean.

>> There is the case at the S5PC1XX, it supports the hardware mixing by
>> using two tx fifo. First Jassi implemented codes using each other cpu
>> dai as Jassi says at the above for the hardware mixing, but it should
>> share codec_dai and need some modification of ASoC core.
> 
> What modifications are you looking for here?  ASoC doesn't make any

Thing modified is the active counting of DAI(struct snd_soc_dai) and pcm
stream(struct snd_soc_pcm_stream). Also, startup() in ops functions of 
same DAI shouldn't be called several times when the device using same 
DAI is opened.

> effort to avoid reuse of DAIs in multiple links - it doesn't actively do
> anything to help here but equally well it's not supposed to get in the
> way.
> 
> The only thing I can think of off the top of my head that would cause
> actual problems is that the DAPM events for stream stop/start in the
> CODEC might not be doing reference counting, I'd need to check.  Other

Ah, i didn't think about this. Right, this should be considered too.

> than that there's a bunch of things that could make use cases like this
> nicer like providing a way of bundling links that share signals together
> and providing callbacks when things start and stop (so shared clocking
> can be turned on and off, for example) but these should be things that
> could be open coded in individual drivers.
> 

Sorry, what does "be open coded" mean?
