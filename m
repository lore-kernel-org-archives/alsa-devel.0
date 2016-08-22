From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: ABI - Add sig_bits to stream
	caps" to the asoc tree
Date: Mon, 22 Aug 2016 18:59:08 +0100
Message-ID: <E1bbtV6-0000pQ-EX@debutante>
References: <d9147786c40ccf5eeb461c06ae008c4f22c68e7a.1471599648.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 19FBD26585A
 for <alsa-devel@alsa-project.org>; Mon, 22 Aug 2016 19:59:19 +0200 (CEST)
In-Reply-To: <d9147786c40ccf5eeb461c06ae008c4f22c68e7a.1471599648.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, mengdong.lin@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, hardik.t.shah@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: ABI - Add sig_bits to stream caps

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

>From f918e1697b1a8f2f26a4813db053cfbcafc48046 Mon Sep 17 00:00:00 2001
From: Mengdong Lin <mengdong.lin@linux.intel.com>
Date: Fri, 19 Aug 2016 18:12:46 +0800
Subject: [PATCH] ASoC: topology: ABI - Add sig_bits to stream caps

Kernel struct snd_soc_pcm_stream, SoC PCM stream information, needs this
field. Although current topology users don't configure this, we define it
for future extension.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/uapi/sound/asoc.h | 1 +
 sound/soc/soc-topology.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index f734bea9a032..33d00a4ce656 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -257,6 +257,7 @@ struct snd_soc_tplg_stream_caps {
 	__le32 period_size_max;	/* max period size bytes */
 	__le32 buffer_size_min;	/* min buffer size bytes */
 	__le32 buffer_size_max;	/* max buffer size bytes */
+	__le32 sig_bits;        /* number of bits of content */
 } __attribute__((packed));
 
 /*
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index a9e83a2dd91c..6b05047a4134 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1556,6 +1556,7 @@ static void set_stream_info(struct snd_soc_pcm_stream *stream,
 	stream->rate_min = caps->rate_min;
 	stream->rate_max = caps->rate_max;
 	stream->formats = caps->formats;
+	stream->sig_bits = caps->sig_bits;
 }
 
 static void set_dai_flags(struct snd_soc_dai_driver *dai_drv,
-- 
2.8.1
