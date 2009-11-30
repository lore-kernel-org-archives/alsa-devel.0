From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoc: pxa/raumfeld: adopt new
 snd_soc_dai_set_pll() API
Date: Mon, 30 Nov 2009 12:55:43 +0000
Message-ID: <20091130125543.GE10968@rakim.wolfsonmicro.main>
References: <1259575964-32251-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F347810384E
	for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2009 13:55:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1259575964-32251-1-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 30, 2009 at 11:12:44AM +0100, Daniel Mack wrote:
> This is needed for recent changes in the for-2.6.33 branch.

Which changes?

> -	ret = snd_soc_dai_set_pll(cpu_dai, 0, 0, clk);
> +	ret = snd_soc_dai_set_pll(cpu_dai, 0, 0, clk, clk);
>  	if (ret < 0)
>  		return ret;

This looks wrong - why would you configure a PLL to produce the same
frequency as is being input?  I suspect you're trying to update for the
addition of the additional source argument to set_pll()...
