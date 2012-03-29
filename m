From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] ASoC: fsl: enable ssi clock in probe
	function
Date: Fri, 30 Mar 2012 00:09:19 +0800
Message-ID: <20120329160916.GG19506@S2101-09.ap.freescale.net>
References: <1332989621-5211-1-git-send-email-shawn.guo@linaro.org>
	<20120329112949.GM3668@opensource.wolfsonmicro.com>
	<4F748751.3020300@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9693D103F71
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 18:09:26 +0200 (CEST)
Received: by iakh37 with SMTP id h37so3343435iak.38
	for <alsa-devel@alsa-project.org>; Thu, 29 Mar 2012 09:09:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F748751.3020300@freescale.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 29, 2012 at 11:01:21AM -0500, Timur Tabi wrote:
> Mark Brown wrote:
> > Applied, thanks (though checking return codes would be nice).  
> 
> Speaking of return codes, I can't even get ASoC for-3.5 to compile:
> 
> /home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c: In function
> 'soc_bind_dai_link':
> /home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c:805:11: error:
> 'EPROBE_DEFER' undeclared (first use in this function)
> /home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c:805:11: note: each
> undeclared identifier is reported only once for each function it appears in
> /home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c: In function
> 'soc_check_aux_dev':
> /home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c:1346:10: error:
> 'EPROBE_DEFER' undeclared (first use in this function)
> /home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c: In function
> 'soc_probe_aux_dev':
> /home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c:1369:10: error:
> 'EPROBE_DEFER' undeclared (first use in this function)
> /home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c: In function
> 'soc_check_aux_dev':
> /home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c:1347:1: warning:
> control reaches end of non-void function
> 
Yes.  To build the branch, we have to revert the commit below.

d18b63ab0b04af1bad01e59a96b88fc8cda08752
ASoC: core: Use driver core probe deferral

-- 
Regards,
Shawn
