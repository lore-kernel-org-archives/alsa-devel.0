From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 1/2] ASoC: Drop owner assignment from i2c_driver
Date: Wed, 15 Jul 2015 10:15:41 +0900
Message-ID: <55A5B43D.9020601@samsung.com>
References: <1436506231-8980-1-git-send-email-k.kozlowski@samsung.com>
 <1436506231-8980-2-git-send-email-k.kozlowski@samsung.com>
 <20150714165758.GF11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150714165758.GF11162@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Support Opensource <support.opensource@diasemi.com>, M R Swami Reddy <mr.swami.reddy@ti.com>, Vishwas A Deshpande <vishwas.a.deshpande@ti.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Peter Rosin <peda@axentia.se>, Matthias Brugger <matthias.bgg@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 15.07.2015 01:57, Mark Brown wrote:
> On Fri, Jul 10, 2015 at 02:30:30PM +0900, Krzysztof Kozlowski wrote:
>> i2c_driver does not need to set an owner because i2c_register_driver()
>> will set it.
> 
> This doesn't apply against current code, please check and resend.

Indeed, I rebased it on linux-next from 8th of July but the release
included changes in the same place in ts3a227e.c.

I'll rebase and resend.

Best regards,
Krzysztof
