From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 1/2] ASoC: Add Springbank I/O card to
	Speyside Kconfig
Date: Tue, 23 Aug 2011 20:26:37 +0100
Message-ID: <4E53FEED.8030308@ti.com>
References: <1314092510-9729-1-git-send-email-jp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id EA85B244A3
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Aug 2011 21:26:44 +0200 (CEST)
In-Reply-To: <1314092510-9729-1-git-send-email-jp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joseph Pentland <jp@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 23/08/11 10:41, Joseph Pentland wrote:
> Signed-off-by: Joseph Pentland <jp@opensource.wolfsonmicro.com>
> ---
>  sound/soc/samsung/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
> index b99091f..65f980e 100644
> --- a/sound/soc/samsung/Kconfig
> +++ b/sound/soc/samsung/Kconfig
> @@ -185,6 +185,7 @@ config SND_SOC_SPEYSIDE
>  	select SND_SAMSUNG_I2S
>  	select SND_SOC_WM8996
>  	select SND_SOC_WM9081
> +	select SND_SOC_WM1250_EV1
>  
>  config SND_SOC_SPEYSIDE_WM8962
>  	tristate "Audio support for Wolfson Speyside with WM8962"

Acked-by: Liam Girdwood <lrg@ti.com>

Missing 2/2 ?
