From: Timur Tabi <timur@freescale.com>
Subject: Re: SoC sound support for imx27
Date: Thu, 24 Apr 2008 09:31:29 -0500
Message-ID: <481099C1.40600@freescale.com>
References: <200804231654.44526.jbe@pengutronix.de>	
	<1208964986.3286.62.camel@localhost.localdomain>	
	<200804241319.40134.jbe@pengutronix.de>
	<1209047171.3286.106.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id CA2481037EC
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Apr 2008 16:31:33 +0200 (CEST)
In-Reply-To: <1209047171.3286.106.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Juergen Beisert <jbe@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

Liam Girdwood wrote:

>> So now we have a few (nearly working) implementations. What should be used? 
>> The implementations from soc/imx or from soc/fsl?
>>
> 
> imx for ARM, fsl for PPC.

Whatever driver is in fsl/ should be for PPC and ARM.  The drivers in there
should be updated to support i.MX.  Who's going to make that change?  Well, I
can help, but I don't know enough about i.MX to do it all.

-- 
Timur Tabi
Linux kernel developer at Freescale
