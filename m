From: Pete Leigh <pete.leigh@gmail.com>
Subject: Re: Fwd: Support for Roland VG-99 (working code,
 but could use help)
Date: Sat, 20 Oct 2012 03:21:42 +0100
Message-ID: <CABn3OEHzKfq-asnXRMRs8GgRosis4fSzdrExBW8mHJk9eKBqqA@mail.gmail.com>
References: <CABn3OEFatrnhGs1xzpmOfXSxpSLuGwgRtN8v=1B96i6=7_9vTg@mail.gmail.com>
 <CABn3OEHRK7TLp+J_pZjMoFts4bZ=-FquQX0WKCzUcaaMZ8Nrpg@mail.gmail.com>
 <507D0F6D.1000102@gmail.com>
 <CABn3OEF1L7hqVAcjs5E5NveA741HPVd4a9eq0w9sS77PYg+2hQ@mail.gmail.com>
 <507D1C77.5080302@gmail.com>
 <CABn3OEHxhguP6E56DUjfPAgxyaSXOHrRSd7jEdsax3e16Zm3Nw@mail.gmail.com>
 <50810512.2040909@gmail.com>
 <CABn3OEECLmo3LXQ7Zg+HVk4HBO54NgLZgxwV11-7rjQYu8BHQQ@mail.gmail.com>
 <50810E4E.2020108@gmail.com>
 <CABn3OEF18-Q3agOZ3Er5BODDo2R=H-G4Njdua-1L_E1uXHqpMw@mail.gmail.com>
 <CABn3OEH4n5i_UNMQSVM9a+gUBD5mXH=faeazu038Kdy_p9G+AQ@mail.gmail.com>
 <508191DF.2060802@gmail.com>
 <CABn3OEF8HHCp2Z-gDV1smYdTpijO_Fty5H-RjfVCtqVQQQPfUA@mail.gmail.com>
 <CABn3OEG=u+iDeVqkar-Dg3rYWnY7b6UgHKJuyRpFgMXqMe_LoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ia0-f179.google.com (mail-ia0-f179.google.com
 [209.85.210.179])
 by alsa0.perex.cz (Postfix) with ESMTP id B39A2262637
 for <alsa-devel@alsa-project.org>; Sat, 20 Oct 2012 04:21:43 +0200 (CEST)
Received: by mail-ia0-f179.google.com with SMTP id k25so730773iah.38
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 19:21:42 -0700 (PDT)
In-Reply-To: <CABn3OEG=u+iDeVqkar-Dg3rYWnY7b6UgHKJuyRpFgMXqMe_LoQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 19 October 2012 23:24, Pete Leigh <pete.leigh@gmail.com> wrote:

> If I take the working config, and disable CONFIG_USB_EHCI_TT_NEWSCHED,
> recompile, make install, reboot, then I get the familiar  "cannot
> submit urb 0, error -28: not enough bandwidth" error, and trying to
> record off the UA-25 in audacity freezes audacity. If I then re-enable
> it, recompile, make install, reboot, then I don't see the error, and
> recording off the UA-25 works normally in audacity.

Just a bit more info on how this is happening in ehci-sched.c (with
the ...NEWSCHED config unset),

It is hitting the Q_TYPE_QH case in tt_no_collision().

In there, (mask & uf_mask) evaluates to true, and thus 0 is returned
to sitd_slot_ok() which in turn returns 0 to iso_stream_schedule().

It goes around this loop 3 times before giving the -ENOSPC error in
iso_stream_schedule().

I'm seeing this from some debug printks I inserted:

[   52.135325] knowsnogap: mask was: 1124206081, uf_mask is: 61444,
mask is now: 1128465927
[   52.135328] returning 0 in tt_no_collision (4) frame: 0,
ehci->periodic_size 1024,  period 1
[   52.135329] returning 0 in sitd slot ok
[   52.135330] knowsnogap: mask was: 1124206081, uf_mask is: 30722,
mask is now: 1128465927
[   52.135330] returning 0 in tt_no_collision (4) frame: 0,
ehci->periodic_size 1024,  period 1
[   52.135331] returning 0 in sitd slot ok
[   52.135331] knowsnogap: mask was: 1124206081, uf_mask is: 15361,
mask is now: 1128465927
[   52.135332] returning 0 in tt_no_collision (4) frame: 0,
ehci->periodic_size 1024,  period 1
[   52.135333] returning 0 in sitd slot ok
[   52.135334] no room: iso resched full ffff8802158b3300 (now 899 max 9091)
[   52.135336] ALSA sound/usb/endpoint.c:877 cannot submit urb 0,
error -28: not enough bandwidth

The "knowsnogap" message  is from just before the break; in the
Q_TYPE_QH case, showing the value of uf_mask and mask before and after
 "mask |= mask >> 8" is done

(I would have put these in hex.. I thought they'd be small! :)

the "returning 0 in tt_no_collision" are printed just before the
return 0, showing the values at that time.

Hope this is somehow useful..

Cheers,

- Pete.
