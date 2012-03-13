From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v4 06/10] ASoC: fsl: check property
 'compatible' for the machine name
Date: Tue, 13 Mar 2012 18:12:58 -0500
Message-ID: <4F5FD47A.9040808@freescale.com>
References: <1331553537-19789-1-git-send-email-shawn.guo@linaro.org>
	<1331553537-19789-7-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db3outboundpool.messaging.microsoft.com
	(db3ehsobe002.messaging.microsoft.com [213.199.154.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 2214F104449
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 00:13:06 +0100 (CET)
In-Reply-To: <1331553537-19789-7-git-send-email-shawn.guo@linaro.org>
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
> Check /compatible rather than /model to determine the machine name.
> The p1022ds older device trees get a different /model from the new
> ones, while /compatible is consistent there, so checking /compatible
> will save the bother of detecting older p1022ds device trees.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---

I'm pretty sure I ack'd this patch already.  Regardless, it does not apply
to for-3.4.

Applying: ASoC: fsl: check property 'compatible' for the machine name
error: patch failed: sound/soc/fsl/fsl_ssi.c:716
error: sound/soc/fsl/fsl_ssi.c: patch does not apply
error: patch failed: sound/soc/fsl/mpc8610_hpcd.c:402
error: sound/soc/fsl/mpc8610_hpcd.c: patch does not apply
error: patch failed: sound/soc/fsl/p1022_ds.c:403
error: sound/soc/fsl/p1022_ds.c: patch does not apply

-- 
Timur Tabi
Linux kernel developer at Freescale
