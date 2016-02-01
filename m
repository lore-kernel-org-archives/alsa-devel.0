From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH 2/2] regmap: cache: Fall back to register by register
 read for cache defaults
Date: Mon, 01 Feb 2016 23:54:43 +0100
Message-ID: <56AFE233.10701@maciej.szmigiero.name>
References: <1454362695-10682-1-git-send-email-broonie@kernel.org> <1454362695-10682-2-git-send-email-broonie@kernel.org> <20160201214139.GI4455@sirena.org.uk> <CAOMZO5BSbFo7xMEHY9s5YNitKFq8gJ83W6oDnS8PYBBDu2+ykQ@mail.gmail.com> <20160201221346.GJ4455@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160201221346.GJ4455@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Nicolin Chen <nicoleotsuka@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 01.02.2016 23:13, Mark Brown wrote:
> On Mon, Feb 01, 2016 at 07:58:54PM -0200, Fabio Estevam wrote:
>> On Mon, Feb 1, 2016 at 7:41 PM, Mark Brown <broonie@kernel.org> wrote:
>>> On Mon, Feb 01, 2016 at 09:38:15PM +0000, Mark Brown wrote:
>>>> If we are unable to read the cache defaults for a regmap then fall back
>>>> on attempting to read them word by word. This is going to be painfully
>>>> slow for large regmaps but might be adequate for smaller ones.
> 
>>> Competely untested, hopefully it helps fix the issues with the SSI.
> 
>> After applying this series I get:
> 
> Please try to fix it yourself, probably needs setting cache_bypass
> around the manual fill.

Thanks for patches.

I was able to make SSI work again after modifying second patch
with cache_bypass around read and skipping of unreadable regs:
diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index 5c5090b..4170b7d 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -30,7 +30,7 @@ static int regcache_hw_init(struct regmap *map)
 	int i, j;
 	int ret;
 	int count;
-	unsigned int val;
+	unsigned int reg, val;
 	void *tmp_buf;
 
 	if (!map->num_reg_defaults_raw)
@@ -67,27 +67,46 @@ static int regcache_hw_init(struct regmap *map)
 		ret = regmap_raw_read(map, 0, tmp_buf,
 				      map->cache_size_raw);
 		map->cache_bypass = cache_bypass;
-		if (ret < 0)
-			goto err_cache_free;
-
-		map->reg_defaults_raw = tmp_buf;
-		map->cache_free = 1;
+		if (ret == 0) {
+			map->reg_defaults_raw = tmp_buf;
+			map->cache_free = 1;
+		} else {
+			kfree(tmp_buf);
+		}
 	}
 
 	/* fill the reg_defaults */
 	for (i = 0, j = 0; i < map->num_reg_defaults_raw; i++) {
-		if (regmap_volatile(map, i * map->reg_stride))
+		reg = i * map->reg_stride;
+
+		if (!regmap_readable(map, reg))
 			continue;
-		val = regcache_get_val(map, map->reg_defaults_raw, i);
-		map->reg_defaults[j].reg = i * map->reg_stride;
+
+		if (regmap_volatile(map, reg))
+			continue;
+
+		if (map->reg_defaults_raw) {
+			val = regcache_get_val(map, map->reg_defaults_raw, i);
+		} else {
+			bool cache_bypass = map->cache_bypass;
+
+			map->cache_bypass = true;
+			ret = regmap_read(map, reg, &val);
+			map->cache_bypass = cache_bypass;
+			if (ret != 0) {
+				dev_err(map->dev, "Failed to read %d: %d\n",
+					reg, ret);
+				goto err_free;
+			}
+		}
+
+		map->reg_defaults[j].reg = reg;
 		map->reg_defaults[j].def = val;
 		j++;
 	}
 
 	return 0;
 
-err_cache_free:
-	kfree(tmp_buf);
 err_free:
 	kfree(map->reg_defaults);
 

 
