From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/2] ASoC: rt5645: fix error handling for
	gpio detection
Date: Thu, 2 Feb 2017 11:40:44 +0900
Message-ID: <c41f5795-4b53-48d5-5a46-b2a579f3b931@sakamocchi.jp>
References: <1485973625-20553-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1485973625-20553-2-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 6CA46267500
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2017 03:40:48 +0100 (CET)
In-Reply-To: <1485973625-20553-2-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Feb 2 2017 03:27, Pierre-Louis Bossart wrote:
> Optional gpio handling should not cause an error status and prevent
> probing if it's missing.  Remove error return for -ENOENT case and
> move error message to dev_info
>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  sound/soc/codecs/rt5645.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
> index 65ac841..e149f3c 100644
> --- a/sound/soc/codecs/rt5645.c
> +++ b/sound/soc/codecs/rt5645.c
> @@ -3660,8 +3660,14 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
>  						       GPIOD_IN);
>
>  	if (IS_ERR(rt5645->gpiod_hp_det)) {
> -		dev_err(&i2c->dev, "failed to initialize gpiod\n");
> -		return PTR_ERR(rt5645->gpiod_hp_det);
> +		dev_info(&i2c->dev, "failed to initialize gpiod\n");
> +		ret = PTR_ERR(rt5645->gpiod_hp_det);
> +		/*
> +		 * Continue if optional gpiod is missing, bail for all other
> +		 * errors, including -EPROBE_DEFER
> +		 */
> +		if (ret != -ENOENT)
> +			return ret;
>  	}
>
>  	for (i = 0; i < ARRAY_SIZE(rt5645->supplies); i++)

(sound/soc/codecs/rt5645.c)
rt5645_i2c_probe()
  (drivers/gpio/devres.c)
  ->devm_gpiod_get_optional()
    ->devm_gpiod_get_index_optional()

As long as seeing current implementation of 
'devm_gpiod_get_index_optional()', this function never returns ENOENT. 
In this case, it returns NULL.
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/gpio/devres.c#n185

IS_ERR(NULL) is false, thus the additional condition is useless. When 
entering the branch, error code should be always returned.

For your purpose, checking NULL at first, then handles the error 
properly, like:

$ git diff
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 1ac96ef..a588454 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3656,10 +3656,15 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,

         rt5645->gpiod_hp_det = devm_gpiod_get_optional(&i2c->dev, 
"hp-detect",
                                                        GPIOD_IN);
-
-       if (IS_ERR(rt5645->gpiod_hp_det)) {
-               dev_err(&i2c->dev, "failed to initialize gpiod\n");
-               return PTR_ERR(rt5645->gpiod_hp_det);
+       if (rt5645->gpiod_hp_det && IS_ERR(rt5645->gpiod_hp_det)) {
+               dev_info(&i2c->dev, "failed to initialize gpiod\n");
+               ret = PTR_ERR(rt5645->gpiod_hp_det);
+               /*
+                * Continue if optional gpiod is missing, bail for all other
+                * errors, including -EPROBE_DEFER. -ENOENT is never returns
+                * according to implementation of devm_gpiod_get_optional().
+                */
+               return ret;
         }

         for (i = 0; i < ARRAY_SIZE(rt5645->supplies); i++)


Regards

Takashi Sakamoto
