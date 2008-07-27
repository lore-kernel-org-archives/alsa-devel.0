From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ALSA: Build jack detection
Date: Sun, 27 Jul 2008 12:12:25 +0100
Message-ID: <1217157145-7647-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20080727111107.GA6667@sirena.org.uk>
	<1217157145-7647-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217157145-7647-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 375D7103812
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jul 2008 13:12:34 +0200 (CEST)
In-Reply-To: <1217157145-7647-2-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Since jack detection requires the input subsystem which may not be
desired on small systems it is not built unless required by a driver
that is being built. Drivers using jack detection should use a pattern
like this:

config SND_FOO
        tristate "..."
        ...
        select SND_JACK if INPUT=y || INPUT=SND

to ensure that the jack detection API is enabled if the input subsystem
is.  If the input subsystem is not enabled then a stub version of the
API is provided.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/core/Kconfig  |    3 +++
 sound/core/Makefile |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/core/Kconfig b/sound/core/Kconfig
index 335d45e..acaa2ef 100644
--- a/sound/core/Kconfig
+++ b/sound/core/Kconfig
@@ -12,6 +12,9 @@ config SND_HWDEP
 config SND_RAWMIDI
 	tristate
 
+config SND_JACK
+	bool
+
 config SND_SEQUENCER
 	tristate "Sequencer support"
 	select SND_TIMER
diff --git a/sound/core/Makefile b/sound/core/Makefile
index da8e685..d57125a 100644
--- a/sound/core/Makefile
+++ b/sound/core/Makefile
@@ -7,6 +7,7 @@ snd-y     := sound.o init.o memory.o info.o control.o misc.o device.o
 snd-$(CONFIG_ISA_DMA_API) += isadma.o
 snd-$(CONFIG_SND_OSSEMUL) += sound_oss.o info_oss.o
 snd-$(CONFIG_SND_VMASTER) += vmaster.o
+snd-$(CONFIG_SND_JACK)	  += jack.o
 
 snd-pcm-objs := pcm.o pcm_native.o pcm_lib.o pcm_timer.o pcm_misc.o \
 		pcm_memory.o
-- 
1.5.4.3
