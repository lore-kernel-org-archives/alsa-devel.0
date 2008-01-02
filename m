From: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Wed, 2 Jan 2008 09:32:35 -0700
Message-ID: <fa686aa40801020832y373c091dn925bfe64afddcb81@mail.gmail.com>
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801012027p4be16b92r43af773f4e5ae531@mail.gmail.com>
	<477BADF5.9060003@freescale.com>
	<9e4733910801020756p18e12ce8o618b8eae5e7c5a53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by alsa0.perex.cz (Postfix) with ESMTP id 1EF092463B
	for <alsa-devel@alsa-project.org>; Wed,  2 Jan 2008 17:32:36 +0100 (CET)
Received: by an-out-0708.google.com with SMTP id c36so1344529ana.80
	for <alsa-devel@alsa-project.org>; Wed, 02 Jan 2008 08:32:36 -0800 (PST)
In-Reply-To: <9e4733910801020756p18e12ce8o618b8eae5e7c5a53@mail.gmail.com>
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
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On 1/2/08, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 1/2/08, Timur Tabi <timur@freescale.com> wrote:
> mpc8610_hpcd is the harder one to load since it doesn't have a device
> tree entry. What you want to do it match on the compatible field of
> the root node.
>
> static struct of_device_id fabric_of_match[] = {
>         {
>                 .compatible     = "fsl,MPC8610HPCD",
>         },
>         {},
> };
>
> But this doesn't work since the root is the device tree isn't passed
> down into the device probe code. (Could this be fixed?)

The driver can always get the root node.  But better yet, instantiate
the correct fabric device (probably as a platform_device) from the
platform code.  Then the correct fabric driver can probe against it.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
