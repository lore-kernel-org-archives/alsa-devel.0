From: Mark Brown <broonie@kernel.org>
Subject: Applied "ALSA: compress: Add SND_AUDIOCODEC_BESPOKE"
	to the asoc tree
Date: Wed, 23 Dec 2015 00:23:21 +0000
Message-ID: <E1aBXD7-0000XJ-S9@debutante>
References: <1446828354-28767-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 920252660BB
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 01:23:28 +0100 (CET)
In-Reply-To: <1446828354-28767-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ALSA: compress: Add SND_AUDIOCODEC_BESPOKE

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

>From dbb6b94339e82ad2532798ed80f2651d21d97975 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Tue, 15 Dec 2015 11:29:44 +0000
Subject: [PATCH] ALSA: compress: Add SND_AUDIOCODEC_BESPOKE

When working with the compressed framework occasionally vendors will
use esoteric internal audio formats. For such formats it doesn't really
make sense to add an new define to the kernel as their use is not
sufficiently general.

This patch adds a new define SND_AUDIOCODEC_BESPOKE that vendors can use
in such situations.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/uapi/sound/compress_params.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/uapi/sound/compress_params.h b/include/uapi/sound/compress_params.h
index d9bd9ca0d5b0..9625484a4a2a 100644
--- a/include/uapi/sound/compress_params.h
+++ b/include/uapi/sound/compress_params.h
@@ -73,7 +73,8 @@
 #define SND_AUDIOCODEC_IEC61937              ((__u32) 0x0000000B)
 #define SND_AUDIOCODEC_G723_1                ((__u32) 0x0000000C)
 #define SND_AUDIOCODEC_G729                  ((__u32) 0x0000000D)
-#define SND_AUDIOCODEC_MAX                   SND_AUDIOCODEC_G729
+#define SND_AUDIOCODEC_BESPOKE               ((__u32) 0x0000000E)
+#define SND_AUDIOCODEC_MAX                   SND_AUDIOCODEC_BESPOKE
 
 /*
  * Profile and modes are listed with bit masks. This allows for a
@@ -312,7 +313,7 @@ struct snd_enc_flac {
 
 struct snd_enc_generic {
 	__u32 bw;	/* encoder bandwidth */
-	__s32 reserved[15];
+	__s32 reserved[15];	/* Can be used for SND_AUDIOCODEC_BESPOKE */
 } __attribute__((packed, aligned(4)));
 
 union snd_codec_options {
-- 
2.6.2
