From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] ALSA: hda - Don't be too specific for
 conflicting boost ctl names
Date: Fri, 20 Dec 2013 21:36:30 +0800
Message-ID: <CAN8cciZ2hX5VJ2D4LpwZBbw4HoQdUXhsCbSVNdAUeFy-AscL0A@mail.gmail.com>
References: <1387388362-1005-1-git-send-email-tiwai@suse.de>
 <52B28583.3050909@canonical.com> <s5h1u19t7d0.wl%tiwai@suse.de>
 <52B2DC85.4020901@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f174.google.com (mail-ie0-f174.google.com
 [209.85.223.174])
 by alsa0.perex.cz (Postfix) with ESMTP id C3DAB265AB0
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 14:36:32 +0100 (CET)
Received: by mail-ie0-f174.google.com with SMTP id at1so3040650iec.33
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 05:36:31 -0800 (PST)
In-Reply-To: <52B2DC85.4020901@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>>> When a boost control influences on multiple input paths, we shouldn't
> >>> pick up the name string specific to one input but rather choose a more
> >>> generic name.  A problem seen often is that a single mic boost
> >>> controls both internal and external mics although the driver picks up
> >>> the very first name randomly like "Internal Mic Boost".  This should
> >>> have been "Mic Boost", instead.
> >>>
> >>> This patch tries to correct that behavior: when a boost control is
> >>> available, check whether it conflicts with other inputs.  If it does,
> >>> use a common string ("Mic", "Line") as long as possible, or take a
> >>> generic name "Input".
> >>
> >> Hrm. I thought today "Mic Boost" is quite common, and meaning the mic
> >> boost of the non-internal mic. So I agree there is a problem - and thank
> >> you for trying to fix it - but isn't this just changing one problem for
> >> another? Now we don't know if a "Mic Boost" control controls the
> >> internal mic or not.
> >
> > That's true, and the problem isn't new...
> > I'm fine to use a different name as a boost control used for multiple
> > mics, though.  Spell your wish.
>
> If *all* inputs go through the boost, then just preferring "Capture
> Boost" or "Input Boost" over "Mic Boost" would do the trick. I e, just
> skip the logic that checks for all inputs being of the same type.
>

not all inputs go through the boost,

only two mic share boost but line in, CD, aux, stereo mix don't

1)rear mic and front mic of desktop

https://bugzilla.kernel.org/show_bug.cgi?id=66621

2)internal mic and external mic of notebook

https://bugzilla.kernel.org/show_bug.cgi?id=64971





>> should "Boost Volume" change to "Boost Capture Volume" if loopback path
not exist ?


> If the loopback doesn't even exist, why to bother?

mic boost appear in both playback view and capture view of alsamixer


https://bugzilla.redhat.com/show_bug.cgi?id=1002831

CX20585 does not has any analog mixer for loopback mixing (no mic playback
volume)
the capabilties of "mic boost" should be cvolume instead of volume

Simple mixer control 'Mic Boost',0
Capabilities: volume
Playback channels: Front Left - Front Right
Capture channels: Front Left - Front Right
Limits: 0 - 4 Front Left: 0 [0%] [0.00dB]
Front Right: 0 [0%] [0.00dB]
