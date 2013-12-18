From: David Henningsson <david.henningsson@canonical.com>
Subject: [RFC PATCH] ALSA: hda - Explicitly keep codec powered
	up in hdmi_present_sense
Date: Wed, 18 Dec 2013 10:46:04 +0100
Message-ID: <1387359964-3382-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id E4B64261646
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2013 10:46:05 +0100 (CET)
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

This should help us avoid the following mutex deadlock:

[] mutex_lock+0x2a/0x50
[] hdmi_present_sense+0x53/0x3a0 [snd_hda_codec_hdmi]
[] generic_hdmi_resume+0x5a/0x70 [snd_hda_codec_hdmi]
[] hda_call_codec_resume+0xec/0x1d0 [snd_hda_codec]
[] snd_hda_power_save+0x1e4/0x280 [snd_hda_codec]
[] codec_exec_verb+0x5f/0x290 [snd_hda_codec]
[] snd_hda_codec_read+0x5b/0x90 [snd_hda_codec]
[] snd_hdmi_get_eld_size+0x1e/0x20 [snd_hda_codec_hdmi]
[] snd_hdmi_get_eld+0x2c/0xd0 [snd_hda_codec_hdmi]
[] hdmi_present_sense+0x9a/0x3a0 [snd_hda_codec_hdmi]
[] hdmi_repoll_eld+0x34/0x50 [snd_hda_codec_hdmi]

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_hdmi.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

So; I came across the above stack trace when testing the latest daily HDA driver.
It only happened once, and jack polling was enabled while testing, if that matters.

As you can see, the hdmi_present_sense is called recursively, and my patch doesn't
really fix that; it should only make the consequences less severe (because now
the recursion would be in the very beginning, i e, at snd_hda_power_up).

I first thought just unlocking the mutex before calling pin_get_eld could do,
but not sure if we really want to do that. Nevertheless, I haven't done much
of the power management work anyway, so I'd like you to double check it and potentially
come up with better ideas if you have any.

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index f5060fc..977db17 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1496,11 +1496,14 @@ static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 	 * specification worked this way. Hence, we just ignore the data in
 	 * the unsolicited response to avoid custom WARs.
 	 */
-	int present = snd_hda_pin_sense(codec, pin_nid);
+	int present;
 	bool update_eld = false;
 	bool eld_changed = false;
 	bool ret;
 
+	snd_hda_power_up(codec);
+	present = snd_hda_pin_sense(codec, pin_nid);
+
 	mutex_lock(&per_pin->lock);
 	pin_eld->monitor_present = !!(present & AC_PINSENSE_PRESENCE);
 	if (pin_eld->monitor_present)
@@ -1573,6 +1576,7 @@ static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 		jack->block_report = !ret;
 
 	mutex_unlock(&per_pin->lock);
+	snd_hda_power_down(codec);
 	return ret;
 }
 
-- 
1.7.9.5
