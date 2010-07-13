From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] Two patches for Alsa-plugins (pulse)
Date: Tue, 13 Jul 2010 13:08:39 +0800
Message-ID: <AANLkTiknkc75yGObTq5DJxsa5Wswpg7tTLDKEsEh76DE@mail.gmail.com>
References: <4C22670D.8010104@epost.diwic.se> <s5h6319dj90.wl%tiwai@suse.de>
	<4C2487EA.3090605@epost.diwic.se> <s5hzky6bgy2.wl%tiwai@suse.de>
	<s5heifcsvom.wl%tiwai@suse.de>
	<AANLkTimnfft0c_V9bTK-g8hX2ljc_IJoMliMEwcQTz5g@mail.gmail.com>
	<s5hiq4or5cz.wl%tiwai@suse.de> <4C376182.5050807@epost.diwic.se>
	<AANLkTinIl5AyMZyJNabLzdfvGRjU8A6wikmoO4edGt9v@mail.gmail.com>
	<4C381651.6060603@epost.diwic.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 52271245C9
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Jul 2010 07:08:42 +0200 (CEST)
Received: by vws9 with SMTP id 9so5315638vws.38
	for <alsa-devel@alsa-project.org>; Mon, 12 Jul 2010 22:08:40 -0700 (PDT)
In-Reply-To: <4C381651.6060603@epost.diwic.se>
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

2010/7/10 David Henningsson <launchpad.web@epost.diwic.se>

>
>
> > PA developer often complain the driver did not provide accurate playback
> > position by the pcm_pointer callback
> >
> > Did the pulse_pointer callback also provide accurate position of the
> pulse
> > device ?
>
> Yes, but it provides the pointer to the fake ring buffer (the alsa-lib
> plugin system expects that all pcm plugins are ring buffers, which seems
> to me like a design flaw).
>
>
This mean that pulse_pointer jump suddenly when PA wake up from sleep and
write audio to sound card until the ring buffer is empty, Those "0 bytes in
queue " message is the result of PA server flush the ring buffer.

Did alsa-lib regard this condition as underrun, since the application
pointer and hardware pointer of the pulse device  seem at the same point ?

Is this the reason why alsa-time-test.c fail on the pulse device ?
