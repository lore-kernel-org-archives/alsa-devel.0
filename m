From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Set card long_name for GPD win
	/ pocket" to the asoc tree
Date: Tue, 12 Dec 2017 11:16:19 +0000
Message-ID: <E1eOiXr-0007p8-Rl@debutante>
References: <20171211212640.10060-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 104A126705F
 for <alsa-devel@alsa-project.org>; Tue, 12 Dec 2017 12:16:27 +0100 (CET)
In-Reply-To: <20171211212640.10060-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: Set card long_name for GPD win / pocket

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From aa9c387c2dc25597b730cd8386cac8ccfe75de07 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 11 Dec 2017 22:26:40 +0100
Subject: [PATCH] ASoC: rt5645: Set card long_name for GPD win / pocket

The GPD win and pocket devices both use the same codec setup and both
have too generic dmi strings making snd_soc_set_dmi_name() not work.

As these devices have only a single speaker we want a separate ucm
file for them, which requires a unique long_name, use the existing
GPD quirk handling to also provide a unique long_name.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/rt5645.h    | 3 +++
 sound/soc/codecs/rt5645.c | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/include/sound/rt5645.h b/include/sound/rt5645.h
index d0c33a9972b9..f218c742f08e 100644
--- a/include/sound/rt5645.h
+++ b/include/sound/rt5645.h
@@ -25,6 +25,9 @@ struct rt5645_platform_data {
 	bool level_trigger_irq;
 	/* Invert JD1_1 status polarity */
 	bool inv_jd1_1;
+
+	/* Value to asign to snd_soc_card.long_name */
+	const char *long_name;
 };
 
 #endif
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index fcd02c2c76f1..a1a7bb770745 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3394,6 +3394,9 @@ static int rt5645_probe(struct snd_soc_codec *codec)
 		snd_soc_dapm_sync(dapm);
 	}
 
+	if (rt5645->pdata.long_name)
+		codec->component.card->long_name = rt5645->pdata.long_name;
+
 	rt5645->eq_param = devm_kzalloc(codec->dev,
 		RT5645_HWEQ_NUM * sizeof(struct rt5645_eq_param_s), GFP_KERNEL);
 
@@ -3624,6 +3627,7 @@ static const struct dmi_system_id dmi_platform_intel_broadwell[] = {
 static const struct rt5645_platform_data gpd_win_platform_data = {
 	.jd_mode = 3,
 	.inv_jd1_1 = true,
+	.long_name = "gpd-win-pocket-rt5645",
 };
 
 static const struct dmi_system_id dmi_platform_gpd_win[] = {
-- 
2.15.1
