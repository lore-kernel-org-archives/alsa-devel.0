From: Philipp Puschmann <philipp.puschmann@emlix.com>
Subject: [PATCH] ASoC: tlv320aix3x: fix reset gpio reference counting
Date: Wed, 27 Feb 2019 15:10:19 +0100
Message-ID: <20190227141019.16027-1-philipp.puschmann@emlix.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, peter.ujfalusi@ti.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Philipp Puschmann <philipp.puschmann@emlix.com>
List-Id: alsa-devel@alsa-project.org

This patch fixes a bug that prevents freeing the reset gpio on unloading
the module.

aic3x_i2c_probe is called when loading the module and it calls list_add
with a probably uninitialized list entry aic3x->list (next = prev = NULL)).
So even if list_del is called it does nothing and in the end the gpio_reset
is not freed. Then a repeated module probing fails silently because
gpio_request fails.

When moving INIT_LIST_HEAD to aic3x_i2c_probe we also have to move
list_del to aic3x_i2c_remove because aic3x_remove may be called
multiple times without aic3x_i2c_remove being called which leads to
a NULL pointer dereference.

Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
---
 sound/soc/codecs/tlv320aic3x.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 6aa0edf8c5ef..cea3ebecdb12 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1609,7 +1609,6 @@ static int aic3x_probe(struct snd_soc_component *component)
 	struct aic3x_priv *aic3x = snd_soc_component_get_drvdata(component);
 	int ret, i;
 
-	INIT_LIST_HEAD(&aic3x->list);
 	aic3x->component = component;
 
 	for (i = 0; i < ARRAY_SIZE(aic3x->supplies); i++) {
@@ -1692,7 +1691,6 @@ static void aic3x_remove(struct snd_soc_component *component)
 	struct aic3x_priv *aic3x = snd_soc_component_get_drvdata(component);
 	int i;
 
-	list_del(&aic3x->list);
 	for (i = 0; i < ARRAY_SIZE(aic3x->supplies); i++)
 		regulator_unregister_notifier(aic3x->supplies[i].consumer,
 					      &aic3x->disable_nb[i].nb);
@@ -1890,6 +1888,7 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 	if (ret != 0)
 		goto err_gpio;
 
+	INIT_LIST_HEAD(&aic3x->list);
 	list_add(&aic3x->list, &reset_list);
 
 	return 0;
@@ -1906,6 +1905,8 @@ static int aic3x_i2c_remove(struct i2c_client *client)
 {
 	struct aic3x_priv *aic3x = i2c_get_clientdata(client);
 
+	list_del(&aic3x->list);
+
 	if (gpio_is_valid(aic3x->gpio_reset) &&
 	    !aic3x_is_shared_reset(aic3x)) {
 		gpio_set_value(aic3x->gpio_reset, 0);
-- 
2.20.1
