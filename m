From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Use bool rather than 1 bit bitfield in
	multi-component
Date: Thu,  1 Jul 2010 20:55:34 +0100
Message-ID: <1278014134-19158-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1277407467.3100.579.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 60CE124153
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Jul 2010 21:55:46 +0200 (CEST)
In-Reply-To: <1277407467.3100.579.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This fixes sparse complaints about the bitfield being signed but
only 1 bit wide (so not enough space to store the sign bit).

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index b3fe7a8..fb3093b 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -573,7 +573,7 @@ struct snd_soc_card {
 	struct list_head list;
 	struct mutex mutex;
 
-	int instantiated:1;
+	bool instantiated;
 
 	int (*probe)(struct platform_device *pdev);
 	int (*remove)(struct platform_device *pdev);
-- 
1.7.1
