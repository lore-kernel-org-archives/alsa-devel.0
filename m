From: zhengxing <zhengxing@rock-chips.com>
Subject: Re: [PATCH 1/2] ASoC: rockchip: Add machine driver for
	max98090 codec
Date: Sat, 18 Jul 2015 12:15:13 +0800
Message-ID: <55A9D2D1.6010206@rock-chips.com>
References: <1436930143-31361-1-git-send-email-zhengxing@rock-chips.com>
 <1436930143-31361-2-git-send-email-zhengxing@rock-chips.com>
 <20150717180402.GS11162@sirena.org.uk> <55A9CD3C.10300@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C8E5260421
 for <alsa-devel@alsa-project.org>; Sat, 18 Jul 2015 06:21:23 +0200 (CEST)
In-Reply-To: <55A9CD3C.10300@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, heiko@sntech.de, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, dianders@chromium.org, linux-rockchip@lists.infradead.org, dgreid@chromium.org, sonnyrao@chromium.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


>>> +static int snd_rk_mc_remove(struct platform_device *pdev)
>>> +{
>>> +    struct snd_soc_card *soc_card = platform_get_drvdata(pdev);
>>> +
>>> +    snd_soc_card_set_drvdata(soc_card, NULL);
>>> +    snd_soc_unregister_card(soc_card);
>>> +    platform_set_drvdata(pdev, NULL);
>> No need for any of the _set_drvdata() calls, the core does them and they
>> shouldn't make any difference anyway.
> Done. I will remove *_set_drvdata and *get_drvdata because we don't 
> need them any more.
>
Sorry, I mean just remove platform_set_drvdata(pdev, NULL);
