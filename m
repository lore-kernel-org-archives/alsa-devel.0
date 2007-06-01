From: Timur Tabi <timur@freescale.com>
Subject: Re: ASoC and a codec that can't be controlled
Date: Fri, 01 Jun 2007 08:45:01 -0500
Message-ID: <466022DD.8010200@freescale.com>
References: <46531097.5040600@freescale.com>	
	<1179934677.12071.30.camel@a10072.wolfsonmicro.main>	
	<46574453.10808@freescale.com>	
	<1180354247.5816.30.camel@a10072.wolfsonmicro.main>	
	<465C78B6.3000001@freescale.com>	
	<1180529741.29590.54.camel@a10072.wolfsonmicro.main>	
	<465DBE14.5020206@freescale.com>	
	<1180631970.29590.102.camel@a10072.wolfsonmicro.main>	
	<465F26D3.50903@freescale.com>
	<1180704965.26032.68.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 07151246AB
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Jun 2007 15:44:43 +0200 (CEST)
In-Reply-To: <1180704965.26032.68.camel@localhost.localdomain>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Liam Girdwood wrote:

> Imho, there is little point in probing or allocating any more resources
> until we know the I2C codec probe succeeds. We would just have to free
> any resources allocated up to that point. 

True, but if the I2C probe fails, then I would think that the whole system is shot, so this sounds like a very unlikely situation.  If you changed the code to clean up after an I2C failure, you could make the whole thing more modular, including eliminating the call to snd_soc_new() in the codec driver.

Since ASoC divides everything into four more-or-less independent drivers, it makes sense that it should be able to handle a situation where one of those drivers just fails to load.
