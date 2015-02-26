From: Eric Nelson <eric.nelson@boundarydevices.com>
Subject: [PATCH] ASoC: sgtl5000: remove useless register write
	clearing CHRGPUMP_POWERUP
Date: Thu, 26 Feb 2015 15:59:00 -0700
Message-ID: <1424991540-10206-1-git-send-email-eric.nelson@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f178.google.com (mail-pd0-f178.google.com
 [209.85.192.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F0B2264F3A
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 23:59:08 +0100 (CET)
Received: by pdev10 with SMTP id v10so16326146pde.10
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 14:59:05 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: fabio.estevam@freescale.com, lars@metafoo.de, tiwai@suse.de, Eric Nelson <eric.nelson@boundarydevices.com>, lgirdwood@gmail.com, broonie@kernel.org, rmk+kernel@arm.linux.org.uk, jean-michel.hautbois@vodalys.com, troy.kisky@boundarydevices.com
List-Id: alsa-devel@alsa-project.org

The only way the SGTL5000_VDDC_CHRGPMP_POWERUP bit is set
is by execution on a machine with vddio and vdda below 3.1V,
and the driver needn't handle the case where the design changes
through a soft reboot.

Even if that were desired, the register write removed by this
patch would get over-written by the cached value.

Patch inspired by Russell King's more colorful remarks in this
patch:
	https://github.com/SolidRun/linux-imx6-3.14/commit/dd4bf6a

Signed-off-by: Eric Nelson <eric.nelson@boundarydevices.com>
---
 sound/soc/codecs/sgtl5000.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index d4d793f..518731a 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -952,13 +952,6 @@ static int sgtl5000_set_power_regs(struct snd_soc_codec *codec)
 		/* Enable VDDC charge pump */
 		ana_pwr |= SGTL5000_VDDC_CHRGPMP_POWERUP;
 	} else if (vddio >= 3100 && vdda >= 3100) {
-		/*
-		 * if vddio and vddd > 3.1v,
-		 * charge pump should be clean before set ana_pwr
-		 */
-		snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
-				SGTL5000_VDDC_CHRGPMP_POWERUP, 0);
-
 		/* VDDC use VDDIO rail */
 		lreg_ctrl |= SGTL5000_VDDC_ASSN_OVRD;
 		lreg_ctrl |= SGTL5000_VDDC_MAN_ASSN_VDDIO <<
-- 
1.9.1
