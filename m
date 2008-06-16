From: Timur Tabi <timur@freescale.com>
Subject: Re: Thoughts on ASOC v2 driver architecture
Date: Mon, 16 Jun 2008 09:23:39 -0500
Message-ID: <4856776B.7040300@freescale.com>
References: <9e4733910806151110y13f171dct3948a1555608c0ee@mail.gmail.com>	<1213612755.6599.51.camel@odin>
	<9e4733910806160626h12525bb5ydfb61acd62ef3f09@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id B664B2434D
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jun 2008 16:23:45 +0200 (CEST)
In-Reply-To: <9e4733910806160626h12525bb5ydfb61acd62ef3f09@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jon Smirl wrote:

> I'd like for the fabric driver to be dynamically loaded by the device tree.

You have a PPC problem, not an ASoC problem.  You're trying to use the 
device tree to load a device without specifying a specific node.  This 
is particularly difficult with device trees because once a driver has 
claimed a node via a probe, that node isn't probed again.  So you can't 
use any I2S, DMA, or codec nodes.

> The root of my problem is that I want to handle my four board variants
> with a single kernel. So when the kernel loads, I need to figure out
> which board specific code to load. In the current ASOC design it is
> assumed that this code is permanently linked in as a platform driver.

Not with ASoC V2.  I load my fabric driver as a regular module.  It also 
doesn't matter what order I load the drivers in.  Once the fourth driver 
is loaded, ASoC does its magic and creates a sound card (or two) for me.

So do what I did: deal with the limitations of ASoC V1 as best you can, 
and port your driver to ASoC V2.
