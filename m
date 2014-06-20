From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH 01/16] ASoC: cs4270: Remove redundant OOM
 message
Date: Fri, 20 Jun 2014 16:34:12 +0530
Message-ID: <53A4152C.2050702@st.com>
References: <1403258352-8210-1-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 1AC1D261ABF
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 13:04:19 +0200 (CEST)
In-Reply-To: <1403258352-8210-1-git-send-email-sachin.kamat@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@samsung.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "broonie@kernel.org" <broonie@kernel.org>, "spk.linux@gmail.com" <spk.linux@gmail.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 6/20/2014 3:28 PM, Sachin Kamat wrote:
> Let memory subsystem handle the error logging.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
> ---
>   sound/soc/codecs/cs4270.c |    4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
> index 9947a9583679..e6d4ff9fd992 100644
> --- a/sound/soc/codecs/cs4270.c
> +++ b/sound/soc/codecs/cs4270.c
> @@ -664,10 +664,8 @@ static int cs4270_i2c_probe(struct i2c_client *i2c_client,
>
>   	cs4270 = devm_kzalloc(&i2c_client->dev, sizeof(struct cs4270_private),
>   			      GFP_KERNEL);
> -	if (!cs4270) {
> -		dev_err(&i2c_client->dev, "could not allocate codec\n");

You are just removing a information which are required in error condition.
In my view it should be here..

~Rajeev

> +	if (!cs4270)
>   		return -ENOMEM;
> -	}
>
>   	/* get the power supply regulators */
>   	for (i = 0; i < ARRAY_SIZE(supply_names); i++)
>
