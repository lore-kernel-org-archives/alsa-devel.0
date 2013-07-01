From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/4] ASoC: sgtl5000: give it a ramping time
 before writting
Date: Mon, 1 Jul 2013 23:33:29 +0800
Message-ID: <20130701153327.GX13206@S2101-09.ap.freescale.net>
References: <1372666571-17276-1-git-send-email-shawn.guo@linaro.org>
 <1372666571-17276-2-git-send-email-shawn.guo@linaro.org>
 <20130701100710.GB27646@sirena.org.uk>
 <201307011254.18952.marex@denx.de>
 <CAOMZO5BAs5-Tf_O0TVLFAuCchVuukV+bH2MpjqMU83tTw2GD=Q@mail.gmail.com>
 <20130701142610.GR13206@S2101-09.ap.freescale.net>
 <20130701143415.GA14172@S2101-09.ap.freescale.net>
 <CAOMZO5Bh5CZLBO-epVA9Vivo-mqmBJZhy7iA6HiMy+xLzDj40w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 480852651BF
 for <alsa-devel@alsa-project.org>; Mon,  1 Jul 2013 17:33:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAOMZO5Bh5CZLBO-epVA9Vivo-mqmBJZhy7iA6HiMy+xLzDj40w@mail.gmail.com>
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
Cc: Marek Vasut <marex@denx.de>, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 01, 2013 at 12:11:58PM -0300, Fabio Estevam wrote:
> On Mon, Jul 1, 2013 at 11:34 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> 
> > And also why we do not see the impact of i2c issue on sgtl5000 before
> > the offending commit af8ee11 (ASoC: sgtl5000: Fix driver probe after
> > reset)?
> 
> Probably because the mxs i2c was working before this commit.

Do you have a commit id at which mxs i2c is known good?  I would like to
find out it's a mxs i2c issue or sgtl5000 problem.

> 
> Commit af8ee11 does fix the reset probe on mx51/mx53/mx6.
> 
> It's only on mx28 that we have this issue.
> 
> Also, please see this patch from Alexandre Belloni:
> https://lkml.org/lkml/2013/6/24/430
> 
> He can only connect the ADC chip if he uses I2C bitbang mode on mx28.

Does I2C bitbang mode help fix the sgtl5000 issue here?

Shawn
