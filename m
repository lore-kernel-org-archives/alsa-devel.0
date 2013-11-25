From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH 5/6] ASoC: spear: Use
	devm_snd_dmaengine_pcm_register
Date: Mon, 25 Nov 2013 09:44:20 +0530
Message-ID: <5292CE9C.90006@st.com>
References: <1385299262-24304-1-git-send-email-lars@metafoo.de>
 <1385299262-24304-5-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog111.obsmtp.com (eu1sys200aog111.obsmtp.com
 [207.126.144.131])
 by alsa0.perex.cz (Postfix) with ESMTP id BD2B5261A28
 for <alsa-devel@alsa-project.org>; Mon, 25 Nov 2013 05:14:28 +0100 (CET)
In-Reply-To: <1385299262-24304-5-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Ryan Mallon <rmallon@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Timur Tabi <timur@tabi.org>, Liam Girdwood <lgirdwood@gmail.com>, H Hartley Sweeten <hsweeten@visionengravers.com>, Mark Brown <broonie@kernel.org>, Bo Shen <voice.shen@atmel.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 11/24/2013 6:51 PM, Lars-Peter Clausen wrote:
> snd_dmaengine_pcm_register(&pdev->dev,
>   		&spear_dmaengine_pcm_config,
>   		SND_DMAENGINE_PCM_FLAG_NO_DT |
>   		SND_DMAENGINE_PCM_FLAG_COMPAT);
>   }
>
> -static int spear_soc_platform_remove(struct platform_device *pdev)
> -{
> -	snd_dmaengine_pcm_unregister(&pdev->dev);
> -	return 0;
> -}

Acked-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
