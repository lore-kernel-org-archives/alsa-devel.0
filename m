From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5] ASoC: wm8960: update pll and
	clock	setting function
Date: Tue, 11 Aug 2015 13:09:19 +0100
Message-ID: <20150811120919.GK25225@opensource.wolfsonmicro.com>
References: <11490c0414fec756d2fb0ebcbcd94a6c7fafadd7.1439292054.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 152A32604FA
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2015 14:09:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <11490c0414fec756d2fb0ebcbcd94a6c7fafadd7.1439292054.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 11, 2015 at 07:25:15PM +0800, Zidan Wang wrote:
> Add sysclk auto mode. When it's sysclk auto mode, if the MCLK is
> available for clock configure, using MCLK to provide sysclk directly,
> otherwise, search a available pll out frequcncy and set pll.
> 
> Configure clock in hw_params may cause problems when using bypass style
> paths without hw_params in machine driver getting called. So add configure
> clock to set_bias_level.
> 
> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
