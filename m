From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 6/6] ASoC: fsl: check property 'compatible'
 for the machine name
Date: Tue, 28 Feb 2012 13:35:39 +0800
Message-ID: <20120228053537.GJ13886@S2101-09.ap.freescale.net>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
	<4F4BFB79.30801@freescale.com>
	<20120228015012.GA13886@S2101-09.ap.freescale.net>
	<4F4C3824.90306@freescale.com>
	<20120228031308.GI13886@S2101-09.ap.freescale.net>
	<4F4C4D3F.3070907@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by alsa0.perex.cz (Postfix) with ESMTP id 286F324381
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 06:21:45 +0100 (CET)
Received: by dady9 with SMTP id y9so2837348dad.38
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2012 21:21:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F4C4D3F.3070907@freescale.com>
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

On Tue, Feb 28, 2012 at 03:42:57AM +0000, Tabi Timur-B04825 wrote:
> Shawn Guo wrote:
> > Are you saying that both older and new P1022 device trees have
> > compatible = "fsl,P1022DS", so that changing to check /compatible
> > could save the check on /model of P1022 device tree?
> 
> Yes, that's what I'm saying.
> 
Ok, I will drop "[PATCH 5/6] ASoC: fsl: use platform_device_id table
to match p1022_ds device" and move to this then.

-- 
Regards,
Shawn
