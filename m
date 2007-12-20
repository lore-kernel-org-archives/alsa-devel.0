From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Thu, 20 Dec 2007 18:13:31 -0500
Message-ID: <9e4733910712201513t329e2a49j420cb3b4ece5057@mail.gmail.com>
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910712201429q5845e786yb2ecb3ce9c8b7871@mail.gmail.com>
	<476AED87.3090703@freescale.com>
	<9e4733910712201438u2165aa77t8eab91bccb4c5bda@mail.gmail.com>
	<476AEF47.8040802@freescale.com> <476AF061.1030605@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B89F24877
	for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2007 00:13:33 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so107764wag.8
	for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2007 15:13:32 -0800 (PST)
In-Reply-To: <476AF061.1030605@freescale.com>
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
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On 12/20/07, Scott Wood <scottwood@freescale.com> wrote:
> Timur Tabi wrote:
> > Jon Smirl wrote:
> >
> >> mpc5200 does it like this:
> >> of_platform_bus_probe(NULL, NULL, NULL);
> >
> > I think that tells the OF base code to probe everything in the device tree,
> > which is probably overkill.  I think fsl_soc.c covers most of the device tree,
> > but the SSI is not defined in fsl_soc.c.
>
> Not quite; it tells it to use a built-in list of bus matches.  Most of
> which are device_type-based, FWIW.

Here's the default. Using NULL would work.

static struct of_device_id of_default_bus_ids[] = {
        { .type = "soc", },
        { .compatible = "soc", },
        { .type = "spider", },
        { .type = "axon", },
        { .type = "plb5", },
        { .type = "plb4", },
        { .type = "opb", },
        { .type = "ebc", },
        {},
};


>
> -Scott
>


-- 
Jon Smirl
jonsmirl@gmail.com
