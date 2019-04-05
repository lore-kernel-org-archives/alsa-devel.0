From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: 'modern dailink' transition
Date: Fri, 5 Apr 2019 07:53:11 -0500
Message-ID: <5e1d6877-a8b3-dc87-0841-7f2dc9f93583@linux.intel.com>
References: <21d1e439-7ecd-dd6a-9a43-e66e8db1ac85@linux.intel.com>
 <20190321141242.GE5684@sirena.org.uk>
 <87ftrbivbr.wl-kuninori.morimoto.gx@renesas.com>
 <20190326142057.GD10898@sirena.org.uk>
 <87r2arriww.wl-kuninori.morimoto.gx@renesas.com>
 <87v9ztjodf.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 82733F80792
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2019 14:53:15 +0200 (CEST)
In-Reply-To: <87v9ztjodf.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Morimoto-san,
> I want to ask you about "Multi CPU" support.
> When you can post it ?
> I'm asking because I'm waiting it for a long term,
> and "switch to modern style" is based on it.
> But, v3 is not yet posted, right ?

the multi-cpu part is required for SoundWire, but the directions taken 
to support multi-cpu are changing due to additional developments in the 
MIPI Software WG (contributors only at this point). So the plan for now 
is to develop with single cpu-dai first, and add multi-cpu support at a 
later stage.

In other words, the multi-cpu/multi-link part isn't the most urgent 
priority and it shouldn't impact your work.

>
> If you can post it soon, I can keep waiting.
> But, if it will takes more long term, can I suggest ?
> I think there is few conflict around soc.h and soc-core.c
> between this suggestion and your patch, but not super much.
>
> 	1. I will post "modern style CPU" support,
> 	   it is still "single CPU"
> 	2. All sound card switch to "modern style"
> 	3. remove "legacy style"
>
> I think, your "Multi CPU" support can be implemented
> on top of it.

yes that's fine, this plan works fine for me.

> And, I can continue, like this
>
> 	4. post "allow no Platfrom"
> 	5. remove "snd-soc-dummy Platfrom",
> 	   and "CPU = Platfrom" code from Intel card
> 	   as trial. If it was OK, continue for all card.

there are only 2 or 3 cases of this snd-soc-dummy platform and I'll try 
to remove it as part of the first batch. I don't think it's necessary at 
all.

Thanks!

-Pierre
