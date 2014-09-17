From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: don't change the root clock rate of
 spdif in driver
Date: Wed, 17 Sep 2014 10:31:28 +0800
Message-ID: <20140917023127.GA16456@dragon>
References: <1410867994-32138-1-git-send-email-shengjiu.wang@freescale.com>
 <20140916180028.GA6784@Asurada> <20140917013251.GA4796@dragon>
 <20140917022440.GA3216@Asurada>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140917022440.GA3216@Asurada>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@freescale.com>, timur@tabi.org, Li.Xiubo@freescale.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 16, 2014 at 07:24:40PM -0700, Nicolin Chen wrote:
> It's not supported in the clock API or just not implemented in our
> code? Can we just register a clock without CLK_SET_RATE_PARENT to
> achieve the purpose? (We are just trying to fix those PRED and PODF
> dividers when the driver calls set_rate to their GATE clock.)

It seems I misunderstood your question.  Yes, if we drop flag
CLK_SET_RATE_PARENT for the gate clock in question, the rate change
request will not be propagated to upstream dividers.

Shawn
