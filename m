From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: ABI - Add configuration for
	BE & Codec-Codec DAI Links" to the asoc tree
Date: Fri, 02 Oct 2015 18:13:48 +0100
Message-ID: <E1Zi3u0-00083h-0q@finisterre>
References: <5a1fe81777b8416e5acc3a854aa88d8c09ab6ce3.1443602494.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B8FAF260831
 for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2015 19:13:53 +0200 (CEST)
In-Reply-To: <5a1fe81777b8416e5acc3a854aa88d8c09ab6ce3.1443602494.git.mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vedang Patel <vedang.patel@intel.com>, Mengdong Lin <mengdong.lin@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: ABI - Add configuration for BE & Codec-Codec DAI Links

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From e2a9df656f28e42538562d090e2b6f3dec5b41f2 Mon Sep 17 00:00:00 2001
From: Vedang Patel <vedang.patel@intel.com>
Date: Wed, 30 Sep 2015 17:32:22 +0800
Subject: [PATCH] ASoC: topology: ABI - Add configuration for BE & Codec-Codec
 DAI Links

struct snd_soc_tplg_link_config is defined to configure BE & CC links.

Signed-off-by: Vedang Patel <vedang.patel@intel.com>
Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/uapi/sound/asoc.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index f75fd29..538ea13 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -395,4 +395,21 @@ struct snd_soc_tplg_pcm {
 	struct snd_soc_tplg_stream_caps caps[2]; /* playback and capture for DAI */
 } __attribute__((packed));
 
+
+/*
+ * Describes the BE or CC link runtime supported configs or params
+ *
+ * File block representation for BE/CC link config :-
+ * +-----------------------------------+-----+
+ * | struct snd_soc_tplg_hdr           |  1  |
+ * +-----------------------------------+-----+
+ * | struct snd_soc_tplg_link_config   |  N  |
+ * +-----------------------------------+-----+
+ */
+struct snd_soc_tplg_link_config {
+	__le32 size;            /* in bytes of this structure */
+	__le32 id;              /* unique ID - used to match */
+	struct snd_soc_tplg_stream stream[SND_SOC_TPLG_STREAM_CONFIG_MAX]; /* supported configs playback and captrure */
+	__le32 num_streams;     /* number of streams */
+} __attribute__((packed));
 #endif
-- 
2.5.0
