From: Niklas Cassel <niklas.cassel@linaro.org>
Subject: Re: [PATCH v2 11/12] ASoC: qdsp6: q6routing: add
	proper error check
Date: Tue, 26 Jun 2018 11:36:08 +0200
Message-ID: <20180626093608.GG25217@centauri.ideon.se>
References: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
 <20180626092016.9296-12-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f67.google.com (mail-lf0-f67.google.com
 [209.85.215.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B1B42675C8
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 11:36:11 +0200 (CEST)
Received: by mail-lf0-f67.google.com with SMTP id j26-v6so8955846lfb.11
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 02:36:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180626092016.9296-12-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-arm-msm@vger.kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org, tiwai@suse.com, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Acked-by: Niklas Cassel <niklas.cassel@linaro.org>

On Tue, Jun 26, 2018 at 10:20:15AM +0100, Srinivas Kandagatla wrote:
> q6adm_open can return error pointer or a null in error cases.
> Fix the return handling.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/qdsp6/q6routing.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
> index ab696bf8d1d3..c80fdbc2442e 100644
> --- a/sound/soc/qcom/qdsp6/q6routing.c
> +++ b/sound/soc/qcom/qdsp6/q6routing.c
> @@ -310,7 +310,7 @@ int q6routing_stream_open(int fedai_id, int perf_mode,
>  			      session->channels, topology, perf_mode,
>  			      session->bits_per_sample, 0, 0);
>  
> -	if (!copp) {
> +	if (IS_ERR_OR_NULL(copp)) {
>  		mutex_unlock(&routing_data->lock);
>  		return -EINVAL;
>  	}
> -- 
> 2.16.2
> 
