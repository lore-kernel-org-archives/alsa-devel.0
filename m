From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v4] ASoC: add imx-sgtl5000 machine driver
 working with fsl_ssi
Date: Wed, 14 Mar 2012 19:33:00 +0800
Message-ID: <20120314113258.GG21337@S2101-09.ap.freescale.net>
References: <1331553537-19789-1-git-send-email-shawn.guo@linaro.org>
	<20120314090115.GN3852@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6CDB2103A85
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 12:32:41 +0100 (CET)
Received: by iakh37 with SMTP id h37so2568520iak.38
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 04:32:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120314090115.GN3852@pengutronix.de>
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

On Wed, Mar 14, 2012 at 10:01:15AM +0100, Sascha Hauer wrote:
...
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
Thanks.

> What are the next steps here? Now we have fsl_ssi.c and imx-ssi.c, one
> for dt bindings and the other one for platform bindings and also AC97
> support. They should probably get merged some day which might be a bit
> difficult since currently I don't see the platform users moving over
> to devicetree and the seem to be no AC97 users in powerpc.
> 
When I was tasked to add DT support for imx5 audio driver, it was my
first attempt to add it on top of imx-ssi driver.  But Timur strongly
disagree with that.  Instead, he asked me to reuse fsl_ssi.  That's
why I came up with this series.  I did not really plan to completely
remove imx-ssi by merging it into fsl_ssi.  But if someday we have all
those imx-ssi users migrated to DT, that will become something we
should consider to do then.

-- 
Regards,
Shawn
