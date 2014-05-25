From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v4] ASoC: sgtl5000: Fix the cache handling
Date: Sun, 25 May 2014 16:13:21 +0800
Message-ID: <20140525081320.GB13258@dragon>
References: <1400958960-18775-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0236.outbound.protection.outlook.com [207.46.163.236])
 by alsa0.perex.cz (Postfix) with ESMTP id D86C926084B
 for <alsa-devel@alsa-project.org>; Sun, 25 May 2014 10:13:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1400958960-18775-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@kernel.org, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

Fabio,

On Sat, May 24, 2014 at 04:16:00PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Since commit e5d80e82e32e (ASoC: sgtl5000: Convert to use regmap directly) a 
> kernel oops is observed after a suspend/resume sequence.
> 
> According to Mark Brown:
> 
> "Looking at the code what I'd expect to happen here is that
> set_bias_level() manages the cache enable, turning on cache only mode
> just before it turns the regulators off and restoring normal mode just
> after enabling them, then calling _restore_regs() after that.  The
> resume call should just be a call to set_bias_level() then.."
> 
> Do as suggested and also complete the cache array with the missing registers
> so that sgtl5000_restore_regs() can properly cache the all the registers it 
> needs.
> 
> Reported-by: Shawn Guo <shawn.guo@freescale.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

I'm not sure if it's the problem of this patch, but when I test
suspend/resume cycle with a wave playback running background, the
playback goes abnormal after system resumes back.  I did this test with
your patch 'ASoC: fsl_ssi: Add suspend/resume support' applied.

The same test goes fine with wm8962 on imx6q-sabresd board.

Shawn
