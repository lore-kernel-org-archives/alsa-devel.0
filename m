From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Mimic legacy behaviour of
	reading controls when DSP is on" to the asoc tree
Date: Fri, 18 Dec 2015 12:15:45 +0000
Message-ID: <E1a9twn-0006Ez-V6@debutante>
References: <1450346759-7011-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 569902666BB
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 13:15:52 +0100 (CET)
In-Reply-To: <1450346759-7011-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Mimic legacy behaviour of reading controls when DSP is on

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

>From bc1765d6e81a70be36a7290bcc829a7714101bbb Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Thu, 17 Dec 2015 10:05:59 +0000
Subject: [PATCH] ASoC: wm_adsp: Mimic legacy behaviour of reading controls
 when DSP is on

Older firmwares don't specify access flags for the controls,
unfortunately the usage of some of these firmware relies on being able
to read back values from the DSP. The current control code will only do
this for volatile controls. This patch will read the control from the
hardware if no flags are specified and the control is currently
enabled, which should cover these legacy use-cases.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index b083642718f0..d1e0826c7db2 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -666,6 +666,9 @@ static int wm_coeff_get(struct snd_kcontrol *kctl,
 		else
 			ret = -EPERM;
 	} else {
+		if (!ctl->flags && ctl->enabled)
+			ret = wm_coeff_read_control(ctl, ctl->cache, ctl->len);
+
 		memcpy(p, ctl->cache, ctl->len);
 	}
 
-- 
2.6.2
