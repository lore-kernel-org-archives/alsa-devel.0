From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: fix params_rate() macro use in
	several codecs
Date: Thu, 24 Dec 2009 09:46:32 +0000
Message-ID: <1261647992.3554.1.camel@odin>
References: <Pine.LNX.4.64.0912240109540.4280@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f212.google.com (mail-ew0-f212.google.com
	[209.85.219.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C616103814
	for <alsa-devel@alsa-project.org>; Thu, 24 Dec 2009 10:46:36 +0100 (CET)
Received: by ewy4 with SMTP id 4so27064081ewy.32
	for <alsa-devel@alsa-project.org>; Thu, 24 Dec 2009 01:46:36 -0800 (PST)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2009-12-24 at 01:13 +0100, Guennadi Liakhovetski wrote:
> Sevelar ASoC codec drivers wrongly assume, that the params_rate() macro 
> returns one of SNDRV_PCM_RATE_* defines instead of the actual numerical 
> sampling rate. Fix them.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
