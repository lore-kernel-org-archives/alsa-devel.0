From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: ABI - Rename dai_elems to
	pcm_elems in manifest" to the asoc tree
Date: Sat, 31 Oct 2015 11:49:36 +0900
Message-ID: <E1ZsMEa-0003RB-Bt@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 42D52260462
 for <alsa-devel@alsa-project.org>; Sat, 31 Oct 2015 03:49:43 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lin Mengdong <mengdong.lin@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: ABI - Rename dai_elems to pcm_elems in manifest

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

>From bbb64300469d207f62c08ea7358c839991a52877 Mon Sep 17 00:00:00 2001
From: Mengdong Lin <mengdong.lin@intel.com>
Date: Fri, 30 Oct 2015 15:13:16 +0800
Subject: [PATCH] ASoC: topology: ABI - Rename dai_elems to pcm_elems in
 manifest

This field is the number of PCM objects (a pair of FE DAI and DAI link).

Signed-off-by: Lin Mengdong <mengdong.lin@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/uapi/sound/asoc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 26539a7..c4cc1e4 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -243,7 +243,7 @@ struct snd_soc_tplg_manifest {
 	__le32 control_elems;	/* number of control elements */
 	__le32 widget_elems;	/* number of widget elements */
 	__le32 graph_elems;	/* number of graph elements */
-	__le32 dai_elems;	/* number of DAI elements */
+	__le32 pcm_elems;	/* number of PCM elements */
 	__le32 dai_link_elems;	/* number of DAI link elements */
 	struct snd_soc_tplg_private priv;
 } __attribute__((packed));
-- 
2.6.1
