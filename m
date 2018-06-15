From: Banajit Goswami <bgoswami@codeaurora.org>
Subject: Re: [PATCH v2 5/7] ASoC: qdsp6: Add depends on OF
Date: Thu, 14 Jun 2018 21:02:53 -0700
Message-ID: <ba296da2-7daf-ba9c-d63c-fbeaeb38b335@codeaurora.org>
References: <20180614111138.8923-1-niklas.cassel@linaro.org>
 <20180614111138.8923-6-niklas.cassel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 64A912673CC
 for <alsa-devel@alsa-project.org>; Fri, 15 Jun 2018 06:02:56 +0200 (CEST)
In-Reply-To: <20180614111138.8923-6-niklas.cassel@linaro.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Niklas Cassel <niklas.cassel@linaro.org>, andy.gross@linaro.org, Patrick Lai <plai@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


On 6/14/2018 4:11 AM, Niklas Cassel wrote:
> of_platform_device_destroy is only defined when building
> with CONFIG_OF=y. Add a depends on OF.
>
> sound/soc/qcom/qdsp6/q6afe.o: In function `q6afe_remove':
> q6afe.c:(.text+0x363): undefined reference to `of_platform_device_destroy'
> sound/soc/qcom/qdsp6/q6adm.o: In function `q6adm_remove':
> q6adm.c:(.text+0x216): undefined reference to `of_platform_device_destroy'
> sound/soc/qcom/qdsp6/q6asm.o: In function `q6asm_remove':
> q6asm.c:(.text+0x723): undefined reference to `of_platform_device_destroy'
>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
