From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC] ASoC: sgtl5000: Remove cache support
Date: Wed, 8 May 2013 13:02:10 -0300
Message-ID: <CAOMZO5DYBONvbEQQd1_CUB7VhVn7pyxB=ms7u-uiJpWS4OSMAw@mail.gmail.com>
References: <20130503223613.GR4945@sirena.org.uk>
 <CAOMZO5B84e0YdcJLa27e4KZv459CGL=msU0fqe4LyFZfM-t1+A@mail.gmail.com>
 <CAOMZO5BG-3SKZF_ZrQ=C51nLvKYSNJEgy-KavzBXJcb=fCk=iA@mail.gmail.com>
 <20130505101515.GT4945@sirena.org.uk>
 <CAKGA1bmKdtAoUP7Yn0CJRVwsCNX5JkEWdWVJj1VJBaJn+9PA=A@mail.gmail.com>
 <20130506220650.GJ7478@sirena.org.uk>
 <CAKGA1b=+j5BpHzWOfkDv+xjLLcauHeD4jDj_Do+6ft6UPhYEtA@mail.gmail.com>
 <20130508103150.GW7478@sirena.org.uk>
 <518A608E.8030802@boundarydevices.com>
 <20130508145919.GU7478@sirena.org.uk>
 <20130508151128.GW7478@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f182.google.com (mail-vc0-f182.google.com
 [209.85.220.182])
 by alsa0.perex.cz (Postfix) with ESMTP id C46602616EF
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2013 18:02:12 +0200 (CEST)
Received: by mail-vc0-f182.google.com with SMTP id ia10so1826519vcb.27
 for <alsa-devel@alsa-project.org>; Wed, 08 May 2013 09:02:11 -0700 (PDT)
In-Reply-To: <20130508151128.GW7478@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Matt Sealey <matt@genesi-usa.com>, Eric Nelson <eric.nelson@boundarydevices.com>, "troy.kisky" <troy.kisky@boundarydevices.com>, "zengzm.kernel" <zengzm.kernel@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Wed, May 8, 2013 at 12:11 PM, Mark Brown <broonie@kernel.org> wrote:

> Actually the simplest way to implement this solution (at least with
> regmap, IIRC there might've been some issues with the ASoC cache code)
> is just to discard the register defaults.  The core will fall back to
> reading the hardware for any register it doesn't have cached but will
> continue to cache values that are written.

Shouldn't we use defaults_raw with regmap?

The patch below fixes the reset issue for me:

>From d9018614781f9a4626d75dabbb495b8b44c74d09 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@freescale.com>
Date: Wed, 8 May 2013 12:56:44 -0300
Subject: [PATCH] ASoC: sgtl5000: Use 'defaults_raw'

When using regmap, the 'defaults_raw' variants must be used, as these are the
ones checked inside drivers/base/regmap/regcache.c

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/sgtl5000.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 327b443..c59fae8 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1470,8 +1470,8 @@ static const struct regmap_config sgtl5000_regmap = {
 	.readable_reg = sgtl5000_readable,

 	.cache_type = REGCACHE_RBTREE,
-	.reg_defaults = sgtl5000_reg_defaults,
-	.num_reg_defaults = ARRAY_SIZE(sgtl5000_reg_defaults),
+	.reg_defaults_raw = sgtl5000_reg_defaults,
+	.num_reg_defaults_raw = ARRAY_SIZE(sgtl5000_reg_defaults),
 };

 static int sgtl5000_i2c_probe(struct i2c_client *client,
-- 
1.7.9.5

If you think this is the right approach I can submit this change and
fix the other codecs that use regmap as well.

Regards,

Fabio Estevam
