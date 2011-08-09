From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: asoc: where to store board specific info?
Date: Wed, 10 Aug 2011 01:17:35 +0900
Message-ID: <20110809161734.GP15861@opensource.wolfsonmicro.com>
References: <CAHG8p1DxxZAxpkUzqP6TK+axv05Do3q3sX+CTK=mOLW9-1SX1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7D4BA24612
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Aug 2011 18:17:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAHG8p1DxxZAxpkUzqP6TK+axv05Do3q3sX+CTK=mOLW9-1SX1w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Scott Jiang <scott.jiang.linux@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 09, 2011 at 06:20:15PM +0800, Scott Jiang wrote:

> I wonder where to store board specific info? For example, some
> customer boards have a reset pin to control codec.
> If I store it in machine driver, I must modify it according to the boards.

The entire purpose of the machine driver is to be board specific, though
machine drivers can take platform data if they support many similar
boards.  There's a few examples of this like the tegra_wm8903 driver.

> I can store it in arch/board file and pass it to codec driver, but how
> about the external system clock?

You can't usually assume the system clock is static in your driver
(unless it's a physical property of the device that it must be) - the
system could connect it to a variable clock source of some kind.
