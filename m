From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Mon, 7 Jan 2008 14:24:30 +0000
Message-ID: <20080107142429.GB6497@sirena.org.uk>
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>
	<9e4733910801010942y47e4cdbfge5e0d3e44ab96760@mail.gmail.com>
	<477BAB67.4080003@freescale.com>
	<9e4733910801020734n115888cbt86351f67f2311629@mail.gmail.com>
	<477D2150.4020506@freescale.com>
	<20080103235156.GE12883@localhost.localdomain>
	<477EEDFA.9010205@freescale.com>
	<20080106004637.GJ4326@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A83AB2490D
	for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2008 15:24:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080106004637.GJ4326@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Liam Girdwood <liam.girdwood@wolfsonmicro.com>, alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 06, 2008 at 11:46:37AM +1100, David Gibson wrote:

> Ok, but couldn't you strucutre your I2S or fabric driver so that it
> only becomes fully operational once the codec driver has registered
> with it?

That's what ASoC v2 is doing, more or less (the core brings things on
line rather than drivers doing it).  For v1 so long as it doesn't cause
any problems in practice I'm not sure I'd worry about it too much.
