From: Zidan Wang <zidan.wang@freescale.com>
Subject: Re: [PATCH v3] ASoC: wm8960: update pll and clock
 setting function
Date: Tue, 4 Aug 2015 09:28:46 +0800
Message-ID: <20150804012844.GA21306@shlinux2>
References: <ac311441efbc167953de3ab8706217c3c669f88d.1436776563.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0119.outbound.protection.outlook.com [157.56.111.119])
 by alsa0.perex.cz (Postfix) with ESMTP id D82ED26064F
 for <alsa-devel@alsa-project.org>; Tue,  4 Aug 2015 04:39:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <ac311441efbc167953de3ab8706217c3c669f88d.1436776563.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ckeepax@opensource.wolfsonmicro.com
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 13, 2015 at 04:41:00PM +0800, Zidan Wang wrote:
> Add sysclk auto mode. When it's sysclk auto mode, if the MCLK is
> available for clock configure, using MCLK to provide sysclk directly,
> otherwise, search a available pll out frequcncy and set pll.
> 
> Configure clock in hw_params may cause problems when using bypass style
> paths without hw_params in machine driver getting called. So add configure
> clock to set_bias_level.
> 
> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>

Hi ckeepax,

Is this patch ok for wm8960 codec driver?


Best Regards,
Zidan
