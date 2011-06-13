From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Remove unused and about to be broken
 SND_SOC_CUSTOM I/O bus
Date: Mon, 13 Jun 2011 19:19:23 +0100
Message-ID: <4DF654AB.3090508@ti.com>
References: <1307988224-3899-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 570AF243BA
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Jun 2011 20:19:32 +0200 (CEST)
In-Reply-To: <1307988224-3899-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 13/06/11 19:03, Mark Brown wrote:
> This will be removed in -next so let's drop it from mainline as soon as
> we can in order to minimise surprises.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> 
> This posting is against -next, sorry, but the update for 3.0 is
> trivially obvious.
> 
>  include/sound/soc.h |    3 +--
>  sound/soc/soc-io.c  |    3 ---
>  2 files changed, 1 insertions(+), 5 deletions(-)
> 

Acked-by: Liam Girdwood <lrg@ti.com>
