From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 3/3] ALSA: hda - block HDMI jack reports while
	repolling
Date: Thu,  7 Nov 2013 13:38:25 +0100
Message-ID: <1383827905-2618-4-git-send-email-david.henningsson@canonical.com>
References: <1383827905-2618-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 3ACF4265542
 for <alsa-devel@alsa-project.org>; Thu,  7 Nov 2013 13:38:29 +0100 (CET)
In-Reply-To: <1383827905-2618-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

This fixes a race condition in case several monitors are being
repolled in parallel.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_hdmi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 497e84d..29ca8de 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1477,6 +1477,7 @@ static int hdmi_read_pin_conn(struct hda_codec *codec, int pin_idx)
 
 static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 {
+	struct hda_jack_tbl *jack;
 	struct hda_codec *codec = per_pin->codec;
 	struct hdmi_spec *spec = codec->spec;
 	struct hdmi_eld *eld = &spec->temp_eld;
@@ -1564,6 +1565,11 @@ static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 		ret = true; /* FIXME: implement fake ELD for AMD */
 	else
 		ret = !repoll || !pin_eld->monitor_present || pin_eld->eld_valid;
+
+	jack = snd_hda_jack_tbl_get(codec, pin_nid);
+	if (jack)
+		jack->block_report = !ret;
+
 	mutex_unlock(&per_pin->lock);
 	return ret;
 }
-- 
1.8.4.2
