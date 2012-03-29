From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC: fsl: enable ssi clock in probe
	function
Date: Thu, 29 Mar 2012 11:01:21 -0500
Message-ID: <4F748751.3020300@freescale.com>
References: <1332989621-5211-1-git-send-email-shawn.guo@linaro.org>
	<20120329112949.GM3668@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
	(tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 52A81103B71
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 18:01:34 +0200 (CEST)
In-Reply-To: <20120329112949.GM3668@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> Applied, thanks (though checking return codes would be nice).  

Speaking of return codes, I can't even get ASoC for-3.5 to compile:

/home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c: In function
'soc_bind_dai_link':
/home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c:805:11: error:
'EPROBE_DEFER' undeclared (first use in this function)
/home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c:805:11: note: each
undeclared identifier is reported only once for each function it appears in
/home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c: In function
'soc_check_aux_dev':
/home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c:1346:10: error:
'EPROBE_DEFER' undeclared (first use in this function)
/home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c: In function
'soc_probe_aux_dev':
/home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c:1369:10: error:
'EPROBE_DEFER' undeclared (first use in this function)
/home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c: In function
'soc_check_aux_dev':
/home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c:1347:1: warning:
control reaches end of non-void function



-- 
Timur Tabi
Linux kernel developer at Freescale
