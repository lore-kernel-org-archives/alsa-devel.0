From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: [PATCH] ASoC: da7210: Minor update for PLL and SRM
Date: Tue, 17 Apr 2012 21:00:02 +0530
Message-ID: <1334676602.13279.13.camel@matrix>
References: <1334674858.13279.9.camel@matrix>
	<20120417145618.GL6652@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 34F8D10416D
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Apr 2012 17:18:13 +0200 (CEST)
In-Reply-To: <20120417145618.GL6652@opensource.wolfsonmicro.com>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, linux-kernel <linux-kernel@vger.kernel.org>, David@alsa-project.org, Chen <david.chen@diasemi.com>, lrg <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2012-04-17 at 15:56 +0100, Mark Brown wrote:
> On Tue, Apr 17, 2012 at 08:30:58PM +0530, Ashish Chavan wrote:
> 
> > +		if ((fref == da7210_pll_div[cnt].fref) &&
> > +			(da7210->master ==  da7210_pll_div[cnt].mode) &&
> > +			(fout == da7210_pll_div[cnt].fout)) {
> 
> Since this is just a coding style thing how about lining up the (s for
> the branches?

To do that we will have to use spaces instead of tab for indentation. I
am not sure if that is fine. You mean something like below, right?

		if ((fref == da7210_pll_div[cnt].fref) &&
		    (da7210->master ==  da7210_pll_div[cnt].mode) &&
		    (fout == da7210_pll_div[cnt].fout)) {
