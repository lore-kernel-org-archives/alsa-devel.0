From: Ian Molton <ian@mnementh.co.uk>
Subject: Re: [Pull request] Support for wm9705 codec and two
 machines that use it.
Date: Fri, 16 Jan 2009 15:46:19 +0000
Message-ID: <4970ABCB.5050300@mnementh.co.uk>
References: <496E8DD0.4090006@mnementh.co.uk> <s5hfxjl3v6s.wl%tiwai@suse.de>
	<496F0ABD.4080207@mnementh.co.uk>
	<s5hk58v4inq.wl%tiwai@suse.de> <497070D1.50301@mnementh.co.uk>
	<20090116115408.GB7554@sirena.org.uk>
	<49708E21.1060800@mnementh.co.uk>
	<20090116143135.GG7554@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mnementh.co.uk (mail.mnementh.co.uk [173.45.232.4])
	by alsa0.perex.cz (Postfix) with ESMTP id 8EB1024151
	for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2009 16:45:51 +0100 (CET)
In-Reply-To: <20090116143135.GG7554@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org


Hi,

Mark, the changes requested are implemented below. There are two 
patchsets, one for wm9705 and one for the other codec issues I found.

also available at:

git://git.mnementh.co.uk/linux-2.6-im.git asoc-pu


 From 8e89f1f1a94bc697d1ce1c07ab8426d372b0d6fe Mon Sep 17 00:00:00 2001
From: Ian Molton <ian@mnementh.co.uk>
Date: Fri, 16 Jan 2009 15:37:22 +0000
Subject: [PATCH] ASoC: codec: wm9705 misc cleanup

This patch fixes an off-by-one error in the wm9705 reg_cache 
implementation and
replaces a kzalloc/copy with kmemdup().

Signed-off-by: Ian Molton <ian@mnementh.co.uk>
---
  sound/soc/codecs/wm9705.c |   11 ++++-------
  1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index c6b7dc2..cb26b6a 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -221,7 +221,7 @@ static unsigned int ac97_read(struct snd_soc_codec 
*codec, unsigned int reg)
  	default:
  		reg = reg >> 1;

-		if (reg > (ARRAY_SIZE(wm9705_reg)))
+		if (reg >= (ARRAY_SIZE(wm9705_reg)))
  			return -EIO;

  		return cache[reg];
