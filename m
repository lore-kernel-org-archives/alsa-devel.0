From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: snd/core,
	freeing the device driver when an USB audio device is unplugged
Date: Tue, 2 Jan 2007 21:53:23 -0500
Message-ID: <9e4733910701021853qa6830b5xd0bcc0746e43a218@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.234])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3C5EC223
	for <alsa-devel@alsa-project.org>; Wed,  3 Jan 2007 03:53:24 +0100 (MET)
Received: by nz-out-0506.google.com with SMTP id l8so2048144nzf
	for <alsa-devel@alsa-project.org>; Tue, 02 Jan 2007 18:53:23 -0800 (PST)
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org, lkml <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

There is a basic problem in the way snd/core is handling the removal
of devices. If I unplug a USB audio device snd/core will end up in:
snd_card_free_when_closed. This isn't good because some desktop app
(don't know which one) keeps the sound device open until it exits.
This is not a good state to be in, the hardware is gone but the device
is still around.

Now if I plug the USB audio device back in, I get a sysfs error for
registering duplicate devices. Because snd_card_free_when_closed. is
waiting for the old device to be closed it is never freeing the sysfs
device. More looks to be messed up inside of snd/core when in this
state, but this is the obvious symptom.

Things do work properly if I restart gnome (killing whoever has the
card open) after I unplug the device and before I plug it back in
again.

I added a few printk to snd/core/init.c

-- I unplug my USB sound device
usb 2-1: USB disconnect, address 2
-- Inside sound core, I go into snd_card_free_when_closed
snd_card_free_when_closed

-- If I plug the snd device back in , the kernel will complain about a
device being registered twice. That because gnome (or something in the
desktop) is still holding the device open.

--- Now I restart gnome which closes whatever had the card open
snd_card_file_remove
snd_card_do_free
-- device finishes getting unregistered
unregistering device

using 2.6.20-rc3

-- 
Jon Smirl
jonsmirl@gmail.com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
