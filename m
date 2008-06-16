From: Timur Tabi <timur@freescale.com>
Subject: Re: Thoughts on ASOC v2 driver architecture
Date: Mon, 16 Jun 2008 10:49:27 -0500
Message-ID: <48568B87.2000408@freescale.com>
References: <9e4733910806151110y13f171dct3948a1555608c0ee@mail.gmail.com>
	<1213612755.6599.51.camel@odin>
	<9e4733910806160626h12525bb5ydfb61acd62ef3f09@mail.gmail.com>
	<4856776B.7040300@freescale.com>
	<9e4733910806160732h2b1b42f3s1afde73ac8f92026@mail.gmail.com>
	<20080616150337.GB22229@sirena.org.uk>
	<48568873.3040906@freescale.com>
	<20080616154529.GA8544@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F8A924375
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jun 2008 17:49:32 +0200 (CEST)
In-Reply-To: <20080616154529.GA8544@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>, Jon Smirl <jonsmirl@gmail.com>, ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:

> But wouldn't it now be legal to represent the machine driver as a device
> in its own right, even if it is connected via GPIOs?

I'm not sure I understand that, so let me say this:

When a driver wants to be probed, it creates a list that describes the kind of
nodes it wants to be probed on.  Typically, the list includes the contents of
the "compatible" property.  The kernel then scans the device tree, and calls the
driver for each matching node.

In the driver's probe function, the driver can either return success or failure.
If it returns success, the driver "owns" the node.  No other driver will ever
get probed for that node again.  This prevents more than one driver from talking
to a particular hardware device.

So if the fabric driver were to list the GPIO node in its probe request, then a
*real* GPIO driver would never get probed (or the other way around).

-- 
Timur Tabi
Linux kernel developer at Freescale
