From: "Handrigan, Paul" <Paul.Handrigan@cirrus.com>
Subject: Re: [PATCH 02/16] ASoC: cs42l73: Remove redundant
	OOM	message
Date: Fri, 20 Jun 2014 14:48:51 +0000
Message-ID: <05ADE5AA-EC0E-4EF6-97A4-FC595AF90033@cirrus.com>
References: <1403258352-8210-1-git-send-email-sachin.kamat@samsung.com>,
 <1403258352-8210-2-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0144.outbound.protection.outlook.com [207.46.163.144])
 by alsa0.perex.cz (Postfix) with ESMTP id A48BB2650C2
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 16:49:09 +0200 (CEST)
In-Reply-To: <1403258352-8210-2-git-send-email-sachin.kamat@samsung.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@samsung.com>
Cc: "Austin, Brian" <Brian.Austin@cirrus.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "spk.linux@gmail.com" <spk.linux@gmail.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org



> On Jun 20, 2014, at 5:04 AM, "Sachin Kamat" <sachin.kamat@samsung.com> wrote:
> 
> Let memory subsystem handle the error logging.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
> ---
> sound/soc/codecs/cs42l73.c |    4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
> index ae3717992d56..e3b601624794 100644
> --- a/sound/soc/codecs/cs42l73.c
> +++ b/sound/soc/codecs/cs42l73.c
> @@ -1408,10 +1408,8 @@ static int cs42l73_i2c_probe(struct i2c_client *i2c_client,
> 
>    cs42l73 = devm_kzalloc(&i2c_client->dev, sizeof(struct cs42l73_private),
>                   GFP_KERNEL);
> -    if (!cs42l73) {
> -        dev_err(&i2c_client->dev, "could not allocate codec\n");
> +    if (!cs42l73)
>        return -ENOMEM;
> -    }
> 
>    cs42l73->regmap = devm_regmap_init_i2c(i2c_client, &cs42l73_regmap);
>    if (IS_ERR(cs42l73->regmap)) {
> -- 
> 1.7.9.5
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-

Please CC the driver maintainers.

Acked-by: Paul Handrigan <Paul.Handrigan@cirrus.com>