@@ -235,7 +235,7 @@ static int ac97_write(struct snd_soc_codec *codec, 
unsigned int reg,

  	soc_ac97_ops.write(codec->ac97, reg, val);
  	reg = reg >> 1;
-	if (reg <= (ARRAY_SIZE(wm9705_reg)))
+	if (reg < (ARRAY_SIZE(wm9705_reg)))
  		cache[reg] = val;

  	return 0;
@@ -327,15 +327,12 @@ static int wm9705_soc_probe(struct platform_device 
*pdev)
  	codec = socdev->codec;
  	mutex_init(&codec->mutex);

-	codec->reg_cache =
-		kzalloc(sizeof(u16) * ARRAY_SIZE(wm9705_reg), GFP_KERNEL);
+	codec->reg_cache = kmemdup(wm9705_reg, sizeof(wm9705_reg), GFP_KERNEL);
  	if (codec->reg_cache == NULL) {
  		ret = -ENOMEM;
  		goto cache_err;
  	}
-	memcpy(codec->reg_cache, wm9705_reg,
-		sizeof(u16) * ARRAY_SIZE(wm9705_reg));
-	codec->reg_cache_size = sizeof(u16) * ARRAY_SIZE(wm9705_reg);
+	codec->reg_cache_size = sizeof(wm9705_reg);
  	codec->reg_cache_step = 2;

  	codec->name = "WM9705";
-- 
1.5.6.5

 From 7ff27c9c1f7a7b7c86d3138060b1b406ad5dd6af Mon Sep 17 00:00:00 2001
From: Ian Molton <ian@mnementh.co.uk>
Date: Fri, 16 Jan 2009 15:03:19 +0000
Subject: [PATCH] ASoC: fixes to caching implementations

This patch takes fixes a number of bugs in the caching code used by
several ASoC codec drivers. Mostly off-by-one fixes.

Signed-off-by: Ian Molton <ian@mnementh.co.uk>
---
  sound/soc/codecs/ac97.c    |    2 --
  sound/soc/codecs/ad1980.c  |    4 ++--
  sound/soc/codecs/twl4030.c |    3 +++
  sound/soc/codecs/wm8580.c  |    4 ++--
  sound/soc/codecs/wm8728.c  |    4 ++--
  sound/soc/codecs/wm8753.c  |    4 ++--
  sound/soc/codecs/wm8990.c  |    4 ++--
  sound/soc/codecs/wm9712.c  |    4 ++--
  sound/soc/codecs/wm9713.c  |    4 ++--
  9 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/ac97.c b/sound/soc/codecs/ac97.c
index fb53e65..89d4127 100644
--- a/sound/soc/codecs/ac97.c
+++ b/sound/soc/codecs/ac97.c
@@ -123,7 +123,6 @@ bus_err:
  	snd_soc_free_pcms(socdev);

  err:
-	kfree(socdev->codec->reg_cache);
  	kfree(socdev->codec);
  	socdev->codec = NULL;
  	return ret;
@@ -138,7 +137,6 @@ static int ac97_soc_remove(struct platform_device *pdev)
  		return 0;

  	snd_soc_free_pcms(socdev);
-	kfree(socdev->codec->reg_cache);
  	kfree(socdev->codec);

  	return 0;
diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index c3c5d0e..faf3587 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -109,7 +109,7 @@ static unsigned int ac97_read(struct snd_soc_codec 
*codec,
  	default:
  		reg = reg >> 1;

-		if (reg >= (ARRAY_SIZE(ad1980_reg)))
+		if (reg >= ARRAY_SIZE(ad1980_reg))
  			return -EINVAL;

  		return cache[reg];
@@ -123,7 +123,7 @@ static int ac97_write(struct snd_soc_codec *codec, 
unsigned int reg,

  	soc_ac97_ops.write(codec->ac97, reg, val);
  	reg = reg >> 1;
-	if (reg < (ARRAY_SIZE(ad1980_reg)))
+	if (reg < ARRAY_SIZE(ad1980_reg))
  		cache[reg] = val;

  	return 0;
diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index ddc9f37..f530c1e 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -125,6 +125,9 @@ static inline unsigned int 
twl4030_read_reg_cache(struct snd_soc_codec *codec,
  {
  	u8 *cache = codec->reg_cache;

+	if (reg >= TWL4030_CACHEREGNUM)
+		return -EIO;
+
  	return cache[reg];
  }

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 9b75a37..3faf0e7 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -200,7 +200,7 @@ static inline unsigned int 
wm8580_read_reg_cache(struct snd_soc_codec *codec,
  	unsigned int reg)
  {
  	u16 *cache = codec->reg_cache;
-	BUG_ON(reg > ARRAY_SIZE(wm8580_reg));
+	BUG_ON(reg >= ARRAY_SIZE(wm8580_reg));
  	return cache[reg];
  }

@@ -223,7 +223,7 @@ static int wm8580_write(struct snd_soc_codec *codec, 
unsigned int reg,
  {
  	u8 data[2];

-	BUG_ON(reg > ARRAY_SIZE(wm8580_reg));
+	BUG_ON(reg >= ARRAY_SIZE(wm8580_reg));

  	/* Registers are 9 bits wide */
  	value &= 0x1ff;
diff --git a/sound/soc/codecs/wm8728.c b/sound/soc/codecs/wm8728.c
index defa310..f90dc52 100644
--- a/sound/soc/codecs/wm8728.c
+++ b/sound/soc/codecs/wm8728.c
@@ -47,7 +47,7 @@ static inline unsigned int 
wm8728_read_reg_cache(struct snd_soc_codec *codec,
  	unsigned int reg)
  {
  	u16 *cache = codec->reg_cache;
-	BUG_ON(reg > ARRAY_SIZE(wm8728_reg_defaults));
+	BUG_ON(reg >= ARRAY_SIZE(wm8728_reg_defaults));
  	return cache[reg];
  }

@@ -55,7 +55,7 @@ static inline void wm8728_write_reg_cache(struct 
snd_soc_codec *codec,
  	u16 reg, unsigned int value)
  {
  	u16 *cache = codec->reg_cache;
-	BUG_ON(reg > ARRAY_SIZE(wm8728_reg_defaults));
+	BUG_ON(reg >= ARRAY_SIZE(wm8728_reg_defaults));
  	cache[reg] = value;
  }

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 7283178..5a1c1fc 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -97,7 +97,7 @@ static inline unsigned int 
wm8753_read_reg_cache(struct snd_soc_codec *codec,
  	unsigned int reg)
  {
  	u16 *cache = codec->reg_cache;
-	if (reg < 1 || reg > (ARRAY_SIZE(wm8753_reg) + 1))
+	if (reg < 1 || reg >= (ARRAY_SIZE(wm8753_reg) + 1))
  		return -1;
  	return cache[reg - 1];
  }
@@ -109,7 +109,7 @@ static inline void wm8753_write_reg_cache(struct 
snd_soc_codec *codec,
  	unsigned int reg, unsigned int value)
  {
  	u16 *cache = codec->reg_cache;
-	if (reg < 1 || reg > 0x3f)
+	if (reg < 1 || reg >= (ARRAY_SIZE(wm8753_reg) + 1))
  		return;
  	cache[reg - 1] = value;
  }
diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index 6b27786..f93c095 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -116,7 +116,7 @@ static inline unsigned int 
wm8990_read_reg_cache(struct snd_soc_codec *codec,
  	unsigned int reg)
  {
  	u16 *cache = codec->reg_cache;
-	BUG_ON(reg > (ARRAY_SIZE(wm8990_reg)) - 1);
+	BUG_ON(reg >= ARRAY_SIZE(wm8990_reg));
  	return cache[reg];
  }

@@ -129,7 +129,7 @@ static inline void wm8990_write_reg_cache(struct 
snd_soc_codec *codec,
  	u16 *cache = codec->reg_cache;

  	/* Reset register and reserved registers are uncached */
-	if (reg == 0 || reg > ARRAY_SIZE(wm8990_reg) - 1)
+	if (reg == 0 || reg >= ARRAY_SIZE(wm8990_reg))
  		return;

  	cache[reg] = value;
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 1b0ace0..4dc90d6 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -452,7 +452,7 @@ static unsigned int ac97_read(struct snd_soc_codec 
*codec,
  	else {
  		reg = reg >> 1;

-		if (reg > (ARRAY_SIZE(wm9712_reg)))
+		if (reg >= (ARRAY_SIZE(wm9712_reg)))
  			return -EIO;

  		return cache[reg];
@@ -466,7 +466,7 @@ static int ac97_write(struct snd_soc_codec *codec, 
unsigned int reg,

  	soc_ac97_ops.write(codec->ac97, reg, val);
  	reg = reg >> 1;
-	if (reg <= (ARRAY_SIZE(wm9712_reg)))
+	if (reg < (ARRAY_SIZE(wm9712_reg)))
  		cache[reg] = val;

  	return 0;
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index a456226..d8ddca9 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -621,7 +621,7 @@ static unsigned int ac97_read(struct snd_soc_codec 
*codec,
  	else {
  		reg = reg >> 1;

-		if (reg > (ARRAY_SIZE(wm9713_reg)))
+		if (reg >= (ARRAY_SIZE(wm9713_reg)))
  			return -EIO;

  		return cache[reg];
@@ -635,7 +635,7 @@ static int ac97_write(struct snd_soc_codec *codec, 
unsigned int reg,
  	if (reg < 0x7c)
  		soc_ac97_ops.write(codec->ac97, reg, val);
  	reg = reg >> 1;
-	if (reg <= (ARRAY_SIZE(wm9713_reg)))
+	if (reg < (ARRAY_SIZE(wm9713_reg)))
  		cache[reg] = val;

  	return 0;
-- 
1.5.6.5
