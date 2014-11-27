From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8960: Move register
	initialisation	to I2C driver probe()
Date: Thu, 27 Nov 2014 10:19:11 +0000
Message-ID: <20141127101911.GB13764@opensource.wolfsonmicro.com>
References: <1417078388-1289-1-git-send-email-b50113@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4AF71265A13
 for <alsa-devel@alsa-project.org>; Thu, 27 Nov 2014 11:19:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1417078388-1289-1-git-send-email-b50113@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <b50113@freescale.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, tiwai@suse.de, linux-kernel@vger.kernel.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Li.Xiubo@freescale.com
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 27, 2014 at 04:53:08PM +0800, Zidan Wang wrote:
> We must ensure that the clocking configuration is valid as rapidly as possible.
> And do software reset before the others registers updates, or the registers
> will be reset to the default state.
> 
> Signed-off-by: Zidan Wang <b50113@freescale.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Looks ok to me.

Thanks,
Charles
