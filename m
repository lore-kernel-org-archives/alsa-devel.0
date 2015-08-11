From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] topology: fix file permissions for output file
	to 0600
Date: Tue, 11 Aug 2015 14:25:59 +0100
Message-ID: <1439299559-5051-2-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1439299559-5051-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 134C926052F
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2015 15:26:14 +0200 (CEST)
In-Reply-To: <1439299559-5051-1-git-send-email-liam.r.girdwood@linux.intel.com>
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

File was incorrectly world rwx.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 src/topology/parser.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/topology/parser.c b/src/topology/parser.c
index 5544517..993f70d 100644
--- a/src/topology/parser.c
+++ b/src/topology/parser.c
@@ -267,7 +267,7 @@ int snd_tplg_build_file(snd_tplg_t *tplg, const char *infile,
 	int err = 0;
 
 	tplg->out_fd =
-		open(outfile, O_RDWR | O_CREAT, S_IRWXU | S_IRWXG | S_IRWXO);
+		open(outfile, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);
 	if (tplg->out_fd < 0) {
 		SNDERR("error: failed to open %s err %d\n",
 			outfile, -errno);
-- 
2.1.4
