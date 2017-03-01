From: jeeja.kp@intel.com
Subject: [PATCH 1/2] ASoC: hdac_hdmi: avoid reference to
	invalid variable of the pin list
Date: Wed,  1 Mar 2017 22:41:23 +0530
Message-ID: <1488388284-11227-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id ABCA0266834
 for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2017 17:59:34 +0100 (CET)
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Using pin list array iterator outside the iteration of the list can
point to dummy element, which can be invalid. So don't use pin variable
outside the pin list iteration.

This fixes the following coccinelle warning:
sound/soc/codecs/hdac_hdmi.c:1419:5-8: ERROR: invalid reference to the
index variable of the iterator

Fixes: 2acd8309a3a4('ASoC: hdac_hdmi: Add support to handle MST capable pin')
Reported-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 78fca8a..bb40569 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1534,21 +1534,20 @@ static void hdac_hdmi_eld_notify_cb(void *aptr, int port, int pipe)
 			pin->mst_capable = false;
 			/* if not MST, default is port[0] */
 			hport = &pin->ports[0];
-			goto out;
 		} else {
 			for (i = 0; i < pin->num_ports; i++) {
 				pin->mst_capable = true;
 				if (pin->ports[i].id == pipe) {
 					hport = &pin->ports[i];
-					goto out;
+					break;
 				}
 			}
 		}
+
+		if (hport)
+			hdac_hdmi_present_sense(pin, hport);
 	}
 
-out:
-	if (pin && hport)
-		hdac_hdmi_present_sense(pin, hport);
 }
 
 static struct i915_audio_component_audio_ops aops = {
-- 
2.5.0
