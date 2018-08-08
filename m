From: Joseph Spencer <joespenceris@gmail.com>
Subject: Re: : Kernal+debug installed: Help with TASCAM US-122
Date: Wed, 8 Aug 2018 11:49:55 -0700
Message-ID: <CAMvaF72MJG-y-O76uZhaO4pWSBW_LY7f5GGH41wygNhLNsLQzg@mail.gmail.com>
References: <CAMvaF73QrtaSAUNFJW7Dy-=EdaaS=F+H-mECdbfvbaC8ZTqzvA@mail.gmail.com>
 <s5h4lg8u4hl.wl-tiwai@suse.de>
 <CAMvaF70_2Y5C-1J2e3ucj-zStU2NG2ehZJ02=Ztt7oicjOAEag@mail.gmail.com>
 <s5hbmachfjv.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com
 [209.85.208.173])
 by alsa0.perex.cz (Postfix) with ESMTP id E57292678C4
 for <alsa-devel@alsa-project.org>; Wed,  8 Aug 2018 20:50:07 +0200 (CEST)
Received: by mail-lj1-f173.google.com with SMTP id v9-v6so2534903ljk.4
 for <alsa-devel@alsa-project.org>; Wed, 08 Aug 2018 11:50:07 -0700 (PDT)
In-Reply-To: <s5hbmachfjv.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I'll give that a shot!

Also, I thought the following lines in journalctl were a bit odd:

first:

Aug 04 03:13:50 localhost.localdomain /lib/udev/tascam_fw[2834]: load
/usr/share/alsa/firmware/usx2yloader/us122fw.ihx for 1604/8006/100 to
/dev/bus/usb/003/002
Aug 04 03:13:50 localhost.localdomain /lib/udev/tascam_fw[2837]: load
/usr/share/alsa/firmware/usx2yloader/us122fw.ihx for 1604/8006/100 to


second:

Aug 04 03:13:52 localhost.localdomain /lib/udev/tascam_fpga[2859]: calling
/usr/bin/usx2yloader for
Aug 04 03:13:52 localhost.localdomain /lib/udev/tascam_fpga[2861]: leaving
Aug 04 03:13:52 localhost.localdomain kernel: usbcore: registered new
interface driver snd-usb-usx2y
Aug 04 03:13:52 localhost.localdomain /lib/udev/tascam_fpga[2864]: calling
/usr/bin/usx2yloader for
Aug 04 03:13:54 localhost.localdomain /lib/udev/tascam_fpga[2867]: leaving


I thought it was stranged that "to" and "for" had missing values after them.

So in the respective /lib/udev/tascam_f* scripts I added some debug
output...

In /lib/udev/tascam_fpga I added:

debug_date=$(date +%S%N)

env > "/fpga-${debug_date}.env"


In /lib/udev/tascam_fw I added:

debug_date=$(date +%S%N)
env > "/fw-${debug_date}.env"

Plugged my device in and sure enough, DEVNAME wasn't set in tascam_fw on
the 2nd run, and DEVICE is never set in tascam_fpga.

Could it be that I don't have udev configured properly?


Joe Spencer
602.777.2307


On Wed, Aug 8, 2018 at 11:35 AM Takashi Iwai <tiwai@suse.de> wrote:

> On Wed, 08 Aug 2018 18:46:13 +0200,
> Joseph Spencer wrote:
> >
> > I installed the kernal-debug package along with debug info (Linux
> > localhost.localdomain 4.17.11-200.fc28.x86_64+debug #1 SMP Mon Jul 30
> > 14:53:06 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux).
> >
> > I looked in /boot/config-4.17.11-200.fc28.x86_64+debug and I see that the
> > debug options are now enabled (attaching this file in case there are more
> > options I can enable).
> >
> > I repeated another failure.  The output in journalctl -f appears to me to
> > be about the same (see attached)
> >
> > Any pointers on what I could enable or do to debug this further?
>
> If so, then try to disable i915 KMS. e.g. boot with nomodeset option,
> and check whether the crash still happens.
>
>
> Takashi
>
