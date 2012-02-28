From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 6/6] ASoC: fsl: check property 'compatible'
 for the machine name
Date: Tue, 28 Feb 2012 11:13:11 +0800
Message-ID: <20120228031308.GI13886@S2101-09.ap.freescale.net>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
	<4F4BFB79.30801@freescale.com>
	<20120228015012.GA13886@S2101-09.ap.freescale.net>
	<4F4C3824.90306@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id 2ABC8243E6
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 03:59:16 +0100 (CET)
Received: by pbcxa12 with SMTP id xa12so4807799pbc.38
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2012 18:59:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F4C3824.90306@freescale.com>
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

On Tue, Feb 28, 2012 at 02:12:53AM +0000, Tabi Timur-B04825 wrote:
> Shawn Guo wrote:
> > Since I was asked by Mark to use new binding for new machine driver,
> > I would drop this patch and keep PowerPC machine drivers working with
> > /model property.
> 
> I think Mark is only concerned with not breaking compatibility with 
> existing device trees.  Both the P1022 and MPC8610 device trees have had 
> this compatible property.
> 
Are you saying that both older and new P1022 device trees have
compatible = "fsl,P1022DS", so that changing to check /compatible
could save the check on /model of P1022 device tree?  Otherwise,
the check between "fsl,P1022" and "fsl,P1022DS" can not be saved.

-- 
Regards,
Shawn
