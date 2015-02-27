From: Eric Nelson <eric.nelson@boundarydevices.com>
Subject: [PATCH V2] ASoC: sgtl5000: remove useless register
	write clearing CHRGPUMP_POWERUP
Date: Fri, 27 Feb 2015 08:06:45 -0700
Message-ID: <1425049605-5473-1-git-send-email-eric.nelson@boundarydevices.com>
References: <1424991540-10206-1-git-send-email-eric.nelson@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 123D1265134
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 16:06:56 +0100 (CET)
Received: by padbj1 with SMTP id bj1so23311152pad.5
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 07:06:51 -0800 (PST)
In-Reply-To: <1424991540-10206-1-git-send-email-eric.nelson@boundarydevices.com>
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

The SGTL5000_CHIP_ANA_POWER register is cached. Update the cached
value instead of writing it directly.

Patch inspired by Russell King's more colorful remarks in this
patch:
	https://github.com/SolidRun/linux-imx6-3.14/commit/dd4bf6a

Signed-off-by: Eric Nelson <eric.nelson@boundarydevices.com>
---
V2 updates the cached variable ana_pwr to make things more explicit,
   removing the need for explanation

 sound/soc/codecs/sgtl5000.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index d4d793f..1536ba7 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -952,13 +952,7 @@ static int sgtl5000_set_power_regs(struct snd_soc_codec *codec)
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
+		ana_pwr &= ~SGTL5000_VDDC_CHRGPMP_POWERUP;
 		/* VDDC use VDDIO rail */
 		lreg_ctrl |= SGTL5000_VDDC_ASSN_OVRD;
 		lreg_ctrl |= SGTL5000_VDDC_MAN_ASSN_VDDIO <<
-- 
1.9.1
