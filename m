From: Mandar Joshi <emailmandar@gmail.com>
Subject: Re: S51 usb support
Date: Fri, 22 Oct 2010 05:14:00 +0000
Message-ID: <AANLkTinLd+XqGBL6UP8_jZw+6qa6FdzfCqWq7_5m7Sc8@mail.gmail.com>
References: <AANLkTin0_BibT7_+n-ipC8S8q14tfdfj7LTGqHpNweCP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id EB6511038D1
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Oct 2010 07:14:27 +0200 (CEST)
Received: by gxk21 with SMTP id 21so351226gxk.38
	for <alsa-devel@alsa-project.org>; Thu, 21 Oct 2010 22:14:27 -0700 (PDT)
In-Reply-To: <AANLkTin0_BibT7_+n-ipC8S8q14tfdfj7LTGqHpNweCP@mail.gmail.com>
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

On Wed, Oct 20, 2010 at 8:30 PM, Mandar Joshi <emailmandar@gmail.com> wrote:

> This is how it works.
> The volume knob sends an interrupt via endpoint 0x83 containing 0xC0
> 0x00 whenever it is
> rotated clockwise,anti-clockwise or pressed.
> After this a control message is sent to the device to retrieve which
> of the 3 actions it was.
> The control packet sent is 0xa1 0x85 0x00 0x00 0x00 0x00 0x04 0x00
> We get a 1 byte response.
> 0x0F for anti-clockwise rotation. 0x0D for press and 0x10 for
> clockwise rotation.
>


Seems the functionality to handle the endpoint and retrieve the action
is already present in snd-usb-audio
Just had to add an entry specific to USB X-Fi to mixer_quirks.c
I tested this with alsa-driver 1.0.23. Compiled it with debug. You can
see the received code in /var/log/messages
0x0F for anticlockwise rotation. 0x0D for press and 0x10 for clockwise rotation

Of course since there is no hardware mixer, the volume won't change.
This received code needs to be communicated to userspace. Any Suggestions?

Here is the addition I've tested

diff -rupN alsa-driver-1.0.23.orig/alsa-kernel/usb/mixer_quirks.c
alsa-driver-1.0.23/alsa-kernel/usb/mixer_quirks.c
--- alsa-driver-1.0.23.orig/alsa-kernel/usb/mixer_quirks.c	2010-04-16
11:10:10.000000000 +0000
+++ alsa-driver-1.0.23/alsa-kernel/usb/mixer_quirks.c	2010-10-22
10:45:22.000000000 +0000
@@ -61,6 +61,7 @@ static const struct rc_config {
 	{ USB_ID(0x041e, 0x3020), 2, 1, 6, 6,  18, 0x0013 }, /* Audigy 2 NX  */
 	{ USB_ID(0x041e, 0x3040), 2, 2, 6, 6,  2,  0x6e91 }, /* Live! 24-bit */
 	{ USB_ID(0x041e, 0x3048), 2, 2, 6, 6,  2,  0x6e91 }, /* Toshiba SB0500 */
+	{ USB_ID(0x041e, 0x3042), 0, 1, 1, 1,  1,  0x000d }, /* Usb X-Fi */
 };

 static void snd_usb_soundblaster_remote_complete(struct urb *urb)
@@ -75,7 +76,7 @@ static void snd_usb_soundblaster_remote_
 	code = mixer->rc_buffer[rc->offset];
 	if (rc->length == 2)
 		code |= mixer->rc_buffer[rc->offset + 1] << 8;
-
+	snd_printd(KERN_DEBUG "remote code: %02X\n",code);
 	/* the Mute button actually changes the mixer control */
 	if (code == rc->mute_code)
 		snd_usb_mixer_notify_id(mixer, rc->mute_mixer_id);
