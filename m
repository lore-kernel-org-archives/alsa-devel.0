From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: Fast Track Ultra 8r...
Date: Fri, 11 Oct 2013 07:03:46 +0200
Message-ID: <CAFz=ag4OEphoDTaGG+1jm5HPTbgr0SKN_0JMbNhKm_rsiJRjcQ@mail.gmail.com>
References: <CAAsyid1UrqG=7zEL2QMz=q4NEKb6A3n8Wp5E4b3LPkr_GF3Q3g@mail.gmail.com>
 <CAFz=ag5aCshs6WJAksartBXfkUpocYEw5WknT=AStP0aFPo35g@mail.gmail.com>
 <CAAsyid35weXqn1amGKz2vEYDYBP6tHqTq1yBsWEUtCpx6iWF3A@mail.gmail.com>
 <CAFz=ag6SdfRTK_FNwWcwtUy2TPmq=nQNH8KEqMfSbbmZOi9PWw@mail.gmail.com>
 <CAAsyid18JgtFpG1pxSz6wkcZ=u7Ojej4B3ywqDWJJ7P1ijQonQ@mail.gmail.com>
 <CACckToX5rsEKJ2wadR5TepdjkfoOqNV8W9AyBwnhu3rCJ2p9zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qe0-f41.google.com (mail-qe0-f41.google.com
 [209.85.128.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 548C22619F9
 for <alsa-devel@alsa-project.org>; Fri, 11 Oct 2013 07:03:47 +0200 (CEST)
Received: by mail-qe0-f41.google.com with SMTP id x7so1642151qeu.0
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2013 22:03:46 -0700 (PDT)
In-Reply-To: <CACckToX5rsEKJ2wadR5TepdjkfoOqNV8W9AyBwnhu3rCJ2p9zQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Grant Diffey <gdiffey@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Am 11.10.2013 01:27 schrieb "Grant Diffey" <gdiffey@gmail.com>:
>
> The bigger problem imho is that snd-usb-audio doesn't preserve alsa
volumes and I still don't understand the reasoning for this.

My understanding is that storing and restoring ALSA volumes is done by
alsactl fired by some udev rule or init script in general.  If you unplug
or switch off your device it is too late to run alsactl on it so the usual
magic cannot succeed. In contrast, when you switch off your computer with
the FTU still plugged in and switched on the volumes will be preserved. At
least on my machine.
