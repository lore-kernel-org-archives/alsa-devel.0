From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 082/102] ASoC: Add SOC_ENUM_SINGLE_CONST() and
	SOC_ENUM_DOUBLE_CONST() macros
Date: Tue, 18 Feb 2014 12:51:28 +0100
Message-ID: <1392724308-13375-2-git-send-email-tiwai@suse.de>
References: <1392724308-13375-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E697926532E
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:51:51 +0100 (CET)
In-Reply-To: <1392724308-13375-1-git-send-email-tiwai@suse.de>
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

Add new helper macros for defining the enum elements with a constant
array.  With these macros, redundant ARRAY_SIZE() can be removed in
the code.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/soc.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index cc891387e7ac..11966c1cd33a 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -285,9 +285,13 @@
  * Simplified versions of above macros, declaring a struct and calculating
  * ARRAY_SIZE internally
  */
+#define SOC_ENUM_DOUBLE_CONST(xreg, xshift_l, xshift_r, xtexts) \
+	SOC_ENUM_DOUBLE(xreg, xshift_l, xshift_r, ARRAY_SIZE(xtexts), xtexts)
+#define SOC_ENUM_SINGLE_CONST(xreg, xshift, xtexts) \
+	SOC_ENUM_DOUBLE_CONST(xreg, xshift, xshift, xtexts)
+
 #define SOC_ENUM_DOUBLE_DECL(name, xreg, xshift_l, xshift_r, xtexts) \
-	const struct soc_enum name = SOC_ENUM_DOUBLE(xreg, xshift_l, xshift_r, \
-						ARRAY_SIZE(xtexts), xtexts)
+	const struct soc_enum name = SOC_ENUM_DOUBLE_CONST(xreg, xshift_l, xshift_r, xtexts)
 #define SOC_ENUM_SINGLE_DECL(name, xreg, xshift, xtexts) \
 	SOC_ENUM_DOUBLE_DECL(name, xreg, xshift, xshift, xtexts)
 #define SOC_ENUM_SINGLE_EXT_DECL(name, xtexts) \
-- 
1.8.5.2
