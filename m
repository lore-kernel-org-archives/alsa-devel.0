From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 5/6] extcon: arizona: Add support for WM8280/WM8281
Date: Fri, 14 Nov 2014 08:34:50 +0900
Message-ID: <5465401A.6060506@samsung.com>
References: <1415901046-3391-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1415901046-3391-6-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-reply-to: <1415901046-3391-6-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: lee.jones@linaro.org, lgirdwood@gmail.com, myungjoo.ham@samsung.com, linus.walleij@linaro.org, gnurou@gmail.com, broonie@kernel.org, tiwai@suse.de, perex@perex.cz, sameo@linux.intel.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, ckeepax@opensource.wolfsonmicro.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11/14/2014 02:50 AM, Richard Fitzgerald wrote:
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> ---
>  drivers/extcon/extcon-arizona.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
> index ba51588..3abe866 100644
> --- a/drivers/extcon/extcon-arizona.c
> +++ b/drivers/extcon/extcon-arizona.c
> @@ -1149,6 +1149,7 @@ static int arizona_extcon_probe(struct platform_device *pdev)
>  		}
>  		break;
>  	case WM5110:
> +	case WM8280:
>  		switch (arizona->rev) {
>  		case 0 ... 2:
>  			break;
> 

This patch is simple.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Best Regards,
Chanwoo Choi
