From: Kirill Marinushkin <k.marinushkin@gmail.com>
Subject: [PATCH] ALSA: usb-audio: Fix parsing descriptor of
	UAC2 processing unit
Date: Mon, 19 Mar 2018 07:11:08 +0100
Message-ID: <20180319061108.24178-1-k.marinushkin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 12EB3267294
 for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2018 07:10:50 +0100 (CET)
Received: by mail-wm0-f68.google.com with SMTP id 139so13274958wmn.2
 for <alsa-devel@alsa-project.org>; Sun, 18 Mar 2018 23:10:50 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, Felipe Balbi <felipe.balbi@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kirill Marinushkin <k.marinushkin@gmail.com>
List-Id: alsa-devel@alsa-project.org

Currently, the offsets in the UAC2 processing unit descriptor are
calculated incorrectly. It causes an issue when connecting the device which
provides such a feature:

~~~~
[84126.724420] usb 1-1.3.1: invalid Processing Unit descriptor (id 18)
~~~~

After this patch is applied, the UAC2 processing unit inits w/o this error.

Fixes: 5e1ddb481776 ("UAPI: (Scripted) Disintegrate include/linux/usb")
Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Cc: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org
---
 include/uapi/linux/usb/audio.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/usb/audio.h b/include/uapi/linux/usb/audio.h
index 17a022c5b414..da3315ed1bcd 100644
--- a/include/uapi/linux/usb/audio.h
+++ b/include/uapi/linux/usb/audio.h
@@ -370,7 +370,7 @@ static inline __u8 uac_processing_unit_bControlSize(struct uac_processing_unit_d
 {
 	return (protocol == UAC_VERSION_1) ?
 		desc->baSourceID[desc->bNrInPins + 4] :
-		desc->baSourceID[desc->bNrInPins + 6];
+		2; /* in UAC2, this value is constant */
 }
 
 static inline __u8 *uac_processing_unit_bmControls(struct uac_processing_unit_descriptor *desc,
@@ -378,7 +378,7 @@ static inline __u8 *uac_processing_unit_bmControls(struct uac_processing_unit_de
 {
 	return (protocol == UAC_VERSION_1) ?
 		&desc->baSourceID[desc->bNrInPins + 5] :
-		&desc->baSourceID[desc->bNrInPins + 7];
+		&desc->baSourceID[desc->bNrInPins + 6];
 }
 
 static inline __u8 uac_processing_unit_iProcessing(struct uac_processing_unit_descriptor *desc,
-- 
2.13.6
