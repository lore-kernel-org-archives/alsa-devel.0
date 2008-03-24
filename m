From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: PXA2xx/3xx AC97 Driver(s)
Date: Mon, 24 Mar 2008 14:05:57 +0000
Message-ID: <20080324140557.GA29401@rakim.wolfsonmicro.main>
References: <47E7A0A8.3010200@oliford.co.uk>
	<20080324134231.GA30281@sirena.org.uk>
	<20080324135703.GA26283@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8899E103891
	for <alsa-devel@alsa-project.org>; Mon, 24 Mar 2008 15:05:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080324135703.GA26283@flint.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alex.meakins@gmail.com, Oliver Ford <ipaqlinux@oliford.co.uk>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 24, 2008 at 01:57:03PM +0000, Russell King - ARM Linux wrote:

> The pxa_set_cken() will not do the right thing for PXA3xx CPUs, which is
> why that interface is deprecated.  If you're building for PXA3 CPUs and
> you get warnings about pxa_set_cken() that's a sure sign that something's
> wrong.

OK, fair enough - in any case, the cken() calls are removed in one of
the patches you have pending so they'll be gone before the PXA3xx
support is merged.
