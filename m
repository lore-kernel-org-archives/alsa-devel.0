From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Thu, 10 Jan 2008 09:39:29 -0600
Message-ID: <47863C31.50309@freescale.com>
References: <9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>	
	<477BAB67.4080003@freescale.com>	
	<9e4733910801020734n115888cbt86351f67f2311629@mail.gmail.com>	
	<477D2150.4020506@freescale.com>	
	<20080103235156.GE12883@localhost.localdomain>	
	<477EEDFA.9010205@freescale.com>	
	<20080106004637.GJ4326@localhost.localdomain>	
	<47824AA3.5070808@freescale.com>
	<20080107182853.GA17312@sirena.org.uk>	
	<20080110034919.GI17816@localhost.localdomain>	
	<9e4733910801092141m5d4476d0l1c081307fd5c1969@mail.gmail.com>
	<1199961015.19903.270.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B81F245E3
	for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2008 16:40:42 +0100 (CET)
In-Reply-To: <1199961015.19903.270.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>, david@gibson.dropbear.id.au, Grant Likely <grant.likely@secretlab.ca>, Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Liam Girdwood wrote:

> I think we are probably looking at submission in the next 8 - 10 weeks.
> Currently most of the core code is complete, however some platforms and
> codecs still need porting.

With that in mind, can I get some kind of consensus from the PPC side as to 
whether this ASoC V1 driver is okay?  I want to get it into 2.6.25.

Keep in mind:

1) ASoC V1 is not PowerPC-friendly, so it's impossible to make an ASoC V1 
PowerPC driver "100% correct".

2) The CS4270 driver does not support I2C nodes in the device tree, so there's 
not point in adding any to the 8610 DTS.

3) Liam and I are working on porting this driver to ASoC V2 and resolving all 
open PPC issue, but that won't be done in time for 2.6.25.

-- 
Timur Tabi
Linux kernel developer at Freescale
