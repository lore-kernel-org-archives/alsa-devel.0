From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Intel HDA / ALC662 analog surround problem
Date: Thu, 26 Feb 2015 18:01:35 +0800
Message-ID: <CAN8cciao0wPsar7NzzY3Hrhr31zFXe_p=p2JA888aAiBH5+RbQ@mail.gmail.com>
References: <CAN8ccibytwovDrBNMtNX6aXW5pOW+5TgPGc4kb6m3ZdbwydHCw@mail.gmail.com>
 <54eee8cd.401a56f7.bm000@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f48.google.com (mail-oi0-f48.google.com
 [209.85.218.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 87D9326147E
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 11:01:36 +0100 (CET)
Received: by mail-oi0-f48.google.com with SMTP id a3so8314894oib.7
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 02:01:35 -0800 (PST)
In-Reply-To: <54eee8cd.401a56f7.bm000@wupperonline.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?SW5nbyBCcsO8Y2ts?= <ib@wupperonline.de>
Cc: tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> >> > You have to post the output of alsa-info.sh
> >>
> >> Please see the attached file.
>
> > [    0.655493] sound hdaudioC1D0: autoconfig: line_outs=1
(0x14/0x0/0x0/0x0/0x0) type:line
> > [    0.655494] sound hdaudioC1D0:    speaker_outs=1
(0x15/0x0/0x0/0x0/0x0)
> > [    0.655495] sound hdaudioC1D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
> > [    0.655496] sound hdaudioC1D0:    mono: mono_out=0x0
> > [    0.655496] sound hdaudioC1D0:    dig-out=0x1e/0x0
> > [    0.655497] sound hdaudioC1D0:    inputs:
> > [    0.655498] sound hdaudioC1D0:      Front Mic=0x19
> > [    0.655499] sound hdaudioC1D0:      Rear Mic=0x18
> > [    0.655499] sound hdaudioC1D0:      Line=0x1a
>
> > This is a known bug of hda_generic.c for those desktop with internal
> > speaker and three audio jacks at rear panel (e.g. those lenovo
thinkcenter
> > with alc66x codec)
>
> > The driver prefer to assign volume control/dac to headphone, line out
and
> > internal speaker instead of line out and the other two multi io jacks
>
> > The workaround is to change the internal speaker as not connected node
> > 0x15
>
> Could you please advise how to do this? Is it possible from userland or
do I
> have to patch something?

http://git.alsa-project.org/?p=alsa-tools.git;a=blob;f=hdajackretask/README;hb=HEAD

>
> Would a new fixup mode definition for the kernel help and if yes, how
should
> it look like, i.e. which pins should be listed? (I'm capable of
submitting a
> kernel patch.)
>
> > or
>
> > You need to increase badness of multi io so that driver select multi io
as
> > the best config
>
> I've found your patch from 2013 while googling for the topic. The current
> kernel already sets BAD_MULTI_IO = 0x120.
>
> Do you mean to further increase it? If so, to what value, or is increasing
> possible from userland?
>

You need to increase BAD_MULTI_IO from 0x120 to 0x4120 since BAD_NO_DAC =
0x4000 for the driver to select config with mio=1

The driver seem to avoid the playback volume control shared by internal
speaker, headphone and line out, this may mean that you need a suitable
name for this volume control
