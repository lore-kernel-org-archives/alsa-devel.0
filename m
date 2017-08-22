From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 3/4] ASoC: Intel: Skylake: Fix to free correct
	dev id in free_irq
Date: Tue, 22 Aug 2017 16:45:52 +0530
Message-ID: <1503400553-15377-4-git-send-email-subhransu.s.prusty@intel.com>
References: <1503400553-15377-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id A5DBA2675B5
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 13:33:14 +0200 (CEST)
In-Reply-To: <1503400553-15377-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The dev_id passed by the driver in request_threaded_irq is an ebus pointer,
whereas to free_irq it is hdac_bus. Fix by passing correct dev_id to
free_irq.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/skylake/skl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index e25e5ed464dc..f94b484abb99 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -415,7 +415,7 @@ static int skl_free(struct hdac_ext_bus *ebus)
 	snd_hdac_ext_stop_streams(ebus);
 
 	if (bus->irq >= 0)
-		free_irq(bus->irq, (void *)bus);
+		free_irq(bus->irq, (void *)ebus);
 	snd_hdac_bus_free_stream_pages(bus);
 	snd_hdac_stream_free_all(ebus);
 	snd_hdac_link_free_all(ebus);
-- 
1.9.1
