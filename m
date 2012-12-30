From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] ALSA: pxa2xx: fix ac97 cold reset for
	pxa27x
Date: Sun, 30 Dec 2012 14:12:43 +0100
Message-ID: <87han3smyc.fsf@free.fr>
References: <1356707815-3235-1-git-send-email-mikedunn@newsguy.com>
 <87wqw2rq92.fsf@free.fr> <50DE54D2.9040608@newsguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by alsa0.perex.cz (Postfix) with ESMTP id E82FC26168C
 for <alsa-devel@alsa-project.org>; Sun, 30 Dec 2012 14:12:55 +0100 (CET)
In-Reply-To: <50DE54D2.9040608@newsguy.com> (Mike Dunn's message of "Fri, 28
 Dec 2012 18:26:26 -0800")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mike Dunn <mikedunn@newsguy.com>
Cc: Marek Vasut <marex@denx.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.y.miao@gmail.com>
List-Id: alsa-devel@alsa-project.org

Mike Dunn <mikedunn@newsguy.com> writes:

> On 12/28/2012 10:22 AM, Robert Jarzmik wrote:
>> Mike Dunn <mikedunn@newsguy.com> writes:
>> 
>>> Currently, ac97 reset is broken on PXA27x.  Through trial-and-error (the pxa270
>>> developer's manual is mostly incoherent on the topic of ac97 reset), I fixed it
>>> by setting the WARM_RST bit in the GCR register at the end of the cold reset,
>>> and then skipping the warm reset if the link is already up and running.
>>>
>>> It appears that setting the WARM_RST bit is a necessary final step during cold
>>> reset.  I think that the PXA25x and PXA3xx may currently be working correctly
>>> because WARM_RST is set within the warm reset routine, and the codec drivers
>>> always follow a cold reset with a warm reset during their initialization. so
>>> this combination effectively completes a cold reset.  This doesn't work on the
>>> PXA27x because its warm reset routine contains additional code for working
>>> around a hardware bug in the warm reset sequence, which causes the reset
>>> sequence to fail.  I only have a PXA27x platform for testing, so this patch only
>>> affects the PXA27x.
>> If you've tested that and if it work, that's great news. I'll test it also to
>> crosscheck.
>
>
> Thanks.  I'd really appreciate that.  Yes, it works for me.

Ok, I tested it, through a suspend/resume cycle with a music played, and it
works, and the patch looks correct to me. So :

Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>
Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

-- 
Robert
