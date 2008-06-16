From: Timur Tabi <timur@freescale.com>
Subject: Re: Thoughts on ASOC v2 driver architecture
Date: Mon, 16 Jun 2008 12:00:41 -0500
Message-ID: <48569C39.5000502@freescale.com>
References: <9e4733910806151110y13f171dct3948a1555608c0ee@mail.gmail.com>
	<1213612755.6599.51.camel@odin>
	<9e4733910806160626h12525bb5ydfb61acd62ef3f09@mail.gmail.com>
	<4856776B.7040300@freescale.com>
	<9e4733910806160732h2b1b42f3s1afde73ac8f92026@mail.gmail.com>
	<20080616150337.GB22229@sirena.org.uk>
	<9e4733910806160853o2970f281m239712d8a2619e91@mail.gmail.com>
	<9e4733910806160911t3c4e6cecg56b5e6dcee5c5e6a@mail.gmail.com>
	<20080616165853.GC8544@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 007E8243B2
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jun 2008 19:00:45 +0200 (CEST)
In-Reply-To: <20080616165853.GC8544@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>, Timur Tabi <timur@freescale.com>, ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:

> I'm wondering if it might be worth adding some sort of infrastructure
> which would allow drivers to load based on the machine type - not by
> defining a device type, just by saying "load me on board X"?  This would
> be very similar to how DMI information is used on x86 systems to handle
> similar situations.

This would be a question worth asking on linuxppc-dev.

-- 
Timur Tabi
Linux kernel developer at Freescale
