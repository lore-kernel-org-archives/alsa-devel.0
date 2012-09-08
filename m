From: Daniel Mack <zonque@gmail.com>
Subject: Re: UAC2 clock selector for AudioBox 1818VSL
Date: Sat, 08 Sep 2012 14:24:13 +0200
Message-ID: <504B38ED.2070904@gmail.com>
References: <76bd1b6473c857ddd3160280e278e4fb.squirrel@master.museresearch.com>
 <50490D2D.3060207@gmail.com>
 <192dce6984143a00813e593a60c5a5f4.squirrel@master.museresearch.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030008000200050606010304"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id AF51026086D
 for <alsa-devel@alsa-project.org>; Sat,  8 Sep 2012 14:24:20 +0200 (CEST)
Received: by wgbed3 with SMTP id ed3so321339wgb.20
 for <alsa-devel@alsa-project.org>; Sat, 08 Sep 2012 05:24:20 -0700 (PDT)
In-Reply-To: <192dce6984143a00813e593a60c5a5f4.squirrel@master.museresearch.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: louis@museresearch.com
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030008000200050606010304
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 07.09.2012 19:57, louis@museresearch.com wrote:
> Hi Daniel,
>   Thanks for the quick reply. I am able to set the clock on my Mac, though
> I do need to do further tests and make sure that the sync is actually
> reliable there. The setting is available from the built-in, standard OS
> X audio setup application "Audio MIDI Setup".
> 
> There should be a S/PDIF clock signal going to the digital inputs on the
> device. Some of the other controls such as per-channel mute also appear to
> work. I've also attached the lsusb output.
> 
> There are some other details that may be relevant, but I didn't want to
> make my initial post too long/confusing because these extra details may
> end up just being a red herring: Each mixer element name (as seen in
> amixer) is prefixed with "AudioBox 1818 VSL Clock Selector" even if it is
> not a clock selector.

That strange but I believe not related. We should still fix that :)

> I am confident though that the control I've been
> playing with is the clock selector because it lists the different clock
> types as options. I also see this when I plug the device in or load the
> ALSA driver:
> 
> ALSA sound/usb/mixer.c:342 cannot get ctl value: req = 0x83, wValue =
> 0x201, wIndex = 0xa00, type = 4
> ALSA sound/usb/mixer.c:846 10:0: cannot get min/max values for control 2
> (id 10)
> ALSA sound/usb/mixer.c:342 cannot get ctl value: req = 0x83, wValue =
> 0x200, wIndex = 0xa00, type = 4
> ALSA sound/usb/mixer.c:846 10:0: cannot get min/max values for control 2
> (id 10)
> ALSA sound/usb/mixer.c:342 cannot get ctl value: req = 0x83, wValue =
> 0x201, wIndex = 0xb00, type = 4
> ALSA sound/usb/mixer.c:846 11:0: cannot get min/max values for control 2
> (id 11)
> ALSA sound/usb/mixer.c:342 cannot get ctl value: req = 0x83, wValue =
> 0x200, wIndex = 0xb00, type = 4
> ALSA sound/usb/mixer.c:846 11:0: cannot get min/max values for control 2
> (id 11)

Do you see any messages when you try to set the clock selector with amixer?

If you're running a recent kernel, try the following patch. That will
produce log messages for each mixer related control packet that is sent
out to the device.


Thanks,
Daniel




--------------030008000200050606010304
Content-Type: text/x-patch;
 name="mixer-debug.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="mixer-debug.diff"

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 4f40ba8..fce9b88 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -446,6 +446,9 @@ int snd_usb_mixer_set_ctl_value(struct usb_mixer_elem_info *cval,
 				    USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_OUT,
 				    validx, snd_usb_ctrl_intf(chip) | (cval->id << 8),
 				    buf, val_len) >= 0) {
+			snd_printk(" DEBUG: %s(): request %08x requesttype %08x, value %04x, index %04x, size %d\n",
+					__func__, request, USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_OUT,
+					validx, snd_usb_ctrl_intf(chip) | (cval->id << 8), val_len);
 			snd_usb_autosuspend(chip);
 			return 0;
 		}

--------------030008000200050606010304
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030008000200050606010304--
