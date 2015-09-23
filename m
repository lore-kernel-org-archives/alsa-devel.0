From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH - 1/2] HDA - Add SND_JACK_HEADSET and
	Headset jack kctl
Date: Thu, 24 Sep 2015 00:03:21 +0800
Message-ID: <CAN8cciZkDFF=r13UEWUp6vGTYObYVffQqCArX4pU-HukvO8RZg@mail.gmail.com>
References: <CAN8cciaSv0Tu_okSE-oXYd0ULrFxazfyZEcfMzTcPyyRCOfqog@mail.gmail.com>
 <s5h1tdp8e3v.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 by alsa0.perex.cz (Postfix) with ESMTP id CE594260423
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2015 18:03:23 +0200 (CEST)
Received: by obbda8 with SMTP id da8so37048978obb.1
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2015 09:03:21 -0700 (PDT)
In-Reply-To: <s5h1tdp8e3v.wl-tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, arthurborsboom@gmail.com
List-Id: alsa-devel@alsa-project.org

> >
> > >From b3ed187912eccf922000aee09c04f9546b068925 Mon Sep 17 00:00:00 2001
>
> Please avoid unnecessary From line.  You should try using
> git-sendemail directly.
>
> > From: Raymond Yau <superquad.vortex2@gmail.com>
> > Date: Sun, 20 Sep 2015 22:10:18 +0800
> > Subject: [PATCH -  1/2] HDA - Add SND_JACK_HEADSET and Headset jack kctl
> >
> > add headset jack kctl for alsa jack type SND_JACK_HEADSET
> >
> > skip creation of Headset Mic Phantom Jack
> >
> > use Headset Playback Volume and Headset Playback Switch
> >
> > allow auto mic selection by using HP pin for jack sense
>
> The most important piece of information is missing: *why* this change
> is needed.  I can guess, but it has to be clarified to all readers.
> At best, give the background information why the current code doesn't
> work for some cases and how your change will help.
>
> Some more comments below:

Please ignore this patch as pulseaudio pa_alsa_jack contain only one
pa_alsa_path which mean pulseaudio does not support SND_JACK_HEADSET which
has input and output path

Although the implementation is much simpler than v2 , but pulseaudio does
not support a single headset jack which represent headphone and microphone
