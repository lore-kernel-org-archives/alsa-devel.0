From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: ABI - Change stream formats
	to a bitwise flag" to the asoc tree
Date: Fri, 02 Oct 2015 18:13:49 +0100
Message-ID: <E1Zi3u1-00084u-UR@finisterre>
References: <eea48b17c22cc093bc808a141593a46f993065ae.1443602494.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D0A3C2612BD
 for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2015 19:13:55 +0200 (CEST)
In-Reply-To: <eea48b17c22cc093bc808a141593a46f993065ae.1443602494.git.mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: ABI - Change stream formats to a bitwise flag

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

>From 478d0d39719127c42f21ac85b8719a87b8fa7bd7 Mon Sep 17 00:00:00 2001
From: Mengdong Lin <mengdong.lin@intel.com>
Date: Wed, 30 Sep 2015 17:31:44 +0800
Subject: [PATCH] ASoC: topology: ABI - Change stream formats to a bitwise flag

The toplogy user space tool will generate this bitwise flag by using
SNDRV_PCM_FORMAT_* exposed by asound.h, and the topology core will copy
this flag when generating DAI streams.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/uapi/sound/asoc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 2181480..eeb74a9c 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -198,7 +198,7 @@ struct snd_soc_tplg_ctl_hdr {
 struct snd_soc_tplg_stream_caps {
 	__le32 size;		/* in bytes of this structure */
 	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
-	__le64 formats[SND_SOC_TPLG_MAX_FORMATS];	/* supported formats SNDRV_PCM_FMTBIT_* */
+	__le64 formats;	/* supported formats SNDRV_PCM_FMTBIT_* */
 	__le32 rates;		/* supported rates SNDRV_PCM_RATE_* */
 	__le32 rate_min;	/* min rate */
 	__le32 rate_max;	/* max rate */
-- 
2.5.0
