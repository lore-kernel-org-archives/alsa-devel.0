From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ASoC: cygnus: remove redundant assignment to
	pointer 'res'
Date: Thu,  8 Mar 2018 14:32:49 +0100
Message-ID: <20180308133249.22032-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id F186026742B
 for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2018 14:32:57 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Lori Hikichi <lori.hikichi@broadcom.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

The pointer res is being initialized with a value that is never read
and re-assigned immediately after, hence the initialization is redundant
and can be removed.

Cleans up clang warning:
sound/soc/bcm/cygnus-ssp.c:1284:19: warning: Value stored to 'res'
during its initialization is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/bcm/cygnus-ssp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/bcm/cygnus-ssp.c b/sound/soc/bcm/cygnus-ssp.c
index abafadc0b534..b733f1446353 100644
--- a/sound/soc/bcm/cygnus-ssp.c
+++ b/sound/soc/bcm/cygnus-ssp.c
@@ -1281,7 +1281,7 @@ static int cygnus_ssp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *child_node;
-	struct resource *res = pdev->resource;
+	struct resource *res;
 	struct cygnus_audio *cygaud;
 	int err = -EINVAL;
 	int node_count;
-- 
2.15.1
