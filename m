From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] alsatplg: fix topology compiler long option
	parsing
Date: Wed, 14 Jun 2017 12:25:33 +0100
Message-ID: <1497439533-28158-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D2F02671E6
 for <alsa-devel@alsa-project.org>; Wed, 14 Jun 2017 13:26:06 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

verbose, compile and output options all have a parameter.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 topology/topology.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/topology/topology.c b/topology/topology.c
index ffe2f05..097c255 100644
--- a/topology/topology.c
+++ b/topology/topology.c
@@ -54,10 +54,10 @@ int main(int argc, char *argv[])
 	snd_tplg_t *snd_tplg;
 	static const char short_options[] = "hc:v:o:";
 	static const struct option long_options[] = {
-		{"help", 0, 0, 'h'},
-		{"verbose", 0, 0, 'v'},
-		{"compile", 0, 0, 'c'},
-		{"output", 0, 0, 'o'},
+		{"help", 0, NULL, 'h'},
+		{"verbose", 1, NULL, 'v'},
+		{"compile", 1, NULL, 'c'},
+		{"output", 1, NULL, 'o'},
 		{0, 0, 0, 0},
 	};
 	char *source_file = NULL, *output_file = NULL;
-- 
1.9.1
