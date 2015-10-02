From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: ABI - Remove tdm_slot &
	dai_fmt from snd_soc_tplg_stream" to the asoc tree
Date: Fri, 02 Oct 2015 18:13:47 +0100
Message-ID: <E1Zi3tz-000836-1K@finisterre>
References: <30ca5b75b0eb2dc29ab9cbbb8c83d180799a91cd.1443602494.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0AD6F260789
 for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2015 19:13:53 +0200 (CEST)
In-Reply-To: <30ca5b75b0eb2dc29ab9cbbb8c83d180799a91cd.1443602494.git.mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: ABI - Remove tdm_slot & dai_fmt from snd_soc_tplg_stream

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

>From 76a822a6ae9c0c67309318bb60a4117329252fc4 Mon Sep 17 00:00:00 2001
From: Mengdong Lin <mengdong.lin@intel.com>
Date: Wed, 30 Sep 2015 17:32:40 +0800
Subject: [PATCH] ASoC: topology: ABI - Remove tdm_slot & dai_fmt from
 snd_soc_tplg_stream

These two fields are line parameters for BE/CC links and
should not be from toplogy but from ACPI.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/uapi/sound/asoc.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 538ea13..26539a7 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -224,8 +224,6 @@ struct snd_soc_tplg_stream {
 	__le32 period_bytes;	/* size of period in bytes */
 	__le32 buffer_bytes;	/* size of buffer in bytes */
 	__le32 channels;	/* channels */
-	__le32 tdm_slot;	/* optional BE bitmask of supported TDM slots */
-	__le32 dai_fmt;		/* SND_SOC_DAIFMT_  */
 } __attribute__((packed));
 
 /*
-- 
2.5.0
