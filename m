From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/5] ASoC: fix clkdev API usage in sh/migor.c
Date: Sun, 19 Sep 2010 16:05:45 +0100
Message-ID: <20100919150545.GD18789@opensource.wolfsonmicro.com>
References: <Pine.LNX.4.64.1009171129550.4988@axis700.grange>
 <Pine.LNX.4.64.1009171215120.4988@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1009171215120.4988@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 17, 2010 at 12:30:11PM +0200, Guennadi Liakhovetski wrote:
> The clkdev API doesn't use .name and .id members of struct clk for clock
> lookup. Instead clocks should be added to a lookup list. Without this patch
> audio om the Migo-R board fails silently.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

> As mentioned before - please also apply to 2.6.36.

Applied and merge up to -next.  As I said, please submit patches against
the kernel version they should be applied to and please submit separate
serieses for separate verisons.
