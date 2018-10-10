From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] pinctrl: madera: Fix uninitialized
 variable issue in madera_mux_set_mux
Date: Wed, 10 Oct 2018 15:33:40 +0100
Message-ID: <20181010143340.GA1653@imbe.wolfsonmicro.main>
References: <20181010141353.GA14382@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 21AC72678D9
 for <alsa-devel@alsa-project.org>; Wed, 10 Oct 2018 16:33:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20181010141353.GA14382@embeddedor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, Richard Fitzgerald <rf@opensource.cirrus.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 10, 2018 at 04:13:53PM +0200, Gustavo A. R. Silva wrote:
> There is a potential execution path in which variable *ret* is checked
> in an IF statement, and then its value is used to report an error at
> line 659 without being properly initialized previously:
> 
> 659 if (ret)
> 660	dev_err(priv->dev, "Failed to write to 0x%x (%d)\n", reg, ret);
> 
> Fix this by initializing variable *ret* to -1.
> 
> Addresses-Coverity-ID: 1471969 ("Uninitialized scalar variable")
> Fixes: 218d72a77b0b ("pinctrl: madera: Add driver for Cirrus Logic Madera codecs")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/pinctrl/cirrus/pinctrl-madera-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/cirrus/pinctrl-madera-core.c b/drivers/pinctrl/cirrus/pinctrl-madera-core.c
> index 0266302..a99ace8 100644
> --- a/drivers/pinctrl/cirrus/pinctrl-madera-core.c
> +++ b/drivers/pinctrl/cirrus/pinctrl-madera-core.c
> @@ -608,7 +608,7 @@ static int madera_mux_set_mux(struct pinctrl_dev *pctldev,
>  	unsigned int n_chip_groups = priv->chip->n_pin_groups;
>  	const char *func_name = madera_mux_funcs[selector].name;
>  	unsigned int reg;
> -	int i, ret;
> +	int i, ret = -1;
>  

I don't believe this would fully address the issue since if you
initialise ret to -1 you will still drop into the if statement
and you will use the reg variable which should also be
uninitialised on that code path.

Feels like initialising to 0 would probably be better anyway
since the code path looks like the case were you have n_pins == 0
and nothing really failed in that case just nothing needed to be
done.

Thanks,
Charles

>  	dev_dbg(priv->dev, "%s selecting %u (%s) for group %u (%s)\n",
>  		__func__, selector, func_name, group,
> -- 
> 2.7.4
