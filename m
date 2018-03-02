From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Subject: [PATCH v2 01/10] ALSA - Ext hda: add wait for codec to
	respond after link reset
Date: Fri,  2 Mar 2018 16:22:29 +0530
Message-ID: <1519987958-5482-2-git-send-email-rakesh.a.ughreja@intel.com>
References: <1519987958-5482-1-git-send-email-rakesh.a.ughreja@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id D08ED267920
 for <alsa-devel@alsa-project.org>; Fri,  2 Mar 2018 11:50:14 +0100 (CET)
In-Reply-To: <1519987958-5482-1-git-send-email-rakesh.a.ughreja@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com
Cc: vinod.koul@intel.com, patches.audio@intel.com, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

As per HDA spec section 4.3 - Codec Discovery, the software shall wait
for atleast 521usec for codec to respond after link reset.
With the multi-link capability each link is turned ON/OFF individually.
Link controller drives reset signal when it is turned ON.

Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
---
 sound/hda/ext/hdac_ext_controller.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/hda/ext/hdac_ext_controller.c b/sound/hda/ext/hdac_ext_controller.c
index 7277411..2d3770a 100644
--- a/sound/hda/ext/hdac_ext_controller.c
+++ b/sound/hda/ext/hdac_ext_controller.c
@@ -271,6 +271,14 @@ int snd_hdac_ext_bus_link_get(struct hdac_bus *bus,
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
 	}
 
 	mutex_unlock(&bus->lock);
-- 
2.7.4
