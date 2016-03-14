From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] topology: Add ops to bytes control.
Date: Mon, 14 Mar 2016 08:07:35 +0000
Message-ID: <1457942858-5652-2-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1457942858-5652-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 943B526066B
 for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2016 09:08:01 +0100 (CET)
In-Reply-To: <1457942858-5652-1-git-send-email-liam.r.girdwood@linux.intel.com>
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

Byte controls can also support ops. Add them to the parser.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 src/topology/ctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/topology/ctl.c b/src/topology/ctl.c
index c250227..a8ac398 100644
--- a/src/topology/ctl.c
+++ b/src/topology/ctl.c
@@ -385,6 +385,14 @@ int tplg_parse_control_bytes(snd_tplg_t *tplg,
 			tplg_dbg("\t%s: %s\n", id, val);
 			continue;
 		}
+
+		if (strcmp(id, "ops") == 0) {
+			err = tplg_parse_compound(tplg, n, tplg_parse_ops,
+				&be->hdr);
+			if (err < 0)
+				return err;
+			continue;
+		}
 	}
 
 	return 0;
-- 
2.5.0
