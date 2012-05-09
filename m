From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] ASoC: sh: fix migor.c compilation
Date: Wed, 9 May 2012 13:35:37 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1205091334210.8599@axis700.grange>
References: <Pine.LNX.4.64.1205091255190.8599@axis700.grange>
 <20120509111701.GI3955@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20120509111701.GI3955@opensource.wolfsonmicro.com>
Sender: linux-sh-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-sh@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark

On Wed, 9 May 2012, Mark Brown wrote:

> On Wed, May 09, 2012 at 12:57:05PM +0200, Guennadi Liakhovetski wrote:
> > Fix a recent compilation breakage, caused by a change in SH clock API.
> 
> How recent - when and where was the API changed?

Between 3.3 and 3.4-rc1:

commit 84c36ffd7c580e1a63d7284e318670b082260118
    sh: remove clk_ops

commit e34828298ec542294f4b798606ee73e462d322f5
    sh: introduce sh_clk_ops in parallel with clk_ops

So, no need for stable.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
