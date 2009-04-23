From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 15/21] ASoC: remove non-existing referece to
	CONFIG_SND_SOC_CODEC_WM8991
Date: Thu, 23 Apr 2009 20:55:49 +0100
Message-ID: <1240516555-22249-15-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090423195420.GA20863@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3081B103897
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 21:56:05 +0200 (CEST)
In-Reply-To: <20090423195420.GA20863@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Takashi Iwai <tiwai@suse.de>

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/Makefile |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 030d245..f265380 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -56,7 +56,6 @@ obj-$(CONFIG_SND_SOC_WM8900)	+= snd-soc-wm8900.o
 obj-$(CONFIG_SND_SOC_WM8903)	+= snd-soc-wm8903.o
 obj-$(CONFIG_SND_SOC_WM8971)	+= snd-soc-wm8971.o
 obj-$(CONFIG_SND_SOC_WM8990)	+= snd-soc-wm8990.o
-obj-$(CONFIG_SND_SOC_WM8991)	+= snd-soc-wm8991.o
 obj-$(CONFIG_SND_SOC_WM9705)	+= snd-soc-wm9705.o
 obj-$(CONFIG_SND_SOC_WM9712)	+= snd-soc-wm9712.o
 obj-$(CONFIG_SND_SOC_WM9713)	+= snd-soc-wm9713.o
-- 
1.5.6.3
