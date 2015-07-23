From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH] ASoC: tas2552: Fix off-by-one for
	max_register setting
Date: Thu, 23 Jul 2015 10:26:12 -0500
Message-ID: <55B10794.50406@ti.com>
References: <1437663364.20606.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id ED133260711
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 17:26:13 +0200 (CEST)
In-Reply-To: <1437663364.20606.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 07/23/2015 09:56 AM, Axel Lin wrote:
> The latest valid register is TAS2552_VBAT_DATA.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  sound/soc/codecs/tas2552.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/tas2552.h b/sound/soc/codecs/tas2552.h
> index 5746f8f..e34752b 100644
> --- a/sound/soc/codecs/tas2552.h
> +++ b/sound/soc/codecs/tas2552.h
> @@ -42,7 +42,7 @@
>  #define TAS2552_BOOST_APT_CTRL		0x14
>  #define TAS2552_VER_NUM			0x16
>  #define TAS2552_VBAT_DATA		0x19
> -#define TAS2552_MAX_REG			0x20
> +#define TAS2552_MAX_REG			TAS2552_VBAT_DATA
>  
>  /* CFG1 Register Masks */
>  #define TAS2552_DEV_RESET		(1 << 0)
Acked-by: Dan Murphy<dmurphy@ti.com>

-- 
------------------
Dan Murphy
