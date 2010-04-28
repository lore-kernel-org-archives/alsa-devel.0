From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] powerpc: add platform registration for
 ALSA SoC drivers
Date: Wed, 28 Apr 2010 14:19:19 +1000
Message-ID: <1272428359.24542.66.camel@pasglop>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>
	<4BD6FA39.3030400@freescale.com> <1272381611.11000.39.camel@odin>
	<4BD70292.20001@freescale.com> <1272386470.11000.84.camel@odin>
	<4BD72DB0.20808@freescale.com>
	<s2ifa686aa41004271215tb3c992c1v8996ce5520896c6c@mail.gmail.com>
	<4BD74351.9030704@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by alsa0.perex.cz (Postfix) with ESMTP id 5893D244F1
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Apr 2010 06:19:23 +0200 (CEST)
In-Reply-To: <4BD74351.9030704@freescale.com>
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
Cc: alsa-devel@alsa-project.org, kumar.gala@freescale.com, broonie@opensource.wolfsonmicro.com, Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-04-27 at 15:04 -0500, Timur Tabi wrote:
> What I need is something like a hashing function that can convert a
> "struct device_node *" into an "int".  I'm going to have two functions
> that independently parse the device tree and locate a specific node.
> Both functions will "register the node" with asoc, but they'll use an
> integer ID to uniquely identify the node.
> 
> At least, that's the way ASoC likes to operate.  AsoC takes a fixed
> string plus a unique integer.  I could technically create a unique
> string for each DMA device, and have the integer always be 0. 

That's just plain gross and horrible. You could use phandles you
know :-)

Or you could use path in your strings, or something like that.

Note that any time you have a struct device, you have a free device_node
pointer as well.

Cheers,
Ben.
