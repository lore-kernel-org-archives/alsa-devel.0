From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 1/1] SND/PCI/HDA: add __init to
	snd_hda_add_codec_preset
Date: Mon,  9 Jun 2014 16:23:32 +0200
Message-ID: <1402323812-1225-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay009.isp.belgacom.be (mailrelay009.isp.belgacom.be
 [195.238.6.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C09B264F1A
 for <alsa-devel@alsa-project.org>; Mon,  9 Jun 2014 16:24:56 +0200 (CEST)
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
Cc: Fabian Frederick <fabf@skynet.be>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

snd_hda_add_codec_preset is only called by __init functions:

__init patch_via_init
__init patch_sigmatel_init
__init patch_si3054_init
__init patch_realtek_init
__init patch_hdmi_init
__init patch_conexant_init
__init patch_cmedia_init
__init patch_cirrus_init
__init patch_ca0132_init
__init patch_ca0110_init
__init patch_analog_init

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 sound/pci/hda/hda_codec.c | 2 +-
 sound/pci/hda/hda_codec.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 4c20277..5770c5c 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -77,7 +77,7 @@ static struct hda_vendor_id hda_vendor_ids[] = {
 static DEFINE_MUTEX(preset_mutex);
 static LIST_HEAD(hda_preset_tables);
 
-int snd_hda_add_codec_preset(struct hda_codec_preset_list *preset)
+int __init snd_hda_add_codec_preset(struct hda_codec_preset_list *preset)
 {
 	mutex_lock(&preset_mutex);
 	list_add_tail(&preset->list, &hda_preset_tables);
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 5825aa1..02a9123 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -182,7 +182,7 @@ struct hda_codec_preset_list {
 };
 
 /* initial hook */
-int snd_hda_add_codec_preset(struct hda_codec_preset_list *preset);
+int __init snd_hda_add_codec_preset(struct hda_codec_preset_list *preset);
 int snd_hda_delete_codec_preset(struct hda_codec_preset_list *preset);
 
 /* ops set by the preset patch */
-- 
1.8.4.5
