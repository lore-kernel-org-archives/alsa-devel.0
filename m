From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH] ASoC: sti: Fix error handling if
	of_clk_get() fails
Date: Fri, 28 Apr 2017 15:45:51 +0200
Message-ID: <27a6c24a-de05-0911-2095-107795d7d506@st.com>
References: <20170428132210.jvjrltku25sepivw@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E083F266A53
 for <alsa-devel@alsa-project.org>; Fri, 28 Apr 2017 15:45:54 +0200 (CEST)
In-Reply-To: <20170428132210.jvjrltku25sepivw@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Wei Yongjun <weiyongjun1@huawei.com>
List-Id: alsa-devel@alsa-project.org

Hi Dan,

Acked-by: Arnaud POULIQUEN <arnaud.pouliquen@st.com>

Thanks!

Arnaud

On 04/28/2017 03:22 PM, Dan Carpenter wrote:
> We intended to return here.  The current code has a static checker
> warning because we set "ret" but don't use it.
> 
> Fixes: 76c2145ded6b ("ASoC: sti: Add CPU DAI driver for playback")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
> index d7e8dd46d2cc..d8b6936e544e 100644
> --- a/sound/soc/sti/uniperif_player.c
> +++ b/sound/soc/sti/uniperif_player.c
> @@ -1074,7 +1074,7 @@ int uni_player_init(struct platform_device *pdev,
>  	player->clk = of_clk_get(pdev->dev.of_node, 0);
>  	if (IS_ERR(player->clk)) {
>  		dev_err(player->dev, "Failed to get clock\n");
> -		ret = PTR_ERR(player->clk);
> +		return PTR_ERR(player->clk);
>  	}
>  
>  	/* Select the frequency synthesizer clock */
> 
