From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V1 09/11] ASoC: DaVinci: i2s,
	add	davinci_i2s_prepare and shutdown
Date: Mon, 27 Sep 2010 01:56:36 +0100
Message-ID: <20100927005636.GC21247@sirena.org.uk>
References: <1246761001-21982-4-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-5-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-6-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-7-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-8-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-9-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-10-git-send-email-troy.kisky@boundarydevices.com>
	<A24693684029E5489D1D202277BE89447289CD0A@dlee02.ent.ti.com>
	<4C9CF898.7070906@boundarydevices.com>
	<A24693684029E5489D1D202277BE89447289CF40@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 35DA124634
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Sep 2010 02:56:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <A24693684029E5489D1D202277BE89447289CF40@dlee02.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Ambrose, Martin" <martin@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 24, 2010 at 02:43:30PM -0500, Ambrose, Martin wrote:
> On Fri, Sep 24, 2010 at 14:14:32, Troy Kisky wrote:

> > My thought was that the device (master) which starts the external
> > wires to wiggling should be last.

> Fair enough. I suppose that is the reasoning for the addition of the
> prepare function.  The assumption being that a cpu_dai callback to the
> prepare function will always proceed a call to the codec_dai trigger
> function. In this way the serial port can be configured and enabled.

These are all generic ALSA things, not ASoC specific - ASoC is just
passing them straight through.  The idea is that prepare() allows the
driver to finalise the configuration of the hardware and do any setup
that can't be done in an atomic context prior to the trigger, there's no
consideration for any aspect of the ASoC design in this arrangement.

> > If the codec is master, and starts the clocks before the mcbsp is
> > ready that could also cause a pop or noise.

> I still a newbie when it comes to the ALSA architecture.
> Is the proper signal indicating everything is ready, including valid
> data, a trigger call with cmd=START?

Yes, the trigger callback actually starts data flowing.  This is mostly
down to DMA, it's rare for anything except the CPU to be involved in the
trigger operation.
