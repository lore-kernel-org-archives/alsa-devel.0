From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] topology: fix output file unlinking
Date: Tue, 11 Aug 2015 14:25:58 +0100
Message-ID: <1439299559-5051-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 332AD26051F
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2015 15:26:13 +0200 (CEST)
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

Unlinking is unecessary as the old file will be overwritten with the new
as intended.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 src/topology/parser.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/topology/parser.c b/src/topology/parser.c
index ed25bb8..5544517 100644
--- a/src/topology/parser.c
+++ b/src/topology/parser.c
@@ -266,9 +266,6 @@ int snd_tplg_build_file(snd_tplg_t *tplg, const char *infile,
 	snd_config_t *cfg = NULL;
 	int err = 0;
 
-	/* delete any old output files */
-	unlink(outfile);
-
 	tplg->out_fd =
 		open(outfile, O_RDWR | O_CREAT, S_IRWXU | S_IRWXG | S_IRWXO);
 	if (tplg->out_fd < 0) {
-- 
2.1.4
