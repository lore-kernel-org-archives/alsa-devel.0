From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] topology: open topology files with O_TRUNC
Date: Wed, 18 Nov 2015 19:12:46 +0530
Message-ID: <1447854166-6533-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 23D502654BD
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 14:39:04 +0100 (CET)
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

The topology file if exists needs to rewritten, so we need to open these
files with O_TRUNC flag as well

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 src/topology/parser.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/topology/parser.c b/src/topology/parser.c
index 18bb9c79f3a8..ee2545aada1b 100644
--- a/src/topology/parser.c
+++ b/src/topology/parser.c
@@ -260,7 +260,7 @@ int snd_tplg_build_file(snd_tplg_t *tplg, const char *infile,
 	int err = 0;
 
 	tplg->out_fd =
-		open(outfile, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);
+		open(outfile, O_RDWR | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR );
 	if (tplg->out_fd < 0) {
 		SNDERR("error: failed to open %s err %d\n",
 			outfile, -errno);
@@ -328,7 +328,7 @@ int snd_tplg_build(snd_tplg_t *tplg, const char *outfile)
 	int err;
 
 	tplg->out_fd =
-		open(outfile, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);
+		open(outfile, O_RDWR | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR);
 	if (tplg->out_fd < 0) {
 		SNDERR("error: failed to open %s err %d\n",
 			outfile, -errno);
-- 
1.9.1
