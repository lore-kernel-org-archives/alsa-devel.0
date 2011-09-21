From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda: hdmi: Hint matching between input
 devices and pcm devices
Date: Wed, 21 Sep 2011 09:18:08 +0200
Message-ID: <4E798FB0.8040306@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010607010305070404080608"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 77AB8103A7A
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Sep 2011 09:18:11 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010607010305070404080608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Takashi,

You went on vacation when this patch was posted and discussed, but would 
you mind reviewing/committing this patch now that you're back?

It was reviewed by Stephen Warren who thought the patch was okay, but 
had some thoughts on doing other changes to the format of that string at 
the same time [1].

I had to distro patch a 3.0 adapted version of this patch into Ubuntu in 
order to meet the Ubuntu 11.10 kernel deadline, so for that reason I'd 
say that the ",pcm=x" format would be preferrable for me, and while I 
don't mind further improvements to the string format in the future, this 
would be a step in the right direction and IMO this patch should not 
block on such future improvements.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

[1] 
http://mailman.alsa-project.org/pipermail/alsa-devel/2011-August/043258.html

--------------010607010305070404080608
Content-Type: text/x-patch;
 name="0001-ALSA-hda-hdmi-Hint-matching-between-input-devices-an.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-hda-hdmi-Hint-matching-between-input-devices-an.pa";
 filename*1="tch"

>From ab5ef7898ca0a6e86401428a3ca77f05db9eb7c9 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Tue, 23 Aug 2011 16:56:03 +0200
Subject: [PATCH] ALSA: hda: hdmi: Hint matching between input devices and pcm devices

Since modern HDMI cards often have more than one output pin and thus
input device, we need to know which one has actually been plugged in.

This patch adds a name hint that indicates which PCM device is connected 
to which pin.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_hdmi.c |   31 ++++++++++++++++++++++++-------
 1 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 19cb72d..8c83ec4 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -967,19 +967,12 @@ static int hdmi_add_pin(struct hda_codec *codec, hda_nid_t pin_nid)
 
 	per_pin->pin_nid = pin_nid;
 
-	err = snd_hda_input_jack_add(codec, pin_nid,
-				     SND_JACK_VIDEOOUT, NULL);
-	if (err < 0)
-		return err;
-
 	err = hdmi_read_pin_conn(codec, pin_idx);
 	if (err < 0)
 		return err;
 
 	spec->num_pins++;
 
-	hdmi_present_sense(codec, pin_nid, eld);
-
 	return 0;
 }
 
@@ -1162,6 +1155,25 @@ static int generic_hdmi_build_pcms(struct hda_codec *codec)
 	return 0;
 }
 
+static int generic_hdmi_build_jack(struct hda_codec *codec, int pin_idx)
+{
+	int err;
+	char hdmi_str[32];
+	struct hdmi_spec *spec = codec->spec;
+	struct hdmi_spec_per_pin *per_pin = &spec->pins[pin_idx];
+	int pcmdev = spec->pcm_rec[pin_idx].device;
+
+	snprintf(hdmi_str, sizeof(hdmi_str), "HDMI/DP,pcm=%d", pcmdev);
+
+	err = snd_hda_input_jack_add(codec, per_pin->pin_nid,
+			     SND_JACK_VIDEOOUT, pcmdev > 0 ? hdmi_str : NULL);
+	if (err < 0)
+		return err;
+
+	hdmi_present_sense(codec, per_pin->pin_nid, &per_pin->sink_eld);
+	return 0;
+}
+
 static int generic_hdmi_build_controls(struct hda_codec *codec)
 {
 	struct hdmi_spec *spec = codec->spec;
@@ -1170,6 +1182,11 @@ static int generic_hdmi_build_controls(struct hda_codec *codec)
 
 	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
 		struct hdmi_spec_per_pin *per_pin = &spec->pins[pin_idx];
+
+		err = generic_hdmi_build_jack(codec, pin_idx);
+		if (err < 0)
+			return err;
+
 		err = snd_hda_create_spdif_out_ctls(codec,
 						    per_pin->pin_nid,
 						    per_pin->mux_nids[0]);
-- 
1.7.4.1


--------------010607010305070404080608
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------010607010305070404080608--
