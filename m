From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: soc-dsp questions
Date: Tue, 8 Nov 2011 20:20:05 +0000
Message-ID: <CABS+qY3kpJjWtEOP4RG=jv_OzD2RVvJqPnJzO09yzDypk6pS8A@mail.gmail.com>
References: <1320740555.32205.144.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog116.obsmtp.com (na3sys009aog116.obsmtp.com
	[74.125.149.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 422ED103975
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2011 21:20:08 +0100 (CET)
Received: by mail-gy0-f180.google.com with SMTP id 20so1566683gyh.25
	for <alsa-devel@alsa-project.org>; Tue, 08 Nov 2011 12:20:06 -0800 (PST)
In-Reply-To: <1320740555.32205.144.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: alsa <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Pierre-louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Vinod,

Sorry, just about to travel again so my replies might be delayed.

On 8 November 2011 08:22, Vinod Koul <vinod.koul@linux.intel.com> wrote:
> Hey Liam,
>
> I had few questions on your dsp work, would be great if you could answer
> them and help me in understanding the approach.
>
> - Is it possible to have one FE connected to multiple BEs (voice FE to
> modem and headset bBE), if so how?

yes, the DAPM graph is extended to link the AIF of each FE PCM to each
supported BE DAI (please look at omap-abe-dsp.c).

This allows (via kcontrol settings) the routing between FE PCMs and BE
DAIs to be controlled at stream runtime. The Dynamic PCM core takes
care of all the PCM ops and hw_params for each DAI (and re-writes any
params that require changes for a particular DAI).

> - SND_SOC_DAI_LINK_OPT_HOST, what does this mean, does not seem to be
> used anywhere in core?

It's historical and can be removed.

> - Why comment need dummy codec for some BEs like BT etc, when soc-core
> has already one?

ditto.

> - any reason why be haves a number associated with a BE, than usual
> convention of referring things by string name in asoc?
>

Sorry, not sure what part do you mean here ?

> and last one, when would this be merged to mainline, 3.3?
>

Ah yes, the important question ;) I've been traveling the last 3
months or so and have not had a chance to finish the upstreaming. I
have one more trip planned this year and my intention is 3.3 when I
return.

Regards

Liam
