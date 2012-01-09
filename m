From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Revert "ASoC: Fix build dependency for
	SND_ATMEL_SOC_SSC"
Date: Sun, 8 Jan 2012 22:23:43 -0800
Message-ID: <20120109062342.GN29065@opensource.wolfsonmicro.com>
References: <1326079783.2951.1.camel@phoenix>
	<20120109041545.GK29065@opensource.wolfsonmicro.com>
	<CAF+7xW=o2NuHZ4joJ7z-JWaA5n7gDpuHKcqHFwsE4f2TBT8CVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 272BE10394B
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2012 07:24:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAF+7xW=o2NuHZ4joJ7z-JWaA5n7gDpuHKcqHFwsE4f2TBT8CVw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, Paul Bolle <pebolle@tiscali.nl>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 09, 2012 at 12:40:35PM +0800, Axel Lin wrote:

> I think this patch reverts the problematic patch.
> And then you can apply [PATCH] ASoC: Fix build dependency for
> SND_AT91_SOC_AFEB9260 (
> http://mailman.alsa-project.org/pipermail/alsa-devel/2012-January/047861.html
> )

What I asked for here was a patch which brings the tree to the desired
state.  Clearly I can just run git revert myself if I want to...
