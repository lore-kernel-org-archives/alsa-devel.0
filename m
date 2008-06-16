From: Timur Tabi <timur@freescale.com>
Subject: Re: Thoughts on ASOC v2 driver architecture
Date: Mon, 16 Jun 2008 10:34:42 -0500
Message-ID: <48568812.5020101@freescale.com>
References: <9e4733910806151110y13f171dct3948a1555608c0ee@mail.gmail.com>	
	<1213612755.6599.51.camel@odin>	
	<9e4733910806160626h12525bb5ydfb61acd62ef3f09@mail.gmail.com>	
	<4856776B.7040300@freescale.com>
	<9e4733910806160732h2b1b42f3s1afde73ac8f92026@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id EEC7324359
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jun 2008 17:34:49 +0200 (CEST)
In-Reply-To: <9e4733910806160732h2b1b42f3s1afde73ac8f92026@mail.gmail.com>
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

> I think I've come up with a solution. Push all of that generic setup
> code in mpc8610_hpcd into fsl_ssi.

I would NACK a patch that did that, if you were to submit it here.

> Leave only the platform specific
> support in mpc8610_hpcd. Now turn mpc8610_hpcd into a loadable module
> but leave it as a platform_driver. During the fsl_ssi probe function
> extract the platform name from the device tree and use it to
> dynamically load the mpc8610_hpcd driver.

If you want to augment the drivers to get more information from the device tree,
like names, I would be okay with that.  But I don't like moving any fabric
functionality from the fabric driver into another driver.  The SSI driver cannot
ever be aware of more than one SSI at a time.

-- 
Timur Tabi
Linux kernel developer at Freescale
