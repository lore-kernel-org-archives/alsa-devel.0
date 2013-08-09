From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ALSA: Add MAINTAINERS entry for compressed
	audio API
Date: Fri,  9 Aug 2013 18:10:50 +0100
Message-ID: <1376068250-3315-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 29A342657EB
 for <alsa-devel@alsa-project.org>; Fri,  9 Aug 2013 19:10:58 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Help ensure that Vinod gets included in review of compressed audio
patches by adding a MAINTAINERS entry for it.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a367e52..427a930 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7694,6 +7694,15 @@ F:	include/sound/
 F:	include/uapi/sound/
 F:	sound/
 
+SOUND - COMPRESSED AUDIO
+M:	Vinod Koul <vinod.koul@intel.com>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
+S:	Supported
+F:	include/sound/compress_driver.h
+F:	sound/core/compress_offload.c
+F:	sound/soc/soc-compress.c
+
 SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEMENT (ASoC)
 M:	Liam Girdwood <lgirdwood@gmail.com>
 M:	Mark Brown <broonie@kernel.org>
-- 
1.8.4.rc1
