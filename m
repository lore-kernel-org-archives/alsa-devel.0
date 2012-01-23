From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH v2] ASoC: da7210: Add support for PLL and SRM
Date: Mon, 23 Jan 2012 11:21:43 +0000
Message-ID: <20120123112142.GA29465@opensource.wolfsonmicro.com>
References: <1327313241.31594.12.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1327313241.31594.12.camel@matrix>
Sender: linux-kernel-owner@vger.kernel.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: lrg <lrg@ti.com>, alsa-devel <alsa-devel@alsa-project.org>, David Dajun Chen <david.chen@diasemi.com>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 23, 2012 at 03:37:21PM +0530, Ashish Chavan wrote:

> +/* PLL out frequency values */
> +#define FOUT_2822400		2822400
> +#define FOUT_3072000		3072000

It's difficult to see what these defines are adding.

> +static const u32 da7210_fout_2822400_div[][DIV_CNT + 1] = {
> +	{ 12000000, 0xE8, 0x6C, 0x2, },		/* MCLK=12Mhz    Fs=44.1Khz */

You're still using magic numbers to find the dividers, and clearly the
same rate comment should apply to the whole table not specific entries.

> +		/* In PLL master mode, use master mode PLL dividers */
> +		if (fout == FOUT_2822400) {


> +		} else if (fout == FOUT_3072000) {

This looks like a switch statement and...

> +			for (row_idx = 0; row_idx < FREF_CNT; row_idx++) {

ARRAY_SIZE()

> +				if (fref == da7210_fout_3072000_div[row_idx]
> +								[FREF_IDX]) {
> +					pll_div1 =
> +						da7210_fout_3072000_div[row_idx]
> +						[DIV1_IDX];

...this code is shared between both branches (as well as the SRM case)
and should be factored out between them.
