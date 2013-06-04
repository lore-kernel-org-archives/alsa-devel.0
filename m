From: David Henningsson <david.henningsson@canonical.com>
Subject: [RFC PATCH] ALSA: hda - Ignore default pin config on
	Haswell HDMI codecs
Date: Tue,  4 Jun 2013 10:02:45 +0200
Message-ID: <1370332965-3489-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A6182650AE
 for <alsa-devel@alsa-project.org>; Tue,  4 Jun 2013 10:02:48 +0200 (CEST)
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
Cc: liam.r.girdwood@intel.com, tiwai@suse.de, mengdong.lin@intel.com, xingchao.wang@intel.com, jocelyn.li@intel.com, daniel@ffwll.ch, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

According to Daniel Vetter, these pin configs should be ignored,
because the graphics driver/userspace could route audio to these
pins even if they are disabled by BIOS.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_hdmi.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

It would be good to have this acked by someone at Intel before committing.

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index e12f7a0..8c1bede 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1307,12 +1307,14 @@ static int hdmi_add_pin(struct hda_codec *codec, hda_nid_t pin_nid)
 	if (!(caps & (AC_PINCAP_HDMI | AC_PINCAP_DP)))
 		return 0;
 
-	config = snd_hda_codec_get_pincfg(codec, pin_nid);
-	if (get_defcfg_connect(config) == AC_JACK_PORT_NONE)
-		return 0;
-
 	if (codec->vendor_id == 0x80862807)
 		intel_haswell_fixup_connect_list(codec, pin_nid);
+	else {
+		/* On Haswell, default pin config should be ignored */
+		config = snd_hda_codec_get_pincfg(codec, pin_nid);
+		if (get_defcfg_connect(config) == AC_JACK_PORT_NONE)
+			return 0;
+	}
 
 	pin_idx = spec->num_pins;
 	per_pin = snd_array_new(&spec->pins);
-- 
1.7.9.5
