From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4 v2] ASoC: Add sh_mobile_hdmi sound
	support
Date: Tue, 7 Sep 2010 10:40:48 +0100
Message-ID: <20100907094047.GA7886@rakim.wolfsonmicro.main>
References: <w3p39tv72sx.wl%kuninori.morimoto.gx@renesas.com>
	<w3pwrr75o6d.wl%kuninori.morimoto.gx@renesas.com>
	<Pine.LNX.4.64.1009060932430.20387@axis700.grange>
	<20100906102557.GE10367@rakim.wolfsonmicro.main>
	<Pine.LNX.4.64.1009070910370.1345@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 124C024485
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Sep 2010 11:40:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1009070910370.1345@axis700.grange>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Paul Mundt <lethal@linux-sh.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 07, 2010 at 09:11:28AM +0200, Guennadi Liakhovetski wrote:
> On Mon, 6 Sep 2010, Mark Brown wrote:

> > > > +static int sh_hdmi_snd_write(struct snd_soc_codec *codec,

> > > Are these two actually needed? As long as you don't have a register cache 
> > > - no need for these?

> > Something needs to translate the ASoC register I/O functions into what
> > the HDMI layer code is expecting.

> AFAICS, with ->reg_cache_size = 0 the ASoC core will not attempt to call 
> them.

Could you please be more explicit here?  Register I/O needs to happen
somehow...
