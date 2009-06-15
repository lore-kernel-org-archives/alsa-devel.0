From: "chaithrika" <chaithrika@ti.com>
Subject: Re: [PATCH v4 3/4] ARM: DaVinci: ASoC: Add mcasp
	support for DM646x
Date: Mon, 15 Jun 2009 14:40:24 +0530
Message-ID: <01ac01c9ed99$1df78630$59e69290$@com>
References: <1244197720-31006-1-git-send-email-chaithrika@ti.com>
	<20090612013107.GA19074@denix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id CD311103803
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Jun 2009 11:11:17 +0200 (CEST)
In-Reply-To: <20090612013107.GA19074@denix.org>
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Denys Dmytriyenko' <denis@denix.org>
Cc: alsa-devel@alsa-project.org, 'Pavel Kiryukhin' <pkiryukhin@ru.mvista.com>, davinci-linux-open-source@linux.davincidsp.com, 'Naresh Medisetty' <naresh@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 12, 2009 at 07:01:07, Denys Dmytriyenko wrote:
> Chaithrika,
> 
> On Fri, Jun 05, 2009 at 06:28:40AM -0400, Chaithrika U S wrote:
> > Adds driver support for the two instances of McASP on TI's DM646x.
> 
> In patch #3 you removed struct evm_snd_platform_data:
> 
> > -struct evm_snd_platform_data {
> > -	int tx_dma_ch;
> > -	int rx_dma_ch;
> > -};
> 
> That structure is still used in sound/soc/davinci/davinci-evm.c, until you
fix 
> it by patch #4:
> 
> > -static struct evm_snd_platform_data dm335evm_snd_data = {
> > -       .tx_dma_ch      = DAVINCI_DMA_ASP1_TX,
> > -       .rx_dma_ch      = DAVINCI_DMA_ASP1_RX,
> 
> That would break git-bisect...

Denys,

These patches have been merged. In the future, I will try to ensure that
there 
will not be a break when a patch series is submitted.

> 
> -- 
> Denys
> 


Regards, 
Chaithrika
