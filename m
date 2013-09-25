From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: imx-sgtl5000: do not use devres on a
 foreign device
Date: Wed, 25 Sep 2013 10:23:05 -0300
Message-ID: <CAOMZO5BJQAGRDXNFng1BJ1RWAsLMKwUapTivDQ4PM0ytd=mG-w@mail.gmail.com>
References: <1380104168-29678-1-git-send-email-p.zabel@pengutronix.de>
 <20130925121428.GA21081@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f170.google.com (mail-vc0-f170.google.com
 [209.85.220.170])
 by alsa0.perex.cz (Postfix) with ESMTP id EF1552654BA
 for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2013 15:23:06 +0200 (CEST)
Received: by mail-vc0-f170.google.com with SMTP id kw10so4383591vcb.15
 for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2013 06:23:06 -0700 (PDT)
In-Reply-To: <20130925121428.GA21081@S2101-09.ap.freescale.net>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Arnaud Patard <arnaud.patard@rtp-net.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 25, 2013 at 9:14 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
>
> This is a known issue [1].  Thanks for fixing it.

Correct. I missed to fix it after Shawn reported it.

Regards,

Fabio Estevam
