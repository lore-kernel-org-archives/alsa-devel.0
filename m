From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [topic/asoc][PATCH 1/1] ASoC: OMAP: Fix preprocessor
	filled DAI name in McBSP DAI
Date: Fri, 21 Nov 2008 14:31:33 +0200
Message-ID: <1227270693-14227-2-git-send-email-jarkko.nikula@nokia.com>
References: <1227270693-14227-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id BBF7F24490
	for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2008 13:31:57 +0100 (CET)
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	mALCVe41014865
	for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2008 14:31:56 +0200
In-Reply-To: <1227270693-14227-1-git-send-email-jarkko.nikula@nokia.com>
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
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/soc/omap/omap-mcbsp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 3d4060b..ba61c9e 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -450,7 +450,7 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 
 #define OMAP_MCBSP_DAI_BUILDER(link_id)				\
 {								\
-	.name = "omap-mcbsp-dai-(link_id)",			\
+	.name = "omap-mcbsp-dai-"#link_id,			\
 	.id = (link_id),					\
 	.type = SND_SOC_DAI_I2S,				\
 	.playback = {						\
-- 
1.5.6.5
