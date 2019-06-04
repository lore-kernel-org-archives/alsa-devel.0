From: Tzung-Bi Shih <tzungbi@google.com>
Subject: [PATCH v2] ASoC: core: move DAI pre-links initiation
	to snd_soc_instantiate_card
Date: Tue,  4 Jun 2019 11:31:02 +0800
Message-ID: <20190604033102.206782-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com
 [IPv6:2607:f8b0:4864:20::84a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D7E11F89673
 for <alsa-devel@alsa-project.org>; Tue,  4 Jun 2019 05:31:10 +0200 (CEST)
Received: by mail-qt1-x84a.google.com with SMTP id q13so5781845qtj.15
 for <alsa-devel@alsa-project.org>; Mon, 03 Jun 2019 20:31:10 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: tzungbi@google.com, alsa-devel@alsa-project.org, dgreid@google.com, cychiang@google.com
List-Id: alsa-devel@alsa-project.org

Kernel crashes when an ASoC component rebinding.

The dai_link->platforms has been reset to NULL by soc_cleanup_platform()
in soc_cleanup_card_resources() when un-registering component.  However,
it has no chance to re-allocate the dai_link->platforms when registering
the component again.

Move the DAI pre-links initiation from snd_soc_register_card() to
snd_soc_instantiate_card() to make sure all DAI pre-links get initiated
when component rebinding.

As an example, by using the following commands:
- echo -n max98357a > /sys/bus/platform/drivers/max98357a/unbind
- echo -n max98357a > /sys/bus/platform/drivers/max98357a/bind

Got the error message:
"Unable to handle kernel NULL pointer dereference at virtual address".

The call trace:
snd_soc_is_matching_component+0x30/0x6c
soc_bind_dai_link+0x16c/0x240
snd_soc_bind_card+0x1e4/0xb10
snd_soc_add_component+0x270/0x300
snd_soc_register_component+0x54/0x6c

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
Changes from v1 (https://patchwork.kernel.org/patch/10968311/):
- reserve original logic as much as possible
    - only acquire client_mutex
    - do not call soc_cleanup_card_resources() if soc_init_dai_link()
      returns fail, in the case some context (e.g. card->dapm) may have
      not initialized yet

Difference from original logic:
- soc_init_dai_link() would be called several times (e.g. -EPROBE_DEFER)

 sound/soc/soc-core.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 7abb017a83f3..9191d2bec489 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2070,6 +2070,16 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	int ret, i, order;
 
 	mutex_lock(&client_mutex);
+	for_each_card_prelinks(card, i, dai_link) {
+		ret = soc_init_dai_link(card, dai_link);
+		if (ret) {
+			soc_cleanup_platform(card);
+			dev_err(card->dev, "ASoC: failed to init link %s: %d\n",
+				dai_link->name, ret);
+			mutex_unlock(&client_mutex);
+			return ret;
+		}
+	}
 	mutex_lock_nested(&card->mutex, SND_SOC_CARD_CLASS_INIT);
 
 	card->dapm.bias_level = SND_SOC_BIAS_OFF;
@@ -2794,26 +2804,9 @@ static int snd_soc_bind_card(struct snd_soc_card *card)
  */
 int snd_soc_register_card(struct snd_soc_card *card)
 {
-	int i, ret;
-	struct snd_soc_dai_link *link;
-
 	if (!card->name || !card->dev)
 		return -EINVAL;
 
-	mutex_lock(&client_mutex);
-	for_each_card_prelinks(card, i, link) {
-
-		ret = soc_init_dai_link(card, link);
-		if (ret) {
-			soc_cleanup_platform(card);
-			dev_err(card->dev, "ASoC: failed to init link %s\n",
-				link->name);
-			mutex_unlock(&client_mutex);
-			return ret;
-		}
-	}
-	mutex_unlock(&client_mutex);
-
 	dev_set_drvdata(card->dev, card);
 
 	snd_soc_initialize_card_lists(card);
-- 
2.22.0.rc1.311.g5d7573a151-goog
