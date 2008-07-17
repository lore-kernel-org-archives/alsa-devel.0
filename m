From: dinesh <dinesh.dua@coraltele.com>
Subject: Re: WRITING AN SOC DRIVER WITHOUT DMA
Date: Thu, 17 Jul 2008 11:33:31 +0530
Message-ID: <1216274611.18207.6.camel@dinesh.dua>
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080712083939.15025.31192.stgit@trillian.secretlab.ca>
	<1216199130.749.4.camel@dinesh.dua>
	<8d6898730807160307g4455597ck921d55da8f51455d@mail.gmail.com>
	<1216203206.9723.0.camel@dinesh.dua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.coraltele.com (unknown [122.160.64.235])
	by alsa0.perex.cz (Postfix) with ESMTP id 159E7243B0
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Jul 2008 08:05:56 +0200 (CEST)
In-Reply-To: <1216203206.9723.0.camel@dinesh.dua>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nobin Mathew <nobin.mathew@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, liam.girdwood@wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hi,
I think no one is able to understand my problem, let me break it to low
level.
What i want is that i have a buffer in driver code which is also handled
by some other application i want that this buffer data is to be used for
capture and playback  stream fills data to another buffer which i can
passover to my other application.
If someone can help me please.
Regards,
Dinesh


-----Original Message-----
From: dinesh <dinesh.dua@coraltele.com>
To: Nobin Mathew <nobin.mathew@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org,
alsa-devel@alsa-project.org, liam.girdwood@wolfsonmicro.com
Subject: Re: [alsa-devel] WRITING AN SOC DRIVER WITHOUT DMA
Date: Wed, 16 Jul 2008 15:43:26 +0530


no i am working on powerpc.     MPC8323


-----Original Message-----
From: Nobin Mathew <nobin.mathew@gmail.com>
To: dinesh <dinesh.dua@coraltele.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org,
alsa-devel@alsa-project.org, liam.girdwood@wolfsonmicro.com
Subject: Re: [alsa-devel] WRITING AN SOC DRIVER WITHOUT DMA
Date: Wed, 16 Jul 2008 15:37:54 +0530


Hi dinesh,

If you are working on ARM, see the ARM AACi code, in sound/arm/aaci.c

Thanks
Nobin Mathew.


On 7/16/08, dinesh <dinesh.dua@coraltele.com> wrote:
>
> Hi,
> I am writing a soc sound driver for MPC8323 board linux 2.6.24 in which i
> want to do data transfer to and from device myself using BUFFER DESCRIPTOR
> not with the usual DMA transfer.
> Please help me.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
