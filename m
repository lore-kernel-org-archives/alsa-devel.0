From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: [PATCH v2] ASoC: da7210: Add support for PLL and
 SRM
Date: Tue, 17 Apr 2012 19:51:00 +0530
Message-ID: <1334672460.13279.3.camel@matrix>
References: <1334666046.32225.8.camel@matrix>
	<20120417134351.GD6652@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db3outboundpool.messaging.microsoft.com
	(db3ehsobe004.messaging.microsoft.com [213.199.154.142])
	by alsa0.perex.cz (Postfix) with ESMTP id 656B724542
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Apr 2012 16:09:19 +0200 (CEST)
In-Reply-To: <20120417134351.GD6652@opensource.wolfsonmicro.com>
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

On Tue, 2012-04-17 at 14:43 +0100, Mark Brown wrote:
> On Tue, Apr 17, 2012 at 06:04:06PM +0530, Ashish Chavan wrote:
> 
> > +	/* Search pll div array for correct divisors */
> > +	for (cnt = 0; cnt < ARRAY_SIZE(da7210_pll_div); cnt++) {
> > +		/* check fref */
> > +		if (fref == da7210_pll_div[cnt].fref) {
> > +			/* check mode */
> > +			 if (da7210->master ==  da7210_pll_div[cnt].mode) {
> > +				/* check fout */
> > +				if (fout == da7210_pll_div[cnt].fout) {
> 
> I've applied but this would be a lot clearer if it were writen as a
> single if statement with &&s.

Actually I implemented it like that first. But then realized that
because of the 80 chars limit and long conditions, readability was
hampered. Let me submit a patch to convert it to single if, if that is
preferred way of doing it.
