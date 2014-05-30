From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Bug report: [alsa-sink-USB Audio] alsa-sink.c:
 Most likely this is a bug in the ALSA driver '(null)'. Please report this
 issue to the ALSA
Date: Fri, 30 May 2014 10:15:25 +0800
Message-ID: <CAN8cciZwbNVu7LO_muaynfbudxTB8qRS0aPyxwnd28yupCxSEA@mail.gmail.com>
References: <001401cf7818$4be327c0$e3a97740$@lucidpixels.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f54.google.com (mail-qg0-f54.google.com
 [209.85.192.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 88D1E261B02
 for <alsa-devel@alsa-project.org>; Fri, 30 May 2014 04:15:27 +0200 (CEST)
Received: by mail-qg0-f54.google.com with SMTP id q108so3609659qgd.27
 for <alsa-devel@alsa-project.org>; Thu, 29 May 2014 19:15:26 -0700 (PDT)
In-Reply-To: <001401cf7818$4be327c0$e3a97740$@lucidpixels.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
>
>
> Bug report:
>

https://bugzilla.kernel.org/enter_bug.cgi?product=Drivers

You have to provide pulseaudio verbose log, output of alsa-info.sh ,  lsusb
-vvvv  and step to reproduce your problem when you report the bug

>
>
> ==> /var/log/user.log <==
>
> May 25 06:38:06 atom pulseaudio[6754]: [alsa-sink-USB Audio] alsa-sink.c:
> ALSA woke us up to write new data to the device, but there was actually
> nothing to write!
>
> May 25 06:38:06 atom pulseaudio[6754]: [alsa-sink-USB Audio] alsa-sink.c:
> Most likely this is a bug in the ALSA driver '(null)'. Please report this
> issue to the ALSA developers.

Name of alsa sink seem changed from USB-audio to null,  did you find any
unplug event if USB audio device in system log

Any error message related to USB controllers and your audio card

>
> May 25 06:38:06 atom pulseaudio[6754]: [alsa-sink-USB Audio] alsa-sink.c:
We
> were woken up with POLLOUT set -- however a subsequent snd_pcm_avail()
> returned 0 or another value < min_avail.
>
>
