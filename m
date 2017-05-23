From: Paul Handrigan <paul.handrigan@cirrus.com>
Subject: Re: [PATCH] ASoC: cs4271: Remove unnecessary
 additional variable definitio
Date: Tue, 23 May 2017 12:22:53 -0500
Message-ID: <683bce62-7ee6-4552-ae2f-ec5fc179b865@EX3.ad.cirrus.com>
References: <1495551819-17040-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 67992267111
 for <alsa-devel@alsa-project.org>; Tue, 23 May 2017 19:22:18 +0200 (CEST)
In-Reply-To: <1495551819-17040-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org



On Tue, 23 May 2017, Charles Keepax wrote:

> The function already defines a ret variable at the top and makes
> no particular use of the shadowed definition, as such remove the
> redundant definition.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/cs4271.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
> index e78b5f0..d882477 100644
> --- a/sound/soc/codecs/cs4271.c
> +++ b/sound/soc/codecs/cs4271.c
> @@ -674,8 +674,6 @@ static int cs4271_common_probe(struct device *dev,
>  		cs4271->gpio_nreset = cs4271plat->gpio_nreset;
>  
>  	if (gpio_is_valid(cs4271->gpio_nreset)) {
> -		int ret;
> -
>  		ret = devm_gpio_request(dev, cs4271->gpio_nreset,
>  					"CS4271 Reset");
>  		if (ret < 0)
>
Acked-by: Paul Handrigan <Paul.Handrigan@cirrus.com> 
