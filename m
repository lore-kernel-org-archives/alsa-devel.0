From: Olivier MOYSAN <olivier.moysan@st.com>
Subject: Re: [PATCH] ASoC: stm32: i2s: return the get_irq error
Date: Thu, 25 Apr 2019 09:05:22 +0000
Message-ID: <215557bf-19f5-7353-e929-f45123f1886e@st.com>
References: <1556119724-9873-1-git-send-email-fabien.dessenne@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1556119724-9873-1-git-send-email-fabien.dessenne@st.com>
Content-Language: en-US
Content-ID: <F4F5BBA671AEAC43BE4CED75A915CD6E@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Fabien DESSENNE <fabien.dessenne@st.com>, Arnaud POULIQUEN <arnaud.pouliquen@st.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 TORGUE <alexandre.torgue@st.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org



On 4/24/19 5:28 PM, Fabien Dessenne wrote:
> During probe, return the "get_irq" error value instead of -ENOENT. This
> allows the driver to be deferred probed if needed.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>

Acked-by: Olivier Moysan <olivier.moysan@st.com>

> ---
>   sound/soc/stm/stm32_i2s.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
> index 9526342..97d5e99 100644
> --- a/sound/soc/stm/stm32_i2s.c
> +++ b/sound/soc/stm/stm32_i2s.c
> @@ -838,8 +838,9 @@ static int stm32_i2s_parse_dt(struct platform_device *pdev,
>   	/* Get irqs */
>   	irq = platform_get_irq(pdev, 0);
>   	if (irq < 0) {
> -		dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
> -		return -ENOENT;
> +		if (irq != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
> +		return irq;
>   	}
>   
>   	ret = devm_request_irq(&pdev->dev, irq, stm32_i2s_isr, IRQF_ONESHOT,
> 
