From: Liam Girdwood <lrg@ti.com>
Subject: Re: asoc: no valid backend routes for PCM: SDP4430
	Media
Date: Wed, 8 Jun 2011 15:22:45 +0100
Message-ID: <4DEF85B5.10808@ti.com>
References: <307164.60382.qm@web161713.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 2BA77103929
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Jun 2011 16:22:52 +0200 (CEST)
In-Reply-To: <307164.60382.qm@web161713.mail.bf1.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: hong zhang <henryzhang62@yahoo.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 07/06/11 20:59, hong zhang wrote:
> Liam,
> 
> Actually, I could not prove DMIC on OMAP4 blaze board is working in both kernel 2.6.35 and 2.6.38 using arecord and gstreamer-alsa.
> 
> In 2.6.35, arecord returns 44 bytes with read error
> In 2.6.38, arecord collects native data.
> 
> Gstreamer-alsa could not get voice after turning off analog captures using amixer. 
> 
> Any information regarding DMIC on OMAP4? I see people send DMIC patch to 2.6.38.
> 

DMIC works on OMAP4, can you try my branch :-

https://gitorious.org/omap-audio/linux-audio/commits/lrg/topic/omap-asoc-next-3.1

Liam
