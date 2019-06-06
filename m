From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc.h: add sound dai_link connection
	macro" to the asoc tree
Date: Thu,  6 Jun 2019 22:27:17 +0100 (BST)
Message-ID: <20190606212717.50979440046@finisterre.sirena.org.uk>
References: <87d0jrmku4.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2B7D7F89811
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:27:18 +0200 (CEST)
In-Reply-To: <87d0jrmku4.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc.h: add sound dai_link connection macro

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 587c984427bf7d031a2a4b693dfb24a51cd660b2 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:07:42 +0900
Subject: [PATCH] ASoC: soc.h: add sound dai_link connection macro

Modern style dai_link requests CPU/Codec/Platform component
pointer array and its size, but it will be very verbose code.
To avoid such scene, this patch adds dai_link connection macro.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  | 88 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/soc-core.c |  7 ++++
 2 files changed, 95 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index ae7ca828e167..0fa79b8330d7 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1048,6 +1048,94 @@ struct snd_soc_dai_link {
 	     ((i) < link->num_codecs) && ((codec) = &link->codecs[i]);	\
 	     (i)++)
 
+/*
+ * Sample 1 : Single CPU/Codec/Platform
+ *
+ * SND_SOC_DAILINK_DEFS(test,
+ *	DAILINK_COMP_ARRAY(COMP_CPU("cpu_dai")),
+ *	DAILINK_COMP_ARRAY(COMP_CODEC("codec", "codec_dai")),
+ *	DAILINK_COMP_ARRAY(COMP_PLATFORM("platform")));
+ *
+ * struct snd_soc_dai_link link = {
+ *	...
+ *	SND_SOC_DAILINK_REG(test),
+ * };
+ *
+ * Sample 2 : Multi CPU/Codec, no Platform
+ *
+ * SND_SOC_DAILINK_DEFS(test,
+ *	DAILINK_COMP_ARRAY(COMP_CPU("cpu_dai1"),
+ *			   COMP_CPU("cpu_dai2")),
+ *	DAILINK_COMP_ARRAY(COMP_CODEC("codec1", "codec_dai1"),
+ *			   COMP_CODEC("codec2", "codec_dai2")));
+ *
+ * struct snd_soc_dai_link link = {
+ *	...
+ *	SND_SOC_DAILINK_REG(test),
+ * };
+ *
+ * Sample 3 : Define each CPU/Codec/Platform manually
+ *
+ * SND_SOC_DAILINK_DEF(test_cpu,
+ *		DAILINK_COMP_ARRAY(COMP_CPU("cpu_dai1"),
+ *				   COMP_CPU("cpu_dai2")));
+ * SND_SOC_DAILINK_DEF(test_codec,
+ *		DAILINK_COMP_ARRAY(COMP_CODEC("codec1", "codec_dai1"),
+ *				   COMP_CODEC("codec2", "codec_dai2")));
+ * SND_SOC_DAILINK_DEF(test_platform,
+ *		DAILINK_COMP_ARRAY(COMP_PLATFORM("platform")));
+ *
+ * struct snd_soc_dai_link link = {
+ *	...
+ *	SND_SOC_DAILINK_REG(test_cpu,
+ *			    test_codec,
+ *			    test_platform),
+ * };
+ *
+ * Sample 4 : Sample3 without platform
+ *
+ * struct snd_soc_dai_link link = {
+ *	...
+ *	SND_SOC_DAILINK_REG(test_cpu,
+ *			    test_codec);
+ * };
+ */
+
+#define SND_SOC_DAILINK_REG1(name)	 SND_SOC_DAILINK_REG3(name##_cpus, name##_codecs, name##_platforms)
+#define SND_SOC_DAILINK_REG2(cpu, codec) SND_SOC_DAILINK_REG3(cpu, codec, null_dailink_component)
+#define SND_SOC_DAILINK_REG3(cpu, codec, platform)	\
+	.cpus		= cpu,				\
+	.num_cpus	= ARRAY_SIZE(cpu),		\
+	.codecs		= codec,			\
+	.num_codecs	= ARRAY_SIZE(codec),		\
+	.platforms	= platform,			\
+	.num_platforms	= ARRAY_SIZE(platform)
+
+#define SND_SOC_DAILINK_REGx(_1, _2, _3, func, ...) func
+#define SND_SOC_DAILINK_REG(...) \
+	SND_SOC_DAILINK_REGx(__VA_ARGS__,		\
+			SND_SOC_DAILINK_REG3,	\
+			SND_SOC_DAILINK_REG2,	\
+			SND_SOC_DAILINK_REG1)(__VA_ARGS__)
+
+#define SND_SOC_DAILINK_DEF(name, def...)		\
+	static struct snd_soc_dai_link_component name[]	= { def }
+
+#define SND_SOC_DAILINK_DEFS(name, cpu, codec, platform...)	\
+	SND_SOC_DAILINK_DEF(name##_cpus, cpu);			\
+	SND_SOC_DAILINK_DEF(name##_codecs, codec);		\
+	SND_SOC_DAILINK_DEF(name##_platforms, platform)
+
+#define DAILINK_COMP_ARRAY(param...)	param
+#define COMP_EMPTY()			{ }
+#define COMP_CPU(_dai)			{ .dai_name = _dai, }
+#define COMP_CODEC(_name, _dai)		{ .name = _name, .dai_name = _dai, }
+#define COMP_PLATFORM(_name)		{ .name = _name }
+#define COMP_DUMMY()			{ .name = "snd-soc-dummy", .dai_name = "snd-soc-dummy-dai", }
+
+extern struct snd_soc_dai_link_component null_dailink_component[0];
+
+
 struct snd_soc_codec_conf {
 	/*
 	 * specify device either by device name, or by
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index f86ee4f48f06..9bd6b08d79b5 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -57,6 +57,13 @@ static LIST_HEAD(unbind_card_list);
 #define for_each_component(component)			\
 	list_for_each_entry(component, &component_list, list)
 
+/*
+ * This is used if driver don't need to have CPU/Codec/Platform
+ * dai_link. see soc.h
+ */
+struct snd_soc_dai_link_component null_dailink_component[0];
+EXPORT_SYMBOL_GPL(null_dailink_component);
+
 /*
  * This is a timeout to do a DAPM powerdown after a stream is closed().
  * It can be used to eliminate pops between different playback streams, e.g.
-- 
2.20.1
