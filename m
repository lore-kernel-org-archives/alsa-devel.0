From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Thu, 03 Jan 2008 12:16:19 -0600
Message-ID: <477D2673.5090203@freescale.com>
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801012027p4be16b92r43af773f4e5ae531@mail.gmail.com>
	<477BADF5.9060003@freescale.com>
	<fa686aa40801020828u5103d09cn2aa5eab7dda2fcff@mail.gmail.com>
	<20080102184957.GB2007@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id F2B2110383B
	for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2008 19:15:10 +0100 (CET)
In-Reply-To: <20080102184957.GB2007@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>, Timur Tabi <timur@freescale.com>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:

> The machine support code (fabric driver in PowerPC terms, I think?)
> tells the core how everything is connected together by registering
> devices representing the links (eg, I2S) between the codecs, CPU and
> other devices.  The ASoC core is then responsible for ensuring that all
> the required components are present before it registers with the ALSA
> core.

I'm no expert on this, but I think from the PowerPC point-of-view, the *ideal* 
situation would be if the ASoC fabric driver were generic, maybe even part of 
ASoC itself, and everything it needed could be obtained from the device tree.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
