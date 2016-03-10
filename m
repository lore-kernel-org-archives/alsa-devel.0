From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Don't handle ELD notify from
	invalid port
Date: Thu, 10 Mar 2016 15:44:19 +0100
Message-ID: <1457621059-32571-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D68A6265005
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2016 15:44:24 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 2C2C0AD8B
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2016 14:44:24 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

The current Intel HDMI codec driver supports only three fixed ports
from port B to port D.  However, i915 driver may assign a DP on other
ports, e.g. port A, when no eDP is used.  This incompatibility is
caught later at pin_nid_to_pin_index() and results in a warning
message like "HDMI: pin nid 4 not registered" at each time.

This patch filters out such invalid events beforehand, so that the
kernel won't be too grumbling.

Reported-by: Stefan Assmann <sassmann@kpanic.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_hdmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index bcbc4ee10130..b90e4f3967de 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2432,6 +2432,10 @@ static void intel_pin_eld_notify(void *audio_ptr, int port)
 	struct hda_codec *codec = audio_ptr;
 	int pin_nid = port + 0x04;
 
+	/* we assume only from port-B to port-D */
+	if (port < 1 || port > 3)
+		return;
+
 	/* skip notification during system suspend (but not in runtime PM);
 	 * the state will be updated at resume
 	 */
-- 
2.7.2
