From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/27]: ASoC: rsnd: add Renesas
	Gen2	DMAEngine support
Date: Tue, 28 Jan 2014 13:05:19 +0000
Message-ID: <20140128130519.GJ15937@n2100.arm.linux.org.uk>
References: <877g9qgl6i.wl%kuninori.morimoto.gx@gmail.com>
 <20140127194902.GU11841@sirena.org.uk>
 <87zjmh7xtd.wl%kuninori.morimoto.gx@gmail.com> <52E75DD5.6040605@metafoo.de>
 <20140128113429.GK11841@sirena.org.uk> <52E79D45.5090301@metafoo.de>
 <20140128123743.GM11841@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.arm.linux.org.uk (gw-1.arm.linux.org.uk [78.32.30.217])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B95B2651CF
 for <alsa-devel@alsa-project.org>; Tue, 28 Jan 2014 14:05:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20140128123743.GM11841@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 28, 2014 at 12:37:43PM +0000, Mark Brown wrote:
> On Tue, Jan 28, 2014 at 01:06:29PM +0100, Lars-Peter Clausen wrote:
> 
> > The virt_dma helper functions already take care of some of the cyclic
> > specific details. And more can probably be added. E.g. what comes to mind is
> > the tracking of whether a descriptor is cyclic and which segment of the
> > descriptor to submit next. All users of virt_dma already implement these in
> > almost the same fashion. So this would not only to allow to factor out the
> > handling for the cyclic case, but also for the non cyclic case. And for all
> > users of those helpers cyclic support would essentially be free.
> 
> OK, I had a brief look and that does seem like the way forwards - I had
> been remembering the last time this was discussed when the DMA guys were
> pretty uncomfortable with the idea of doing things there but it seems
> things are different now.

I don't want virt_dma to do any tracking of which part of the descriptor
is to be submitted next, because that needlessly makes virt_dma harder to
use on hardware which you can generate the scatterlist in memory and have
the hardware walk it, only notifying when it reaches the end of the list.

I also want to leave the door open for DMA implementations that decide to
extend such a list when the next descriptor(s) is/are issued, thereby
allowing hardware to move on to the next DMA task with the software only
taking care of the status update and callback notification.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
