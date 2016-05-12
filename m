From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8985: rework and fix the clock
	calculation
Date: Thu, 12 May 2016 16:15:29 +0100
Message-ID: <20160512151529.GL1646@localhost.localdomain>
References: <1463035734-24477-1-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id C411A26047C
 for <alsa-devel@alsa-project.org>; Thu, 12 May 2016 17:15:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1463035734-24477-1-git-send-email-petr@barix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <petr@barix.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, May 12, 2016 at 08:48:54AM +0200, Petr Kulhavy wrote:
> The clock calculation has several issues:
> 1) if PLL is used in master mode the BCLK output runs at double the speed
> 2) de-facto only 44.1kHz and 48kHz sampling rates are supported, other
>    rates like 8kHz, 12kHz, 24kHz fail to find the proper BCLK divider
> 3) the wm8985->sysclk variable has a misleading name and is used wrongly
>    in the clock calculation in wm8985_hw_params() which is the root cause
>    for (1)
> 4) wm8985->bclk is used only in wm8985_hw_params() and therefore no
>    need to store it in the wm8985_priv structure
> 
> Therefore the clock calculation is rewritten in more clean and proper way:
> - move wm8985_priv->bclk as a local variable into mw8985_hw_params()
> - new variable wm8985_priv->pllout holds the actual frequency that is input
>   to the MCLKDIV post-divider
> - move wm8985_priv->sysclk as a local variable into mw8985_hw_params()
> - sysclk is now always calculated as 256 * fs
> - the MCLKDIV is looked up as pllout/sysclk
> - fs_ratios[] is replaced by simpler mclk_divs[] lookup table
> 
> With this patch all rates: 8, 11.025, 12, 16, 22.05, 24, 32, 44.1 and 48kHz
> work properly and generate the correct BCLK.
> 
> Signed-off-by: Petr Kulhavy <petr@barix.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
