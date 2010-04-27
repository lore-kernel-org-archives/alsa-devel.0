From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 3/5] ASoC: pandora - update DAPM pins
Date: Tue, 27 Apr 2010 15:54:18 +0100
Message-ID: <1272380060-12493-3-git-send-email-lrg@slimlogic.co.uk>
References: <1272380060-12493-1-git-send-email-lrg@slimlogic.co.uk>
	<1272380060-12493-2-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B1BA2243AB
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Apr 2010 16:54:59 +0200 (CEST)
Received: by wwg30 with SMTP id 30so599401wwg.38
	for <alsa-devel@alsa-project.org>; Tue, 27 Apr 2010 07:54:59 -0700 (PDT)
In-Reply-To: <1272380060-12493-2-git-send-email-lrg@slimlogic.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Remove bogus TWL4030 pins.

Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/omap/omap3pandora.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/omap3pandora.c b/sound/soc/omap/omap3pandora.c
index de10f76..87ce842 100644
--- a/sound/soc/omap/omap3pandora.c
+++ b/sound/soc/omap/omap3pandora.c
@@ -188,8 +188,6 @@ static int omap3pandora_out_init(struct snd_soc_codec *codec)
 	int ret;
 
 	/* All TWL4030 output pins are floating */
-	snd_soc_dapm_nc_pin(codec, "OUTL");
-	snd_soc_dapm_nc_pin(codec, "OUTR");
 	snd_soc_dapm_nc_pin(codec, "EARPIECE");
 	snd_soc_dapm_nc_pin(codec, "PREDRIVEL");
 	snd_soc_dapm_nc_pin(codec, "PREDRIVER");
-- 
1.6.3.3
