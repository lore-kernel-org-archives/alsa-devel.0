From: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Thu, 3 Jan 2008 11:13:57 -0700
Message-ID: <fa686aa40801031013w54b15286u8e6e2561219422f2@mail.gmail.com>
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>
	<9e4733910801010942y47e4cdbfge5e0d3e44ab96760@mail.gmail.com>
	<477BAB67.4080003@freescale.com>
	<9e4733910801020734n115888cbt86351f67f2311629@mail.gmail.com>
	<477D2150.4020506@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 1128D103859
	for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2008 19:13:58 +0100 (CET)
Received: by an-out-0708.google.com with SMTP id c36so1452732ana.80
	for <alsa-devel@alsa-project.org>; Thu, 03 Jan 2008 10:13:57 -0800 (PST)
In-Reply-To: <477D2150.4020506@freescale.com>
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
Cc: Liam Girdwood <liam.girdwood@wolfsonmicro.com>, alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

On 1/3/08, Timur Tabi <timur@freescale.com> wrote:
> Jon Smirl wrote:
> > Don't we want to follow the device tree policy of putting the device
> > on the controlling bus and then link it to the data bus?
>
> Normally, that sounds like a good idea, but the cs4270 is an I2S device first,
> and an I2C device second.  I need to be able to find that codec from the I2S
> node.  My I2S driver would not know to scan all I2C devices to find the codec.

The device tree is a description of the hardware; not software.  It's
not a good idea to break with convention due to current driver
architecture.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
