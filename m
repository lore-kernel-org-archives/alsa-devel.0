From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Which project to choose?
Date: Thu, 15 Jul 2010 08:52:24 +0800
Message-ID: <AANLkTimSn2SFOR3L8stLV1TTVRzrGnFU3BoYIMnNgffD@mail.gmail.com>
References: <1279062131.24837.22.camel@localhost.localdomain>
	<AANLkTildhplqQxzk7mBMc5IW_3bwAVDDrRe5UDpJXIS6@mail.gmail.com>
	<4C3DD271.6040003@epost.diwic.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 776A91038C5
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Jul 2010 02:52:26 +0200 (CEST)
Received: by vws9 with SMTP id 9so455786vws.38
	for <alsa-devel@alsa-project.org>; Wed, 14 Jul 2010 17:52:24 -0700 (PDT)
In-Reply-To: <4C3DD271.6040003@epost.diwic.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/7/14 David Henningsson <launchpad.web@epost.diwic.se>

> 2010-07-14 13:13, Raymond Yau skrev:
>
> > localhost pulseaudio[24553]: alsa-util.c:   appl_ptr     : 735801008
> > localhost pulseaudio[24553]: alsa-util.c:   hw_ptr       : 735846184
> >
> > This is underrun as you can see appl_ptr is behing hw_ptr
>
> Ehm, isn't that a ring buffer? I e, there is nothing wrong with appl_ptr
> being less than hw_ptr.
>

I think Jaroslav Kysela had already explained to you that this is an
underrun

The ring buffer size is only 4408 , appl_ptr is 45176 frames behind hw_ptr
and you can deduce the underrun occur for more than 1 second (45176/44100)

>> pulseaudio[24553]: alsa-util.c: snd_pcm_delay() returned a value that is
exceptionally large: -161920 bytes (-917 ms).



localhost pulseaudio[24553]: alsa-util.c:   buffer_size  : 4408
localhost pulseaudio[24553]: alsa-util.c:   period_size  : 1102
localhost pulseaudio[24553]: alsa-util.c:   period_time  : 24988

...

localhost pulseaudio[24553]: alsa-util.c:   start_threshold  : -1
localhost pulseaudio[24553]: alsa-util.c:   stop_threshold   :
1155530752



> > However PA server had disabled the underrun detection.
>
> Please clarify. If you're talking about my patch (disable underruns in
> alsa-plugins) here, it has nothing to do with this situation (PA
> complaining about its back-end).
>
>
This seem has no relationship to your patch which only ignore the client
side underrun

The PA server has already disabled underrun detection ( no-XRUN check mode )

http://thread.gmane.org/gmane.linux.alsa.devel/60371/focus=60531

It is the responsibility of PA server to ensure underrun/overrun would not
occur on the sound driver if it disabled underrun  detection
