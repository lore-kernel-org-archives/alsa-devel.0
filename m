From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/4] ASoC: intel: atom: localize variable
	without external linkage
Date: Tue,  2 May 2017 22:33:03 +0900
Message-ID: <20170502133303.19622-5-o-takashi@sakamocchi.jp>
References: <20170502133303.19622-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 4970E266B98
 for <alsa-devel@alsa-project.org>; Tue,  2 May 2017 15:33:08 +0200 (CEST)
In-Reply-To: <20170502133303.19622-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, broonie@kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Sebastien Guiriec <sebastien.guiriec@intel.com>
List-Id: alsa-devel@alsa-project.org

A driver for Intel SST driver for old atom platform includes a variable
which has no external linkage. These functions should have static
qualifier.

This commit adds the qualifier to localize the variable. This issue is
detected by sparse:

sst.c:261:1: warning: symbol 'dev_attr_firmware_version' was not declared. Should it be static?

Cc: Sebastien Guiriec <sebastien.guiriec@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/soc/intel/atom/sst/sst.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst/sst.c b/sound/soc/intel/atom/sst/sst.c
index f9ba713..d97556a 100644
--- a/sound/soc/intel/atom/sst/sst.c
+++ b/sound/soc/intel/atom/sst/sst.c
@@ -258,7 +258,7 @@ static ssize_t firmware_version_show(struct device *dev,
 
 }
 
-DEVICE_ATTR_RO(firmware_version);
+static DEVICE_ATTR_RO(firmware_version);
 
 static const struct attribute *sst_fw_version_attrs[] = {
 	&dev_attr_firmware_version.attr,
-- 
2.9.3
