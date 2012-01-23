From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: [PATCH v2] ASoC: da7210: Add support for PLL and
 SRM
Date: Mon, 23 Jan 2012 17:39:21 +0530
Message-ID: <1327320561.31594.23.camel@matrix>
References: <1327313241.31594.12.camel@matrix>
	<20120123112142.GA29465@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) by alsa0.perex.cz (Postfix) with ESMTP id 821C9244EB
	for <alsa-devel@alsa-project.org>; Mon, 23 Jan 2012 12:57:28 +0100 (CET)
In-Reply-To: <20120123112142.GA29465@opensource.wolfsonmicro.com>
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

On Mon, 2012-01-23 at 11:21 +0000, Mark Brown wrote:
> On Mon, Jan 23, 2012 at 03:37:21PM +0530, Ashish Chavan wrote:
> 
> > +/* PLL out frequency values */
> > +#define FOUT_2822400		2822400
> > +#define FOUT_3072000		3072000
> 
> It's difficult to see what these defines are adding.

Yes, true. Anyways, converting if-else in to switch will make them
unnecessary.

> 
> > +static const u32 da7210_fout_2822400_div[][DIV_CNT + 1] = {
> > +	{ 12000000, 0xE8, 0x6C, 0x2, },		/* MCLK=12Mhz    Fs=44.1Khz */
> 
> You're still using magic numbers to find the dividers, and clearly the
> same rate comment should apply to the whole table not specific entries.

OK, will define a new constant for column count and update comment.

> 
> > +		/* In PLL master mode, use master mode PLL dividers */
> > +		if (fout == FOUT_2822400) {
> 
> 
> > +		} else if (fout == FOUT_3072000) {
> 
> This looks like a switch statement and...

Yes, will make it a switch instead of if-else.
> 
> > +			for (row_idx = 0; row_idx < FREF_CNT; row_idx++) {
> 
> ARRAY_SIZE()
> 
> > +				if (fref == da7210_fout_3072000_div[row_idx]
> > +								[FREF_IDX]) {
> > +					pll_div1 =
> > +						da7210_fout_3072000_div[row_idx]
> > +						[DIV1_IDX];
> 
> ...this code is shared between both branches (as well as the SRM case)
> and should be factored out between them.
> 
We are picking values from three different tables in three cases. Even
if we factor out this code, we will need a switch or if-else to identify
correct table. As we are already checking those conditions, I put the
code there. Can you please elaborate a bit, in case if I misunderstood
your point?
