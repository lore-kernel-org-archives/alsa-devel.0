From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: don't change the root
 clock rate of spdif in driver
Date: Tue, 16 Sep 2014 19:50:15 -0700
Message-ID: <20140917025014.GA6048@Asurada>
References: <1410867994-32138-1-git-send-email-shengjiu.wang@freescale.com>
 <20140916180028.GA6784@Asurada> <20140917013251.GA4796@dragon>
 <20140917022440.GA3216@Asurada> <20140917023127.GA16456@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f172.google.com (mail-pd0-f172.google.com
 [209.85.192.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 0627F26516D
 for <alsa-devel@alsa-project.org>; Wed, 17 Sep 2014 04:50:33 +0200 (CEST)
Received: by mail-pd0-f172.google.com with SMTP id v10so1137823pde.3
 for <alsa-devel@alsa-project.org>; Tue, 16 Sep 2014 19:50:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140917023127.GA16456@dragon>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Shengjiu Wang <shengjiu.wang@freescale.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de, linux-kernel@vger.kernel.org, broonie@kernel.org, timur@tabi.org, Li.Xiubo@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 17, 2014 at 10:31:28AM +0800, Shawn Guo wrote:
> On Tue, Sep 16, 2014 at 07:24:40PM -0700, Nicolin Chen wrote:
> > It's not supported in the clock API or just not implemented in our
> > code? Can we just register a clock without CLK_SET_RATE_PARENT to
> > achieve the purpose? (We are just trying to fix those PRED and PODF
> > dividers when the driver calls set_rate to their GATE clock.)
> 
> It seems I misunderstood your question.  Yes, if we drop flag
> CLK_SET_RATE_PARENT for the gate clock in question, the rate change
> request will not be propagated to upstream dividers.

Okay. Since there's a solution that allows us to handle it better,
problem solved then.

@Shengjiu
Would you please take a look at the clock driver to implement a
new clock register function? And make sure to register the GATE
clock only without the flag CLK_SET_RATE_PARENT, as we may still
need to set a reasonable rate for the clock by setting its PODF
clock node instead.

Thank you both
Nicolin
