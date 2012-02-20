From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: Direct use of the DMA buffer?
Date: Mon, 20 Feb 2012 10:25:57 +0100
Message-ID: <4F4211A5.7050104@ivitera.com>
References: <4F4181AF.1060303@ivitera.com> <4F420017.70508@ladisch.de>
	<4F420694.6040902@ivitera.com> <4F4210A6.8010902@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (static-84-242-75-189.net.upcbroadband.cz
	[84.242.75.189]) by alsa0.perex.cz (Postfix) with ESMTP id 98A79246EE
	for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2012 10:25:59 +0100 (CET)
In-Reply-To: <4F4210A6.8010902@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dne 20.2.2012 10:21, Jaroslav Kysela napsal(a):
>>
>> Clemens, thanks a lot for the information. How does it work when the
>> alsa-lib chain contains plugins, such as plug, rate, etc.? I would
>> assume the application circumvents these.
> 
> Nope. The mmap commit mechanism was introduced to keep the plugin
> interface functional. The direct mmap access to the DMA buffer is only
> applied for the direct hw: devices. If a plugin is used inside alsa-lib,
> the application talks to the plugin chain (it means that an intermediate
> buffer for samples can be allocated to let things working).
> 

Jaroslav, thanks a lot for the clarification.

Pavel.
