From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Fri, 04 Jan 2008 20:39:54 -0600
Message-ID: <477EEDFA.9010205@freescale.com>
References: <11981089894052-git-send-email-timur@freescale.com>	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>	<9e4733910801010942y47e4cdbfge5e0d3e44ab96760@mail.gmail.com>	<477BAB67.4080003@freescale.com>	<9e4733910801020734n115888cbt86351f67f2311629@mail.gmail.com>	<477D2150.4020506@freescale.com>
	<20080103235156.GE12883@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F45524498
	for <alsa-devel@alsa-project.org>; Sat,  5 Jan 2008 03:38:49 +0100 (CET)
In-Reply-To: <20080103235156.GE12883@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>, Jon Smirl <jonsmirl@gmail.com>, Liam Girdwood <liam.girdwood@wolfsonmicro.com>, alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

David Gibson wrote:

> And what distinction are you drawing between "first" and "second"
> here? 

Oh, that's an easy one:  The CS4270 can work without an I2C or SPI connection, 
but it will never work without an I2S connection.

> Why would the I2S need to scan for codecs?  Wouldn't it be up to the
> codec driver to register with I2S?

Not in ASoC V1.  The codec driver registers with ASoC, but the actual 
connection to other devices (e.g. the I2S driver) is done either in the I2S 
driver or in the fabric driver, depending on your mood.  And that connection 
is done via a pointer to a structure in the codec driver.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
