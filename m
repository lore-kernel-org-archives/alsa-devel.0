From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 06/12] imx-ssi sound driver
Date: Mon, 23 Nov 2009 12:00:01 +0000
Message-ID: <20091123120000.GC24326@rakim.wolfsonmicro.main>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-2-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-3-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-4-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-5-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-6-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-7-git-send-email-s.hauer@pengutronix.de>
	<ed82fe3e0911211812i49342b0eg2afe861c866db90c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 629E01037E3
	for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2009 13:00:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <ed82fe3e0911211812i49342b0eg2afe861c866db90c@mail.gmail.com>
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 21, 2009 at 08:12:34PM -0600, Timur Tabi wrote:

> Why did you write a new SSI driver when there already is one in sound/soc/fsl?

I can't speak for Sascha here but the i.MX BSPs provided by your
colleagues on the i.MX team also have an independant driver for the SSI
port.  The latest public version of the Freescale i.MX code I'm aware of
is in the recent Ubuntu kernels - I've not yet checked but I'd not be
surprised to see substantial code sharing between Sascha's code and the
BSP for the SSI-specific bits.

It would be very much desirable to unify the various drivers, though I
would prefer to avoid making this a blocker for getting i.MX3x "DMA"
support in mainline.  Taking a brief glance through the code it looks
like there's some platform-specifics in the drivers - the i.MX one has
optional DMA support due to the whole SDMA issue, while the PowerPC one
is including asm/immap_86xx.h for something.  Perhaps pulling the common
code into a library would be a good approach here?
