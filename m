From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH] ASoC: samsung: Enable COMPILE_TEST builds
Date: Mon, 22 Jul 2013 18:31:43 +0200
Message-ID: <1777239.X51REAvKl1@amdc1227>
References: <1373908284-14305-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1373908284-14305-1-git-send-email-broonie@kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Sangbeom Kim <sbkim73@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-samsung-soc@vger.kernel.org, alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Monday 15 of July 2013 18:11:24 Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> Platform using OF and some others don't have any dependencies on arch/arm
> so can be built on any platform. Enable that for better compile coverage
> when COMPILE_TEST is enabled.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  sound/soc/samsung/Kconfig | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
