From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH -next] ASoC: samsung: i2s: Fix return value check in
 i2s_create_secondary_device()
Date: Mon, 18 Feb 2019 12:04:37 +0100
Message-ID: <282ae8b4-f86f-2254-0956-3cc3b4915bbf@samsung.com>
References: <20190216012055.79622-1-weiyongjun1@huawei.com>
        <CGME20190218110447epcas1p3bb248ada6447551c1ca19f2d6af40bc4@epcas1p3.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20190216012055.79622-1-weiyongjun1@huawei.com>
Content-language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 2/16/19 02:20, Wei Yongjun wrote:
> In case of error, the function platform_device_register_simple() returns
> ERR_PTR() and never returns NULL. The NULL test in the return value
> check should be replaced with IS_ERR().

Thanks for the patch, it looks good but I have already prepared other
fix that removes the platform_device_register_simple() call entirely: 

"ASoC: samsung: i2s: Fix multiple "IIS multi" devices initialization"
https://www.spinics.net/lists/kernel/msg3045092.html

-- 
Thanks,
Sylwester
