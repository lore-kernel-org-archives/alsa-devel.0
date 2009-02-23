From: Daniel Mack <daniel@caiaq.org>
Subject: Re: snd_pcm_hw_params_get_period_size points to	__old_
	symbol
Date: Mon, 23 Feb 2009 12:32:52 +0100
Message-ID: <20090223113252.GA16934@buzzloop.caiaq.de>
References: <20090222213553.GA5893@buzzloop.caiaq.de>
	<1235340956.27887.547.camel@vega.slimlogic.co.uk>
	<20090222222228.GE5893@buzzloop.caiaq.de>
	<200902231152.39825.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id CA5F31037FB
	for <alsa-devel@alsa-project.org>; Mon, 23 Feb 2009 12:32:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200902231152.39825.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 23, 2009 at 11:52:39AM +0000, Alan Horstmann wrote:
> > This is rather unpracticable for us as we build the whole system with
> > buildroot. Hence, I'd rather go and fix it. Any hint about what could
> > possibily go wrong during the build phase which would explain that bug
> > to happen? A missing/wrong define, bogus configure arguments?
> =

> Just thought I would chip in from the sidelines here; we have successfull=
y =

> built for ARM (AT91 though) using Buildroot.
> =

> Looking back to my posting on devel list dated 12.08.08, one problem was:
> =

> "We are currently using the Buildroot system which uses the uClibc librar=
ies. =A0
>  Simply, uClibc does not support versioned symbols. =A0Therefore it is ne=
cessary =

>  to override the ALSA-lib default by adding
> =A0=A0=A0=A0=A0=A0=A0=A0--with-versioned=3Dno
>  to the build. =A0Aplay, Alsamixer etc run without problems.

Yes, as discussed on the buildroot mailing list in the last few hours,
this is what makes it work for me, too. There will be a fix for buildroot
to make it add this configure option.

Unfortunately, this does not solve the other "pxassp pointer not moving"
issue, but I will follow up on this in the other thread.

Thanks for the help on this one to anyone who jumped in!

Daniel
