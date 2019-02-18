From: "Schulman, James" <James.Schulman@cirrus.com>
Subject: Re: [PATCH -next] ASoC: cs35l36: Make some symbols
	static
Date: Mon, 18 Feb 2019 17:26:47 +0000
Message-ID: <alpine.DEB.2.10.1902181126050.1596@james-tower>
References: <20190218074653.181365-1-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 16D6226552B
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2019 18:26:51 +0100 (CET)
In-Reply-To: <20190218074653.181365-1-weiyongjun1@huawei.com>
Content-Language: en-US
Content-ID: <94AED2AAD7DAF647A3D83FF6941D0803@namprd19.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: "Austin, Brian" <Brian.Austin@cirrus.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, "Handrigan, Paul" <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Schulman, James" <James.Schulman@cirrus.com>
List-Id: alsa-devel@alsa-project.org



On Mon, 18 Feb 2019, Wei Yongjun wrote:

> Fixes the following sparse warnings:
>
> sound/soc/codecs/cs35l36.c:135:20: warning:
> symbol 'cs35l36_reg' was not declared. Should it be static?
> sound/soc/codecs/cs35l36.c:248:6: warning:
> symbol 'cs35l36_readable_reg' was not declared. Should it be static?
> sound/soc/codecs/cs35l36.c:398:6: warning:
> symbol 'cs35l36_precious_reg' was not declared. Should it be static?
> sound/soc/codecs/cs35l36.c:410:6: warning:
> symbol 'cs35l36_volatile_reg' was not declared. Should it be static?
>
> Fixes: 6ba9dd6c893b ("ASoC: cs35l36: Add support for Cirrus CS35L36 Amplifier")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
> sound/soc/codecs/cs35l36.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/sound/soc/codecs/cs35l36.c b/sound/soc/codecs/cs35l36.c
> index 4f880a678812..005f1adc80b8 100644
> --- a/sound/soc/codecs/cs35l36.c
> +++ b/sound/soc/codecs/cs35l36.c
> @@ -132,7 +132,7 @@ static const struct cs35l36_pll_config cs35l36_pll_sysclk[] = {
> 	{27000000,	0x3F, 0x0A},
> };
>
> -struct reg_default cs35l36_reg[] = {
> +static struct reg_default cs35l36_reg[] = {
> 	{CS35L36_TESTKEY_CTRL,			0x00000000},
> 	{CS35L36_USERKEY_CTL,			0x00000000},
> 	{CS35L36_OTP_CTRL1,			0x00002460},
> @@ -245,7 +245,7 @@ struct reg_default cs35l36_reg[] = {
> 	{CS35L36_PAC_INT7_CTRL,			0x00000001},
> };
>
> -bool cs35l36_readable_reg(struct device *dev, unsigned int reg)
> +static bool cs35l36_readable_reg(struct device *dev, unsigned int reg)
> {
> 	switch (reg) {
> 	case CS35L36_SW_RESET:
> @@ -395,7 +395,7 @@ bool cs35l36_readable_reg(struct device *dev, unsigned int reg)
> 	}
> }
>
> -bool cs35l36_precious_reg(struct device *dev, unsigned int reg)
> +static bool cs35l36_precious_reg(struct device *dev, unsigned int reg)
> {
> 	switch (reg) {
> 	case CS35L36_TESTKEY_CTRL:
> @@ -407,7 +407,7 @@ bool cs35l36_precious_reg(struct device *dev, unsigned int reg)
> 	}
> }
>
> -bool cs35l36_volatile_reg(struct device *dev, unsigned int reg)
> +static bool cs35l36_volatile_reg(struct device *dev, unsigned int reg)
> {
> 	switch (reg) {
> 	case CS35L36_SW_RESET:
>
>
>
>

Thanks Wei. I agree with the changes.

Acked-by: James Schulman <james.schulman@cirrus.com>
