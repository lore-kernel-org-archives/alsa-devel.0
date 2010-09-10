From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/5] ASoC: fsi-ak4642: modiry platform_name
Date: Fri, 10 Sep 2010 11:39:02 +0100
Message-ID: <20100910103902.GH3068@rakim.wolfsonmicro.main>
References: <w3pvd6i6ois.wl%kuninori.morimoto.gx@renesas.com>
	<w3pmxru6ofb.wl%kuninori.morimoto.gx@renesas.com>
	<1283944130.3097.97.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A0317103981
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 12:39:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1283944130.3097.97.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Guennadi <g.liakhovetski@gmx.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 08, 2010 at 12:08:50PM +0100, Liam Girdwood wrote:
> On Tue, 2010-09-07 at 15:46 +0900, Kuninori Morimoto wrote:
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

> >  #ifdef CONFIG_MACH_AP4EVB
> > -	.platform_name	= "sh_fsi2.0",
> > +	.platform_name	= "sh_fsi2",
> >  	.codec_name	= "ak4642-codec.0-0013",
> >  #else
> >  	.platform_name	= "sh_fsi.0",

> Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

Applied, thanks.
