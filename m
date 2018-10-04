From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/5] ALSA: opti92xx-ad1848: Use the standard
	fall-through annotation
Date: Thu,  4 Oct 2018 20:12:33 +0200
Message-ID: <20181004181234.21152-5-tiwai@suse.de>
References: <20181004181234.21152-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8856A267889
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2018 20:12:36 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 0C160B049
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2018 18:12:36 +0000 (UTC)
In-Reply-To: <20181004181234.21152-1-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

As a preparatory patch for the upcoming -Wimplicit-fallthrough
compiler checks, replace with the standard "fall through" annotation
at the right places.  They have to be put right before the next
labels.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/isa/opti9xx/opti92x-ad1848.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
index ac0ab6eb40f0..47e0b2820ace 100644
--- a/sound/isa/opti9xx/opti92x-ad1848.c
+++ b/sound/isa/opti9xx/opti92x-ad1848.c
@@ -389,7 +389,8 @@ static int snd_opti9xx_configure(struct snd_opti9xx *chip,
 	case OPTi9XX_HW_82C931:
 		/* disable 3D sound (set GPIO1 as output, low) */
 		snd_opti9xx_write_mask(chip, OPTi9XX_MC_REG(20), 0x04, 0x0c);
-	case OPTi9XX_HW_82C933: /* FALL THROUGH */
+		/* fall through */
+	case OPTi9XX_HW_82C933:
 		/*
 		 * The BTC 1817DW has QS1000 wavetable which is connected
 		 * to the serial digital input of the OPTI931.
@@ -400,7 +401,8 @@ static int snd_opti9xx_configure(struct snd_opti9xx *chip,
 		 * or digital input signal.
 		 */
 		snd_opti9xx_write_mask(chip, OPTi9XX_MC_REG(26), 0x01, 0x01);
-	case OPTi9XX_HW_82C930: /* FALL THROUGH */
+		/* fall through */
+	case OPTi9XX_HW_82C930:
 		snd_opti9xx_write_mask(chip, OPTi9XX_MC_REG(6), 0x02, 0x03);
 		snd_opti9xx_write_mask(chip, OPTi9XX_MC_REG(3), 0x00, 0xff);
 		snd_opti9xx_write_mask(chip, OPTi9XX_MC_REG(4), 0x10 |
-- 
2.18.0
