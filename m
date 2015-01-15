From: Zidan Wang <b50113@freescale.com>
Subject: Re: [PATCH v2 2/2] ASoC: wm8960: Let wm8960 driver
 configure its bit clock and frame clock
Date: Thu, 15 Jan 2015 21:34:40 +0800
Message-ID: <20150115133439.GA29323@b50113>
References: <1420615905-4078-1-git-send-email-zidan.wang@freescale.com>
 <1420615905-4078-2-git-send-email-zidan.wang@freescale.com>
 <20150114192703.GH3043@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0118.outbound.protection.outlook.com [157.56.110.118])
 by alsa0.perex.cz (Postfix) with ESMTP id AF19B26059D
 for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2015 14:33:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20150114192703.GH3043@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, Zidan Wang <zidan.wang@freescale.com>, tiwai@suse.de, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 14, 2015 at 07:27:03PM +0000, Mark Brown wrote:
> On Wed, Jan 07, 2015 at 03:31:45PM +0800, Zidan Wang wrote:
> 
> > +	for (i = 0; i < ARRAY_SIZE(dac_divs); ++i) {
> > +		if (wm8960->sysclk == lrclk * dac_divs[i]) {
> > +			for (j = 0; j < ARRAY_SIZE(bclk_divs); ++j) {
> > +				if (wm8960->sysclk ==  wm8960->bclk *
> > +						bclk_divs[j] / 10) {
> > +					goto config_clock;
> > +				}
> > +			}
> > +		}
> > +	}
> > +
> > +	dev_err(codec->dev, "Unsupported sysclk %d\n", wm8960->sysclk);
> > +	return;
> 
> It's a bit awkward using the goto like this.  A more common way of
> writing this is to change the above block to be
> 
> 	if (i == ARRAY_SIZE(dac_divs))
> 		/* return error */
> 
> rather than skipping over the error.  Otherwise this looks good.

Hi Mark,

I found it can't generate bclk for S20_3LE data format.

For 2 channel S20_3LE data format:

bclk = fs * 20 * 2
Sysclk = BCLKDIV * bclk = BCLKDIV * fs * 40
Sysclk = DACDIV * fs * 256

BCLKDIV/DACDIV = 256/40 = 32/5

But BCLKDIV/DACDIV can't be 32/5. So I want to support tdm slot.

bclk = fs * slot_width * slots * channal.

Do you think it make sense, or any other ideas?

Best Regards,
Zidan
