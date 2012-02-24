From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 6/6] ASoC: fsl: check property 'compatible'
 for the machine name
Date: Sat, 25 Feb 2012 07:23:01 +0800
Message-ID: <20120224232259.GB24268@S2101-09.ap.freescale.net>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
	<4F47BBB2.7090100@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51])
	by alsa0.perex.cz (Postfix) with ESMTP id BCBF9104340
	for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2012 00:09:20 +0100 (CET)
Received: by dady9 with SMTP id y9so3306019dad.38
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 15:09:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F47BBB2.7090100@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 24, 2012 at 10:32:50AM -0600, Timur Tabi wrote:
> Shawn Guo wrote:
> > It seems the fsl_ssi PowerPC users, machine mpc8610_hpcd and p1022ds,
> > basically have the same thing in model and compatible properties.
> > Detecting machine name using compatible property becomes a solution
> > working for both PowerPC and ARM users of fsl_ssi.
> 
> Do you actually have an 8610 or P1022 to test this?  I'm guessing the
> answer is no.
> 
No, I do not.  I only compile-tested it.  I need your favor here.

-- 
Regards,
Shawn
