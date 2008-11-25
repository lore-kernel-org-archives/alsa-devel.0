From: Qinghuang Feng <qhfeng.kernel@gmail.com>
Subject: [PATCH 1/2] sound/pci/hda/hda_codec.c: cleanup kernel-doc
Date: Tue, 25 Nov 2008 23:24:49 +0800
Message-ID: <492c18c6.011e6e0a.0d83.7b0b@mx.google.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753932AbYKYPZT@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>, Randy Dunlap <rdunlap@xenotime.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

There is no argument named @state in snd_hda_resume,
remove its' comment.

Signed-off-by: Qinghuang Feng <qhfeng.kernel@gmail.com>
---
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index ba1ab73..979f34a 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -3109,7 +3109,6 @@ int snd_hda_suspend(struct hda_bus *bus, pm_message_t state)
 /**
  * snd_hda_resume - resume the codecs
  * @bus: the HDA bus
- * @state: resume state
  *
  * Returns 0 if successful.
  *
