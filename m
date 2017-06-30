From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] alsa-lib: topology: improve verbose output for
	block output.
Date: Fri, 30 Jun 2017 14:14:56 +0100
Message-ID: <1498828496-28897-2-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1498828496-28897-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id D84FD2674F1
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 15:15:20 +0200 (CEST)
In-Reply-To: <1498828496-28897-1-git-send-email-liam.r.girdwood@linux.intel.com>
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

Show index and full DAPm route in verbose output.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 src/topology/builder.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/src/topology/builder.c b/src/topology/builder.c
index ca5cbe1a..997df0c7 100644
--- a/src/topology/builder.c
+++ b/src/topology/builder.c
@@ -67,9 +67,10 @@ static int write_block_header(snd_tplg_t *tplg, unsigned int type,
 		exit(-EINVAL);
 	}
 
-	verbose(tplg, " header type %d size 0x%lx/%ld vendor %d "
-		"version %d\n", type, (long unsigned int)payload_size,
-		(long int)payload_size, vendor_type, version);
+	verbose(tplg, " header index %d type %d count %d size 0x%lx/%ld vendor %d "
+		"version %d\n", index, type, count,
+		(long unsigned int)payload_size, (long int)payload_size,
+		vendor_type, version);
 
 	tplg->next_hdr_pos += hdr.payload_size + sizeof(hdr);
 
@@ -119,8 +120,10 @@ static int write_elem_block(snd_tplg_t *tplg,
 					verbose(tplg, " %s '%s': write %d bytes\n",
 						obj_name, elem->id, elem->size);
 				else
-					verbose(tplg, " %s '%s': write %d bytes\n",
-						obj_name, elem->route->source, elem->size);
+					verbose(tplg, " %s '%s -> %s -> %s': write %d bytes\n",
+						obj_name, elem->route->source,
+						elem->route->control,
+						elem->route->sink, elem->size);
 
 				wsize = write(tplg->out_fd, elem->obj, elem->size);
 				if (wsize < 0) {
-- 
2.11.0
