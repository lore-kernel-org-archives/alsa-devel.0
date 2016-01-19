From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8960: Fix WM8960_SYSCLK_PLL mode
Date: Tue, 19 Jan 2016 13:49:36 +0000
Message-ID: <20160119134936.GJ1490@localhost.localdomain>
References: <1453208949-23946-1-git-send-email-stuarth@opensource.wolfsonmicro.com>
 <1453208949-23946-2-git-send-email-stuarth@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EA1E26596B
 for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2016 14:49:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1453208949-23946-2-git-send-email-stuarth@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: stuarth@opensource.wolfsonmicro.com
Cc: Stuart Henderson <stuart.henderson@cirrus.com>, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, zidan.wang@freescale.com
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 19, 2016 at 01:09:09PM +0000, stuarth@opensource.wolfsonmicro.com wrote:
> From: Stuart Henderson <stuart.henderson@cirrus.com>
> 
> With the introduction of WM8960_SYSCLK_AUTO mode, WM8960_SYSCLK_PLL mode was
> made unusable.  Ensure we're not PLL mode before trying to use MCLK.
> 
> Fixes: 3176bf2d7ccd ("ASoC: wm8960: update pll and clock setting function")
> Signed-off-by: Stuart Henderson <stuart.henderson@cirrus.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
