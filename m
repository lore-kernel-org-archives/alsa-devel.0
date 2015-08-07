From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] topology: print error prefix on error message.
Date: Fri,  7 Aug 2015 16:39:16 +0100
Message-ID: <1438961956-6239-2-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1438961956-6239-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id BE7C82604EF
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2015 17:39:36 +0200 (CEST)
In-Reply-To: <1438961956-6239-1-git-send-email-liam.r.girdwood@linux.intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Let the user know it's an error.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 src/topology/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/topology/data.c b/src/topology/data.c
index c768bc5..0901851 100644
--- a/src/topology/data.c
+++ b/src/topology/data.c
@@ -384,7 +384,7 @@ int tplg_copy_data(struct tplg_elem *elem, struct tplg_elem *ref)
 		break;
 
 	default:
-		SNDERR("elem '%s': type %d private data not supported \n",
+		SNDERR("error: elem '%s': type %d private data not supported \n",
 			elem->id, elem->type);
 		return -EINVAL;
 	}
-- 
2.1.4
