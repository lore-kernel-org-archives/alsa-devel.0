From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: twl6040 - Add method to query
	optimum PDM_DL1	gain
Date: Wed, 11 Jan 2012 21:12:23 +0000
Message-ID: <20120111211222.GF24213@opensource.wolfsonmicro.com>
References: <1326111082-11678-1-git-send-email-lrg@ti.com>
	<20120110004428.GL30766@opensource.wolfsonmicro.com>
	<1326193389.3944.8.camel@odin>
	<20120110192957.GJ7164@opensource.wolfsonmicro.com>
	<1326277933.4162.11.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 258E22448A
	for <alsa-devel@alsa-project.org>; Wed, 11 Jan 2012 22:12:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1326277933.4162.11.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 11, 2012 at 10:32:13AM +0000, Liam Girdwood wrote:
> On Tue, 2012-01-10 at 19:29 +0000, Mark Brown wrote:

> > So if you turn on some of the outputs in the CODEC the CODEC will apply
> > a gain to the signal coming in on DL1 which affects other CODEC outputs
> > and this needs to be worked around in the ABE so the machine driver is
> > doing that?

> Yes, but the Codec component (widget) must also be enabled for the
> attenuation to happen.

And (since it wasn't entirely clear to me) this is the DL1 interface the
CODEC has not the similarly named interface that the ABE has.

> > > > Shouldn't this be being done by reading the CODEC register settings to
> > > > know which output DL1 is connected to?

> > > The DL1 path output devices can all operate at the same time and may or
> > > may not be connected by the machine drivers.

> > But surely the paths from DL1 to the various outputs within the CODEC
> > are controlled by registers in the CODEC?  I don't understand why the
> > CODEC needs to query DAPM here.

> The machine driver may not have the Earpiece, Handsfree or Headset
> connected (even though the codec path is set to use them). The codec has
> no way of knowing this except to check the widget DAPM status for the
> outputs. Now we can check the DAPM status of each widget by reading the

Yeah, I was expecting the code to just read the power bits that DAPM
sets to see which outputs were enabled - having to ask DAPM looked like
a lot of work and made me wonder if there was something else going on.

> codec register, but I think that defeats DAPMs codec widget power
> control and status APIs.

It makes me a bit nervous when CODEC drivers need to go back and ask
DAPM what they've done with themselves, that way can lie polling and
reentrancy issues if the driver ends up querying DAPM from
within DAPM.

> I've applied this since I'm doing pull request this morning, you are in
> Asia and this is a trivial patch. We can rework if required later.

There was no rush here, there's no users at the minute and we're into
the merge window so shouldn't really be adding non-bugfix code anyway.
