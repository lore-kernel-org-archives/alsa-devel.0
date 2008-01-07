From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Mon, 7 Jan 2008 18:28:54 +0000
Message-ID: <20080107182853.GA17312@sirena.org.uk>
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>
	<9e4733910801010942y47e4cdbfge5e0d3e44ab96760@mail.gmail.com>
	<477BAB67.4080003@freescale.com>
	<9e4733910801020734n115888cbt86351f67f2311629@mail.gmail.com>
	<477D2150.4020506@freescale.com>
	<20080103235156.GE12883@localhost.localdomain>
	<477EEDFA.9010205@freescale.com>
	<20080106004637.GJ4326@localhost.localdomain>
	<47824AA3.5070808@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4158324977
	for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2008 19:29:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <47824AA3.5070808@freescale.com>
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

On Mon, Jan 07, 2008 at 09:52:03AM -0600, Timur Tabi wrote:
> David Gibson wrote:

> > Ok, but couldn't you strucutre your I2S or fabric driver so that it
> > only becomes fully operational once the codec driver has registered
> > with it?

> Not in ASoC V1.  You have to understand, ASoC V1 was designed without any 
> consideration for runtime-bindings and other OF goodies.  All connections 
> between the drivers are static, literally.  In fact, I wouldn't be surprised if 
> some ASoC drivers cannot be compiled as modules.

I'd just like to emphasise this point - ASoC v1 really doesn't
understand the idea that the components of the sound subsystem might be
probed separately.  It's set up to handle bare hardware with everything
being probed from code in the machine/fabric driver.  This makes life
very messy for platforms with something like the device tree.

As has been said, handling this properly is one of the major motivations
behind ASoC v2.

> So all I'm trying to do now is get my driver, with warts and all, into the tree 
> so that I can focus with Liam et al to get a real ASoC V2 up and running.

This is certainly the approach we want to take from an ASoC point of
view.
