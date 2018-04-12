From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: trace: remove snd_soc_codec" to the asoc tree
Date: Thu, 12 Apr 2018 17:17:09 +0100
Message-ID: <E1f6euL-0008KO-Vb@debutante>
References: <87vadh3pz1.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87vadh3pz1.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, Linux-ALSA <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: trace: remove snd_soc_codec

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 03a364502bebb5f464853c6ec5d49e85195600ca Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 28 Mar 2018 02:18:13 +0000
Subject: [PATCH] ASoC: trace: remove snd_soc_codec

snd_soc_codec is replaced to snd_soc_component,
and it is not used in this file.
Let's remove it

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/trace/events/asoc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/trace/events/asoc.h b/include/trace/events/asoc.h
index ccd1a3bdff46..40c300fe704d 100644
--- a/include/trace/events/asoc.h
+++ b/include/trace/events/asoc.h
@@ -12,7 +12,6 @@
 #define DAPM_ARROW(dir) (((dir) == SND_SOC_DAPM_DIR_OUT) ? "->" : "<-")
 
 struct snd_soc_jack;
-struct snd_soc_codec;
 struct snd_soc_card;
 struct snd_soc_dapm_widget;
 struct snd_soc_dapm_path;
-- 
2.17.0
