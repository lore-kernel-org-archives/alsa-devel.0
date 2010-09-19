From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5] ASoC: fix compile breakage of the sh/siu driver
Date: Sun, 19 Sep 2010 16:04:48 +0100
Message-ID: <20100919150448.GB18789@opensource.wolfsonmicro.com>
References: <Pine.LNX.4.64.1009171129550.4988@axis700.grange>
 <Pine.LNX.4.64.1009171211580.4988@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1009171211580.4988@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 17, 2010 at 12:29:46PM +0200, Guennadi Liakhovetski wrote:
> The sh/siu ASoC driver doesn't compile because of a function defined static in
> the source and extern in a header. Remove the unneeded declaration in the
> header.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Applied, thanks.
