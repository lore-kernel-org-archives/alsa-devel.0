From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Intel HDA / ALC662 analog surround problem
Date: Tue, 24 Feb 2015 12:46:34 +0800
Message-ID: <CAN8cciafikMAomrDsPaPqKnPtdgOm3xwbzUAmes9-N=jV9Jdiw@mail.gmail.com>
References: <CAN8ccibQh643hZ+owuNVj86ic2H55NOz5huwWhQVJu7fa1h=MQ@mail.gmail.com>
 <54eb7f49.4a51f1ff.bm000@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f54.google.com (mail-oi0-f54.google.com
 [209.85.218.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 341A52604A7
 for <alsa-devel@alsa-project.org>; Tue, 24 Feb 2015 05:46:36 +0100 (CET)
Received: by mail-oi0-f54.google.com with SMTP id v63so17395412oia.13
 for <alsa-devel@alsa-project.org>; Mon, 23 Feb 2015 20:46:35 -0800 (PST)
In-Reply-To: <54eb7f49.4a51f1ff.bm000@wupperonline.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> >> 1) Does 5.1 analog surround work for the ALC662? If yes, how?
>
> >
https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/plain/Documentation/sound/alsa/HD-Audio-Controls.txt
> > Channel Mode
> >   [...]
>
> I know this document and while I do have the auto-mute control a channel
> control is missing.
>
> So, is the ALC662 supposed to have a channel control? (Maybe I'm missing a
> kernel configuration for it, or what else could affect it?)

You have to post the output of alsa-info.sh

The channel mode should be automatically added for those desktop with three
audio jacks (green line out, blue line in and pink mic) at rear panel

http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/plain/Documentation/sound/alsa/HD-Audio.txt

either your computer BIOS does not set the correct pin default or it can be
disabled by hint

- multi_io (bool): try probing multi-I/O config (e.g. shared
  line-in/surround, mic/clfe jacks)

>
> > Do "pcm playback volume" affect the volume after you change channel mode
> > from 2ch to 6 ch so that mic and line in jacks are retasked as output ?
>
> I can't answer, because of the lack of channel mode.
>
> Any further help is appreciated.
>
>
