From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH 4/6] ASoC: uniperf: Add missing __iomem
	annotation
Date: Tue, 28 Jul 2015 09:41:16 +0200
Message-ID: <55B7321C.1070705@st.com>
References: <1437987388-9706-1-git-send-email-lars@metafoo.de>
 <1437987388-9706-5-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 7FC872604C5
 for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2015 09:41:36 +0200 (CEST)
In-Reply-To: <1437987388-9706-5-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Patrick Lai <plai@codeaurora.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Max Filippov <jcmvbkbc@gmail.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi

On 07/27/2015 10:56 AM, Lars-Peter Clausen wrote:
> base referes to a iomem region, so it should have the __iomem annotation.
> Fixes the following warnings from sparse:
>
> 	sound/soc/sti/sti_uniperif.c:169:19: warning: incorrect type in
> 		assignment (different address spaces)
> 	sound/soc/sti/sti_uniperif.c:169:19:    expected void *base
> 	sound/soc/sti/sti_uniperif.c:169:19:    got void [noderef] <asn:2>*
> 	sound/soc/sti/uniperif_player.c:104:18: warning: incorrect type in
> 		argument 1 (different address spaces)
> 	sound/soc/sti/uniperif_player.c:104:18:    expected void const volatile
> 		[noderef] <asn:2>*addr
> 	sound/soc/sti/uniperif_player.c:104:18:    got void *
> 	[...]
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>   sound/soc/sti/uniperif.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/sti/uniperif.h b/sound/soc/sti/uniperif.h
> index ee462f7..f0fd5a9 100644
> --- a/sound/soc/sti/uniperif.h
> +++ b/sound/soc/sti/uniperif.h
> @@ -1168,7 +1168,7 @@ struct uniperif {
>
>   	/* Resources */
>   	struct resource *mem_region;
> -	void *base;
> +	void __iomem *base;
>   	unsigned long fifo_phys_address;
>   	int irq;
>
>
Thanks for the patch,
  acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>

Br,
Arnaud
