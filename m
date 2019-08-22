From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ALSA: line6: Fix -Wunused-const-variable warnings
Date: Thu, 22 Aug 2019 22:57:41 +0800
Message-ID: <20190822145741.9592-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, gregkh@linuxfoundation.org, pavel@denx.de, allison@lohutok.net, tglx@linutronix.de, yuehaibing@huawei.com, pakki001@umn.edu
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

sound/usb/line6/driver.h:69:18: warning:
 SYSEX_DATA_OFS defined but not used [-Wunused-const-variable=]
sound/usb/line6/driver.h:70:18: warning:
 SYSEX_EXTRA_SIZE defined but not used [-Wunused-const-variable=]

SYSEX_EXTRA_SIZE is only used in driver.c and
SYSEX_DATA_OFS in pod.c, so move them to .c fix
this warning.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/usb/line6/driver.c | 2 ++
 sound/usb/line6/driver.h | 3 ---
 sound/usb/line6/pod.c    | 2 ++
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index b5a3f75..8027da8 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -31,6 +31,8 @@ const unsigned char line6_midi_id[3] = {
 };
 EXPORT_SYMBOL_GPL(line6_midi_id);
 
+static const int SYSEX_EXTRA_SIZE = sizeof(line6_midi_id) + 4;
+
 /*
 	Code to request version of POD, Variax interface
 	(and maybe other devices).
diff --git a/sound/usb/line6/driver.h b/sound/usb/line6/driver.h
index e5e572e..c57633a 100644
--- a/sound/usb/line6/driver.h
+++ b/sound/usb/line6/driver.h
@@ -66,9 +66,6 @@
 
 extern const unsigned char line6_midi_id[3];
 
-static const int SYSEX_DATA_OFS = sizeof(line6_midi_id) + 3;
-static const int SYSEX_EXTRA_SIZE = sizeof(line6_midi_id) + 4;
-
 /*
 	 Common properties of Line 6 devices.
 */
diff --git a/sound/usb/line6/pod.c b/sound/usb/line6/pod.c
index ee4c9d2..24ad337 100644
--- a/sound/usb/line6/pod.c
+++ b/sound/usb/line6/pod.c
@@ -110,6 +110,8 @@ enum {
 	POD_BUSY_MIDISEND
 };
 
+static const int SYSEX_DATA_OFS = sizeof(line6_midi_id) + 3;
+
 static struct snd_ratden pod_ratden = {
 	.num_min = 78125,
 	.num_max = 78125,
-- 
2.7.4
