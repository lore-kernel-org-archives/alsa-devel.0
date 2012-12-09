From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: ALSA sound/usb/mixer.c:415 cannot get current
 value for control 2 ch 1: err = -22
Date: Sun, 9 Dec 2012 12:03:37 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1212091139000.12715@xoschi>
References: <CAN+NVkUjFR7bchQACU4jG5tH9zHhn8w+5aRnmSNG4G3HesFo_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id C942526171A
 for <alsa-devel@alsa-project.org>; Sun,  9 Dec 2012 12:03:40 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id ik5so684619bkc.38
 for <alsa-devel@alsa-project.org>; Sun, 09 Dec 2012 03:03:40 -0800 (PST)
In-Reply-To: <CAN+NVkUjFR7bchQACU4jG5tH9zHhn8w+5aRnmSNG4G3HesFo_A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Joe Cooper <swelljoe@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Thu, 6 Dec 2012, Joe Cooper wrote:
> On most HP Envy laptops the snd-usb-audio module causes the system to
> become unresponsive and Gnome Shell 3 to crash. This effects every kernel
> I've tried from 3.3.4 on up to 3.7rc8. It also produces these errors on the
> console:
> 
> ALSA sound/usb/mixer.c:415 cannot get current value for control 2 ch 1: err
> = -22
> 
> ALSA sound/usb/clock.c:228 3:1:1: cannot set freq 44100 to ep 0x1
> 
> Blacklisting this module allows the system to function, but with most of
> its speakers not working. It also prevents use of other USB audio devices,
> making multitrack recording impossible.
> 
> I have a ticket about it in the Fedora bug tracker, but was referred to
> alsa-devel. That ticket links to other discussions of this bug, as well.
> Here's that ticket: https://bugzilla.redhat.com/show_bug.cgi?id=884368
> 
> alsa-info is here: https://bugzilla.redhat.com/attachment.cgi?id=658989
> 
> Please let me know if you need further details, or if there's anything else
> I can do to help troubleshoot this.

Hi Joe,

I can try to help.

Do you get any sound output at all (even if it stutters or sounds 
wrong)?

Can you please send the output of "lsusb -v -d 0424:b832"?
I think I can work out a patch for you to skip this device, so 
you can use other audio usb devices until this gets proper support.

Cheers,
Eldad
