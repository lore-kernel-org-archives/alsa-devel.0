From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdmi-codec: make const array
	hdmi_codec_eld_spk_alloc_bits static" to the asoc tree
Date: Tue, 11 Jul 2017 15:43:17 +0100
Message-ID: <E1dUwNh-0005LF-Q0@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 235A6266A0C
 for <alsa-devel@alsa-project.org>; Tue, 11 Jul 2017 16:43:26 +0200 (CEST)
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
To: Colin Ian King <colin.king@canonical.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdmi-codec: make const array hdmi_codec_eld_spk_alloc_bits static

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

>From fc2b74460d96ec28110a581d6e58d15c27304d16 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Tue, 11 Jul 2017 15:08:55 +0100
Subject: [PATCH] ASoC: hdmi-codec: make const array
 hdmi_codec_eld_spk_alloc_bits static

Don't populate array hdmi_codec_eld_spk_alloc_bits on the stack but
make it static. Makes the object code smaller by over 260 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
  10882	   3384	     64	  14330	   37fa	sound/soc/codecs/hdmi-codec.o

After:
   text	   data	    bss	    dec	    hex	filename
  10557	   3440	     64	  14061	   36ed	sound/soc/codecs/hdmi-codec.o

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdmi-codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 7686a80861f1..509ab513b4b2 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -326,7 +326,7 @@ static int hdmi_eld_ctl_get(struct snd_kcontrol *kcontrol,
 static unsigned long hdmi_codec_spk_mask_from_alloc(int spk_alloc)
 {
 	int i;
-	const unsigned long hdmi_codec_eld_spk_alloc_bits[] = {
+	static const unsigned long hdmi_codec_eld_spk_alloc_bits[] = {
 		[0] = FL | FR, [1] = LFE, [2] = FC, [3] = RL | RR,
 		[4] = RC, [5] = FLC | FRC, [6] = RLC | RRC,
 	};
-- 
2.13.2
