From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 07/11] ASoC: tegra: Add tegra-das driver
Date: Wed, 5 Jan 2011 23:18:12 +0000
Message-ID: <20110105231812.GC5476@opensource.wolfsonmicro.com>
References: <1292622090-21896-1-git-send-email-swarren@nvidia.com>
	<1292622090-21896-8-git-send-email-swarren@nvidia.com>
	<20101217220029.GD25609@sirena.org.uk>
	<74CDBE0F657A3D45AFBB94109FB122FF030FD78D90@HQMAIL01.nvidia.com>
	<20101222201118.GA8167@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310567AAE@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BBBCE24434
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2011 00:17:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0310567AAE@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 05, 2011 at 02:58:02PM -0800, Stephen Warren wrote:
> Mark Brown wrote:

> > I guess for now setting up a 1:1 mapping between the CPU DAIs and the
> > physical ports would get the CPU driver going, then I can do the
> > framework work required to make sure DAPM propagates nicely over the
> > mux.  Does that sound reasonable?

> So I'm clear, I'm interpreting that as meaning the existing tegra_das.c
> driver that I sent to the list is acceptable for now. Then, once that's
> merged in, we can add in the infra-structure to recast it as a codec/...
> Or, were you asking for some kind of structural change?

No, I don't think this should be made visible to machine drivers at all
- they should just see a straight through mapping from the DMA channels
to the ports in the first instance.
