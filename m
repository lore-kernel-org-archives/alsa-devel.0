From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Intel HDA / ALC662 analog surround problem
Date: Thu, 26 Feb 2015 08:58:49 +0800
Message-ID: <CAN8ccibytwovDrBNMtNX6aXW5pOW+5TgPGc4kb6m3ZdbwydHCw@mail.gmail.com>
References: <CAN8cciafikMAomrDsPaPqKnPtdgOm3xwbzUAmes9-N=jV9Jdiw@mail.gmail.com>
 <54ee1d13.2602f650.bm000@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f182.google.com (mail-ob0-f182.google.com
 [209.85.214.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 53D6D2614D1
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 01:58:51 +0100 (CET)
Received: by mail-ob0-f182.google.com with SMTP id nt9so7669458obb.13
 for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2015 16:58:50 -0800 (PST)
In-Reply-To: <54ee1d13.2602f650.bm000@wupperonline.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?SW5nbyBCcsO8Y2ts?= <ib@wupperonline.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

>
> > You have to post the output of alsa-info.sh
>
> Please see the attached file.

   0.655493] sound hdaudioC1D0: autoconfig: line_outs=1
(0x14/0x0/0x0/0x0/0x0) type:line
[    0.655494] sound hdaudioC1D0:    speaker_outs=1 (0x15/0x0/0x0/0x0/0x0)
[    0.655495] sound hdaudioC1D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[    0.655496] sound hdaudioC1D0:    mono: mono_out=0x0
[    0.655496] sound hdaudioC1D0:    dig-out=0x1e/0x0
[    0.655497] sound hdaudioC1D0:    inputs:
[    0.655498] sound hdaudioC1D0:      Front Mic=0x19
[    0.655499] sound hdaudioC1D0:      Rear Mic=0x18
[    0.655499] sound hdaudioC1D0:      Line=0x1a

This is a known bug of hda_generic.c for those desktop with internal
speaker and three audio jacks at rear panel (e.g. those lenovo thinkcenter
with alc66x codec)

The driver prefer to assign volume control/dac to headphone, line out and
internal speaker instead of line out and the other two multi io jacks

The workaround is to change the internal speaker as not connected node 0x15

or

You need to increase badness of multi io so that driver select multi io as
the  best config

>
> > The channel mode should be automatically added for those desktop with
three
> > audio jacks (green line out, blue line in and pink mic) at rear panel
>
> Although I do have these jacks, there unfortunately isn't a channel mode.
>
> > either your computer BIOS does not set the correct pin default or it
can be
> > disabled by hint
>
> Do you really mean "disabled" or do you mean to enable them by hint?
>
> As you can see I don't have a hwC1D0/hints (and no reconfig), so I cannot
try
> setting multi_io to make the driver re-configuring itself. Would an early
> patching make sense (or maybe I missing a kernel config option for the
> hints)?
>
> If I only knew more about these "pins" (there seem to be 11, from 0x12 to
> 0x1e) I could try to add a model for the ALC66x since the existing ones
> (mario, asus-mode?, etc) don't make any differences.
>
