From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Thu, 10 Jan 2008 14:35:29 -0600
Message-ID: <47868191.4000901@freescale.com>
References: <9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>	
	<20080107182853.GA17312@sirena.org.uk>	
	<20080110034919.GI17816@localhost.localdomain>	
	<9e4733910801092141m5d4476d0l1c081307fd5c1969@mail.gmail.com>	
	<1199961015.19903.270.camel@localhost.localdomain>	
	<47863C31.50309@freescale.com>	
	<fa686aa40801100801p3da98eecn44401b17fe652da8@mail.gmail.com>	
	<478641E3.5070404@freescale.com>	
	<9e4733910801101210w5846bb4ds38a603a489ef0522@mail.gmail.com>	
	<47867C80.4050408@freescale.com>
	<fa686aa40801101224p298e60bcheb622324c80690ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id A4CEE24706
	for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2008 21:35:54 +0100 (CET)
In-Reply-To: <fa686aa40801101224p298e60bcheb622324c80690ea@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org, Olof Johansson <olof@lixom.net>, david@gibson.dropbear.id.au
List-Id: alsa-devel@alsa-project.org

Grant Likely wrote:

> Nit: node name should be either i2s@16000 (the mode that it is in), or
> sound@16000 (if you feel that this node encapsulates the concept of a
> sound device enough).

Well, SSI stands for "Synchronous Serial  Interface" (although it's capable of 
asynchronous communication as well).  From the manual:

"The SSI is a full-duplex, serial port that allows the chip to communicate with 
a variety of serial devices.  These serial devices can be standard CODer-DECoder 
(CODECs), Digital Signal Processors (DSPs), microprocessors, peripherals, and 
popular industry audio CODECs that implement the inter-IC sound bus standard 
(I2S) and Intel AC97 standard."

It might an I2S device in this case, but it could be an AC97 device in some 
other case.  It all depends on how the board is wired.  Do we really want to 
change the name of an SOC device based on what it's connected to?

-- 
Timur Tabi
Linux kernel developer at Freescale
