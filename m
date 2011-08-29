From: Liam Girdwood <lrg@ti.com>
Subject: Re: ASoC DSP and related status
Date: Mon, 29 Aug 2011 19:12:33 +0100
Message-ID: <4E5BD691.70302@ti.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF04B24A41A8@HQMAIL01.nvidia.com>
	<4E5BD5D7.2020909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id BF2D6244DD
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Aug 2011 20:12:36 +0200 (CEST)
In-Reply-To: <4E5BD5D7.2020909@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Mark Brown
	(broonie@opensource.wolfsonmicro.com)" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 29/08/11 19:09, Girdwood, Liam wrote:
> Hi Stephen,
> 
> On 26/08/11 20:44, Stephen Warren wrote:
>> Liam, Mark,
>>
>> I was recently talking to our internal audio team, extolling the virtues
>> of writing upstreamable drivers for Tegra's audio HW.
>>
>> One of the big unknowns here is how to represent the Tegra DAS and AHUB
>> modules[1] in a standard fashion, and allowing configuration via kcontrols
>> that influence DAPM routing, rather than open-coding and/or hard-coding
>> such policy in the ASoC machine driver.
>>
>> So, my questions are:
>>
>> * What's the status of the ASoC DSP work. I see that some of the base
>> infra-structure has been merged into ASoC's for-next branch, but I think
>> that's just a small portion of the work. Do you have any kind of estimate
>> for when the whole thing will be merged? I don't see recent updates to
>> e.g. Liams' topic/dsp or topic/dsp-upstream branches.
>>
> 
> I have about 10 Dynamic PCM (AKA ASoC DSP) core patches still to make it upstream atm.
> 
> It in progress atm, but will probably slow down for the next 2 weeks since I'll be in California.
> 
> I am aiming to upstream asap, but other things usually take higher priority than upstream at times.

Forgot to add the link. My kernel.org branches above are stable but the development is being done on Gitorious :-

https://gitorious.org/omap-audio/linux-audio

I plan to push a new squashed stable to kernel.org in the next few days.

Liam
