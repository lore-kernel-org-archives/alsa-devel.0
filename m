From: Andre Guedes <andre.guedes@intel.com>
Subject: [PATCH - Multiple plugins 3/4] oss: Fix leaks when
	oss_hw_constraint() fails
Date: Fri, 28 Sep 2018 14:27:26 -0700
Message-ID: <20180928212727.15151-4-andre.guedes@intel.com>
References: <20180928212727.15151-1-andre.guedes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id CD30B267737
 for <alsa-devel@alsa-project.org>; Fri, 28 Sep 2018 23:27:58 +0200 (CEST)
In-Reply-To: <20180928212727.15151-1-andre.guedes@intel.com>
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

If oss_hw_constraint() returns error, we leak 'oss' object and all the
resources referenced by it. This patch fixes the issue by jumping to
'error' label where the proper clean up is already done.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 oss/pcm_oss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/oss/pcm_oss.c b/oss/pcm_oss.c
index dadbb5b..8ab4fb0 100644
--- a/oss/pcm_oss.c
+++ b/oss/pcm_oss.c
@@ -413,7 +413,7 @@ SND_PCM_PLUGIN_DEFINE_FUNC(oss)
 
 	if ((err = oss_hw_constraint(oss)) < 0) {
 		snd_pcm_ioplug_delete(&oss->io);
-		return err;
+		goto error;
 	}
 
 	*pcmp = oss->io.pcm;
-- 
2.14.4
