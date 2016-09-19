From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH -next] ASoC: sti: fix missing clk_disable_unprepare() on
 error in uni_player_start()
Date: Mon, 19 Sep 2016 09:27:03 +0200
Message-ID: <357834f2-bae9-c481-785e-b5d4dd6f152b@st.com>
References: <1474076073-9569-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474076073-9569-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Moise GERGAUD <moise.gergaud@st.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hello Wei,

Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>

Thanks!

On 09/17/2016 03:34 AM, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Fix the missing clk_disable_unprepare() before return
> from uni_player_start() in the error handling case.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  sound/soc/sti/uniperif_player.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
> index 645e415..1bc8ebc 100644
> --- a/sound/soc/sti/uniperif_player.c
> +++ b/sound/soc/sti/uniperif_player.c
> @@ -893,8 +893,10 @@ static int uni_player_start(struct uniperif *player)
>  	SET_UNIPERIF_SOFT_RST_SOFT_RST(player);
>  
>  	ret = reset_player(player);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		clk_disable_unprepare(player->clk);
>  		return ret;
> +	}
>  
>  	/*
>  	 * Does not use IEC61937 features of the uniperipheral hardware.
> 
