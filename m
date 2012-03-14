From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v4] ASoC: add imx-sgtl5000 machine driver
 working with fsl_ssi
Date: Wed, 14 Mar 2012 18:02:44 -0500
Message-ID: <4F612394.4060703@freescale.com>
References: <1331553537-19789-1-git-send-email-shawn.guo@linaro.org>
	<20120314090115.GN3852@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
	(tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A07210414F
	for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2012 00:02:51 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Sascha Hauer wrote:
> What are the next steps here? Now we have fsl_ssi.c and imx-ssi.c, one
> for dt bindings and the other one for platform bindings and also AC97
> support. They should probably get merged some day which might be a bit
> difficult since currently I don't see the platform users moving over
> to devicetree and the seem to be no AC97 users in powerpc.

I don't have any problem with adding AC97 support to fsl_ssi.c, assuming
it's not a huge mess.  I don't know enough about AC97 to know how easy
that is, though.

-- 
Timur Tabi
Linux kernel developer at Freescale
