From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] ASoC: sirf-audio-codec: Add missing
	Makefile entry
Date: Fri, 14 Mar 2014 09:26:12 +0100
Message-ID: <1394785572-28315-2-git-send-email-lars@metafoo.de>
References: <1394785572-28315-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-088.synserver.de (smtp-out-118.synserver.de
 [212.40.185.118])
 by alsa0.perex.cz (Postfix) with ESMTP id 0861E265086
 for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2014 09:25:34 +0100 (CET)
In-Reply-To: <1394785572-28315-1-git-send-email-lars@metafoo.de>
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
Cc: Rongjun Ying <rongjun.ying@csr.com>, Barry Song <baohua@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Without this the driver can't be built.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 73df822..94ef89e 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -210,6 +210,7 @@ obj-$(CONFIG_SND_SOC_RT5640)	+= snd-soc-rt5640.o
 obj-$(CONFIG_SND_SOC_SGTL5000)  += snd-soc-sgtl5000.o
 obj-$(CONFIG_SND_SOC_SIGMADSP)	+= snd-soc-sigmadsp.o
 obj-$(CONFIG_SND_SOC_SI476X)	+= snd-soc-si476x.o
+obj-$(CONFIG_SND_SOC_SIRF_AUDIO_CODEC) += snd-soc-sirf-audio-codec.o
 obj-$(CONFIG_SND_SOC_SN95031)	+=snd-soc-sn95031.o
 obj-$(CONFIG_SND_SOC_SPDIF)	+= snd-soc-spdif-rx.o snd-soc-spdif-tx.o
 obj-$(CONFIG_SND_SOC_SSM2518)	+= snd-soc-ssm2518.o
-- 
1.8.0
