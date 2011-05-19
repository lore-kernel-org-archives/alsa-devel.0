From: Liam Girdwood <lrg@ti.com>
Subject: Re: ASoC "long name" generation,
 without enumerating all machine_is_xxx() calls
Date: Thu, 19 May 2011 12:22:45 +0100
Message-ID: <4DD4FD85.8070507@ti.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0498A47AA7@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F5CC103809
	for <alsa-devel@alsa-project.org>;
	Thu, 19 May 2011 13:22:53 +0200 (CEST)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0498A47AA7@HQMAIL01.nvidia.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 18/05/11 21:07, Stephen Warren wrote:
> Liam,
> 
> I have a question about your recent "long name" change:
> 
> commit 22de71ba03311cdc1063757c50a1488cb90a1fca
> ASoC: core - allow ASoC more flexible machine name
> 
> The question is: How to generate the long name. The only example I could
> find of this was:
> 
> +	if (machine_is_omap_4430sdp())
> +		snd_soc_sdp4430.name = "SDP4430";
> +	else if (machine_is_omap4_panda())
> +		snd_soc_sdp4430.name = "Panda"
> 
> (from http://patchwork.ozlabs.org/patch/67831/)
>

This is up to you. :)  In our case the Panda and SPD4430 are different physical machines that share roughly 95% the same audio architecture and we use the extra naming here just to tell alsa userspace that we have different flavours of the same card. i.e. The panda does not have the Handsfree speaker so we have to use a different alsa init file and/or UCM configuration.

> But, I don't really want to call machine_is_xxx for every single machine
> the tegra-wm8903 driver can support; upstream there are 5 so far, and
> more similar derivatives downstream. 

We are only doing this as both machines are a little different wrt userspace.

That said, I suppose the code is
> already switching on machine_is_xxx to pick the correct dapm_route map,
> so I could just assign the name there, and fold multiple identical
> machines onto a single name.
> 
> It looks like the kernel doesn't have any kind of machine_name() API;
> the code in e.g. arch/arm/kernel/setup.c that prints the machine name at
> boot stores it in a static that's only exposed through syss/similar file.
> 
> Thanks for any hints!
>

Ok, this sounds like a good idea to add a small call here to get the machine name. It would certainly simplify the above code where there are differences between machines that use the same driver.

Liam  
