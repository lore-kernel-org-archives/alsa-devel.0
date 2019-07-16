From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda/hdmi - Fix i915 reverse port/pin
	mapping
Date: Tue, 16 Jul 2019 09:42:55 +0200
Message-ID: <20190716074255.14267-2-tiwai@suse.de>
References: <20190716074255.14267-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 42EEAF8038F
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2019 09:43:05 +0200 (CEST)
In-Reply-To: <20190716074255.14267-1-tiwai@suse.de>
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
Cc: Hui Wang <hui.wang@canonical.com>
List-Id: alsa-devel@alsa-project.org

The recent fix for Icelake HDMI codec introduced the mapping from pin
NID to the i915 gfx port number.  However, it forgot the reverse
mapping from the port number to the pin NID that is used in the ELD
notifier callback.  As a result, it's processed to a wrong widget and
gives a warning like
  snd_hda_codec_hdmi hdaudioC0D2: HDMI: pin nid 5 not registered

This patch corrects it with a proper reverse mapping function.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=204133
Fixes: b0d8bc50b9f2 ("ALSA: hda: hdmi - add Icelake support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_hdmi.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 1e6c489bca15..664c81cf5ffb 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2524,18 +2524,29 @@ static int intel_pin2port(void *audio_ptr, int pin_nid)
 	return -1;
 }
 
+static int intel_port2pin(struct hda_codec *codec, int port)
+{
+	struct hdmi_spec *spec = codec->spec;
+
+	if (!spec->port_num) {
+		/* we assume only from port-B to port-D */
+		if (port < 1 || port > 3)
+			return 0;
+		/* intel port is 1-based */
+		return port + intel_base_nid(codec) - 1;
+	}
+
+	if (port < 1 || port > spec->port_num)
+		return 0;
+	return spec->port_map[port - 1];
+}
+
 static void intel_pin_eld_notify(void *audio_ptr, int port, int pipe)
 {
 	struct hda_codec *codec = audio_ptr;
-	int pin_nid;
+	int pin_nid = intel_port2pin(codec, port);
 	int dev_id = pipe;
 
-	/* we assume only from port-B to port-D */
-	if (port < 1 || port > 3)
-		return;
-
-	pin_nid = port + intel_base_nid(codec) - 1; /* intel port is 1-based */
-
 	/* skip notification during system suspend (but not in runtime PM);
 	 * the state will be updated at resume
 	 */
-- 
2.16.4
