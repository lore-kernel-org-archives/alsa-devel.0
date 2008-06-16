From: Timur Tabi <timur@freescale.com>
Subject: Re: Thoughts on ASOC v2 driver architecture
Date: Mon, 16 Jun 2008 12:10:36 -0500
Message-ID: <48569E8C.3030708@freescale.com>
References: <9e4733910806151110y13f171dct3948a1555608c0ee@mail.gmail.com>
	<1213612755.6599.51.camel@odin>
	<9e4733910806160626h12525bb5ydfb61acd62ef3f09@mail.gmail.com>
	<4856776B.7040300@freescale.com>
	<9e4733910806160732h2b1b42f3s1afde73ac8f92026@mail.gmail.com>
	<20080616150337.GB22229@sirena.org.uk>
	<48568873.3040906@freescale.com>
	<20080616154529.GA8544@sirena.org.uk>
	<48568B87.2000408@freescale.com>
	<20080616170325.GD8544@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 49FFB243F6
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jun 2008 19:10:41 +0200 (CEST)
In-Reply-To: <20080616170325.GD8544@sirena.org.uk>
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

> Right, but you could not then idiomatically have a device tree entry
> saying something to the effect of "This board has a Frobnitz 2000 with
> control line 1 connected to GPIO4 and control line 2 connected to GPIO5"

Yes.

> which would register the presence of this other device (in the same way
> as you have an entry for an I2C device)?

I'm still not sure I understand.  I2C devices are represented by complete nodes
under the I2C adapter node.  The file fsl_soc.c scans each I2C adapter node, and
enumerates every child node under the adapter node.  It creates I2C platform
devices this way.

I'm not sure how we could use this model for ASoC.  There is no "ASoC adapter
node" in the device tree, because there is no ASoC adapter.

-- 
Timur Tabi
Linux kernel developer at Freescale
