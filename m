From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/2] regmap: Add support for device
 specific write and read flag masks.
Date: Mon, 5 Sep 2011 14:59:53 -0700
Message-ID: <20110905215952.GC11107@opensource.wolfsonmicro.com>
References: <1315248393-31791-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BC5E324544
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Sep 2011 00:00:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1315248393-31791-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Scott Jiang <scott.jiang.linux@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, uclinux-dist-devel@blackfin.uclinux.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 05, 2011 at 08:46:32PM +0200, Lars-Peter Clausen wrote:
> Some buses like SPI have no standard notation of read or write operations.
> The general scheme here is to set or clear specific bits in the register
> address to indicate whether the operation is a read or write. We already
> support having a read flag mask per bus, but as there is no standard
> the bits which need to be set or cleared differ between devices and vendors,
> thus we need a mechanism to specify them per device.

So, I tried to apply this to my topic/interface branch (which is where
I'm keeping stuff for merge into other trees) but that won't fly due to
the internal.h change.  What I might do to resolve the merge issues is
to make a commit with the new regmap.h changes alone.  This won't help
in terms of actually running things but it'll keep things buildable
which is more achievable.

Anyway, thanks for doing this - there's a bunch of other devices that
need this.
