From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Specify register defaults for WM8958
 MICBIAS1 and MICBIAS2
Date: Wed, 10 Aug 2011 09:21:23 +0100
Message-ID: <4E423F83.1000406@ti.com>
References: <1312953609-26975-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 727D124599
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Aug 2011 10:21:27 +0200 (CEST)
In-Reply-To: <1312953609-26975-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On 10/08/11 06:20, Mark Brown wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8994-tables.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8994-tables.c b/sound/soc/codecs/wm8994-tables.c
> index a87adbd..13e5a01 100644
> --- a/sound/soc/codecs/wm8994-tables.c
> +++ b/sound/soc/codecs/wm8994-tables.c
> @@ -1635,8 +1635,8 @@ const u16 wm8994_reg_defaults[WM8994_CACHE_SIZE] = {
>  	0x0000,     /* R58    - MICBIAS */
>  	0x000D,     /* R59    - LDO 1 */
>  	0x0003,     /* R60    - LDO 2 */
> -	0x0000,     /* R61 */
> -	0x0000,     /* R62 */
> +	0x0039,     /* R61    - MICBIAS1 */
> +	0x0039,     /* R62    - MICBIAS2 */
>  	0x0000,     /* R63 */
>  	0x0000,     /* R64 */
>  	0x0000,     /* R65 */

Acked-by: Liam Girdwood <lrg@ti.com>
