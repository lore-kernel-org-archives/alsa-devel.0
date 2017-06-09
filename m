From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] topology: delete output file if parsing fails.
Date: Fri,  9 Jun 2017 16:33:42 +0100
Message-ID: <1497022422-5974-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 3EA44266AB2
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 17:33:55 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Currently the binary output file is left when parsing fails. This confuses
GNU Make if the parsing fails and causes the compilation to partially
complete.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 topology/topology.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/topology/topology.c b/topology/topology.c
index 6d876ee..097c255 100644
--- a/topology/topology.c
+++ b/topology/topology.c
@@ -108,6 +108,7 @@ int main(int argc, char *argv[])
 	if (err < 0) {
 		fprintf(stderr, _("failed to compile context %s\n"), source_file);
 		snd_tplg_free(snd_tplg);
+		unlink(output_file);
 		return 1;
 	}
 
-- 
2.11.0
