From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: ABI - Use __le32 instead of
	__u32 in snd_soc_tplg_dapm_widget" to the asoc tree
Date: Fri, 02 Oct 2015 18:13:51 +0100
Message-ID: <E1Zi3u3-00085y-Sa@finisterre>
References: <1adb358d870891f0553feb8469a36632557e68a8.1443602494.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 74CA0260668
 for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2015 19:13:57 +0200 (CEST)
In-Reply-To: <1adb358d870891f0553feb8469a36632557e68a8.1443602494.git.mengdong.lin@intel.com>
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

   ASoC: topology: ABI - Use __le32 instead of __u32 in snd_soc_tplg_dapm_widget

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

>From e8b3fe8f383bbf055cbd69b776fcbbb5ed3befcd Mon Sep 17 00:00:00 2001
From: Vedang Patel <vedang.patel@intel.com>
Date: Wed, 30 Sep 2015 17:30:05 +0800
Subject: [PATCH] ASoC: topology: ABI - Use __le32 instead of __u32 in
 snd_soc_tplg_dapm_widget

This fixes the endianness of the ABI parameters in the struct.
The field 'num_kcontrols' is also extended from 16 bits to 32 bits.

Signed-off-by: Vedang Patel <vedang.patel@intel.com>
Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/uapi/sound/asoc.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 4bef63f..88210a8 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -356,11 +356,11 @@ struct snd_soc_tplg_dapm_widget {
 	__le32 shift;		/* bits to shift */
 	__le32 mask;		/* non-shifted mask */
 	__le32 subseq;		/* sort within widget type */
-	__u32 invert;		/* invert the power bit */
-	__u32 ignore_suspend;	/* kept enabled over suspend */
-	__u16 event_flags;
-	__u16 event_type;
-	__u16 num_kcontrols;
+	__le32 invert;		/* invert the power bit */
+	__le32 ignore_suspend;	/* kept enabled over suspend */
+	__le16 event_flags;
+	__le16 event_type;
+	__le32 num_kcontrols;
 	struct snd_soc_tplg_private priv;
 	/*
 	 * kcontrols that relate to this widget
-- 
2.5.0
