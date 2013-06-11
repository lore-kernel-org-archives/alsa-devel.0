From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: imx-sgtl5000: Use devm_clk_get()
Date: Mon, 10 Jun 2013 23:04:29 -0300
Message-ID: <CAOMZO5Avoamo-JPEVz4BoXvrmmbQd8C4o5DQ0For5Asueb5jQA@mail.gmail.com>
References: <1370881565-5455-1-git-send-email-fabio.estevam@freescale.com>
 <20130611004437.GA12514@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f170.google.com (mail-vc0-f170.google.com
 [209.85.220.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 144E12619D8
 for <alsa-devel@alsa-project.org>; Tue, 11 Jun 2013 04:04:29 +0200 (CEST)
Received: by mail-vc0-f170.google.com with SMTP id hf12so5051671vcb.29
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2013 19:04:29 -0700 (PDT)
In-Reply-To: <20130611004437.GA12514@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 10, 2013 at 9:44 PM, Shawn Guo <shawn.guo@linaro.org> wrote:

> I do not think the change is correct.  It only works if the struct *dev
> is what imx_sgtl5000 platform_device points to, that is pdev->dev here.
> However what you pass here is codec's.  So when imx_sgtl5000_probe()
> fails or imx_sgtl5000 module is removed, clk_put() will not be called.
> And if I remember correctly, that's the reason why devm_clk_get() wasn't
> used here in the first place.

Ok, as you suggested I think we should handle the clocks at the codec
driver only and pass the codec frequency to the machine driver.

Will work on it tomorrow.
