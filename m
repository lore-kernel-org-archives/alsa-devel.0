From: Niklas Cassel <niklas.cassel@linaro.org>
Subject: Re: [PATCH v2 12/12] ASoC: qdsp6: q6asm: remove unused
 struct q6asm member
Date: Tue, 26 Jun 2018 11:36:41 +0200
Message-ID: <20180626093641.GH25217@centauri.ideon.se>
References: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
 <20180626092016.9296-13-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 846872678C2
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 11:36:44 +0200 (CEST)
Received: by mail-lj1-f193.google.com with SMTP id o26-v6so8263518ljg.3
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 02:36:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180626092016.9296-13-srinivas.kandagatla@linaro.org>
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

On Tue, Jun 26, 2018 at 10:20:16AM +0100, Srinivas Kandagatla wrote:
> pcmdev in struct q6asm seems be left over and unused, so just remove it.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/qdsp6/q6asm.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
> index c4fd28f168d5..2b2c7233bb5f 100644
> --- a/sound/soc/qcom/qdsp6/q6asm.c
> +++ b/sound/soc/qcom/qdsp6/q6asm.c
> @@ -174,7 +174,6 @@ struct q6asm {
>  	struct device *dev;
>  	struct q6core_svc_api_info ainfo;
>  	wait_queue_head_t mem_wait;
> -	struct platform_device *pcmdev;
>  	spinlock_t slock;
>  	struct audio_client *session[MAX_SESSIONS + 1];
>  };
> -- 
> 2.16.2
> 
