From: Andre Guedes <andre.guedes@intel.com>
Subject: [PATCH - Multiple plugins 1/4] a52: Fix leaks when
	a52_set_hw_constraint() fails
Date: Fri, 28 Sep 2018 14:27:24 -0700
Message-ID: <20180928212727.15151-2-andre.guedes@intel.com>
References: <20180928212727.15151-1-andre.guedes@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id B9BFB2678CA
 for <alsa-devel@alsa-project.org>; Fri, 28 Sep 2018 23:27:57 +0200 (CEST)
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

If a52_set_hw_constraint() returns error, we leak 'rec' and
'rec->slave'. This patch fixes the issue by jumping to 'error' label
where the proper clean up is already done.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 a52/pcm_a52.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/a52/pcm_a52.c b/a52/pcm_a52.c
index 29ce45f..e431fd0 100644
--- a/a52/pcm_a52.c
+++ b/a52/pcm_a52.c
@@ -978,7 +978,7 @@ SND_PCM_PLUGIN_DEFINE_FUNC(a52)
 
 	if ((err = a52_set_hw_constraint(rec)) < 0) {
 		snd_pcm_ioplug_delete(&rec->io);
-		return err;
+		goto error;
 	}
 
 	*pcmp = rec->io.pcm;
-- 
2.14.4
