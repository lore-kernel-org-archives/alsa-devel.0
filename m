From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: Codec: wm8962: declare ALC
 Coefficients as 4 separate registers
Date: Tue, 20 Oct 2015 09:59:08 +0100
Message-ID: <20151020085908.GB10520@ck-lbox>
References: <1445309232-24094-1-git-send-email-jiada_wang@mentor.com>
 <1445309232-24094-3-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 50412266374
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 11:17:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1445309232-24094-3-git-send-email-jiada_wang@mentor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jiada Wang <jiada_wang@mentor.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 20, 2015 at 11:47:12AM +0900, Jiada Wang wrote:
> As ALC2 register is volatile, declare it as one of ALC Coefficients
> register together with other non-volatile registers will cause issue,
> in case wm8962 has enter suspend mode, and cache_only flag is set,
> any attempt to read from ALC2 will fail.
> 
> Instead of declaring one ALC Coefficients register which contains
> ALC1 ~ ALC3 and Noise Gate, this patch declares 4 separate registers,
> so that regmap can handle these registers differently based on their
> classification.
> 
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> ---
>  sound/soc/codecs/wm8962.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
> index a3d7778..157530c 100644
> --- a/sound/soc/codecs/wm8962.c
> +++ b/sound/soc/codecs/wm8962.c
> @@ -1782,8 +1782,11 @@ SND_SOC_BYTES("HD Bass Coefficients", WM8962_HDBASS_AI_1, 30),
>  
>  SOC_DOUBLE("ALC Switch", WM8962_ALC1, WM8962_ALCL_ENA_SHIFT,
>  		WM8962_ALCR_ENA_SHIFT, 1, 0),
> -SND_SOC_BYTES_MASK("ALC Coefficients", WM8962_ALC1, 4,
> +SND_SOC_BYTES_MASK("ALC1", WM8962_ALC1, 1,
>  		WM8962_ALCL_ENA_MASK | WM8962_ALCR_ENA_MASK),
> +SND_SOC_BYTES("ALC2", WM8962_ALC2, 1),
> +SND_SOC_BYTES("ALC3", WM8962_ALC3, 1),
> +SND_SOC_BYTES("Noise Gate", WM8962_NOISE_GATE, 1),

This doesn't really seem ideal to be changing the interface at
this point in the drivers life.

Looking through the datasheet/driver there are 5 status bits in
the ALC2 register but we don't use them anywhere in the driver
and they don't look like they are likely to be useful to the end
user. I wonder if an easier solution might just be to have the
register be non-volatile?

Thanks,
Charles
