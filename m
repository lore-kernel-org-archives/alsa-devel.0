From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 10/17] ASoC: imx: merge sound/soc/imx
 into sound/soc/fsl
Date: Tue, 6 Mar 2012 07:46:27 +0800
Message-ID: <20120305234626.GK16232@S2101-09.ap.freescale.net>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
	<1330957865-19085-11-git-send-email-shawn.guo@linaro.org>
	<20120305173910.GZ3852@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-tul01m020-f179.google.com (mail-tul01m020-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E56D22417D
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 00:31:55 +0100 (CET)
Received: by obbup3 with SMTP id up3so5227363obb.38
	for <alsa-devel@alsa-project.org>; Mon, 05 Mar 2012 15:31:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120305173910.GZ3852@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 05, 2012 at 06:39:10PM +0100, Sascha Hauer wrote:
> On Mon, Mar 05, 2012 at 10:30:58PM +0800, Shawn Guo wrote:
> > Freescale PowerPC and ARM/IMX families share the same SSI IP block.
> > The patch merges sound/soc/imx into sound/soc/fsl, so that the possible
> > code sharing and consolidation can happen.
> > 
> > This is a plain merge, except that menuconfig SND_POWERPC_SOC is added
> > in Kconfig for PowerPC platform as a correspondence to SND_IMX_SOC for
> > IMX platform.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  sound/soc/Kconfig                        |    1 -
> >  sound/soc/Makefile                       |    1 -
> >  sound/soc/fsl/Kconfig                    |   92 ++++++++++++++++++++++++++++++
> >  sound/soc/fsl/Makefile                   |   22 +++++++
> >  sound/soc/{imx => fsl}/eukrea-tlv320.c   |    2 +-
> >  sound/soc/{imx => fsl}/imx-audmux.c      |    0
> >  sound/soc/{imx => fsl}/imx-audmux.h      |    0
> >  sound/soc/{imx => fsl}/imx-pcm-dma-mx2.c |    0
> 
> Maybe this is the right time to rename this file to something like
> imx-pcm-dma.c since it has nothing to do with mx2 anymore.
> 
Ok, will do.

-- 
Regards,
Shawn
