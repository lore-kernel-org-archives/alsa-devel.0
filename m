From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC 2/4] ASoC: imx-sgtl5000: Let the code clock
	be a mandatory binding
Date: Thu, 18 Apr 2013 00:56:15 -0300
Message-ID: <CAOMZO5CDBBV1H1-uj=qXj5Ayo_Lp57j6tcS7izN3AEGHze9XXg@mail.gmail.com>
References: <1366242921-16376-1-git-send-email-festevam@gmail.com>
 <1366242921-16376-2-git-send-email-festevam@gmail.com>
 <20130418033616.GD20563@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f172.google.com (mail-vc0-f172.google.com
 [209.85.220.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 2BD38265DD4
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2013 05:56:16 +0200 (CEST)
Received: by mail-vc0-f172.google.com with SMTP id gd11so1991295vcb.31
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 20:56:15 -0700 (PDT)
In-Reply-To: <20130418033616.GD20563@S2101-09.ap.freescale.net>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, matt@genesi-usa.com, mfuzzey@gmail.com, broonie@kernel.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 18, 2013 at 12:36 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

>> I am marking this one as RFC because I don't have mx51babbage nor mx53qsb handy
>> to test it.
>
> It works on imx53-qsb but doe not on imx5q-babbage.  That clk_26M is not
> registered to clock framework as a clk provider.

Thanks for testing it, Shawn.

I will investigate this when I get access to a mx51-babbage.

If anyone has any hints as to how register this clk_26M properly via
device tree, please let me know.

Thanks,

Fabio Estevam
