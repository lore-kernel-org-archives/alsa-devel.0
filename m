From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: [PATCH 2/4] ASoC: UDA1380: DATAI is slave only
Date: Tue,  3 Mar 2009 16:10:52 +0100
Message-ID: <1236093054-1952-2-git-send-email-philipp.zabel@gmail.com>
References: <1236093054-1952-1-git-send-email-philipp.zabel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f177.google.com (mail-fx0-f177.google.com
	[209.85.220.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 9934A10380E
	for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2009 16:11:00 +0100 (CET)
Received: by fxm25 with SMTP id 25so2677141fxm.32
	for <alsa-devel@alsa-project.org>; Tue, 03 Mar 2009 07:11:00 -0800 (PST)
In-Reply-To: <1236093054-1952-1-git-send-email-philipp.zabel@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

Only allow SND_SOC_DAIFMT_CBS_CFS for the playback DAI.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
---
 sound/soc/codecs/uda1380.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 5242b81..1e3769d 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -377,8 +377,9 @@ static int uda1380_set_dai_fmt_both(struct snd_soc_dai *codec_dai,
 		iface |= R01_SFORI_MSB | R01_SFORO_MSB;
 	}
 
-	if ((fmt & SND_SOC_DAIFMT_MASTER_MASK) == SND_SOC_DAIFMT_CBM_CFM)
-		iface |= R01_SIM;
+	/* DATAI is slave only, so in single-link mode, this has to be slave */
+	if ((fmt & SND_SOC_DAIFMT_MASTER_MASK) != SND_SOC_DAIFMT_CBS_CFS)
+		return -EINVAL;
 
 	uda1380_write(codec, UDA1380_IFACE, iface);
 
@@ -406,6 +407,10 @@ static int uda1380_set_dai_fmt_playback(struct snd_soc_dai *codec_dai,
 		iface |= R01_SFORI_MSB;
 	}
 
+	/* DATAI is slave only, so this has to be slave */
+	if ((fmt & SND_SOC_DAIFMT_MASTER_MASK) != SND_SOC_DAIFMT_CBS_CFS)
+		return -EINVAL;
+
 	uda1380_write(codec, UDA1380_IFACE, iface);
 
 	return 0;
-- 
1.6.1.3
