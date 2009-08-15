From: Damien Zammit <damien.zammit@gmail.com>
Subject: Digidesign Mbox2 - usb support
Date: Sun, 16 Aug 2009 00:59:18 +1000
Message-ID: <98ec50f0908150759x14271088tfae47314f7be2157@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 745271037F9
	for <alsa-devel@alsa-project.org>;
	Sat, 15 Aug 2009 16:59:23 +0200 (CEST)
Received: by ewy23 with SMTP id 23so2198186ewy.32
	for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2009 07:59:21 -0700 (PDT)
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

I have a Digidesign Mbox2 and I am trying to write an open source alsa
driver for it.
It is a usb self powered device, and I used usbsnoop on the Windows XP
drivers to capture the initialisation of the device.
It doesn't seem to require any firmware, as I was able to playback the
init code to the device over libusb
and all the lights turned on (which hopefully means it's awaiting
further instructions to play/record).

I have written some C code which sends the init codes to the device
using raw URB, but I really need someone
who is familiar with snd-usb-audio to take a look at my lsusb output
in case it is a standard device before I waste any more time on it.

Please find the debugging output for my experimental initialisation driver here:

http://cytdesign.com/mbox2/mbox2.tar.bz2

Note: After running my init codes, all the lights appeared on the device just
as it does when you boot windows.

Please contact me at damien.zammit [at] gmail.com if you are able to
help.  I'm not up to speed with mailing lists, I would prefer an email
to my account
if you are replying to me.

Thanks,
Damien Zammit
