From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ASoC: intel: skylake: fix spelling mistake:
	"Homogenous" -> "Homogeneous"
Date: Mon, 21 May 2018 10:35:48 +0100
Message-ID: <20180521093548.18491-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 865CD26738C
 for <alsa-devel@alsa-project.org>; Mon, 21 May 2018 11:35:57 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in snprintf literal string

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/intel/skylake/skl-debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-debug.c b/sound/soc/intel/skylake/skl-debug.c
index a016455a6ddb..302b40e63e6c 100644
--- a/sound/soc/intel/skylake/skl-debug.c
+++ b/sound/soc/intel/skylake/skl-debug.c
@@ -142,8 +142,8 @@ static ssize_t module_read(struct file *file, char __user *user_buf,
 			mconfig->max_out_queue, ret, false);
 
 	ret += snprintf(buf + ret, MOD_BUF - ret,
-			"Other:\n\tDomain %d\n\tHomogenous Input %s\n\t"
-			"Homogenous Output %s\n\tIn Queue Mask %d\n\t"
+			"Other:\n\tDomain %d\n\tHomogeneous Input %s\n\t"
+			"Homogeneous Output %s\n\tIn Queue Mask %d\n\t"
 			"Out Queue Mask %d\n\tDMA ID %d\n\tMem Pages %d\n\t"
 			"Module Type %d\n\tModule State %d\n",
 			mconfig->domain,
-- 
2.17.0
