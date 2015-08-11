From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v4] ASoC: wm8960: update pll and
	clock	setting function
Date: Tue, 11 Aug 2015 09:03:35 +0100
Message-ID: <20150811080334.GJ25225@opensource.wolfsonmicro.com>
References: <f6e8caad9d39c37ff0660a5a59d707ee7b3963fb.1439268589.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 90E7A2604D8
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2015 10:03:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <f6e8caad9d39c37ff0660a5a59d707ee7b3963fb.1439268589.git.zidan.wang@freescale.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 11, 2015 at 01:11:35PM +0800, Zidan Wang wrote:
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
