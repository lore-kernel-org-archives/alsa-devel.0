From: Wang Xingchao <xingchao.wang@linux.intel.com>
Subject: [PATCH 1/2] ALSA: hda - Remove unused variable
Date: Mon, 24 Jun 2013 09:10:18 -0400
Message-ID: <1372079419-31903-1-git-send-email-xingchao.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 74574261B36
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2013 13:59:55 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, Wang Xingchao <xingchao.wang@linux.intel.com>, xingchao.wang@intel.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
---
 sound/pci/hda/patch_hdmi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 7803ddd..0f7a380 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1891,7 +1891,6 @@ static void intel_haswell_fixup_connect_list(struct hda_codec *codec,
 
 	/* override pins connection list */
 	snd_printdd("hdmi: haswell: override pin connection 0x%x\n", nid);
-	nconns = max(spec->num_cvts, 4);
 	snd_hda_override_conn_list(codec, nid, spec->num_cvts, spec->cvt_nids);
 }
 
-- 
1.8.1.2
