From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: Fix snd_soc_kcontrol_platform() return
	type
Date: Tue, 15 Apr 2014 22:24:21 +0200
Message-ID: <1397593461-11369-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-027.synserver.de (smtp-out-049.synserver.de
 [212.40.185.49])
 by alsa0.perex.cz (Postfix) with ESMTP id CD9F3265095
 for <alsa-devel@alsa-project.org>; Tue, 15 Apr 2014 22:24:28 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

This should obviously be snd_soc_platform * and not snd_soc_codec *

Fixes: f6272ff8a5f4 ("ASoC: Add snd_soc_kcontrol_platform() helper function")
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 3396594..488e749 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1252,7 +1252,7 @@ static inline struct snd_soc_codec *snd_soc_kcontrol_codec(
  * registered with snd_soc_add_platform_controls() or via table based setup of
  * a snd_soc_platform_driver. Otherwise the behavior is undefined.
  */
-static inline struct snd_soc_codec *snd_soc_kcontrol_platform(
+static inline struct snd_soc_platform *snd_soc_kcontrol_platform(
 	struct snd_kcontrol *kcontrol)
 {
 	return snd_kcontrol_chip(kcontrol);
-- 
1.8.0
