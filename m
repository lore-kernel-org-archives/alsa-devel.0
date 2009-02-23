From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: snd_pcm_hw_params_get_period_size points to __old_
	symbol
Date: Mon, 23 Feb 2009 12:30:12 +0000
Message-ID: <200902231230.12430.gineera@aspect135.co.uk>
References: <20090222213553.GA5893@buzzloop.caiaq.de>
	<200902231152.39825.gineera@aspect135.co.uk>
	<20090223113252.GA16934@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ttsmtp.cpwnetworks.com (ttsmtp-2.cpwnetworks.com
	[62.24.128.243])
	by alsa0.perex.cz (Postfix) with ESMTP id ED1421037FB
	for <alsa-devel@alsa-project.org>; Mon, 23 Feb 2009 13:04:53 +0100 (CET)
In-Reply-To: <20090223113252.GA16934@buzzloop.caiaq.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.org>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Monday 23 February 2009 11:32, you wrote:
> On Mon, Feb 23, 2009 at 11:52:39AM +0000, Alan Horstmann wrote:
> >
> > Looking back to my posting on devel list dated 12.08.08, one problem wa=
s:
> >
> > "We are currently using the Buildroot system which uses the uClibc
> > libraries. =A0 Simply, uClibc does not support versioned symbols.
> > =A0Therefore it is necessary to override the ALSA-lib default by adding
> > =A0=A0=A0=A0=A0=A0=A0=A0--with-versioned=3Dno
> >  to the build. =A0Aplay, Alsamixer etc run without problems.
>
> Yes, as discussed on the buildroot mailing list in the last few hours,
> this is what makes it work for me, too. There will be a fix for buildroot
> to make it add this configure option.

It's frustrating, as my collegue pointed that out on that list in July 08:

http://lists.busybox.net/pipermail/buildroot/2008-July/009884.html

Alan
