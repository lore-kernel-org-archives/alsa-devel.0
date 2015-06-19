From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 5/6] ASoC: intel - atom: statify
	sst_slot_enum_info
Date: Fri, 19 Jun 2015 23:55:30 +0530
Message-ID: <1434738331-12518-6-git-send-email-vinod.koul@intel.com>
References: <1434738331-12518-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id A5693260644
 for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2015 20:24:06 +0200 (CEST)
In-Reply-To: <1434738331-12518-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

Sparse complains that sst_slot_enum_info should be static, so make it
static

sound/soc/intel/atom/sst-atom-controls.c:135:5: warning: symbol
'sst_slot_enum_info' was not declared. Should it be static?

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/atom/sst-atom-controls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst-atom-controls.c b/sound/soc/intel/atom/sst-atom-controls.c
index 31e9b9ecbb8a..c95bc52dcd74 100644
--- a/sound/soc/intel/atom/sst-atom-controls.c
+++ b/sound/soc/intel/atom/sst-atom-controls.c
@@ -132,7 +132,7 @@ static int sst_send_slot_map(struct sst_data *drv)
 			      sizeof(cmd.header) + cmd.header.length);
 }
 
-int sst_slot_enum_info(struct snd_kcontrol *kcontrol,
+static int sst_slot_enum_info(struct snd_kcontrol *kcontrol,
 		       struct snd_ctl_elem_info *uinfo)
 {
 	struct sst_enum *e = (struct sst_enum *)kcontrol->private_value;
-- 
1.9.1
