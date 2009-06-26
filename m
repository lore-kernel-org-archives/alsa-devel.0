From: =?ISO-8859-1?Q?Emilio_L=F3pez?= <buhitoescolar@gmail.com>
Subject: Re: routing audio stream to multiple devices
Date: Thu, 25 Jun 2009 22:57:55 -0300
Message-ID: <d54969c50906251857n7e0073c8h9ae61943da6c5ca@mail.gmail.com>
References: <aceb60a00906251846v2f9607dcp8f89c4379f7bc097@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f200.google.com (mail-px0-f200.google.com
	[209.85.216.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 27594245F7
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Jun 2009 03:57:55 +0200 (CEST)
Received: by pxi38 with SMTP id 38so1494542pxi.16
	for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2009 18:57:55 -0700 (PDT)
In-Reply-To: <aceb60a00906251846v2f9607dcp8f89c4379f7bc097@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Baek Chang <baeksan@ccrma.stanford.edu>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

You can achieve this with pulseaudio, and maybe with alsa's dmix.

2009/6/25 Baek Chang <baeksan@ccrma.stanford.edu>:
> I was wondering if it was possible to route a single audio stream to
> multiple alsa devices or plugins?
>
> For example, I am playing a song and want it to stream to both my sound c=
ard
> at hw:0 and a bluetooth device, an alsa plugin. =A0Is this possible? =A0I=
t seems
> that configuring asound.conf only lets you route streams serially to a
> single device at a time. =A0Any info would be greatly appreciated.
>
> Thanks in advance
> Baek
>
> --
> Baek Chang
> baeksan@ccrma.stanford.edu
> 407-267-6701
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
