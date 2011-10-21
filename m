From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: [PATCH v7 2/3] ASoC: da7210: Add support for line
 out and DAC
Date: Fri, 21 Oct 2011 15:19:15 +0530
Message-ID: <1319190555.24621.160.camel@matrix>
References: <1319121769.24621.130.camel@matrix>
	<CABS+qY3zsuQSE_9=_jaoO=AYRyopZ3WPNeG-PJYzwucmWxcqkA@mail.gmail.com>
	<1319186260.24621.154.camel@matrix>
	<20111021090054.GF3513@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE005.bigfish.com (am1ehsobe005.messaging.microsoft.com
	[213.199.154.208])
	by alsa0.perex.cz (Postfix) with ESMTP id 338A6103AB2
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Oct 2011 11:38:05 +0200 (CEST)
In-Reply-To: <20111021090054.GF3513@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, "Girdwood, Liam" <lrg@ti.com>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-10-21 at 10:00 +0100, Mark Brown wrote:
> On Fri, Oct 21, 2011 at 02:07:40PM +0530, Ashish Chavan wrote:
> > On Thu, 2011-10-20 at 18:10 +0100, Girdwood, Liam wrote:
> 
> > > Any reason for not using DAPM here ? Otherwise they are always on
> > > making your chip burn mW.....
> 
> > Not really. As explained in the comment in DAPM patch, this enables will
> > be effective (burn mW) only after respective IO is taken out from
> > STANDBY mode. DAPM takes care of managing STANDBY mode for all IOs and
> > ADC/DAC. I know this way of handling low power mode is bit non-trivial,
> > but it is what is recommended by chip designers. Actually Mark was also
> > initially confused with this and requested to put enough documentation
> > into code. After that I tried explaining the logic in source code
> > comment in DAPM patch. Let me know if it is not clear and doesn't convey
> > clearly what is should.
> 
> That'd be fine but there's no DAPM code in the patch, only code to
> unconditionally enable on init.
> 

Yes, because DAPM part for those IOs is already covered by DAPM patch.
