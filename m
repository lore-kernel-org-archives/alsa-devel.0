From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: i.MX audio support
Date: Fri, 20 Nov 2009 11:17:03 +0000
Message-ID: <20091120111703.GB20236@rakim.wolfsonmicro.main>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C18FE24363
	for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2009 12:17:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 19, 2009 at 04:48:14PM +0100, Sascha Hauer wrote:

> one single FIFO. The WM9712 I worked with sends data in slot 12 which we have
> to sort out manually from the FIFO, so I think there is no way to work around
> the fiq handler using the DMA engine with AC97.

Slot 12 is used for GPIOs to allow them to be read/written without
register accesses - I'd expect that data there will not be uncommon.

> The devdma code is actually a copy of sound/arm/devdma.[ch]. It should probably
> be selected somehow instead of duplicated.

Yes, ideally.  A simple Makefile change in sound/arm should do the
trick.  Other than this I'm happy with all the patches I've not
specifically commented on.
