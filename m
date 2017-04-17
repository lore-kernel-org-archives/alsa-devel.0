From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH v4 6/6] sound: replace /proc/bus/usb by /dev/bus/usb
Date: Sun, 16 Apr 2017 21:51:11 -0300
Message-ID: <d85036cb07d0eca7606616a93b5f68a5261d2b57.1492389736.git.mchehab@s-opensource.com>
References: <cover.1492389736.git.mchehab@s-opensource.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <cover.1492389736.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1492389736.git.mchehab@s-opensource.com>
References: <cover.1492389736.git.mchehab@s-opensource.com>
Sender: linux-doc-owner@vger.kernel.org
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Mauro Carvalho Chehab <mchehab@infradead.org>, Jonathan Corbet <corbet@lwn.net>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Ross Zwisler <ross.zwisler@linux.intel.com>, Dave Jiang <dave.jiang@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The /proc/bus/usb devices don't exist anymore, since when we
got rid of usbfs. Those devices are now seen at
/dev/bus/usb.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 sound/usb/usx2y/us122l.c        | 2 +-
 sound/usb/usx2y/usX2Yhwdep.c    | 2 +-
 sound/usb/usx2y/usx2yhwdeppcm.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/usb/usx2y/us122l.c b/sound/usb/usx2y/us122l.c
index cf45bf1f7ee0..e118bdca983d 100644
--- a/sound/usb/usx2y/us122l.c
+++ b/sound/usb/usx2y/us122l.c
@@ -472,7 +472,7 @@ static int usb_stream_hwdep_new(struct snd_card *card)
 	hw->ops.mmap = usb_stream_hwdep_mmap;
 	hw->ops.poll = usb_stream_hwdep_poll;
 
-	sprintf(hw->name, "/proc/bus/usb/%03d/%03d/hwdeppcm",
+	sprintf(hw->name, "/dev/bus/usb/%03d/%03d/hwdeppcm",
 		dev->bus->busnum, dev->devnum);
 	return 0;
 }
diff --git a/sound/usb/usx2y/usX2Yhwdep.c b/sound/usb/usx2y/usX2Yhwdep.c
index 605e1047c01d..f4b3cda412fc 100644
--- a/sound/usb/usx2y/usX2Yhwdep.c
+++ b/sound/usb/usx2y/usX2Yhwdep.c
@@ -258,7 +258,7 @@ int usX2Y_hwdep_new(struct snd_card *card, struct usb_device* device)
 	hw->ops.mmap = snd_us428ctls_mmap;
 	hw->ops.poll = snd_us428ctls_poll;
 	hw->exclusive = 1;
-	sprintf(hw->name, "/proc/bus/usb/%03d/%03d", device->bus->busnum, device->devnum);
+	sprintf(hw->name, "/dev/bus/usb/%03d/%03d", device->bus->busnum, device->devnum);
 	return 0;
 }
 
diff --git a/sound/usb/usx2y/usx2yhwdeppcm.c b/sound/usb/usx2y/usx2yhwdeppcm.c
index f95164b91152..d51c7fd7835b 100644
--- a/sound/usb/usx2y/usx2yhwdeppcm.c
+++ b/sound/usb/usx2y/usx2yhwdeppcm.c
@@ -723,7 +723,7 @@ int usX2Y_hwdep_pcm_new(struct snd_card *card)
 	hw->ops.release = snd_usX2Y_hwdep_pcm_release;
 	hw->ops.mmap = snd_usX2Y_hwdep_pcm_mmap;
 	hw->exclusive = 1;
-	sprintf(hw->name, "/proc/bus/usb/%03d/%03d/hwdeppcm", dev->bus->busnum, dev->devnum);
+	sprintf(hw->name, "/dev/bus/usb/%03d/%03d/hwdeppcm", dev->bus->busnum, dev->devnum);
 
 	err = snd_pcm_new(card, NAME_ALLCAPS" hwdep Audio", 2, 1, 1, &pcm);
 	if (err < 0) {
-- 
2.9.3

