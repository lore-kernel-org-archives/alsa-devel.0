From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: don't change the root
 clock rate of spdif in driver
Date: Tue, 16 Sep 2014 11:19:28 -0700
Message-ID: <20140916180028.GA6784@Asurada>
References: <1410867994-32138-1-git-send-email-shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f179.google.com (mail-pd0-f179.google.com
 [209.85.192.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 142A3261A7F
 for <alsa-devel@alsa-project.org>; Tue, 16 Sep 2014 20:20:15 +0200 (CEST)
Received: by mail-pd0-f179.google.com with SMTP id g10so301208pdj.38
 for <alsa-devel@alsa-project.org>; Tue, 16 Sep 2014 11:20:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1410867994-32138-1-git-send-email-shengjiu.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shengjiu Wang <shengjiu.wang@freescale.com>, shawn.guo@freescale.com
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de, Li.Xiubo@freescale.com, timur@tabi.org, broonie@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 16, 2014 at 07:46:34PM +0800, Shengjiu Wang wrote:
> The spdif root clock may be used by other module or defined with
> CLK_SET_RATE_GATE, so we can't change the clock rate in driver.
> In this patch remove the clk_set_rate and clk_round_rate to protect the
> clock.

It's a quite convenient and conservative way to remove the clock
dealing code in the driver, however, it may result less flexible
functionalities.

The reason why I left the clk_set_rate() in the driver is to hope
we may find a better way to tackle those tough situations. For IP
itself, it doesn't matter if the clock the SoC provides to it is
being shared by other modules or not.

So I think, if it's a shared clock, we should not define it as a
rate-changeable one in the SoC level, as we might still have some
SoCs provide a dedicated clock to S/PDIF so as to get the maximum
range of clock support for users.

@Shawn
Sorry to involve you in this topic. I'm not so sure if we can do
this in the clock driver so that the clock rate would be fixed
even if the driver is trying to change it. If we can, I think we
may use a better solution here instead.

Thank you
Nicolin
