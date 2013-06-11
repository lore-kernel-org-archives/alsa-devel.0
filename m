From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] ASoC: imx-sgtl5000: Use devm_clk_get()
Date: Tue, 11 Jun 2013 10:50:40 +0800
Message-ID: <CAAQ0ZWSs7otvj2pO64+8b=QJc=c563SPAPK3unS_VzQA+LLO-w@mail.gmail.com>
References: <1370881565-5455-1-git-send-email-fabio.estevam@freescale.com>
 <20130611004437.GA12514@S2101-09.ap.freescale.net>
 <CAOMZO5Avoamo-JPEVz4BoXvrmmbQd8C4o5DQ0For5Asueb5jQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f45.google.com (mail-pb0-f45.google.com
 [209.85.160.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 99A1C261A13
 for <alsa-devel@alsa-project.org>; Tue, 11 Jun 2013 04:50:42 +0200 (CEST)
Received: by mail-pb0-f45.google.com with SMTP id mc8so7945214pbc.32
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2013 19:50:41 -0700 (PDT)
In-Reply-To: <CAOMZO5Avoamo-JPEVz4BoXvrmmbQd8C4o5DQ0For5Asueb5jQA@mail.gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 10, 2013 at 11:04:29PM -0300, Fabio Estevam wrote:
> On Mon, Jun 10, 2013 at 9:44 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
>
> > I do not think the change is correct.  It only works if the struct *dev
> > is what imx_sgtl5000 platform_device points to, that is pdev->dev here.
> > However what you pass here is codec's.  So when imx_sgtl5000_probe()
> > fails or imx_sgtl5000 module is removed, clk_put() will not be called.
> > And if I remember correctly, that's the reason why devm_clk_get() wasn't
> > used here in the first place.
>
> Ok, as you suggested I think we should handle the clocks at the codec
> driver only and pass the codec frequency to the machine driver.

Why do you need to pass it at all?  It seems to me that the machine
driver only needs the frequency to set up sgtl5000 sysclk.  So it ends
up with something below.

 - sgtl5000 driver calls clk_get_rate() to get the frequency
 - sgtl5000 driver passes the frequency to imx-sgtl500 driver
 - imx-sgtl500 driver sets the frequency back to sgtl5000 via
   .set_sysclk callback

I need some help to understand why sgtl5000 driver can not just set up
its sysclk but having to do the above.

Shawn
