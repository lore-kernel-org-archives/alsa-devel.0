From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH 07/11] ASoC: tegra: Add tegra-das driver
Date: Wed, 5 Jan 2011 16:20:04 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310567AE9@HQMAIL01.nvidia.com>
References: <1292622090-21896-1-git-send-email-swarren@nvidia.com>
	<1292622090-21896-8-git-send-email-swarren@nvidia.com>
	<20101217220029.GD25609@sirena.org.uk>
	<74CDBE0F657A3D45AFBB94109FB122FF030FD78D90@HQMAIL01.nvidia.com>
	<20101222201118.GA8167@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310567AAE@HQMAIL01.nvidia.com>
	<20110105231812.GC5476@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310567AC4@HQMAIL01.nvidia.com>
	<20110105233338.GA5714@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id D17F12447C
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2011 01:20:25 +0100 (CET)
In-Reply-To: <20110105233338.GA5714@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Wed, Jan 05, 2011 at 03:27:17PM -0800, Stephen Warren wrote:
> > Mark Brown wrote:
> 
> > > No, I don't think this should be made visible to machine drivers at all
> > > - they should just see a straight through mapping from the DMA channels
> > > to the ports in the first instance.
> 
> > Oh. So what should set up this 1:1 mapping then; what module should the
> > DAS register writes be contained in? And later, what module should
> 
> I guess the I2S driver?
> 
> > configure the DAS with the mux configuration that is appropriate for
> > the board? It seems like the machine driver is the only place with the
> 
> My suggestion would only work for very simple boards like Harmony.
> 
> > knowledge to define what the routing should be. Whether the machine driver
> > calls tegra_das_* vs. some codec/mux API to set this up seems like a
> > different issue to whether the machine driver or something else should
> > contain this knowledge.
> 
> The end result would be that this would all be done in the application
> layer, potentially dynamically.

Hmmm.

One of the nice things about ALSA on desktop is that everything just works
without having to fiddle around setting up routing etc. from user-space e.g.
using alsamixer or custom code.

Isn't ASoC attempting to set up a reasonably good routing/configuration on a
per-board basis, driven by knowledge in the machine (board?) driver? Then,
let people tweak it /if/ they want? It kinda sounds like you're pushing for a
model where simply loading the driver may or may not have things set up right,
then one has to configure everything from user-space before audio will work.
Am I grossly misunderstanding?

Something else I was holding off on asking, but may as well now:

Related to this, there's a lot of code in the-original-Tegra-driver-that-I-
based-my-submission-on which pokes all kinds of registers in the codec from
the machine driver to set up recording; e.g. mic mux selection, mic volume
or gain, bias on/off, mono/stereo etc. based off detailed knowledge of the
Harmony board. Seaboard, Ventana, ... would have similar but subtly different
configuration logic. I stripped this out to simplify things initially. Is
such configuration not meant to be part of the machine driver, but provided
by manually setting everything up with alsamixer for example (and perhaps
shipping a saved alsamixer state file)?

> > In the short-term, are you expecting the I2S driver to expose a CPU DAI for
> > each audio controller and port? The number of audio controllers and ports
> > isn't equal, and hence it wouldn't be possible to support a board using just
> > port 5 since there's no controller 5 (and even audio controller 3 I think is
> > SPDIF not I2S)...
> 
> Oh, hrm.  That wasn't clear from your code.  Would mapping controller n
> to port n work for Harmony?

Yes, Harmony just happens to use controller ID 1 and port ID 1.

-- 
nvpublic
