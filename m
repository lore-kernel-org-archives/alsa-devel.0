From: Antonio Ospite <ao2@amarulasolutions.com>
Subject: [PATCH 4/4] ALSA: usb: uniform style used in
	MODULE_SUPPORTED_DEVICE()
Date: Fri, 21 Jun 2013 13:11:51 +0200
Message-ID: <1371813111-26661-5-git-send-email-ao2@amarulasolutions.com>
References: <1371813111-26661-1-git-send-email-ao2@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1371813111-26661-1-git-send-email-ao2@amarulasolutions.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, patch@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Antonio Ospite <ao2@amarulasolutions.com>, Clemens Ladisch <clemens@ladisch.de>, Karsten Wiese <annabellesgarden@yahoo.de>, Torsten Schenk <torsten.schenk@zoho.com>, Daniel Mack <daniel@caiaq.de>, Michael Trimarchi <michael@amarulasolutions.com>
List-Id: alsa-devel@alsa-project.org

In sound/usb/card.c and sound/usb/misc/ua101.c there are no spaces
between the vendor and the device names, use this style in the other
drivers too.

This also helps keeping consistency when new drivers copies from the
ones already in the mainline tree.

Signed-off-by: Antonio Ospite <ao2@amarulasolutions.com>
---
 sound/usb/6fire/chip.c     |  2 +-
 sound/usb/caiaq/device.c   | 28 ++++++++++++++--------------
 sound/usb/usx2y/usbusx2y.c |  2 +-
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/usb/6fire/chip.c b/sound/usb/6fire/chip.c
index 4394ae7..c39c779 100644
--- a/sound/usb/6fire/chip.c
+++ b/sound/usb/6fire/chip.c
@@ -30,7 +30,7 @@
 MODULE_AUTHOR("Torsten Schenk <torsten.schenk@zoho.com>");
 MODULE_DESCRIPTION("TerraTec DMX 6Fire USB audio driver");
 MODULE_LICENSE("GPL v2");
-MODULE_SUPPORTED_DEVICE("{{TerraTec, DMX 6Fire USB}}");
+MODULE_SUPPORTED_DEVICE("{{TerraTec,DMX 6Fire USB}}");
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX; /* Index 0-max */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR; /* Id for card */
diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
index 23cf55d..1a61dd1 100644
--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -39,20 +39,20 @@
 MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
 MODULE_DESCRIPTION("caiaq USB audio");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Native Instruments, RigKontrol2},"
-			 "{Native Instruments, RigKontrol3},"
-			 "{Native Instruments, Kore Controller},"
-			 "{Native Instruments, Kore Controller 2},"
-			 "{Native Instruments, Audio Kontrol 1},"
-			 "{Native Instruments, Audio 2 DJ},"
-			 "{Native Instruments, Audio 4 DJ},"
-			 "{Native Instruments, Audio 8 DJ},"
-			 "{Native Instruments, Traktor Audio 2},"
-			 "{Native Instruments, Session I/O},"
-			 "{Native Instruments, GuitarRig mobile},"
-			 "{Native Instruments, Traktor Kontrol X1},"
-			 "{Native Instruments, Traktor Kontrol S4},"
-			 "{Native Instruments, Maschine Controller}}");
+MODULE_SUPPORTED_DEVICE("{{Native Instruments,RigKontrol2},"
+			 "{Native Instruments,RigKontrol3},"
+			 "{Native Instruments,Kore Controller},"
+			 "{Native Instruments,Kore Controller 2},"
+			 "{Native Instruments,Audio Kontrol 1},"
+			 "{Native Instruments,Audio 2 DJ},"
+			 "{Native Instruments,Audio 4 DJ},"
+			 "{Native Instruments,Audio 8 DJ},"
+			 "{Native Instruments,Traktor Audio 2},"
+			 "{Native Instruments,Session I/O},"
+			 "{Native Instruments,GuitarRig mobile},"
+			 "{Native Instruments,Traktor Kontrol X1},"
+			 "{Native Instruments,Traktor Kontrol S4},"
+			 "{Native Instruments,Maschine Controller}}");
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX; /* Index 0-max */
 static char* id[SNDRV_CARDS] = SNDRV_DEFAULT_STR; /* Id for this card */
diff --git a/sound/usb/usx2y/usbusx2y.c b/sound/usb/usx2y/usbusx2y.c
index 9af7c1f..1f9bbd5 100644
--- a/sound/usb/usx2y/usbusx2y.c
+++ b/sound/usb/usx2y/usbusx2y.c
@@ -150,7 +150,7 @@
 MODULE_AUTHOR("Karsten Wiese <annabellesgarden@yahoo.de>");
 MODULE_DESCRIPTION("TASCAM "NAME_ALLCAPS" Version 0.8.7.2");
 MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{TASCAM(0x1604), "NAME_ALLCAPS"(0x8001)(0x8005)(0x8007) }}");
+MODULE_SUPPORTED_DEVICE("{{TASCAM(0x1604),"NAME_ALLCAPS"(0x8001)(0x8005)(0x8007)}}");
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX; /* Index 0-max */
 static char* id[SNDRV_CARDS] = SNDRV_DEFAULT_STR; /* Id for this card */
-- 
1.8.3.1
