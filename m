From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: [PATCH 3/3] ASoC: Davinci: evm: Fix typo in cpu dai
	name
Date: Fri, 31 Aug 2012 18:20:59 +0530
Message-ID: <1346417459-30042-4-git-send-email-gururaja.hebbar@ti.com>
References: <1346417459-30042-1-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 85F0D265DFE
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2012 15:08:59 +0200 (CEST)
In-Reply-To: <1346417459-30042-1-git-send-email-gururaja.hebbar@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com, linux-arm-kernel@lists.infradead.org
Cc: sudhakar.raj@ti.com, tony@atomide.com, broonie@opensource.wolfsonmicro.com, nsekhar@ti.com, gururaja.hebbar@ti.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Fix typo caused by recent commit (cf53756 - ASoC: davinci: davinci-pcm
does not need to be a plaform_driver)

Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
---
:100644 100644 ca2a547... 2864f24... M	sound/soc/davinci/davinci-evm.c
 sound/soc/davinci/davinci-evm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index ca2a547..2864f24 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -208,7 +208,7 @@ static struct snd_soc_dai_link dm365_evm_dai = {
 	.cpu_dai_name = "davinci-vcif",
 	.codec_dai_name = "cq93vc-hifi",
 	.codec_name = "cq93vc-codec",
-	.platform_name = "avinci-vcif",
+	.platform_name = "davinci-vcif",
 #endif
 };
 
-- 
1.7.1
