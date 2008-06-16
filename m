From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Thoughts on ASOC v2 driver architecture
Date: Mon, 16 Jun 2008 12:11:31 -0400
Message-ID: <9e4733910806160911t3c4e6cecg56b5e6dcee5c5e6a@mail.gmail.com>
References: <9e4733910806151110y13f171dct3948a1555608c0ee@mail.gmail.com>
	<1213612755.6599.51.camel@odin>
	<9e4733910806160626h12525bb5ydfb61acd62ef3f09@mail.gmail.com>
	<4856776B.7040300@freescale.com>
	<9e4733910806160732h2b1b42f3s1afde73ac8f92026@mail.gmail.com>
	<20080616150337.GB22229@sirena.org.uk>
	<9e4733910806160853o2970f281m239712d8a2619e91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B70B2435B
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jun 2008 18:11:41 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so2696632ywk.2
	for <alsa-devel@alsa-project.org>; Mon, 16 Jun 2008 09:11:31 -0700 (PDT)
In-Reply-To: <9e4733910806160853o2970f281m239712d8a2619e91@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>, ALSA-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

A more familiar example of this problem is unified graphics drivers.
NVidia probably has 100 variations on their GPUs. They used to have
dozens of device drivers for these chips. Figuring out exactly which
GPU you have and loading the right driver for it is too hard for the
customer to do. So nvidia has built a unified driver for all their
hardware. When it initializes it detects the exact GPU type and
discards all the unneeded code.

I have the same problem. We have four devices that are almost
identical but not quite. Each of these devices has a different product
name in their device tree. I want to be able to send out a single
kernel image that can support all four devices.

To do this I'll put all of the device drivers on an initrd. Then as
the kernel processes the device tree the right drivers will get
loaded. After the boot process is finished the initrd and unused
drivers disappear. Moving the fabric device creation in the my
equivalent of arch/powerpc/platforms/86xx/mpc8610_hpcd.c will let me
do this.

BTW, if you read in /Documentation about platform drivers they say not
to make the devices in the module init function because it causes
problems like the one I'm having.

-- 
Jon Smirl
jonsmirl@gmail.com
