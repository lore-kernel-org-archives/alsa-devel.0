From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 4/6] ASoC: fsl: create fsl_utils to
 accommodate the common functions
Date: Mon, 27 Feb 2012 12:15:29 -0600
Message-ID: <4F4BC841.7000407@freescale.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-5-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.31])
	by alsa0.perex.cz (Postfix) with ESMTP id 96092103B0F
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2012 19:15:49 +0100 (CET)
In-Reply-To: <1330092582-21180-5-git-send-email-shawn.guo@linaro.org>
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
> There are some amount of code duplication between mpc8610_hpcd and
> p1022_ds machine drivers, and the same code will be duplicated again
> when another new machine driver is added.  The patch creates fsl_utils
> to accommodate the common functions to stop the code duplication.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---

What repository is this for?  When I apply it to Mark's for-next branch, I
get this:

Applying: ASoC: fsl: create fsl_utils to accommodate the common functions
error: patch failed: sound/soc/fsl/Kconfig:1
error: sound/soc/fsl/Kconfig: patch does not apply
error: patch failed: sound/soc/fsl/Makefile:8
error: sound/soc/fsl/Makefile: patch does not apply
Patch failed at 0004 ASoC: fsl: create fsl_utils to accommodate the common
functions
When you have resolved this problem run "git am --resolved".
If you would prefer to skip this patch, instead run "git am --skip".
To restore the original branch and stop patching run "git am --abort".

-- 
Timur Tabi
Linux kernel developer at Freescale
