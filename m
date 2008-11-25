From: "Klaus Schulz" <kls.schlz@googlemail.com>
Subject: snd-usb-audio: minimum period time as module option?
Date: Tue, 25 Nov 2008 14:59:44 +0100
Message-ID: <d9690f190811250559x4510abdo82adcc0b42cce1ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.152])
	by alsa0.perex.cz (Postfix) with ESMTP id EDBC62444B
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2008 14:59:46 +0100 (CET)
Received: by yx-out-1718.google.com with SMTP id 36so1521666yxh.2
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2008 05:59:46 -0800 (PST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi there.

I wrote a small  patch which introduces an usb-audio module option called
uperiod.

Changing to lower values will improve sound quality in some cases.

Please comment.

THX
Klaus




--- alsa-driver-1.0.18a/sound/usb/usbaudio.c.orig    2008-11-21
19:19:11.000000000 +0100
+++ alsa-driver-1.0.18a/sound/usb/usbaudio.c    2008-11-24
13:40:12.000000000 +0100
@@ -72,6 +72,7 @@ static int nrpacks = 8;        /* max. number
 static int async_unlink = 1;
 static int device_setup[SNDRV_CARDS]; /* device parameter for this card*/
 static int ignore_ctl_error;
+static int uperiod = 125;

 module_param_array(index, int, NULL, 0444);
 MODULE_PARM_DESC(index, "Index value for the USB audio adapter.");
@@ -92,6 +93,8 @@ MODULE_PARM_DESC(device_setup, "Specific
 module_param(ignore_ctl_error, bool, 0444);
 MODULE_PARM_DESC(ignore_ctl_error,
          "Ignore errors from USB controller for mixer interfaces.");
+module_param(uperiod, int, 0644);
+MODULE_PARM_DESC(uperiod, "Max. size of period per URB.");

 /*
  * debug the h/w constraints
@@ -108,6 +111,8 @@ MODULE_PARM_DESC(ignore_ctl_error,
 #define MAX_URBS    8
 #define SYNC_URBS    4    /* always four urbs for sync */
 #define MIN_PACKS_URB    1    /* minimum 1 packet per urb */
+#define MAX_UPERIOD    1000
+#define MIN_UPERIOD    64

 struct audioformat {
     struct list_head list;
@@ -1919,7 +1924,7 @@ static int setup_hw_info(struct snd_pcm_
      * in the current code assume the 1ms period.
      */
     snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_PERIOD_TIME,
-                     1000 * MIN_PACKS_URB,
+                     uperiod * MIN_PACKS_URB,
                      /*(nrpacks * MAX_URBS) * 1000*/ UINT_MAX);

     err = check_hw_params_convention(subs);
@@ -3767,6 +3772,11 @@ static int __init snd_usb_audio_init(voi
         printk(KERN_WARNING "invalid nrpacks value.\n");
         return -EINVAL;
     }
+
+        if (uperiod < MIN_UPERIOD || uperiod > MAX_UPERIOD) {
+        printk(KERN_WARNING "invalid uperiod value.\n");
+        return -EINVAL;
+    }
     return usb_register(&usb_audio_driver);
 }
