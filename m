From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] Alsa-plugins: Pulse: Fix snd_pcm_avail
 returning 0 in some cases
Date: Sat, 7 May 2011 11:18:29 +0800
Message-ID: <BANLkTinsLR-ejL_YBYJWjnJnsaPT08=RZw@mail.gmail.com>
References: <4DB02F8A.4040001@canonical.com>
	<BANLkTikb0uuEw9-gbbGW6Kcf0LkPHsgxdw@mail.gmail.com>
	<4DB67BD3.7090706@canonical.com> <s5hfwp5axg3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C2707103807
	for <alsa-devel@alsa-project.org>;
	Sat,  7 May 2011 05:18:29 +0200 (CEST)
Received: by fxm5 with SMTP id 5so3114662fxm.38
	for <alsa-devel@alsa-project.org>; Fri, 06 May 2011 20:18:29 -0700 (PDT)
In-Reply-To: <s5hfwp5axg3.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/4/26 Takashi Iwai <tiwai@suse.de>

> At Tue, 26 Apr 2011 10:01:23 +0200,
> David Henningsson wrote:
> >
> > On 2011-04-22 01:25, Raymond Yau wrote:
> > > 2011/4/21 David Henningsson<david.henningsson@canonical.com>
> > >
> > >> Due to a round-off error, snd_pcm_avail could in some cases
> > >> return 0 even though more data could be written to the stream.
> > >>
> > >> This was discovered by Maarten Lankhorst [1], and there is also a test
> > >> program available that triggers this error [2].
> > >>
> > >> [1]
> > >>
> https://tango.0pointer.de/pipermail/pulseaudio-discuss/2011-April/009935.html
> > >>
> > >> [2]
> > >>
> https://tango.0pointer.de/pipermail/pulseaudio-discuss/attachments/20110420/3c852d6e/attachment.c
> > >>
> > >
> > > if the test program can force under-run occur with "hw" device and
> "pulse"
> > > device with his patch in
> > >
> https://tango.0pointer.de/pipermail/pulseaudio-discuss/2011-April/009918.html
> > >
> > > Is it normal that underrun does not occur with the test program and
> your
> > > patch
> >
> > Yes; underruns are not reported to the application due to the risk of
> > the underrun being obsolete at that time. As for Maarten's patch in the
> > post you refer to,
> >
> > 1) if underruns are being reported (this is configurable), it might be a
> > good idea to call "pulse_start".
> >
> > 2) it changes underruns to being reported by default, which is what I'm
> > opposed to.
>
> Applied now.  Thanks.
>
>
> Takashi
>

With this patch and Maarten's example.c , it seem that pulse plugin return
SND_PCM_STATE_XRUN when the server is aborted
