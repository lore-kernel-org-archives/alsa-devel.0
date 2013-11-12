From: David Henningsson <david.henningsson@canonical.com>
Subject: Please backport "ALSA: hda - Move one-time init codes from generic_hdmi_init"
 to 3.4/3.5
Date: Tue, 12 Nov 2013 13:33:11 +0100
Message-ID: <52822007.1010305@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040108070204080001020302"
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, 1212160@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040108070204080001020302
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

This is a real oldie, but better late than never.

A while back, I discovered that this patch would help against a kernel
panic when "cat /proc/asound/card0/codec0" was executed on this machine,
which was running an fglrx driver.

I asked for a stable backport, but Takashi wanted testing to make sure
this was actually fixed by the patch [1]. And now, several months later,
I have this confirmation [2].

The test was conducted on an 3.5 Ubuntu kernel, based on the 3.5
extended stable tree, but would apply equally well to 3.4.

I'm attaching the backported patch - it applied cleanly, I've just added
an extra section with an explanation.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

[1]
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-March/060132.html

[2] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1212160/comments/4

--------------040108070204080001020302
Content-Type: text/x-patch;
 name="0001-ALSA-hda-Move-one-time-init-codes-from-generic_hdmi_.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-hda-Move-one-time-init-codes-from-generic_hdmi_.pa";
 filename*1="tch"

>From 76aabf83ca9c8cff2dd9e3bb5300e3778e0baf7d Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Wed, 20 Jun 2012 16:32:22 +0200
Subject: [PATCH] ALSA: hda - Move one-time init codes from
 generic_hdmi_init()

The codes to initialize work struct or create a proc interface should
be called only once and never although it's called many times through
the init callback.  Move that stuff into patch_generic_hdmi() so that
it's called only once.

Signed-off-by: Takashi Iwai <tiwai@suse.de>

(cherry picked from commit 8b8d654b55648561287bd8baca0f75f964a17038)

This is being backported to 3.4 and 3.5 due to prevention of kernel
panic. The kernel panic was observed by executing
'cat /proc/asound/card0/codec0' on a particular machine, which was
 - running in battery mode
 - having an external HDMI monitor connected
 - running the fglrx driver.

In short, the one-time init code initializes a delayed_work struct.
Then, I believe the following happened:
 1) the delayed_work was activated
 2) the delayed_work struct was reinitialized by the init code
 3) when the delayed_work timed out (ready to run the callback function),
    the kernel panic happened because the delayed_work struct had
    been corrupted in step 2.

BugLink: https://bugs.launchpad.net/bugs/1212160
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_hdmi.c |   22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 02a6e3f..ef917bf 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1282,23 +1282,34 @@ static int generic_hdmi_build_controls(struct hda_codec *codec)
 	return 0;
 }
 
-static int generic_hdmi_init(struct hda_codec *codec)
+static int generic_hdmi_init_per_pins(struct hda_codec *codec)
 {
 	struct hdmi_spec *spec = codec->spec;
 	int pin_idx;
 
 	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
 		struct hdmi_spec_per_pin *per_pin = &spec->pins[pin_idx];
-		hda_nid_t pin_nid = per_pin->pin_nid;
 		struct hdmi_eld *eld = &per_pin->sink_eld;
 
-		hdmi_init_pin(codec, pin_nid);
-		snd_hda_jack_detect_enable(codec, pin_nid, pin_nid);
-
 		per_pin->codec = codec;
 		INIT_DELAYED_WORK(&per_pin->work, hdmi_repoll_eld);
 		snd_hda_eld_proc_new(codec, eld, pin_idx);
 	}
+	return 0;
+}
+
+static int generic_hdmi_init(struct hda_codec *codec)
+{
+	struct hdmi_spec *spec = codec->spec;
+	int pin_idx;
+
+	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
+		struct hdmi_spec_per_pin *per_pin = &spec->pins[pin_idx];
+		hda_nid_t pin_nid = per_pin->pin_nid;
+
+		hdmi_init_pin(codec, pin_nid);
+		snd_hda_jack_detect_enable(codec, pin_nid, pin_nid);
+	}
 	snd_hda_jack_report_sync(codec);
 	return 0;
 }
@@ -1343,6 +1354,7 @@ static int patch_generic_hdmi(struct hda_codec *codec)
 		return -EINVAL;
 	}
 	codec->patch_ops = generic_hdmi_patch_ops;
+	generic_hdmi_init_per_pins(codec);
 
 	init_channel_allocations();
 
-- 
1.7.9.5


--------------040108070204080001020302--
