From: Baek Chang <baeksan@ccrma.stanford.edu>
Subject: Re: routing audio stream to multiple devices
Date: Thu, 25 Jun 2009 19:50:01 -0700
Message-ID: <aceb60a00906251950m427a1ecg82ba038561d54c6e@mail.gmail.com>
References: <aceb60a00906251846v2f9607dcp8f89c4379f7bc097@mail.gmail.com>
	<d54969c50906251857n7e0073c8h9ae61943da6c5ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f189.google.com (mail-yx0-f189.google.com
	[209.85.210.189])
	by alsa0.perex.cz (Postfix) with ESMTP id C1FBB24641
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Jun 2009 04:50:02 +0200 (CEST)
Received: by yxe27 with SMTP id 27so1478386yxe.16
	for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2009 19:50:01 -0700 (PDT)
In-Reply-To: <d54969c50906251857n7e0073c8h9ae61943da6c5ca@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?Emilio_L=F3pez?= <buhitoescolar@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I am trying to do this with dmix, but I can't seem to find a clear cut
solution to this?  I was under the impression that editing my asound.conf
could acheive this?  Basically, it seems that you have to make a stream a
slave to two different devices.  Is this possible?

Thanks
Baek

On Thu, Jun 25, 2009 at 6:57 PM, Emilio L=F3pez <buhitoescolar@gmail.com>wr=
ote:

> You can achieve this with pulseaudio, and maybe with alsa's dmix.
>
> 2009/6/25 Baek Chang <baeksan@ccrma.stanford.edu>:
> > I was wondering if it was possible to route a single audio stream to
> > multiple alsa devices or plugins?
> >
> > For example, I am playing a song and want it to stream to both my sound
> card
> > at hw:0 and a bluetooth device, an alsa plugin.  Is this possible?  It
> seems
> > that configuring asound.conf only lets you route streams serially to a
> > single device at a time.  Any info would be greatly appreciated.
> >
> > Thanks in advance
> > Baek
> >
> > --
> > Baek Chang
> > baeksan@ccrma.stanford.edu
> > 407-267-6701
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
>
>


-- =

Baek Chang
baeksan@ccrma.stanford.edu
407-267-6701
