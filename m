From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Front speakers doesn't work in multichannel output,
 regression in ALC888
Date: Thu, 7 May 2015 02:23:57 +0800
Message-ID: <CAN8cciYOSYZ-diTWTrtp-q21RqWsMDWPKeAA-WtGjeitG=t7nw@mail.gmail.com>
References: <2927807.UsnFnTlWVL@luklap.workgroup>
 <7993879.9dprRWFvNQ@luklap.workgroup>
 <CAN8ccibMjud9MAbXhS=QxPTosYZOQjQLq-Zt1qSiJ9DF6BkLJQ@mail.gmail.com>
 <29807127.PULdKhJLmi@luklap.workgroup>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f171.google.com (mail-ob0-f171.google.com
 [209.85.214.171])
 by alsa0.perex.cz (Postfix) with ESMTP id A23E1260631
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2015 20:23:58 +0200 (CEST)
Received: by obblk2 with SMTP id lk2so13735432obb.0
 for <alsa-devel@alsa-project.org>; Wed, 06 May 2015 11:23:57 -0700 (PDT)
In-Reply-To: <29807127.PULdKhJLmi@luklap.workgroup>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?xYF1a2FzeiBXb2puacWCb3dpY3o=?= <lukasz.wojnilowicz@gmail.com>, tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

>
> > > > > My problem is that when I set channel output to "Analog output
> >
> > surround
> >
> > > > > 5.1"
> > > > > (or 2.1 or 4.1), I hear no sound in front speakers, but in case of
> >
> > 5.1 or
> >
> > > > > 4.1
> >
> > You need pulseaudio lfe-filter for 2.1
> >
> >
http://cgit.freedesktop.org/pulseaudio/pulseaudio/log/?qt=grep&q=lfe-filter
>
> External 5.1 and 4.1 worked fine without lfe-filter. Fedora doesn't
package lfe-
> filter and I'm more interested to get my 5.1 configuration back.
>
> > do you mean surround21 need 6 channel instead of channels with 5.1
internal
> > /external speaker ?
> >
> >
http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=48f1b308cc66152eb
> > 6db66742dd0d08d888cda8d;hp=5c4cd46810cef8850b037fca9e38ffd43b0bff22
>
> No. When in KDE channel output is set to 2.1 it makes no difference what
is set
> in alsamixer. When my external speakers are disconnected built-in front
left
> and front right works on my laptop, but built-in subwoofer doesn't work
There
> is no difference what channel output is set in alsamixer.
>
> My laptop has built-in front left, front right, rear left, rear right and
> subwoofer and something is strange.
> When I set channel output to 5.1 or 4.1 and external speakers are
> disconnected, then front left and front right work as expected but
built-in
> subwoofer is heard only if I test rear left channel (wrong channel
mapping?)

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/hda_codec.c?id=cd4035e814b04c009ece9939396d06370c53ed44

Seem only two pairs of stereo speakers and internal subwoofer at left
channel before this patch

ALSA: hda - Enable surround speakers (when line out is also present)
