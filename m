From: Roman Haefeli <reduzent@gmail.com>
Subject: Re: hdsp rpm support
Date: Tue, 20 Nov 2012 08:57:22 +0100
Message-ID: <1353398242.2165.1.camel@yoyo5>
References: <1326877559.24738.84.camel@yoyo4>
 <20120118102658.GA5351@linuxaudio.org>  <1349046242.2195.6.camel@yoyo5>
 <1353259841.4990.8.camel@chello084112006029.chello.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f179.google.com (mail-ea0-f179.google.com
 [209.85.215.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 096EA261603
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2012 08:57:25 +0100 (CET)
Received: by mail-ea0-f179.google.com with SMTP id i12so128380eaa.38
 for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2012 23:57:24 -0800 (PST)
In-Reply-To: <1353259841.4990.8.camel@chello084112006029.chello.at>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Karl Grill <kgrill@chello.at>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Son, 2012-11-18 at 18:30 +0100, Karl Grill wrote:
> Hi all,
> I finally got my hands on my son's RPM+cardbus, and my results were
> exactly the same as Roman's (timeout at the beginning of firmware
> upload). With a bit of experimenting (imitating the windows driver), I
> am now at stage where the firmware loads, but there are still some
> quirks (I had to bypass the iobox recognition code, and I have to eject
> the card and push it back in for it to work - well that is at least
> better than having to boot into XP and back out).

Sounds great to me.

>  I'll post a patch when
> these are fixed.

I'll happily test any patches regarding this hardware. Many thanks for
your efforts.

Roman
