From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Thu, 20 Dec 2007 17:38:31 -0500
Message-ID: <9e4733910712201438u2165aa77t8eab91bccb4c5bda@mail.gmail.com>
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910712201429q5845e786yb2ecb3ce9c8b7871@mail.gmail.com>
	<476AED87.3090703@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 9957B2485F
	for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2007 23:38:34 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so91637wag.8
	for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2007 14:38:31 -0800 (PST)
In-Reply-To: <476AED87.3090703@freescale.com>
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
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 12/20/07, Timur Tabi <timur@freescale.com> wrote:
> Jon Smirl wrote:
>
> > How is of_platform_bus_probe() supposed to be called? mpc5200/virtex
> > call it with three NULLs. Is it necessary to name all of the buses in
> > a of_device_id? If it's not necessary to list the buses the
> > of_platform_bus_probe() call could be moved to common code.
>
> I added the above code because it is the only way I could get my SSI nodes to be
> probed.  If there's a better way to do it, I'm all ears.  I just copied that
> code from the mpc836x_mds.c platform file.

mpc5200 does it like this:
of_platform_bus_probe(NULL, NULL, NULL);

No need for the ids.


>
> > Are these buses?
> >         { .compatible = "ibm,plb4", },
> >         { .compatible = "ibm,opb", },
> >         { .compatible = "ibm,ebc", },
>
> I have no idea.
>
> > Could of_platform_bus_probe() be simplified? No one uses the first and
> > third parameters.
>
> Maybe, but that's not a discussion for this thread!
>
> --
> Timur Tabi
> Linux kernel developer at Freescale
>


-- 
Jon Smirl
jonsmirl@gmail.com
