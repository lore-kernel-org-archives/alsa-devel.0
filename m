From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 1/2] ASoC: rt5645: change micbias widget
	type to supply.
Date: Wed,  3 Jan 2018 13:39:01 +0100
Message-ID: <20180103123902.17287-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 255052668F0
 for <alsa-devel@alsa-project.org>; Wed,  3 Jan 2018 13:39:06 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <bardliao@realtek.com>

Register "micbias1" and "micbias2" to supply widgets as modern drivers do.

This should not cause any (new) issues for existing users of the codec,
since micbias support is broken anyways. Micbias support needs the
RT5645_MICBIAS?_POW_CTRL_SEL bits in the RT5645_GEN_CTRL2 register to be
updated when enabled/disabled which we currently do not do.

The updating of these bits will be fixed in a follow-up commit.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Update the commit message to explain why changing the type of the widget
 is ok / will not cause any (new) issues for existing users of the codec
---
 sound/soc/codecs/rt5645.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index fd5c36afdbb5..fdab5bf56c61 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -1980,10 +1980,10 @@ static const struct snd_soc_dapm_widget rt5645_dapm_widgets[] = {
 
 	/* Input Side */
 	/* micbias */
-	SND_SOC_DAPM_MICBIAS("micbias1", RT5645_PWR_ANLG2,
-			RT5645_PWR_MB1_BIT, 0),
-	SND_SOC_DAPM_MICBIAS("micbias2", RT5645_PWR_ANLG2,
-			RT5645_PWR_MB2_BIT, 0),
+	SND_SOC_DAPM_SUPPLY("micbias1", RT5645_PWR_ANLG2,
+			RT5645_PWR_MB1_BIT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("micbias2", RT5645_PWR_ANLG2,
+			RT5645_PWR_MB2_BIT, 0, NULL, 0),
 	/* Input Lines */
 	SND_SOC_DAPM_INPUT("DMIC L1"),
 	SND_SOC_DAPM_INPUT("DMIC R1"),
-- 
2.14.3
