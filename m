From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] powerpc: add platform registration for
 ALSA SoC drivers
Date: Tue, 27 Apr 2010 15:04:33 -0500
Message-ID: <4BD74351.9030704@freescale.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>
	<4BD6FA39.3030400@freescale.com>
	<1272381611.11000.39.camel@odin> <4BD70292.20001@freescale.com>
	<1272386470.11000.84.camel@odin> <4BD72DB0.20808@freescale.com>
	<s2ifa686aa41004271215tb3c992c1v8996ce5520896c6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 9789410383E
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Apr 2010 22:04:53 +0200 (CEST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3RK4Y6q002980
	for <alsa-devel@alsa-project.org>; Tue, 27 Apr 2010 13:04:46 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o3RKCuBX029646
	for <alsa-devel@alsa-project.org>; Tue, 27 Apr 2010 15:12:56 -0500 (CDT)
In-Reply-To: <s2ifa686aa41004271215tb3c992c1v8996ce5520896c6c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: alsa-devel@alsa-project.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, kumar.gala@freescale.com, broonie@opensource.wolfsonmicro.com, linuxppc-dev@ozlabs.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Grant Likely wrote:

> Can you not dynamically assign an id?  If alsa soc needs a unique id
> number, then just create a lookup function. 

What I need is something like a hashing function that can convert a "struct device_node *" into an "int".  I'm going to have two functions that independently parse the device tree and locate a specific node.  Both functions will "register the node" with asoc, but they'll use an integer ID to uniquely identify the node.

At least, that's the way ASoC likes to operate.  AsoC takes a fixed string plus a unique integer.  I could technically create a unique string for each DMA device, and have the integer always be 0.

> Something like
> of_asoc_phandle_to_codec_id() that will either return a previously
> assigned id, or will assign a new id.  You shouldn't ever need to add
> data to the tree at runtime.

I know.  It just would have been nice if my nodes already had phandles in them.

-- 
Timur Tabi
Linux kernel developer at Freescale
