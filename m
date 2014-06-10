From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [RESEND PATCH v2 1/2] ASoC: samsung: s3c24{xx,12}-i2s: port to use
 generic dmaengine API
Date: Tue, 10 Jun 2014 17:25:43 +0200
Message-ID: <53972377.7050109@samsung.com>
References: <1401642958-6236-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1401642958-6236-1-git-send-email-anarsoul@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Vasily Khoruzhick <anarsoul@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Kukjin Kim <kgene.kim@samsung.com>, Sangbeom Kim <sbkim73@samsung.com>, Lars-Peter Clausen <lars@metafoo.de>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>
List-Id: alsa-devel@alsa-project.org

Hi,

On 01.06.2014 19:15, Vasily Khoruzhick wrote:
> Use dmaengine instead of legacy s3c24xx DMA API for s3c24xx and s3c2412
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
> v2: use hardcoded dma channel number
> 
>  sound/soc/samsung/Kconfig       |  9 +++----
>  sound/soc/samsung/dmaengine.c   |  3 +++
>  sound/soc/samsung/s3c-i2s-v2.c  | 17 +------------
>  sound/soc/samsung/s3c2412-i2s.c | 47 +++++++++++++++++-----------------
>  sound/soc/samsung/s3c24xx-i2s.c | 56 +++++++++++++++++++----------------------
>  5 files changed, 56 insertions(+), 76 deletions(-)
> 

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
