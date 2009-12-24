From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: fix params_rate() macro use in
	several codecs
Date: Thu, 24 Dec 2009 12:08:56 +0000
Message-ID: <20091224120855.GA29968@opensource.wolfsonmicro.com>
References: <Pine.LNX.4.64.0912240109540.4280@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B4F07103814
	for <alsa-devel@alsa-project.org>; Thu, 24 Dec 2009 13:08:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0912240109540.4280@axis700.grange>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 24, 2009 at 01:13:51AM +0100, Guennadi Liakhovetski wrote:
> Sevelar ASoC codec drivers wrongly assume, that the params_rate() macro 
> returns one of SNDRV_PCM_RATE_* defines instead of the actual numerical 
> sampling rate. Fix them.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Applied, thanks.
