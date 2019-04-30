From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 08/19] ASoC: SOF: Intel: hda: set bus->idx as 0
Date: Tue, 30 Apr 2019 18:09:23 -0500
Message-ID: <20190430230934.4321-9-pierre-louis.bossart@linux.intel.com>
References: <20190430230934.4321-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 81F02F8065C
 for <alsa-devel@alsa-project.org>; Wed,  1 May 2019 01:10:01 +0200 (CEST)
In-Reply-To: <20190430230934.4321-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Zhu Yingjiang <yingjiang.zhu@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Zhu Yingjiang <yingjiang.zhu@linux.intel.com>

Setting the bus->idx as 0, for we only have one HDA
bus atm. This need to be fixed when there are more
than one HDA bus.

Signed-off-by: Zhu Yingjiang <yingjiang.zhu@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-bus.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/intel/hda-bus.c b/sound/soc/sof/intel/hda-bus.c
index 62cc9921bb55..a7e6d8227df6 100644
--- a/sound/soc/sof/intel/hda-bus.c
+++ b/sound/soc/sof/intel/hda-bus.c
@@ -80,8 +80,6 @@ static const struct hdac_io_ops io_ops = {
 void sof_hda_bus_init(struct hdac_bus *bus, struct device *dev,
 		      const struct hdac_ext_bus_ops *ext_ops)
 {
-	static int idx;
-
 	memset(bus, 0, sizeof(*bus));
 	bus->dev = dev;
 
@@ -90,7 +88,12 @@ void sof_hda_bus_init(struct hdac_bus *bus, struct device *dev,
 
 	bus->irq = -1;
 	bus->ext_ops = ext_ops;
-	bus->idx = idx++;
+
+	/*
+	 * There is only one HDA bus atm. keep the index as 0.
+	 * Need to fix when there are more than one HDA bus.
+	 */
+	bus->idx = 0;
 
 	spin_lock_init(&bus->reg_lock);
 
-- 
2.17.1
