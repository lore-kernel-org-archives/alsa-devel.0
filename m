From: Timur Tabi <timur@freescale.com>
Subject: Re: snd_soc_dai_link.init()
Date: Fri, 01 Jun 2007 11:42:42 -0500
Message-ID: <46604C82.5050909@freescale.com>
References: <465DFBF5.9040800@freescale.com>	
	<1180630964.29590.83.camel@a10072.wolfsonmicro.main>	
	<465F0025.4010008@freescale.com>	
	<1180631362.29590.90.camel@a10072.wolfsonmicro.main>	
	<465F56D2.70201@freescale.com>	
	<1180705118.26032.72.camel@localhost.localdomain>
	<1180708880.26032.79.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D8DE246E5
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Jun 2007 18:42:47 +0200 (CEST)
In-Reply-To: <1180708880.26032.79.camel@localhost.localdomain>
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

> This will be pull/clone access only. I've created a separate ppc-dev
> (will show up in a few hours) branch as it will be easier to merge
> changes in without affecting any of the current working dev tree for
> other platforms.

Thanks.  It looks like fixing bug 3135 isn't as trivial as I thought, so it'll take me 
longer than expected.  Even though it makes more sense to pass a snd_soc_dai_link pointer, 
all the current code expects a snd_soc_codec pointer.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
