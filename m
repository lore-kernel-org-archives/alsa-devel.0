From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] ASoC: SAMSUNG: Fix initial return value
Date: Mon, 06 Dec 2010 12:35:54 +0000
Message-ID: <1291638954.3281.29.camel@odin>
References: <1291589819-19793-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id E81D924159
	for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2010 13:35:58 +0100 (CET)
Received: by wwi18 with SMTP id 18so3770840wwi.2
	for <alsa-devel@alsa-project.org>; Mon, 06 Dec 2010 04:35:58 -0800 (PST)
In-Reply-To: <1291589819-19793-1-git-send-email-sw.youn@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seungwhan Youn <sw.youn@samsung.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, jassi.brar@samsung.com
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-12-06 at 07:56 +0900, Seungwhan Youn wrote:
> This patch fixed intial return value to be a '0' as asuccess on
> set_audio_clock_heirachy(). This avoids unintended error on initialize.
> 
> Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
> ---
>  sound/soc/samsung/smdk_spdif.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/samsung/smdk_spdif.c b/sound/soc/samsung/smdk_spdif.c
> index ca779ad..56d058d 100644
> --- a/sound/soc/samsung/smdk_spdif.c
> +++ b/sound/soc/samsung/smdk_spdif.c
> @@ -28,7 +28,7 @@
>  static int set_audio_clock_heirachy(struct platform_device *pdev)
>  {
>  	struct clk *fout_epll, *mout_epll, *sclk_audio0, *sclk_spdif;
> -	int ret;
> +	int ret = 0;
>  
>  	fout_epll = clk_get(NULL, "fout_epll");
>  	if (IS_ERR(fout_epll)) {

Both

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
