From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] Davinci: DM365: Enable DaVinci Voice
 Codec support for DM365 EVM
Date: Wed, 20 Jan 2010 15:01:43 +0000
Message-ID: <20100120150143.GA29114@rakim.wolfsonmicro.main>
References: <20100108113121.GB10128@sirena.org.uk>
	<4B476D3B.3050200@ridgerun.com>
	<20100108193720.GA3088@sirena.org.uk>
	<4B4B3F97.8060508@ridgerun.com>
	<20100111153458.GA2661@rakim.wolfsonmicro.main>
	<4B4B4987.1080507@ridgerun.com>
	<20100111162101.GA26771@rakim.wolfsonmicro.main>
	<4B561A54.6070201@ridgerun.com>
	<20100119221015.GA29306@sirena.org.uk>
	<4B5713F1.1050407@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D598D2459B
	for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2010 16:01:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B5713F1.1050407@ridgerun.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com, "Nori, Sekhar" <nsekhar@ti.com>, diego.dompe@ridgerun.com, alsa-devel@alsa-project.org, "Narnakaje, Snehaprabha" <nsnehaprabha@ti.com>, todd.fischer@ridgerun.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 20, 2010 at 08:32:17AM -0600, Miguel Aguilar wrote:

> Ok, machine driver you mean sound/soc/davinci/davinci-evm.c file?

Yes.

> So at the moment I will use ifdef to choose by using the
> configuration menu one codec or the other one at time, as you said
> it should be straightforward to enable the AIC3x and the Voice Codec
> simultaneously.

Sounds like a plan - hopefully even just as part of the generic update
work.
