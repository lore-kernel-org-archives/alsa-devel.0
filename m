From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 4/4] ASoC: topology: fix info callback for TLV
	byte control
Date: Mon,  9 Nov 2015 23:20:01 +0530
Message-ID: <1447091401-24298-5-git-send-email-vinod.koul@intel.com>
References: <1447091401-24298-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id D6EE9261A0A
 for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2015 18:46:44 +0100 (CET)
In-Reply-To: <1447091401-24298-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Omair M Abdullah <omair.m.abdullah@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Omair M Abdullah <omair.m.abdullah@intel.com>

topology core used wrong callback for TLV bytes control, it should be
snd_soc_bytes_info_ext and not snd_soc_bytes_info

Signed-off-by: Omair M Abdullah <omair.m.abdullah@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/soc-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 69d01cd925ce..a697f9fc8495 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -531,7 +531,7 @@ static int soc_tplg_kcontrol_bind_io(struct snd_soc_tplg_ctl_hdr *hdr,
 		/* TLV bytes controls need standard kcontrol info handler,
 		 * TLV callback and extended put/get handlers.
 		 */
-		k->info = snd_soc_bytes_info;
+		k->info = snd_soc_bytes_info_ext;
 		k->tlv.c = snd_soc_bytes_tlv_callback;
 
 		ext_ops = tplg->bytes_ext_ops;
-- 
1.9.1
