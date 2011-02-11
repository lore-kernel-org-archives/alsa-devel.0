From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2 2.6.38] ASoC: soc-cache: Introduce the
	cache_bypass option
Date: Fri, 11 Feb 2011 14:54:01 +0000
Message-ID: <1297436042-18324-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E391C10387A
	for <alsa-devel@alsa-project.org>; Fri, 11 Feb 2011 15:54:04 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

This is primarily needed to avoid writing back to the cache
whenever we are syncing the cache with the hardware.  This gives a
performance benefit especially for large register maps.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h   |    1 +
 sound/soc/soc-cache.c |   36 ++++++++++++++++++++++++------------
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 74921f2..5e19644 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -463,6 +463,7 @@ struct snd_soc_codec {
 	/* runtime */
 	struct snd_ac97 *ac97;  /* for ad-hoc ac97 devices */
 	unsigned int active;
+	unsigned int cache_bypass:1; /* Suppress access to the cache */
 	unsigned int cache_only:1;  /* Suppress writes to hardware */
 	unsigned int cache_sync:1; /* Cache needs to be synced to hardware */
 	unsigned int suspended:1; /* Codec is in suspend PM state */
diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 8c2a21a..799e376 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -25,7 +25,8 @@ static unsigned int snd_soc_4_12_read(struct snd_soc_codec *codec,
 	unsigned int val;
 
 	if (reg >= codec->driver->reg_cache_size ||
-		snd_soc_codec_volatile_register(codec, reg)) {
+		snd_soc_codec_volatile_register(codec, reg) ||
+		codec->cache_bypass) {
 			if (codec->cache_only)
 				return -1;
 
@@ -49,7 +50,8 @@ static int snd_soc_4_12_write(struct snd_soc_codec *codec, unsigned int reg,
 	data[1] = value & 0x00ff;
 
 	if (!snd_soc_codec_volatile_register(codec, reg) &&
-		reg < codec->driver->reg_cache_size) {
+		reg < codec->driver->reg_cache_size &&
+		!codec->cache_bypass) {
 		ret = snd_soc_cache_write(codec, reg, value);
 		if (ret < 0)
 			return -1;
@@ -106,7 +108,8 @@ static unsigned int snd_soc_7_9_read(struct snd_soc_codec *codec,
 	unsigned int val;
 
 	if (reg >= codec->driver->reg_cache_size ||
-		snd_soc_codec_volatile_register(codec, reg)) {
+		snd_soc_codec_volatile_register(codec, reg) ||
+		codec->cache_bypass) {
 			if (codec->cache_only)
 				return -1;
 
@@ -130,7 +133,8 @@ static int snd_soc_7_9_write(struct snd_soc_codec *codec, unsigned int reg,
 	data[1] = value & 0x00ff;
 
 	if (!snd_soc_codec_volatile_register(codec, reg) &&
-		reg < codec->driver->reg_cache_size) {
+		reg < codec->driver->reg_cache_size &&
+		!codec->cache_bypass) {
 		ret = snd_soc_cache_write(codec, reg, value);
 		if (ret < 0)
 			return -1;
@@ -191,7 +195,8 @@ static int snd_soc_8_8_write(struct snd_soc_codec *codec, unsigned int reg,
 	data[1] = value & 0xff;
 
 	if (!snd_soc_codec_volatile_register(codec, reg) &&
-		reg < codec->driver->reg_cache_size) {
+		reg < codec->driver->reg_cache_size &&
+		!codec->cache_bypass) {
 		ret = snd_soc_cache_write(codec, reg, value);
 		if (ret < 0)
 			return -1;
@@ -216,7 +221,8 @@ static unsigned int snd_soc_8_8_read(struct snd_soc_codec *codec,
 
 	reg &= 0xff;
 	if (reg >= codec->driver->reg_cache_size ||
-		snd_soc_codec_volatile_register(codec, reg)) {
+		snd_soc_codec_volatile_register(codec, reg) ||
+		codec->cache_bypass) {
 			if (codec->cache_only)
 				return -1;
 
@@ -271,7 +277,8 @@ static int snd_soc_8_16_write(struct snd_soc_codec *codec, unsigned int reg,
 	data[2] = value & 0xff;
 
 	if (!snd_soc_codec_volatile_register(codec, reg) &&
-		reg < codec->driver->reg_cache_size) {
+		reg < codec->driver->reg_cache_size &&
+		!codec->cache_bypass) {
 		ret = snd_soc_cache_write(codec, reg, value);
 		if (ret < 0)
 			return -1;
@@ -295,7 +302,8 @@ static unsigned int snd_soc_8_16_read(struct snd_soc_codec *codec,
 	unsigned int val;
 
 	if (reg >= codec->driver->reg_cache_size ||
-	    snd_soc_codec_volatile_register(codec, reg)) {
+	    snd_soc_codec_volatile_register(codec, reg) ||
+	    codec->cache_bypass) {
 		if (codec->cache_only)
 			return -1;
 
@@ -450,7 +458,8 @@ static unsigned int snd_soc_16_8_read(struct snd_soc_codec *codec,
 
 	reg &= 0xff;
 	if (reg >= codec->driver->reg_cache_size ||
-		snd_soc_codec_volatile_register(codec, reg)) {
+		snd_soc_codec_volatile_register(codec, reg) ||
+		codec->cache_bypass) {
 			if (codec->cache_only)
 				return -1;
 
@@ -476,7 +485,8 @@ static int snd_soc_16_8_write(struct snd_soc_codec *codec, unsigned int reg,
 
 	reg &= 0xff;
 	if (!snd_soc_codec_volatile_register(codec, reg) &&
-		reg < codec->driver->reg_cache_size) {
+		reg < codec->driver->reg_cache_size &&
+		!codec->cache_bypass) {
 		ret = snd_soc_cache_write(codec, reg, value);
 		if (ret < 0)
 			return -1;
@@ -568,7 +578,8 @@ static unsigned int snd_soc_16_16_read(struct snd_soc_codec *codec,
 	unsigned int val;
 
 	if (reg >= codec->driver->reg_cache_size ||
-	    snd_soc_codec_volatile_register(codec, reg)) {
+	    snd_soc_codec_volatile_register(codec, reg) ||
+	    codec->cache_bypass) {
 		if (codec->cache_only)
 			return -1;
 
@@ -595,7 +606,8 @@ static int snd_soc_16_16_write(struct snd_soc_codec *codec, unsigned int reg,
 	data[3] = value & 0xff;
 
 	if (!snd_soc_codec_volatile_register(codec, reg) &&
-		reg < codec->driver->reg_cache_size) {
+		reg < codec->driver->reg_cache_size &&
+		!codec->cache_bypass) {
 		ret = snd_soc_cache_write(codec, reg, value);
 		if (ret < 0)
 			return -1;
-- 
1.7.4
