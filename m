From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: ASoC and a codec that can't be controlled
Date: Fri, 01 Jun 2007 14:36:05 +0100
Message-ID: <1180704965.26032.68.camel@localhost.localdomain>
References: <46531097.5040600@freescale.com>
	<1179934677.12071.30.camel@a10072.wolfsonmicro.main>
	<46574453.10808@freescale.com>
	<1180354247.5816.30.camel@a10072.wolfsonmicro.main>
	<465C78B6.3000001@freescale.com>
	<1180529741.29590.54.camel@a10072.wolfsonmicro.main>
	<465DBE14.5020206@freescale.com>
	<1180631970.29590.102.camel@a10072.wolfsonmicro.main>
	<465F26D3.50903@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id D9C532469F
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Jun 2007 15:36:06 +0200 (CEST)
In-Reply-To: <465F26D3.50903@freescale.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2007-05-31 at 14:49 -0500, Timur Tabi wrote:
> Liam Girdwood wrote:
> 
> > I think the best place to call snd_soc_new_pcms is in the machine
> > driver. This means we don't have to add any pcms that are not used. 
> 
> True, but the machine driver is probed before the codec driver is probed.  So if you 
> really need the codec driver to initialize the I2C bus first, then you've got a problem. 
> Re-arranging the order of probes in soc_probe() is not really a solution.
> 
> So on your baord, why does the I2C interface need to be running before anything else can 
> be probed?

Imho, there is little point in probing or allocating any more resources
until we know the I2C codec probe succeeds. We would just have to free
any resources allocated up to that point. 


> 
> > Yes, the hw_params could return error on anything the machine didn't
> > like. e.g. this could be used to workaround quirks. 
> 
> Would ALSA know to try something else, if a particular combination was rejected?
> 

This would be up to your user space application. In general all common
sample rates and formats are supported by most drivers e.g. 44.1k
stereo. If some combinations are rejected, it's most likely due to
hardware limitations.

Liam
