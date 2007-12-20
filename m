From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Thu, 20 Dec 2007 17:29:23 -0500
Message-ID: <9e4733910712201429q5845e786yb2ecb3ce9c8b7871@mail.gmail.com>
References: <11981089894052-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by alsa0.perex.cz (Postfix) with ESMTP id AC41B243B8
	for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2007 23:29:24 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so87186wag.8
	for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2007 14:29:23 -0800 (PST)
In-Reply-To: <11981089894052-git-send-email-timur@freescale.com>
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

On 12/19/07, Timur Tabi <timur@freescale.com> wrote:

> +static struct of_device_id mpc8610_ids[] = {
> +       { .type = "soc", },
> +       {}
> +};
> +
> +static int __init mpc8610_declare_of_platform_devices(void)
> +{
> +       if (!machine_is(mpc86xx_hpcd))
> +               return 0;
> +
> +       /* Without this call, the SSI device driver won't get probed. */
> +       of_platform_bus_probe(NULL, mpc8610_ids, NULL);
> +
> +       return 0;
> +}
> +device_initcall(mpc8610_declare_of_platform_devices);

How is of_platform_bus_probe() supposed to be called? mpc5200/virtex
call it with three NULLs. Is it necessary to name all of the buses in
a of_device_id? If it's not necessary to list the buses the
of_platform_bus_probe() call could be moved to common code.

Are these buses?
        { .compatible = "ibm,plb4", },
        { .compatible = "ibm,opb", },
        { .compatible = "ibm,ebc", },

Could of_platform_bus_probe() be simplified? No one uses the first and
third parameters.

-- 
Jon Smirl
jonsmirl@gmail.com
