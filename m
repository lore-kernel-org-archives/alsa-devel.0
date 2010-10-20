From: Mandar Joshi <emailmandar@gmail.com>
Subject: S51 usb support
Date: Wed, 20 Oct 2010 20:30:12 +0000
Message-ID: <AANLkTin0_BibT7_+n-ipC8S8q14tfdfj7LTGqHpNweCP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B14EF1037FC
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Oct 2010 22:30:14 +0200 (CEST)
Received: by yws5 with SMTP id 5so2726268yws.38
	for <alsa-devel@alsa-project.org>; Wed, 20 Oct 2010 13:30:13 -0700 (PDT)
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

> Hmm, there is no feature unit in this dump, so the volume is most
> probably set with an vendor-specific USB request. Unless the Windows
> driver does something similar than PulseAudio and handles the volume
> level control in software (iow, modify each sample before sending it to
> the hardware) rather than setting any actual hardware volume level.

Daniel, you are right, Its the driver thing.
Feb 2009, I was dealing this the same issue and
James Courtier-Dutton from this list pointed out that the device has no
hardware based mixer controls which is why alsamixer does not find anything.
He suggested using SoftVol.

I've been using dmix and Softvol for volume control whenever I need it.
This is the ~/.asoundrc I use http://mndar.phpnet.us/usbxfi/files/asoundrc.log

The device has a volume knob. I had left the issue of the volume knob
alone until a few days back..

I was about the post this when I came across the query from Matti Picus.

This is how it works.
The volume knob sends an interrupt via endpoint 0x83 containing 0xC0
0x00 whenever it is
rotated clockwise,anti-clockwise or pressed.
After this a control message is sent to the device to retrieve which
of the 3 actions it was.
The control packet sent is 0xa1 0x85 0x00 0x00 0x00 0x00 0x04 0x00
We get a 1 byte response.
0x0F for anti-clockwise rotation. 0x0D for press and 0x10 for
clockwise rotation.

I've tested this using a simple kernel module to handle just the
volume knob and it works fine.
The quick little code I've written does the above, then sets a sysfs
attribute and sends a kobject_uevent.
Udev rules execute a command depending on the value of this sysfs
attribute. (Having some issues here but anyway...)

Since the volume is entirely a software thing, I figure this might be
a good way of letting userspace know about the volume knob.
Using softvol we can have a Master volume control and then we can use
a command like amixer in udev rules to change the volume.
Or since events are passed to HAL, something could be done there.

I do not know much about the usbaudio driver but does this seem like
something that can be done from within the usbaudio driver ?


-Mandar Joshi
