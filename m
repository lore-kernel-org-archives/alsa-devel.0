From: Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH v2] ASoC: hdac_hdmi: Remove 'edev' NULL check
Date: Wed, 17 Feb 2016 09:42:13 -0200
Message-ID: <1455709333-19807-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0076.outbound.protection.outlook.com [65.55.169.76])
 by alsa0.perex.cz (Postfix) with ESMTP id 065FA26583F
 for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2016 12:42:23 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@nxp.com>, jeeja.kp@intel.com, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, dan.carpenter@oracle.com
List-Id: alsa-devel@alsa-project.org

Commit 4a3478debf36 ("ASoC: hdac_hdmi: Add jack reporting") 
leads to the following Smatch complaint:

sound/soc/codecs/hdac_hdmi.c:971 hdac_hdmi_present_sense()
         warn: variable dereferenced before check 'edev' (see line 967)

As explained by Subhransu S. Prusty:

"This NULL check is not required, can be removed.

edev object is expected to be present when the present_sense is 
called. This is called from places where this edev object is 
already available."

So remove the evdev NULL check.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- Remove NULL check (Subhransu)

 sound/soc/codecs/hdac_hdmi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 36f1200..2884dbf 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -968,9 +968,6 @@ static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin, int repoll)
 	struct hdac_hdmi_pcm *pcm;
 	int val;
 
-	if (!edev)
-		return;
-
 	pin->repoll_count = repoll;
 
 	pm_runtime_get_sync(&edev->hdac.dev);
-- 
1.9.1
