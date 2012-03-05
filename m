From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 15/20] ASoC: fsl: make fsl_ssi driver
 compilable on ARM/IMX
Date: Mon, 5 Mar 2012 21:40:51 +0800
Message-ID: <20120305134048.GG16232@S2101-09.ap.freescale.net>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
	<1330788001-10158-16-git-send-email-shawn.guo@linaro.org>
	<4F53F704.8080703@freescale.com>
	<20120305073930.GC16232@S2101-09.ap.freescale.net>
	<4F54B183.4080607@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9DE5C104199
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 14:26:24 +0100 (CET)
Received: by ggni2 with SMTP id i2so1610008ggn.38
	for <alsa-devel@alsa-project.org>; Mon, 05 Mar 2012 05:26:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F54B183.4080607@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 05, 2012 at 12:28:52PM +0000, Tabi Timur-B04825 wrote:
> Shawn Guo wrote:
> > Yeah, it makes the diff neat.  However I would make it an inline
> > function which is easier to play.
> 
> However you want to do it is fine with me, although I would use "u32 
> __iomem *addr" instead of "void __iomem *addr".
> 
Right, will make the change. 

-- 
Regards,
Shawn
