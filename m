From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: add defines for single-input
	gain control" to the asoc tree
Date: Fri, 02 Oct 2015 18:13:55 +0100
Message-ID: <E1Zi3u7-00088O-Vc@finisterre>
References: <1429619636-25478-3-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 81D6F261294
 for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2015 19:14:03 +0200 (CEST)
In-Reply-To: <1429619636-25478-3-git-send-email-rf@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: arizona: add defines for single-input gain control

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

>From 50e6168f27fdc1f915d3341743b46147c626dc6e Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Date: Mon, 28 Sep 2015 14:01:08 +0100
Subject: [PATCH] ASoC: arizona: add defines for single-input gain control

Adds convenience defines for declaring a gain control that
has an input mux. These blocks are functionally equivalent to
the existing mixer blocks but can only have a single input
active at once.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/arizona.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 7b68d05..b73920a 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -99,6 +99,11 @@ extern const unsigned int arizona_mixer_tlv[];
 extern const char *arizona_mixer_texts[ARIZONA_NUM_MIXER_INPUTS];
 extern int arizona_mixer_values[ARIZONA_NUM_MIXER_INPUTS];
 
+#define ARIZONA_GAINMUX_CONTROLS(name, base) \
+	SOC_SINGLE_RANGE_TLV(name " Input Volume", base + 1,		\
+			     ARIZONA_MIXER_VOL_SHIFT, 0x20, 0x50, 0,	\
+			     arizona_mixer_tlv)
+
 #define ARIZONA_MIXER_CONTROLS(name, base) \
 	SOC_SINGLE_RANGE_TLV(name " Input 1 Volume", base + 1,		\
 			     ARIZONA_MIXER_VOL_SHIFT, 0x20, 0x50, 0,	\
-- 
2.5.0
