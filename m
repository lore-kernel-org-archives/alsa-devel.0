From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v7 2/3] ASoC: da7210: Add support for line
 out and DAC
Date: Fri, 21 Oct 2011 11:24:30 +0100
Message-ID: <20111021102429.GB4080@opensource.wolfsonmicro.com>
References: <1319121769.24621.130.camel@matrix>
	<CABS+qY3zsuQSE_9=_jaoO=AYRyopZ3WPNeG-PJYzwucmWxcqkA@mail.gmail.com>
	<1319186260.24621.154.camel@matrix>
	<20111021090054.GF3513@opensource.wolfsonmicro.com>
	<1319190555.24621.160.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AC24924519
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Oct 2011 12:24:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1319190555.24621.160.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, "Girdwood, Liam" <lrg@ti.com>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 21, 2011 at 03:19:15PM +0530, Ashish Chavan wrote:
> On Fri, 2011-10-21 at 10:00 +0100, Mark Brown wrote:

> > That'd be fine but there's no DAPM code in the patch, only code to
> > unconditionally enable on init.

> Yes, because DAPM part for those IOs is already covered by DAPM patch.

Ah, you should split that out of the DAPM patch into here - the DAPM bit
won't work without the enable bits (as I understand it).
