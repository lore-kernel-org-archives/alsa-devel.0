From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 2/2] ASoC: imx-wm8962: Fix codec_clk
 cleanup
Date: Tue, 28 Mar 2017 16:42:38 +0100
Message-ID: <20170328154238.GS6986@localhost.localdomain>
References: <1490691532-2086-1-git-send-email-daniel.baluta@nxp.com>
 <1490691532-2086-3-git-send-email-daniel.baluta@nxp.com>
 <20170328092103.GQ6986@localhost.localdomain>
 <CAEnQRZAx1o9xtbf3u1A_Zun7MSaJjdjunpJm1Q6=ZAA3beoFbA@mail.gmail.com>
 <20170328115306.GR6986@localhost.localdomain>
 <20170328152457.2j5zaxdbdavpuspa@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 4429726583C
 for <alsa-devel@alsa-project.org>; Tue, 28 Mar 2017 17:41:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20170328152457.2j5zaxdbdavpuspa@sirena.org.uk>
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Xiubo.Lee@gmail.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, linuxppc-dev@lists.ozlabs.org, fabio.estevam@nxp.com, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 28, 2017 at 04:24:57PM +0100, Mark Brown wrote:
> On Tue, Mar 28, 2017 at 12:53:06PM +0100, Charles Keepax wrote:
> > On Tue, Mar 28, 2017 at 01:47:04PM +0300, Daniel Baluta wrote:
> 
> > > >> -     codec_clk = devm_clk_get(&codec_dev->dev, NULL);
> > > >> +     codec_clk = clk_get(&codec_dev->dev, NULL);
> 
> > > is different from &codec_dev->dev.
> 
> > I get that they are different, I just don't get why changing
> > from a devm_clk_get to a clk_get is a better fix than changing
> > &codec->dev to &pdev->dev.
> 
> This should be clear from the semantics of clk_get(): you're looking up
> the clock in the context of the supplied device and the clock is
> attached to the CODEC so you need to look up in the CODEC context.  What
> would be even better would be to move the allocation of the clock into
> the CODEC driver...

Ah yes thats what I was missing.

Thanks,
Charles
