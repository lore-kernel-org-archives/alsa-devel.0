From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH] ASoC: rt5640: change widgetsequencefordepop
Date: Wed, 7 Aug 2013 09:32:08 +0800
Message-ID: <1121E117AD4ECE49880A389A396215BB935C692EE6@rtitmbs7.realtek.com.tw>
References: <1375676343-13891-1-git-send-email-bardliao@realtek.com>
 <20130805144808.GG9858@sirena.org.uk> <51FFDF11.5020106@metafoo.de>
 <1121E117AD4ECE49880A389A396215BB935C692E0E@rtitmbs7.realtek.com.tw>
 <5200B7B5.7050506@metafoo.de>
 <1121E117AD4ECE49880A389A396215BB935C692E40@rtitmbs7.realtek.com.tw>
 <5200C369.6050607@metafoo.de>
 <1121E117AD4ECE49880A389A396215BB935C692E62@rtitmbs7.realtek.com.tw>
 <5200CD0D.7030007@metafoo.de>
 <1121E117AD4ECE49880A389A396215BB935C692E81@rtitmbs7.realtek.com.tw>
 <5200DE78.5060409@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E1402616FF
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2013 03:32:17 +0200 (CEST)
In-Reply-To: <5200DE78.5060409@metafoo.de>
Content-Language: zh-TW
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "swarren@nvidia.com" <swarren@nvidia.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> Makes sense. So this should fix it, I guess:
> 
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -229,6 +229,8 @@ static int dapm_kcontrol_data_alloc(struct
>   			template.id = snd_soc_dapm_kcontrol;
>   			template.name = kcontrol->id.name;
> 
> +			data->value = template.on_val;
> +
>   			data->widget = snd_soc_dapm_new_control(widget->dapm,
>   				&template);
>   			if (!data->widget) {
> 

It works. Thanks.

> 
> 
> ------Please consider the environment before printing this e-mail.
