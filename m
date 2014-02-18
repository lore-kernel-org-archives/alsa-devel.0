From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 003/102] ALSA: da732x: Remove superfluous
	DA732X_SOC_ENUM_DOUBLE_R()
Date: Tue, 18 Feb 2014 12:29:27 +0100
Message-ID: <1392722967-12472-4-git-send-email-tiwai@suse.de>
References: <1392722967-12472-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 36BCB2651B9
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:29:34 +0100 (CET)
In-Reply-To: <1392722967-12472-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

It's nowhere used.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/da732x.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/da732x.h b/sound/soc/codecs/da732x.h
index c8ce5475de22..1dceafeec415 100644
--- a/sound/soc/codecs/da732x.h
+++ b/sound/soc/codecs/da732x.h
@@ -113,9 +113,6 @@
 #define	DA732X_EQ_OVERALL_VOL_DB_MIN	-1800
 #define	DA732X_EQ_OVERALL_VOL_DB_INC	600
 
-#define DA732X_SOC_ENUM_DOUBLE_R(xreg, xrreg, xmax, xtext) \
-	{.reg = xreg, .reg2 = xrreg, .max = xmax, .texts = xtext}
-
 enum da732x_sysctl {
 	DA732X_SR_8KHZ		= 0x1,
 	DA732X_SR_11_025KHZ	= 0x2,
-- 
1.8.5.2
