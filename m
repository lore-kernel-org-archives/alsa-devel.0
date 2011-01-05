From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH 07/11] ASoC: tegra: Add tegra-das driver
Date: Wed, 5 Jan 2011 15:27:17 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310567AC4@HQMAIL01.nvidia.com>
References: <1292622090-21896-1-git-send-email-swarren@nvidia.com>
	<1292622090-21896-8-git-send-email-swarren@nvidia.com>
	<20101217220029.GD25609@sirena.org.uk>
	<74CDBE0F657A3D45AFBB94109FB122FF030FD78D90@HQMAIL01.nvidia.com>
	<20101222201118.GA8167@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310567AAE@HQMAIL01.nvidia.com>
	<20110105231812.GC5476@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id E6F7024447
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2011 00:27:22 +0100 (CET)
In-Reply-To: <20110105231812.GC5476@opensource.wolfsonmicro.com>
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
> On Wed, Jan 05, 2011 at 02:58:02PM -0800, Stephen Warren wrote:
> > Mark Brown wrote:
> 
> > > I guess for now setting up a 1:1 mapping between the CPU DAIs and the
> > > physical ports would get the CPU driver going, then I can do the
> > > framework work required to make sure DAPM propagates nicely over the
> > > mux.  Does that sound reasonable?
> 
> > So I'm clear, I'm interpreting that as meaning the existing tegra_das.c
> > driver that I sent to the list is acceptable for now. Then, once that's
> > merged in, we can add in the infra-structure to recast it as a codec/...
> > Or, were you asking for some kind of structural change?
> 
> No, I don't think this should be made visible to machine drivers at all
> - they should just see a straight through mapping from the DMA channels
> to the ports in the first instance.

Oh. So what should set up this 1:1 mapping then; what module should the
DAS register writes be contained in? And later, what module should
configure the DAS with the mux configuration that is appropriate for
the board? It seems like the machine driver is the only place with the
knowledge to define what the routing should be. Whether the machine driver
calls tegra_das_* vs. some codec/mux API to set this up seems like a
different issue to whether the machine driver or something else should
contain this knowledge.

In the short-term, are you expecting the I2S driver to expose a CPU DAI for
each audio controller and port? The number of audio controllers and ports
isn't equal, and hence it wouldn't be possible to support a board using just
port 5 since there's no controller 5 (and even audio controller 3 I think is
SPDIF not I2S)...

-- 
nvpublic
