From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v5 2/8] ASoC: imx: merge sound/soc/imx into
	sound/soc/fsl
Date: Sat, 17 Mar 2012 08:21:30 +0800
Message-ID: <20120317002128.GC7860@S2101-09.ap.freescale.net>
References: <1331888204-27058-1-git-send-email-shawn.guo@linaro.org>
	<1331888204-27058-3-git-send-email-shawn.guo@linaro.org>
	<4F63AEE7.4030505@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8302424490
	for <alsa-devel@alsa-project.org>; Sat, 17 Mar 2012 01:20:54 +0100 (CET)
Received: by iakh37 with SMTP id h37so6827584iak.38
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 17:20:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F63AEE7.4030505@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>, Kumar Gala <galak@kernel.crashing.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 16, 2012 at 04:21:43PM -0500, Timur Tabi wrote:
> Shawn Guo wrote:
> > Freescale PowerPC and ARM/IMX families share the same SSI IP block.
> > The patch merges sound/soc/imx into sound/soc/fsl, so that the possible
> > code sharing and consolidation can happen.
> > 
> > This is a plain merge, except that menuconfig SND_POWERPC_SOC is added
> > in Kconfig for PowerPC platform as a correspondence to SND_IMX_SOC for
> > IMX platform.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> 
> I'm okay with this patch, but you will need an Ack from Kumar Gala to
> carry the defconfig portions through the ASoC tree.  Or, he might want you
> to split the patch up.
> 
Splitting the patch up will introduce a dependency between PowerPC tree
and sound tree.  Since the change is trivial enough (one line change),
even if there is a merge conflict (very unlikely, just tried linux-next
and did not see), Linus will be able to handle it.  So I'd rather not
split.  What'd you say, Kumar?

> >  arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig |    1 +
> >  arch/powerpc/configs/mpc85xx_defconfig           |    1 +
> >  arch/powerpc/configs/mpc85xx_smp_defconfig       |    1 +

-- 
Regards,
Shawn
