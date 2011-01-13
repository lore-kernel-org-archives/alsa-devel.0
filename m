From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: fix compatible properties of
	the P1022DS DMA nodes used for audio
Date: Wed, 12 Jan 2011 18:08:29 -0600
Message-ID: <F8A5F136-1479-4DAC-971A-448134B51987@freescale.com>
References: <1291395134-12435-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe002.messaging.microsoft.com
	[213.199.154.205])
	by alsa0.perex.cz (Postfix) with ESMTP id 16D8124156
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 01:08:39 +0100 (CET)
In-Reply-To: <1291395134-12435-1-git-send-email-timur@freescale.com>
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
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Dec 3, 2010, at 10:52 AM, Timur Tabi wrote:

> In order to prevent the fsl_dma driver from claiming the DMA channels that the
> P1022DS audio driver needs, the compatible properties for those nodes must say
> "fsl,ssi-dma-channel" instead of "fsl,eloplus-dma-channel".
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> 
> Kumar, please pick up this patch for 2.6.37.
> 
> arch/powerpc/boot/dts/p1022ds.dts |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)

applied to next

- k
