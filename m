From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: fix compilation breakage in
	sound/soc/sh/fsi.c
Date: Wed, 03 Feb 2010 16:43:44 +0000
Message-ID: <1265215424.3269.0.camel@odin>
References: <Pine.LNX.4.64.1002031735230.6324@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.147])
	by alsa0.perex.cz (Postfix) with ESMTP id DCC01103827
	for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2010 17:43:46 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 4so343935eyg.16
	for <alsa-devel@alsa-project.org>; Wed, 03 Feb 2010 08:43:46 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1002031735230.6324@axis700.grange>
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
Cc: alsa-devel@alsa-project.org, Paul Mundt <lethal@linux-sh.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-02-03 at 17:37 +0100, Guennadi Liakhovetski wrote:
> ctrl_outl() has become void at some point, which breaks compilation of fsi.c.
> Make writing functions void, as their output is anyway not evaluated, and use
> __raw_writel and __raw_readl instead of deprecated ctrl_outl and ctrl_inl
> respectively.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
