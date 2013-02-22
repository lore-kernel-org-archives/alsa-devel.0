From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - hdmi: Make jacks phantom, if they're not detectable
Date: Fri, 22 Feb 2013 10:16:28 +0100
Message-ID: <1361524588-30448-1-git-send-email-david.henningsson@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: 961286@bugs.launchpad.org, superquad.vortex2@gmail.com, David Henningsson <david.henningsson@canonical.com>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Just as for analog codecs, a jack that isn't suitable for detection
(in this case, NO_PRESENCE was set) should be a phantom Jack
instead of a normal one.

Thanks to Raymond Yau for spotting.

Cc: stable@vger.kernel.org
BugLink: https://bugs.launchpad.net/bugs/961286
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=903869
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_hdmi.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 21425fb..78e1827 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1640,6 +1640,9 @@ static int generic_hdmi_build_jack(struct hda_codec *codec, int pin_idx)
 
 	if (pcmdev > 0)
 		sprintf(hdmi_str + strlen(hdmi_str), ",pcm=%d", pcmdev);
+	if (!is_jack_detectable(codec, per_pin->pin_nid))
+		strncat(hdmi_str, " Phantom",
+			sizeof(hdmi_str) - strlen(hdmi_str) - 1);
 
 	return snd_hda_jack_add_kctl(codec, per_pin->pin_nid, hdmi_str, 0);
 }
-- 
1.7.9.5
