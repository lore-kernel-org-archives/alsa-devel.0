From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [1/2] ASoC: samsung: odroid: fix an use-after-free issue for
 codec
Date: Sun, 14 Jul 2019 12:55:49 +0200
Message-ID: <6f537916-9dec-606d-ea4b-8d41cc75a55d@web.de>
References: <1562989575-33785-2-git-send-email-wen.yang99@zte.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1562989575-33785-2-git-send-email-wen.yang99@zte.com.cn>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wen Yang <wen.yang99@zte.com.cn>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Cheng Shengyu <cheng.shengyu@zte.com.cn>, Jaroslav Kysela <perex@perex.cz>, Krzysztof Kozlowski <krzk@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Takashi Iwai <tiwai@suse.com>, Xue Zhihong <xue.zhihong@zte.com.cn>, Yi Wang <wang.yi59@zte.com.cn>
List-Id: alsa-devel@alsa-project.org

> Fixes: bc3cf17b575a ("ASoC: samsung: odroid: Add support for secondary CPU DAI")

* Can it be that this commit identification is relevant more for the second update step?

* Was the handling of device node references questionable already before this change?

Regards,
Markus
