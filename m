From: Ben Whitten <ben.whitten@gmail.com>
Subject: Re: No sound from internal speaker on 2013 Macbook Air
 6, 1
Date: Mon, 16 Sep 2013 10:44:27 +0100
Message-ID: <CAF3==iuP_7_gQece7yNVDOGPmwFSKPF-3n4VjknmHPMtrLJygA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f174.google.com (mail-ie0-f174.google.com
 [209.85.223.174])
 by alsa0.perex.cz (Postfix) with ESMTP id BC50F261A53
 for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2013 11:44:28 +0200 (CEST)
Received: by mail-ie0-f174.google.com with SMTP id u16so6742664iet.19
 for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2013 02:44:27 -0700 (PDT)
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
List-Id: alsa-devel@alsa-project.org

> > > OK, then the normal jack detection doesn't work with this machine, as
> > > it seems.  You can try the above to all pins for checking if any of
> > > other pins reacts to the headphone jack.
> >
> > No luck I'm afraid - none of the other pins seem to react to the
> > headphones. Is there anything else you can think of that I can try
> > tomorrow?
>
> Well, it might be notified via GPIO.  Try to read GPIO pins except for
> GPIO0.  That is, set the all unmasked, the direction to READ.

We have found that jack sense comes in on the headphone pin in a windows
bootcamp install. However this bit isn't set in linux using either the
default chip, bootloader, or windows pin configs. No other GPIO's are
enabled in windows.

Ben
