From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Wed, 2 Jan 2008 18:49:57 +0000
Message-ID: <20080102184957.GB2007@sirena.org.uk>
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801012027p4be16b92r43af773f4e5ae531@mail.gmail.com>
	<477BADF5.9060003@freescale.com>
	<fa686aa40801020828u5103d09cn2aa5eab7dda2fcff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1AFA224346
	for <alsa-devel@alsa-project.org>; Wed,  2 Jan 2008 19:50:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <fa686aa40801020828u5103d09cn2aa5eab7dda2fcff@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 02, 2008 at 09:28:12AM -0700, Grant Likely wrote:
> On 1/2/08, Timur Tabi <timur@freescale.com> wrote:

> > However, it doesn't make sense to have a node in the device tree for the
> > fabric driver, because there is no such "device".  The fabric driver is
> > an abstraction.  So I need to chose some other node to probe the fabric
> > driver with.  I chose the SSI, since each SSI can have only one codec.

I'm not sure I'd go so far as to say that the fabric/machine driver is
purely an abstraction.  It does represent real hardware, often with
software control.

> Does that mean with ASoC V2 you can instantiate it with the board
> specific platform code instead?  I think that is the consensus we were
> leaning towards in the last discussion about this issue.

With ASoC v2 rather than having a single monolithic ASoC device which
probes everything ASoC is converted into a proper subsystem with each
component (codec, SoC CPU port, whatever) having a sysfs-visible driver.
These drivers register with the core as they are probed with the probing
happening through whatever mechanism is appropriate for the driver.

The machine support code (fabric driver in PowerPC terms, I think?)
tells the core how everything is connected together by registering
devices representing the links (eg, I2S) between the codecs, CPU and
other devices.  The ASoC core is then responsible for ensuring that all
the required components are present before it registers with the ALSA
core.
