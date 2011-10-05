From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] Add "Line In" input jack constants
Date: Wed, 05 Oct 2011 16:01:22 +0200
Message-ID: <4E8C6332.2080902@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050706010401040202030702"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B5D810380B
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Oct 2011 16:01:23 +0200 (CEST)
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
--------------050706010401040202030702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Do you think this is reasonable to apply to 3.2? If so I'll continue 
with writing some patches that use this new constant, of course.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------050706010401040202030702
Content-Type: text/x-patch;
 name="0001-Add-Line-In-input-jack-constants.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Add-Line-In-input-jack-constants.patch"

>From 356e80c4e2f5d9d1c85b5eee93d2932f7637b338 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Wed, 5 Oct 2011 15:53:25 +0200
Subject: [PATCH] Add "Line In" input jack constants

Similar to Line Out, these constants form the base for future
patches enabling input jack reporting for Line in jacks.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 include/linux/input.h     |    1 +
 include/sound/jack.h      |    1 +
 sound/core/jack.c         |    1 +
 sound/pci/hda/hda_codec.c |    2 ++
 4 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/linux/input.h b/include/linux/input.h
index a637e78..a514fb8 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -814,6 +814,7 @@ struct input_keymap_entry {
 #define SW_KEYPAD_SLIDE		0x0a  /* set = keypad slide out */
 #define SW_FRONT_PROXIMITY	0x0b  /* set = front proximity sensor active */
 #define SW_ROTATE_LOCK		0x0c  /* set = rotate locked/disabled */
+#define SW_LINEIN_INSERT	0x0d  /* set = inserted */
 #define SW_MAX			0x0f
 #define SW_CNT			(SW_MAX+1)
 
diff --git a/include/sound/jack.h b/include/sound/jack.h
index c140fc7..63c7907 100644
--- a/include/sound/jack.h
+++ b/include/sound/jack.h
@@ -42,6 +42,7 @@ enum snd_jack_types {
 	SND_JACK_MECHANICAL	= 0x0008, /* If detected separately */
 	SND_JACK_VIDEOOUT	= 0x0010,
 	SND_JACK_AVOUT		= SND_JACK_LINEOUT | SND_JACK_VIDEOOUT,
+	SND_JACK_LINEIN		= 0x0020,
 
 	/* Kept separate from switches to facilitate implementation */
 	SND_JACK_BTN_0		= 0x4000,
diff --git a/sound/core/jack.c b/sound/core/jack.c
index 53b53e9..240a3e1 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -30,6 +30,7 @@ static int jack_switch_types[] = {
 	SW_LINEOUT_INSERT,
 	SW_JACK_PHYSICAL_INSERT,
 	SW_VIDEOOUT_INSERT,
+	SW_LINEIN_INSERT,
 };
 
 static int snd_jack_dev_free(struct snd_device *device)
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index e3db196..8b046a1 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -5264,6 +5264,8 @@ static const char *get_jack_default_name(struct hda_codec *codec, hda_nid_t nid,
 		return "Mic";
 	case SND_JACK_LINEOUT:
 		return "Line-out";
+	case SND_JACK_LINEIN:
+		return "Line-in";
 	case SND_JACK_HEADSET:
 		return "Headset";
 	case SND_JACK_VIDEOOUT:
-- 
1.7.5.4


--------------050706010401040202030702
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050706010401040202030702--
