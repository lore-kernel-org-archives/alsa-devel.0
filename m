From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/8] ASoC: fsi: modify format area
	definition on flags
Date: Tue, 13 Jul 2010 09:55:57 +0100
Message-ID: <20100713085556.GB11860@rakim.wolfsonmicro.main>
References: <w3pr5j9dz2s.wl%kuninori.morimoto.gx@renesas.com>
	<w3ppqytdz12.wl%kuninori.morimoto.gx@renesas.com>
	<20100712085419.GB21840@rakim.wolfsonmicro.main>
	<w3pbpackwf9.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8291A243AF
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Jul 2010 10:55:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <w3pbpackwf9.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 13, 2010 at 10:22:35AM +0900, Kuninori Morimoto wrote:

> > > +#define SH_FSI_FMT_TDM_DELAY	(6 << 0)

> > Wouldn't it be clearer to just define these as straight numbers?

> Sorry. Do you mean (1 << 0) is needed ?
> (1 << 0) is not changed from old one

I mean the << 0 is not needed - a shift by zero bits is just the
original number.
