From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: add wm8960 support
Date: Thu, 13 Aug 2015 20:58:06 -0700
Message-ID: <20150814035805.GA2180@Asurada>
References: <dc4e5a52a90982cea95445e27a30f2ad6cb73513.1439349623.git.zidan.wang@freescale.com>
 <20150812034257.GA2980@Asurada-CZ80>
 <20150812044505.GA21786@shlinux2>
 <20150812064053.GA2807@Asurada-CZ80>
 <20150812073859.GB21786@shlinux2>
 <20150812222735.GA57015@Asurada-CZ80>
 <20150814022116.GA11145@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
 [209.85.220.49])
 by alsa0.perex.cz (Postfix) with ESMTP id EF94C260A56
 for <alsa-devel@alsa-project.org>; Fri, 14 Aug 2015 05:58:17 +0200 (CEST)
Received: by pabyb7 with SMTP id yb7so50924707pab.0
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2015 20:58:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150814022116.GA11145@shlinux2>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, tiwai@suse.com, timur@tabi.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 14, 2015 at 10:21:18AM +0800, Zidan Wang wrote:

> > And there is a crucial problem I can imagine:
> >   Is it okay to set this bit while setting SD1_CLK PAD as one
> >   of other functions rather than SAI MCLK? -- Customers might
> >   keep your code as they also use SAI2 while using SD1_CLK PAD
> >   as a GPIO input.

> I just add a gpr node in device tree, if customer want to use SD1_CLK
> PAD as a GPIO input, remove the gpr node.

My question was whether setting this bit would cause a hardware
damage -- Customers might not notice your gpr node in the Device
Tree at all, not to mention the possibility of an accidental wrong
configurations.

And another reason I asked that is to find out if we can set these
bits anyway in the SoC level driver of imx6ul when this bit would
not cause anything dangerous and when there's no extra clock MUX
for the SAI MCLK between internal CCM and external clock source.

Nicolin
