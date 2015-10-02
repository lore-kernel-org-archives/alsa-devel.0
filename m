From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: ABI - Add name element to
	snd_soc_tplg_stream" to the asoc tree
Date: Fri, 02 Oct 2015 18:13:50 +0100
Message-ID: <E1Zi3u2-00085V-Ts@finisterre>
References: <08b095d38f59c43690daaa45e1d201f367812228.1443602494.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9002C26694F
 for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2015 19:13:56 +0200 (CEST)
In-Reply-To: <08b095d38f59c43690daaa45e1d201f367812228.1443602494.git.mengdong.lin@intel.com>
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

   ASoC: topology: ABI - Add name element to snd_soc_tplg_stream

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

>From 731324f5cee3caf230427f754701212961fe0bb1 Mon Sep 17 00:00:00 2001
From: Vedang Patel <vedang.patel@intel.com>
Date: Wed, 30 Sep 2015 17:31:34 +0800
Subject: [PATCH] ASoC: topology: ABI - Add name element to snd_soc_tplg_stream

For codec-codec links, this struct will be mapped to the DAI links's
params, which is struct snd_soc_pcm_stream and it needs a stream name.

Signed-off-by: Vedang Patel <vedang.patel@intel.com>
Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/uapi/sound/asoc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 88210a8..2181480 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -217,6 +217,7 @@ struct snd_soc_tplg_stream_caps {
  */
 struct snd_soc_tplg_stream {
 	__le32 size;		/* in bytes of this structure */
+	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN]; /* Name of the stream */
 	__le64 format;		/* SNDRV_PCM_FMTBIT_* */
 	__le32 rate;		/* SNDRV_PCM_RATE_* */
 	__le32 period_bytes;	/* size of period in bytes */
-- 
2.5.0
