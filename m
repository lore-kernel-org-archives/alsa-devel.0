From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v3 2/9] ALSA: hda - add helper to get channels
	from cap bits
Date: Thu, 14 Apr 2016 10:07:29 +0530
Message-ID: <1460608656-8860-3-git-send-email-subhransu.s.prusty@intel.com>
References: <1460608656-8860-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 0286026641C
 for <alsa-devel@alsa-project.org>; Thu, 14 Apr 2016 06:38:36 +0200 (CEST)
In-Reply-To: <1460608656-8860-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

This helper is copied from legacy hda driver.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/hda/local.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/hda/local.h b/sound/hda/local.h
index d692f41..0d5bb15 100644
--- a/sound/hda/local.h
+++ b/sound/hda/local.h
@@ -16,6 +16,16 @@ static inline int get_wcaps_type(unsigned int wcaps)
 	return (wcaps & AC_WCAP_TYPE) >> AC_WCAP_TYPE_SHIFT;
 }
 
+static inline unsigned int get_wcaps_channels(u32 wcaps)
+{
+	unsigned int chans;
+
+	chans = (wcaps & AC_WCAP_CHAN_CNT_EXT) >> 13;
+	chans = (chans + 1) * 2;
+
+	return chans;
+}
+
 extern const struct attribute_group *hdac_dev_attr_groups[];
 int hda_widget_sysfs_init(struct hdac_device *codec);
 void hda_widget_sysfs_exit(struct hdac_device *codec);
-- 
1.9.1
