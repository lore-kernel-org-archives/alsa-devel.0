From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: topology: add support for
	mux/demux component" to the asoc tree
Date: Mon,  3 Jun 2019 19:01:54 +0100 (BST)
Message-ID: <20190603180154.AB3B1440046@finisterre.sirena.org.uk>
References: <20190603161821.7486-10-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D43D2F8972F
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2019 20:02:00 +0200 (CEST)
In-Reply-To: <20190603161821.7486-10-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jaska Uimonen <jaska.uimonen@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: topology: add support for mux/demux component

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

>From 663580695611b9c3837cdf596de2194234f0fbd5 Mon Sep 17 00:00:00 2001
From: Jaska Uimonen <jaska.uimonen@intel.com>
Date: Mon, 3 Jun 2019 11:18:21 -0500
Subject: [PATCH] ASoC: SOF: topology: add support for mux/demux component

Add enumerations to support mux/demux processing component.

Signed-off-by: Jaska Uimonen <jaska.uimonen@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/sof/topology.h | 3 +++
 sound/soc/sof/topology.c     | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/include/sound/sof/topology.h b/include/sound/sof/topology.h
index 46b2a7e63167..4978999fd362 100644
--- a/include/sound/sof/topology.h
+++ b/include/sound/sof/topology.h
@@ -35,6 +35,7 @@ enum sof_comp_type {
 	SOF_COMP_KEYWORD_DETECT,
 	SOF_COMP_KPB,			/* A key phrase buffer component */
 	SOF_COMP_SELECTOR,		/**< channel selector component */
+	SOF_COMP_DEMUX,
 	/* keep FILEREAD/FILEWRITE as the last ones */
 	SOF_COMP_FILEREAD = 10000,	/**< host test based file IO */
 	SOF_COMP_FILEWRITE = 10001,	/**< host test based file IO */
@@ -175,6 +176,8 @@ enum sof_ipc_process_type {
 	SOF_PROCESS_KEYWORD_DETECT,	/**< Keyword Detection */
 	SOF_PROCESS_KPB,		/**< KeyPhrase Buffer Manager */
 	SOF_PROCESS_CHAN_SELECTOR,	/**< Channel Selector */
+	SOF_PROCESS_MUX,
+	SOF_PROCESS_DEMUX,
 };
 
 /* generic "effect", "codec" or proprietary processing component */
diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 745cb875863c..b969686f954f 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -394,6 +394,8 @@ static const struct sof_process_types sof_process[] = {
 	{"KEYWORD_DETECT", SOF_PROCESS_KEYWORD_DETECT, SOF_COMP_KEYWORD_DETECT},
 	{"KPB", SOF_PROCESS_KPB, SOF_COMP_KPB},
 	{"CHAN_SELECTOR", SOF_PROCESS_CHAN_SELECTOR, SOF_COMP_SELECTOR},
+	{"MUX", SOF_PROCESS_MUX, SOF_COMP_MUX},
+	{"DEMUX", SOF_PROCESS_DEMUX, SOF_COMP_DEMUX},
 };
 
 static enum sof_ipc_process_type find_process(const char *name)
-- 
2.20.1
