From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [GIT PULL] AC'97 gpiochip
Date: Mon, 7 Dec 2015 13:34:31 +0100
Message-ID: <CACRpkdah5HLMR+fT5JRWdSNj-hFpRGm_mvu8mbJ__NA-SLwzTw@mail.gmail.com>
References: <20151203001214.GP1929@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20151203001214.GP1929@sirena.org.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 3, 2015 at 1:12 AM, Mark Brown <broonie@kernel.org> wrote:

> The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:
>
>   Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-ac97-gpio
>
> for you to fetch changes up to 9bf5c3d11f1fbaf43399d189f05fb20ceb46ee5d:
>
>   ASoC: ac97: add gpio chip (2015-11-18 18:08:54 +0000)
>
> ----------------------------------------------------------------
> ASoC: Add a GPIO chip for AC'97

Pulled to the GPIO devel branch, then I immediately applied this on top:

>From a1eb9d5751220433998ae2e66216288161b1355b Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 7 Dec 2015 13:32:28 +0100
Subject: [PATCH] ASoC: ac97: fix parent assignment

Upstream GPIO has substituted .dev for .parent in struct gpio_chip.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 sound/soc/soc-ac97.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-ac97.c b/sound/soc/soc-ac97.c
index ae563e379a72..a2012652f212 100644
--- a/sound/soc/soc-ac97.c
+++ b/sound/soc/soc-ac97.c
@@ -142,7 +142,7 @@ static int snd_soc_ac97_init_gpio(struct snd_ac97 *ac97,
     gpio_priv->codec = codec;
     gpio_priv->gpio_chip = snd_soc_ac97_gpio_chip;
     gpio_priv->gpio_chip.ngpio = AC97_NUM_GPIOS;
-    gpio_priv->gpio_chip.dev = codec->dev;
+    gpio_priv->gpio_chip.parent = codec->dev;
     gpio_priv->gpio_chip.base = -1;

     ret = gpiochip_add(&gpio_priv->gpio_chip);
-- 
2.4.3



Yours,
Linus Walleij
