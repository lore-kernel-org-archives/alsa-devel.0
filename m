From: dinesh <dinesh.dua@coraltele.com>
Subject: Re: Using BD in place of DMA in soc driver
Date: Fri, 04 Jul 2008 18:39:27 +0530
Message-ID: <1215176967.16282.22.camel@dinesh.dua>
References: <1215173518.16282.19.camel@dinesh.dua>
	<1215175289.4882.128.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.coraltele.com (unknown [122.160.64.235])
	by alsa0.perex.cz (Postfix) with ESMTP id 82D8824A6E
	for <Alsa-devel@alsa-project.org>;
	Fri,  4 Jul 2008 15:11:16 +0200 (CEST)
In-Reply-To: <1215175289.4882.128.camel@localhost.localdomain>
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
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

i mean i want to give buffer descriptor base address in place of dma
addresses.


-----Original Message-----
From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
To: dinesh <dinesh.dua@coraltele.com>
Cc: Alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Using BD in place of DMA in soc driver
Date: Fri, 04 Jul 2008 13:41:29 +0100


On Fri, 2008-07-04 at 17:41 +0530, dinesh wrote:
> Hi i want to use mpc8323 ucc tdm as sound soc device but i dont know how
> to configure its buffer descriptor because every soc device available
> uses DMA. Please help. 
> 

Do you mean Programmed IO ?

Liam

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
