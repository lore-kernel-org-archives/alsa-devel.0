From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] powerpc: add platform registration for
 ALSA SoC drivers
Date: Tue, 27 Apr 2010 13:32:16 -0500
Message-ID: <4BD72DB0.20808@freescale.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>	
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>	
	<4BD6FA39.3030400@freescale.com> <1272381611.11000.39.camel@odin>	
	<4BD70292.20001@freescale.com> <1272386470.11000.84.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id CD2E610382A
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Apr 2010 20:32:19 +0200 (CEST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3RIWHNG003723
	for <alsa-devel@alsa-project.org>; Tue, 27 Apr 2010 11:32:17 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o3RIecAc004126
	for <alsa-devel@alsa-project.org>; Tue, 27 Apr 2010 13:40:38 -0500 (CDT)
In-Reply-To: <1272386470.11000.84.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, kumar.gala@freescale.com, broonie@opensource.wolfsonmicro.com, Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

Liam Girdwood wrote:

>> I would need some way for fsl_dma_open() to get a pointer to private,
>> DMA-specific data.  I'm not sure how I can do that.
> 
> In multi-component we now have platform_data and device private data
> (from the regular driver model).

In that case, I still have the same problem with how to generate an 'id' based on a device tree node.  We have the idea of a 'phandle', which is a unique integer for a node, but there's no way to create phandles from within Linux.  They have to exist in the DTS first, and I'm loathe to modify the DTS.


-- 
Timur Tabi
Linux kernel developer at Freescale
