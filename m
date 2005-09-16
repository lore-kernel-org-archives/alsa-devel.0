From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: au88x0 modem
Date: Thu, 15 Sep 2005 22:26:34 -0400
Message-ID: <1126837594.4986.20.camel@mindpipe>
References: <20050911124530.GA16795@titan.lahn.de>
	 <20050915143533.GB23218@sashak.softier1.local>
	 <4329946B.9030407@netvigator.com>
	 <200509152325.42883.alien999999999@users.sourceforge.net>
	 <432A2B1D.3040204@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <432A2B1D.3040204@netvigator.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Raymond <rayau@netvigator.com>
Cc: Alien <alien999999999@users.sourceforge.net>, alsa-devel@lists.sourceforge.net, openvortex-dev@nongnu.org, Sasha Khapyorsky <sashak@smlink.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-09-16 at 10:17 +0800, Raymond wrote:
> +        if (pci_set_dma_mask(pci, VORTEX_DMA_MASK) < 0 ||
> +        	pci_set_consistent_dma_mask(pci, VORTEX_DMA_MASK) < 0) {
>   		printk(KERN_ERR "error to set DMA mask\n");
> +		pci_disable_device(pci);
>   		return -ENXIO;
>   	}
> -	pci_set_dma_mask(pci, VORTEX_DMA_MASK);

>   #define	VORTEX_DMA_MASK	0xffffffff
> 

You should be using DMA_32BIT_MASK for this (see
include/linux/dma-mapping.h).

Lee



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
