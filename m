From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH 4/5] ALSA: hda - Implement shared front
 mic/hp jack for HP Z220
Date: Wed, 5 Dec 2012 16:20:29 +0800
Message-ID: <CAN8cciabe=sLT6d_ueQrWfSgODdSyPVS-jtOAo0Zx7e3CE_A2w@mail.gmail.com>
References: <1354202489-12769-1-git-send-email-tiwai@suse.de>
 <1354202489-12769-5-git-send-email-tiwai@suse.de>
 <CAN8ccibE0xEpOTPwLrFAJbypSnO4jdaAHRK3L=_bqHFY1ATepA@mail.gmail.com>
 <s5h8v9j4j2p.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com
 [209.85.223.179])
 by alsa0.perex.cz (Postfix) with ESMTP id AF7B8260799
 for <alsa-devel@alsa-project.org>; Wed,  5 Dec 2012 09:20:30 +0100 (CET)
Received: by mail-ie0-f179.google.com with SMTP id k14so7274639iea.38
 for <alsa-devel@alsa-project.org>; Wed, 05 Dec 2012 00:20:29 -0800 (PST)
In-Reply-To: <s5h8v9j4j2p.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> >
> > > HP Z220 with ALC221 codec has a front jack that should work as both
> > > the front mic and the secondary headphone.  This patch adds a new
> > > mixer enum to change the jack behavior.
> > >
> > > In the headphone mode, the auto-mic switching is disabled and the
> > > input is fixed to the rear line-in.
> > >
> >
> > I expect when any input jack(line in or mic) is retasked as output e.g.
> > alc_set_multi_io() the corresponding jack detection kcontrol should
change
> > to false
>
> In the current implementation, this doesn't matter because the front
> panel has no capability of multi-io.  The multi-io is enabled only
> when all jacks are located in the same place.  On the front panel,
> there are only two.
>
> But it's a thing to be considered in future if we'll need to extend
> such retasking functionalities more generically.
>
>

if mic_event change to hp_event in this case, does it mean that hp_event
should change to mic_event in Q1-ultra

http://git.kernel.org/?p=linux/kernel/git/tiwai/sound.git;a=commitdiff;h=24de183ed0369d73af89e6752fcc1ecbde59053d;hp=82e14a4754599952f5504c1f696bbc77bdfd6009
