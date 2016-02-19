From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/3] ASoC: Intel: Skylake: fix pointer scaling
Date: Fri, 19 Feb 2016 11:42:32 +0530
Message-ID: <1455862354-6455-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C9D9261521
 for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2016 07:08:53 +0100 (CET)
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
Cc: Alan <gnomes@lxorguk.ukuu.org.uk>, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Alan <gnomes@lxorguk.ukuu.org.uk>

skl_tplg_tlv_control_set does pointer maths on data but forgets that data
is not uint8_t so the maths is already scaled in the pointer type.

Signed-off-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index ba0d02d1613e..22a9e6fe1c05 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1111,7 +1111,7 @@ static int skl_tplg_tlv_control_set(struct snd_kcontrol *kcontrol,
 				return -EFAULT;
 		} else {
 			if (copy_from_user(ac->params,
-					   data + 2 * sizeof(u32), size))
+					   data + 2, size))
 				return -EFAULT;
 		}
 
-- 
1.9.1
