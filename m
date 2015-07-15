From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2 2/2] ASoC: Drop owner assignment from platform_driver
Date: Wed, 15 Jul 2015 16:23:00 +0900
Message-ID: <55A60A54.7040004@samsung.com>
References: <1436934105-12700-1-git-send-email-k.kozlowski@samsung.com>
 <1436934105-12700-2-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1436934105-12700-2-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Support Opensource <support.opensource@diasemi.com>, Vishwas A Deshpande <vishwas.a.deshpande@ti.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Peter Rosin <peda@axentia.se>, Matthias Brugger <matthias.bgg@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Cc: Koro Chen <koro.chen@mediatek.com>
List-Id: alsa-devel@alsa-project.org

On 15.07.2015 13:21, Krzysztof Kozlowski wrote:
> platform_driver does not need to set an owner because
> platform_driver_register() will set it.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> ---
> 
> Changes since v1:
> 1. None
> ---

D'oh! I forgot to include ack from Koro Chen given here:
https://lkml.org/lkml/2015/7/12/218

Please accept my apologies,
Krzysztof
