From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Thoughts on ASOC v2 driver architecture
Date: Mon, 16 Jun 2008 10:32:37 -0400
Message-ID: <9e4733910806160732h2b1b42f3s1afde73ac8f92026@mail.gmail.com>
References: <9e4733910806151110y13f171dct3948a1555608c0ee@mail.gmail.com>
	<1213612755.6599.51.camel@odin>
	<9e4733910806160626h12525bb5ydfb61acd62ef3f09@mail.gmail.com>
	<4856776B.7040300@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.155])
	by alsa0.perex.cz (Postfix) with ESMTP id EC3A52432F
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jun 2008 16:32:38 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 36so423943yxh.2
	for <alsa-devel@alsa-project.org>; Mon, 16 Jun 2008 07:32:37 -0700 (PDT)
In-Reply-To: <4856776B.7040300@freescale.com>
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
Cc: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 6/16/08, Timur Tabi <timur@freescale.com> wrote:
> Jon Smirl wrote:
>
>
> > I'd like for the fabric driver to be dynamically loaded by the device
> tree.
> >
>
>  You have a PPC problem, not an ASoC problem.  You're trying to use the
> device tree to load a device without specifying a specific node.  This is
> particularly difficult with device trees because once a driver has claimed a
> node via a probe, that node isn't probed again.  So you can't use any I2S,
> DMA, or codec nodes.
>
>
> > The root of my problem is that I want to handle my four board variants
> > with a single kernel. So when the kernel loads, I need to figure out
> > which board specific code to load. In the current ASOC design it is
> > assumed that this code is permanently linked in as a platform driver.
> >
>
>  Not with ASoC V2.  I load my fabric driver as a regular module.  It also
> doesn't matter what order I load the drivers in.  Once the fourth driver is
> loaded, ASoC does its magic and creates a sound card (or two) for me.
>
>  So do what I did: deal with the limitations of ASoC V1 as best you can, and
> port your driver to ASoC V2.

I'm already using ASOC V2.

I think I've come up with a solution. Push all of that generic setup
code in mpc8610_hpcd into fsl_ssi. Leave only the platform specific
support in mpc8610_hpcd. Now turn mpc8610_hpcd into a loadable module
but leave it as a platform_driver. During the fsl_ssi probe function
extract the platform name from the device tree and use it to
dynamically load the mpc8610_hpcd driver.


-- 
Jon Smirl
jonsmirl@gmail.com
