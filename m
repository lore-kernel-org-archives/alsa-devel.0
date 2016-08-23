From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH -next] ASoC: samsung: i2s: Add missing
 clk_disable_unprepare() on error in samsung_i2s_probe()
Date: Tue, 23 Aug 2016 18:46:30 +0200
Message-ID: <b9fe0cf3-3b5c-efff-c508-02c0be0be855@samsung.com>
References: <1471965402-6642-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1471965402-6642-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 08/23/2016 05:16 PM, Wei Yongjun wrote:
> Add the missing clk_disable_unprepare() before return
> from samsung_i2s_probe() in the error handling case.
> 
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
