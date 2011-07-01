From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: wm8731: set the ACTIVE bit if bias
	ON entered
Date: Fri, 1 Jul 2011 15:18:20 +0100
Message-ID: <4E0DD72C.3020209@ti.com>
References: <ccd4b125244271af7978948689cf1dcef37bc06b.1309368631.git.nicolas.ferre@atmel.com>
	<1309517034-26110-1-git-send-email-nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 05CF810380B
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Jul 2011 16:18:26 +0200 (CEST)
In-Reply-To: <1309517034-26110-1-git-send-email-nicolas.ferre@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On 01/07/11 11:43, Nicolas Ferre wrote:
> Resuming from a suspend/resume cycle, the ACTIVE bit was not set even if a
> stream had actually been processing.
> Setting this bit at entering SND_SOC_BIAS_ON level will ensure this.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
> Supersed the wrong patch:
> "[PATCH 1/5] ASoC: wm8731: rework power management"
> 
> now based on broonie/sound-2.6 git tree branch: for-3.1.
> 
>  sound/soc/codecs/wm8731.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
> index 2dc964b..ee4ec31 100644
> --- a/sound/soc/codecs/wm8731.c
> +++ b/sound/soc/codecs/wm8731.c
> @@ -453,6 +453,7 @@ static int wm8731_set_bias_level(struct snd_soc_codec *codec,
>  
>  	switch (level) {
>  	case SND_SOC_BIAS_ON:
> +		snd_soc_write(codec, WM8731_ACTIVE, 0x0001);
>  		break;
>  	case SND_SOC_BIAS_PREPARE:
>  		break;


Acked-by: Liam Girdwood <lrg@ti.com>
