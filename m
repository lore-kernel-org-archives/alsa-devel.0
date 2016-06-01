From: "Handrigan, Paul" <Paul.Handrigan@cirrus.com>
Subject: Re: [PATCH 2/2] ASoC: cs53l30: Check return value of regcache_sync()
Date: Wed, 1 Jun 2016 01:28:25 +0000
Message-ID: <D373A44D.1446E%Paul.Handrigan@cirrus.com>
References: <1464735999-10384-2-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464735999-10384-2-git-send-email-nicoleotsuka@gmail.com>
Content-Language: en-US
Content-ID: <ED9A696B133A7D488E381B173C55B404@ad.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "Austin, Brian" <Brian.Austin@cirrus.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



On 5/31/16, 6:06 PM, "Nicolin Chen" <nicoleotsuka@gmail.com> wrote:

>Regcache_sync() might fail. So this patch adds a return value Check for
>it.
>
>Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
>---
> sound/soc/codecs/cs53l30.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>
>diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
>index 9aff449..ac90dd7 100644
>--- a/sound/soc/codecs/cs53l30.c
>+++ b/sound/soc/codecs/cs53l30.c
>@@ -1055,7 +1055,11 @@ static int cs53l30_runtime_resume(struct device
>*dev)
> 		gpiod_set_value_cansleep(cs53l30->reset_gpio, 1);
> 
> 	regcache_cache_only(cs53l30->regmap, false);
>-	regcache_sync(cs53l30->regmap);
>+	ret = regcache_sync(cs53l30->regmap);
>+	if (ret) {
>+		dev_err(dev, "failed to synchronize regcache: %d\n", ret);
>+		return ret;
>+	}
> 
> 	return 0;
> }
>-- 
>2.1.4

Acked-by: Paul Handrigan <Paul.Handrigan@cirrus.com>
