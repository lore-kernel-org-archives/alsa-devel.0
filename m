From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Swapped channels issue on pxa-ssp based platforms
Date: Tue, 8 Nov 2011 11:39:30 +0000
Message-ID: <20111108113930.GI25591@opensource.wolfsonmicro.com>
References: <4EB817FC.4000905@gmail.com>
 <4EB83D3B.2050906@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0BBBE2437E
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2011 12:39:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4EB83D3B.2050906@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Haojian Zhuang <haojian.zhuang@marvell.com>, alsa-devel@alsa-project.org, Sven Neumann <s.neumann@raumfeld.com>, Liam Girdwood <lrg@ti.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 07, 2011 at 09:19:07PM +0100, Clemens Ladisch wrote:
> Daniel Mack wrote:

> > I guess this is some sort of a race condition in the stream startup,
> > and suspected sound/soc/pxa/pxa-ssp.c to lack some locking, so I added
> > a spinlock around all register read-modify-write cycles. But that doesn't
> > seem to be the reason.

> I'd guess this is a race in the programming of the L/R clock signals;
> try putting a lock/mutex about all the stream initialization code, and
> maybe adding some delay.

That's very unlikely to help, these issues are generally issues with the
controller not being able to figure out which clock edge to start on
properly and if there are problems here locking is unlikely to help -
the issue is the two hardware blocks synchronizing with each other,
usually with the clocks driven from an asynchronous domain.
