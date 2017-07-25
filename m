From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 01/11] ASoC: samsung: s3c2412: Handle
 return value of clk_prepare_enable.
Date: Tue, 25 Jul 2017 19:43:53 +0200
Message-ID: <20170725174353.GA8243@kozik-book>
References: <1500977674-27960-1-git-send-email-arvind.yadav.cs@gmail.com>
 <1500977674-27960-2-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f170.google.com (mail-yw0-f170.google.com
 [209.85.161.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 09101267281
 for <alsa-devel@alsa-project.org>; Tue, 25 Jul 2017 19:43:59 +0200 (CEST)
Received: by mail-yw0-f170.google.com with SMTP id u207so11445817ywc.3
 for <alsa-devel@alsa-project.org>; Tue, 25 Jul 2017 10:43:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1500977674-27960-2-git-send-email-arvind.yadav.cs@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: alsa-devel@alsa-project.org, sbkim73@samsung.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, tiwai@suse.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 25, 2017 at 03:44:28PM +0530, Arvind Yadav wrote:
> clk_prepare_enable() can fail here and we must check its return value.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  sound/soc/samsung/s3c2412-i2s.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/samsung/s3c2412-i2s.c b/sound/soc/samsung/s3c2412-i2s.c
> index 0a47182..bcd1cbd 100644
> --- a/sound/soc/samsung/s3c2412-i2s.c
> +++ b/sound/soc/samsung/s3c2412-i2s.c
> @@ -71,7 +71,9 @@ static int s3c2412_i2s_probe(struct snd_soc_dai *dai)
>  	/* Set MPLL as the source for IIS CLK */
>  
>  	clk_set_parent(s3c2412_i2s.iis_cclk, clk_get(NULL, "mpll"));
> -	clk_prepare_enable(s3c2412_i2s.iis_cclk);
> +	ret = clk_prepare_enable(s3c2412_i2s.iis_cclk);
> +	if (ret)

You miss here path for error handling for things done in
s3c_i2sv2_probe().

Best regards,
Krzysztof

> +		return ret;
>  
>  	s3c2412_i2s.iis_cclk = s3c2412_i2s.iis_pclk;
>  
> -- 
> 1.9.1
> 
