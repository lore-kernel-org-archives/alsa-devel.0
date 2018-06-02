From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 12/13] ALSA: hdac: ext: add wait for codec
	to respond after link reset
Date: Fri,  1 Jun 2018 22:54:00 -0500
Message-ID: <20180602035401.26934-13-pierre-louis.bossart@linux.intel.com>
References: <20180602035401.26934-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CD30267865
 for <alsa-devel@alsa-project.org>; Sat,  2 Jun 2018 05:54:22 +0200 (CEST)
In-Reply-To: <20180602035401.26934-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, rakesh.a.ughreja@intel.com
List-Id: alsa-devel@alsa-project.org

From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>

As per HDA spec section 4.3 - Codec Discovery, the software shall wait
for atleast 521usec for codec to respond after link reset.
With the multi-link capability each link is turned ON/OFF individually.
Link controller drives reset signal when it is turned ON.

Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/hda/ext/hdac_ext_controller.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/hda/ext/hdac_ext_controller.c b/sound/hda/ext/hdac_ext_controller.c
index 72774119dd11..5bc4a1d587d4 100644
--- a/sound/hda/ext/hdac_ext_controller.c
+++ b/sound/hda/ext/hdac_ext_controller.c
@@ -271,6 +271,15 @@ int snd_hdac_ext_bus_link_get(struct hdac_bus *bus,
 		}
 
 		ret = snd_hdac_ext_bus_link_power_up(link);
+
+		/*
+		 *  wait for 521usec for codec to report status
+		 *  HDA spec section 4.3 - Codec Discovery
+		 */
+		udelay(521);
+		bus->codec_mask = snd_hdac_chip_readw(bus, STATESTS);
+		dev_dbg(bus->dev, "codec_mask = 0x%lx\n", bus->codec_mask);
+		snd_hdac_chip_writew(bus, STATESTS, bus->codec_mask);
 	}
 
 	mutex_unlock(&bus->lock);
-- 
2.14.1
