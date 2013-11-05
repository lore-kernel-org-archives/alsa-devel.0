From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 04/31] ASoC: tpa6130a2: Use WARN_ON() instead
	of BUG_ON()
Date: Tue,  5 Nov 2013 18:39:51 +0100
Message-ID: <1383673218-18405-5-git-send-email-tiwai@suse.de>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D9A5326519F
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 18:40:41 +0100 (CET)
In-Reply-To: <1383673218-18405-1-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

BUG_ON() is rather useless for debugging as it leads to panic().
Use WARN_ON() and handle the error cases accordingly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/tpa6130a2.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 998555f2a8aa..b27c396037d4 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -56,7 +56,8 @@ static int tpa6130a2_i2c_read(int reg)
 	struct tpa6130a2_data *data;
 	int val;
 
-	BUG_ON(tpa6130a2_client == NULL);
+	if (WARN_ON(!tpa6130a2_client))
+		return -EINVAL;
 	data = i2c_get_clientdata(tpa6130a2_client);
 
 	/* If powered off, return the cached value */
@@ -78,7 +79,8 @@ static int tpa6130a2_i2c_write(int reg, u8 value)
 	struct tpa6130a2_data *data;
 	int val = 0;
 
-	BUG_ON(tpa6130a2_client == NULL);
+	if (WARN_ON(!tpa6130a2_client))
+		return -EINVAL;
 	data = i2c_get_clientdata(tpa6130a2_client);
 
 	if (data->power_state) {
@@ -99,7 +101,8 @@ static u8 tpa6130a2_read(int reg)
 {
 	struct tpa6130a2_data *data;
 
-	BUG_ON(tpa6130a2_client == NULL);
+	if (WARN_ON(!tpa6130a2_client))
+		return 0;
 	data = i2c_get_clientdata(tpa6130a2_client);
 
 	return data->regs[reg];
@@ -110,7 +113,8 @@ static int tpa6130a2_initialize(void)
 	struct tpa6130a2_data *data;
 	int i, ret = 0;
 
-	BUG_ON(tpa6130a2_client == NULL);
+	if (WARN_ON(!tpa6130a2_client))
+		return -EINVAL;
 	data = i2c_get_clientdata(tpa6130a2_client);
 
 	for (i = 1; i < TPA6130A2_REG_VERSION; i++) {
@@ -128,7 +132,8 @@ static int tpa6130a2_power(u8 power)
 	u8	val;
 	int	ret = 0;
 
-	BUG_ON(tpa6130a2_client == NULL);
+	if (WARN_ON(!tpa6130a2_client))
+		return -EINVAL;
 	data = i2c_get_clientdata(tpa6130a2_client);
 
 	mutex_lock(&data->mutex);
@@ -194,7 +199,8 @@ static int tpa6130a2_get_volsw(struct snd_kcontrol *kcontrol,
 	unsigned int mask = (1 << fls(max)) - 1;
 	unsigned int invert = mc->invert;
 
-	BUG_ON(tpa6130a2_client == NULL);
+	if (WARN_ON(!tpa6130a2_client))
+		return -EINVAL;
 	data = i2c_get_clientdata(tpa6130a2_client);
 
 	mutex_lock(&data->mutex);
@@ -224,7 +230,8 @@ static int tpa6130a2_put_volsw(struct snd_kcontrol *kcontrol,
 	unsigned int val = (ucontrol->value.integer.value[0] & mask);
 	unsigned int val_reg;
 
-	BUG_ON(tpa6130a2_client == NULL);
+	if (WARN_ON(!tpa6130a2_client))
+		return -EINVAL;
 	data = i2c_get_clientdata(tpa6130a2_client);
 
 	if (invert)
-- 
1.8.4.2
