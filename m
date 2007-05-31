From: Timur Tabi <timur@freescale.com>
Subject: Re: ASoC and a codec that can't be controlled
Date: Thu, 31 May 2007 14:49:39 -0500
Message-ID: <465F26D3.50903@freescale.com>
References: <46531097.5040600@freescale.com>	
	<1179934677.12071.30.camel@a10072.wolfsonmicro.main>	
	<46574453.10808@freescale.com>	
	<1180354247.5816.30.camel@a10072.wolfsonmicro.main>	
	<465C78B6.3000001@freescale.com>	
	<1180529741.29590.54.camel@a10072.wolfsonmicro.main>	
	<465DBE14.5020206@freescale.com>
	<1180631970.29590.102.camel@a10072.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id CBF43243DE
	for <alsa-devel@alsa-project.org>;
	Thu, 31 May 2007 21:49:43 +0200 (CEST)
In-Reply-To: <1180631970.29590.102.camel@a10072.wolfsonmicro.main>
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

> I think the best place to call snd_soc_new_pcms is in the machine
> driver. This means we don't have to add any pcms that are not used. 

True, but the machine driver is probed before the codec driver is probed.  So if you 
really need the codec driver to initialize the I2C bus first, then you've got a problem. 
Re-arranging the order of probes in soc_probe() is not really a solution.

So on your baord, why does the I2C interface need to be running before anything else can 
be probed?

> Yes, the hw_params could return error on anything the machine didn't
> like. e.g. this could be used to workaround quirks. 

Would ALSA know to try something else, if a particular combination was rejected?



-- 
Timur Tabi
Linux Kernel Developer @ Freescale
