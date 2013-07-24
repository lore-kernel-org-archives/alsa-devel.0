From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/5] ASoC: dapm: Fix return value of
	snd_soc_dapm_put_{volsw, enum_virt}()
Date: Wed, 24 Jul 2013 15:27:35 +0200
Message-ID: <1374672459-5202-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-127.synserver.de (smtp-out-127.synserver.de
 [212.40.185.127])
 by alsa0.perex.cz (Postfix) with ESMTP id 92704265354
 for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2013 15:26:55 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: =?UTF-8?q?Andreas=20Irest=C3=A5l?= <Andreas.Irestal@axis.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@nvidia.com>, Hebbar Gururaja <gururaja.hebbar@ti.com>
List-Id: alsa-devel@alsa-project.org

The ALSA core expect the put callback of a control to return 1 if the value of
the control changed and 0 if it did not. Both snd_soc_dapm_put_volsw() and
snd_soc_dapm_put_enum_virt() currently always returns 0. For both functions we
already have a 'change' variable which either contains 1 or 0 depending on
whether the value has changed or not, so just return that.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index deb1b3d..4097a55 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2703,7 +2703,7 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 	}
 
 	mutex_unlock(&card->dapm_mutex);
-	return 0;
+	return change;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_put_volsw);
 
@@ -2831,7 +2831,6 @@ int snd_soc_dapm_put_enum_virt(struct snd_kcontrol *kcontrol,
 	struct soc_enum *e =
 		(struct soc_enum *)kcontrol->private_value;
 	int change;
-	int ret = 0;
 	int wi;
 
 	if (ucontrol->value.enumerated.item[0] >= e->max)
@@ -2851,7 +2850,7 @@ int snd_soc_dapm_put_enum_virt(struct snd_kcontrol *kcontrol,
 	}
 
 	mutex_unlock(&card->dapm_mutex);
-	return ret;
+	return change;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_put_enum_virt);
 
-- 
1.8.0
