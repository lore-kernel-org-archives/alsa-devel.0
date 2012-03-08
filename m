From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v3 09/11] ASoC: fsl: remove the fatal error
 checking on codec-handle
Date: Thu, 8 Mar 2012 14:50:21 -0600
Message-ID: <4F591B8D.8090705@freescale.com>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
	<1331225990-27308-10-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
	(tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
	by alsa0.perex.cz (Postfix) with ESMTP id D9E301041F8
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 21:50:34 +0100 (CET)
In-Reply-To: <1331225990-27308-10-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Shawn Guo wrote:
> As Documentation/devicetree/bindings/powerpc/fsl/ssi.txt documented,
> codec-handle is an optional property, so missing it should not be a
> fatal error.]

It's optional in the sense that if your SSI is not connected to anything,
then you don't need to specify the codec handle.  If the SSI is connected
to a codec, then the SSI node needs to point to it.

> More importantly, the imx machine drivers to be added working with
> fsl_ssi will not have this property, as they use new ASoC machine
> driver binding mechanism.

I want to see that binding documented in Documentation/devicetree/bindings
first.

-- 
Timur Tabi
Linux kernel developer at Freescale
