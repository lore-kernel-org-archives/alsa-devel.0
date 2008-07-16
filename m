From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Re: WRITING AN SOC DRIVER WITHOUT DMA
Date: Wed, 16 Jul 2008 15:37:54 +0530
Message-ID: <8d6898730807160307g4455597ck921d55da8f51455d@mail.gmail.com>
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080712083939.15025.31192.stgit@trillian.secretlab.ca>
	<1216199130.749.4.camel@dinesh.dua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.233])
	by alsa0.perex.cz (Postfix) with ESMTP id E78122443A
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Jul 2008 12:07:56 +0200 (CEST)
Received: by wx-out-0506.google.com with SMTP id h30so3085154wxd.23
	for <alsa-devel@alsa-project.org>; Wed, 16 Jul 2008 03:07:55 -0700 (PDT)
In-Reply-To: <1216199130.749.4.camel@dinesh.dua>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: dinesh <dinesh.dua@coraltele.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, liam.girdwood@wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

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
