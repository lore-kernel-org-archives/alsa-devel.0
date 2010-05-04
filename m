From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] powerpc/8610: add probing for
 individual DMA channels, not just DMA controllers
Date: Tue, 04 May 2010 10:11:34 -0500
Message-ID: <4BE03926.4050900@freescale.com>
References: <1272923655-31807-1-git-send-email-timur@freescale.com>
	<20100504145430.GC3651@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E40F2414B
	for <alsa-devel@alsa-project.org>;
	Tue,  4 May 2010 17:11:52 +0200 (CEST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o44FBZII023088
	for <alsa-devel@alsa-project.org>; Tue, 4 May 2010 08:11:45 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o44FK8iX007669
	for <alsa-devel@alsa-project.org>; Tue, 4 May 2010 10:20:09 -0500 (CDT)
In-Reply-To: <20100504145430.GC3651@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Mon, May 03, 2010 at 04:54:15PM -0500, Timur Tabi wrote:
> 
>>  	{ .compatible = "simple-bus", },
>> -	{ .compatible = "gianfar", },
>> +	/* So that the DMA channel nodes can be probed individually: */
>> +	{ .compatible = "fsl,eloplus-dma", },
>>  	{}
> 
> The removal of gianfar looks a bit surprising here - if it's not a
> mistake a note in the changelog would be useful.

The changelog says this:

Also remove the "gianfar" compatible from mpc8610_ids[], since there is no
gianfar (or any other networking device) on the 8610.

The 8610 is almost unique among our high-end PowerPC chips in that it
literally has no on-board networking.  The board provides networking via a
PCI device.

-- 
Timur Tabi
Linux kernel developer at Freescale
