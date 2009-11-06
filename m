From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC - Add support for upto 16 channels	on
	OMAP MCBSP
Date: Fri, 6 Nov 2009 13:20:25 +0000
Message-ID: <20091106132024.GA4938@sirena.org.uk>
References: <1257357235.2887.499.camel@odin>
	<20091104185534.GA22055@xora.vm.bytemark.co.uk>
	<1257364009.2887.665.camel@odin>
	<20091105095143.995beeea.jhnikula@gmail.com>
	<1257432930.3603.902.camel@odin>
	<20091105212822.2fab9974.jhnikula@gmail.com>
	<1257451710.3576.292.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BBF0124673
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2009 14:20:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1257451710.3576.292.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Graeme Gregory <gg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 05, 2009 at 08:08:30PM +0000, Liam Girdwood wrote:
> On Thu, 2009-11-05 at 21:28 +0200, Jarkko Nikula wrote:

> > Would be nice if both the divider and frame size are calculated
> > dynamically based on CLKSRG frequency and sample rate.

> This does sound like a useful feature and should probably exist in
> soc-core for other platforms too.

A lot of drivers would probably have trouble using this due to the
number of different constraints in the dividers that can be set up that
random hardware has - it'd probably take more effort to finesse things
than it's worth - but a utility function for mostly unconstrained
hardware would be good.
