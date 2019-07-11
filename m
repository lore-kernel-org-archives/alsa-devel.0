From: <wen.yang99@zte.com.cn>
Subject: Re:
	=?utf-8?q?=5BPATCH=5D_ASoC=3A_audio-graph-card=3A_ad?=
	=?utf-8?q?d_missing_const_at_graph=5Fget=5Fdai=5Fid=28=29?=
Date: Thu, 11 Jul 2019 12:34:39 +0800 (CST)
Message-ID: <201907111234393553279@zte.com.cn>
References: <87sgrd43ja.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mxct.zte.com.cn (out1.zte.com.cn [202.103.147.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0C9C1F800D8
 for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2019 06:35:13 +0200 (CEST)
In-Reply-To: <87sgrd43ja.wl-kuninori.morimoto.gx@renesas.com>
References: 87sgrd43ja.wl-kuninori.morimoto.gx@renesas.com
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: kuninori.morimoto.gx@renesas.com
Cc: alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> commit c152f8491a8d9 ("ASoC: audio-graph-card: fix an use-after-free in
> graph_get_dai_id()") fixups use-after-free issue,
> but, it need to use "const" for reg. This patch adds it.
> 
> We will have below without this patch
> 
> LINUX/sound/soc/generic/audio-graph-card.c: In function 'graph_get_dai_id':
> LINUX/sound/soc/generic/audio-graph-card.c:87:7: warning: assignment discards\
> 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
> reg = of_get_property(node, "reg", NULL);
> 
> Fixes: c152f8491a8d9 ("ASoC: audio-graph-card: fix an use-after-free in graph_get_dai_id()")
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> sound/soc/generic/audio-graph-card.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
> index 343ede8..ebf2ca3 100644
> --- a/sound/soc/generic/audio-graph-card.c
> +++ b/sound/soc/generic/audio-graph-card.c
> @@ -63,7 +63,7 @@ static int graph_get_dai_id(struct device_node *ep)
> struct device_node *endpoint;
> struct of_endpoint info;
> int i, id;
> -    u32 *reg;
> +    const u32 *reg;
> int ret;
> 
> /* use driver specified DAI ID if exist */
> --
> 2.7.4

Thanks.
Acked-by: Wen Yang <wen.yang99@zte.com.cn>

---
Best regards
Wen
