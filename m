From: Harry van Haaren <harryhaaren@gmail.com>
Subject: Re: ALSA snd-fireworks Echo AudioFire 2
Date: Mon, 25 Aug 2014 13:09:39 +0100
Message-ID: <CAKudYbMC-jioVYJ3ViJWYuWZmPy_vbVXqgHorC7ZQFbBUXCDqQ@mail.gmail.com>
References: <CAKudYbO=FZwPHzgxwYADxdUKHOtSUzd5V7WayENkmcz__unFQA@mail.gmail.com>
 <53FAB9DA.1060202@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f182.google.com (mail-lb0-f182.google.com
 [209.85.217.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 67965265007
 for <alsa-devel@alsa-project.org>; Mon, 25 Aug 2014 14:09:40 +0200 (CEST)
Received: by mail-lb0-f182.google.com with SMTP id z11so11799237lbi.41
 for <alsa-devel@alsa-project.org>; Mon, 25 Aug 2014 05:09:39 -0700 (PDT)
In-Reply-To: <53FAB9DA.1060202@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 25, 2014 at 5:21 AM, Takashi Sakamoto
<o-takashi@sakamocchi.jp> wrote:
> (C.C.ed to alsa-devel and Clemens)
Thanks!

> I know that some Fireworks devices with a certain firmware (not exactly
> identified) sometimes perform the same behaviour. Could I ask you to
> confirm to see these logs always when you playback, or sometimes?

Its consistent: every time it is opened for playback.

To test / debug some more, I've tried starting JACK on the device
using ALSA, hw:AudioFire2, duplex, -p256 -n2. QJackCtl reports a
stream of xruns: are these the discontinuities similar to the dmesg
prints?

I'll try upgrading the firmware on the device (I don't know what
version is currently on it).
OK: after a flash (using a windows machine), the ASIO driver there now
reports the following (latest from Echo) firmware versions:

WDM driver 5.8
ASIO driver 5.8
Console 5.8.1
ARM firmware 5.8
FPGA 3.0.2

Just tried using it, the same type of dmesg discontinuities unfortunately:
[  190.433203] snd-fireworks fw1.0: Detect discontinuity of CIP: 00 0A
[  190.591959] snd-fireworks fw1.0: Detect discontinuity of CIP: 00 02
[  190.749202] snd-fireworks fw1.0: Detect discontinuity of CIP: 00 12
[  190.908270] snd-fireworks fw1.0: Detect discontinuity of CIP: 00 12
[  191.066267] snd-fireworks fw1.0: Detect discontinuity of CIP: 00 0A
[  191.225139] snd-fireworks fw1.0: Detect discontinuity of CIP: 00 02
[  191.383942] snd-fireworks fw1.0: Detect discontinuity of CIP: 00 02

JACK also reports xruns, same as before: flashing the firmware to the
latest doesn't seem to have changed anything. The firmware of this
device was at 5.7 before the flash, perhaps its "too new" for
snd-fireworks in its current state?

> # Currently I'm working for moving to my new flat.
> # So during a few weeks, I may not reply as you expected, sorry.
Good luck with the new place!

I'm new to snd kernel module development, so I'm not sure what the next step is:
Guidance and help appreciated, -Harry
