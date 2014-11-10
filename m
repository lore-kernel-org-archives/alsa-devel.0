From: Damien Zammit <damien.zammit@gmail.com>
Subject: [PATCH 1/3 v4] ALSA: usb-audio: Move mutex define to
	more general location
Date: Mon, 10 Nov 2014 20:40:35 +1100
Message-ID: <1415612437-5557-2-git-send-email-damien@zamaudio.com>
References: <1415612437-5557-1-git-send-email-damien@zamaudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f174.google.com (mail-pd0-f174.google.com
 [209.85.192.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 01FB7260586
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 10:40:59 +0100 (CET)
Received: by mail-pd0-f174.google.com with SMTP id p10so7446623pdj.5
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 01:40:57 -0800 (PST)
In-Reply-To: <1415612437-5557-1-git-send-email-damien@zamaudio.com>
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
Cc: tiwai@suse.de, Damien Zammit <damien@zamaudio.com>, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Allow quirks to lock/unlock the usb audio register mutex by moving
its definition to usbaudio.h

Signed-off-by: Damien Zammit <damien@zamaudio.com>
---
 sound/usb/card.c     | 1 -
 sound/usb/usbaudio.h | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 1fab977..d71025b 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -106,7 +106,6 @@ MODULE_PARM_DESC(autoclock, "Enable auto-clock selection for UAC2 devices (defau
  * the all interfaces on the same card as one sound device.
  */
 
-static DEFINE_MUTEX(register_mutex);
 static struct snd_usb_audio *usb_chip[SNDRV_CARDS];
 static struct usb_driver usb_audio_driver;
 
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 91d0380..229978f 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -115,4 +115,6 @@ struct snd_usb_audio_quirk {
 #define combine_triple(s)  (combine_word(s) | ((unsigned int)(s)[2] << 16))
 #define combine_quad(s)    (combine_triple(s) | ((unsigned int)(s)[3] << 24))
 
+static DEFINE_MUTEX(register_mutex);
+
 #endif /* __USBAUDIO_H */
-- 
1.9.1
