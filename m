From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re:
	=?iso-8859-1?q?snd=5Fpcm=5Fhw=5Fparams=5Fget=5Fperio?=
	=?iso-8859-1?q?d=5Fsize_points_to=09=5F=5Fold=5F_symbol?=
Date: Mon, 23 Feb 2009 11:52:39 +0000
Message-ID: <200902231152.39825.gineera@aspect135.co.uk>
References: <20090222213553.GA5893@buzzloop.caiaq.de>
	<1235340956.27887.547.camel@vega.slimlogic.co.uk>
	<20090222222228.GE5893@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ttsmtp.cpwnetworks.com (ttsmtp-3.cpwnetworks.com
	[62.24.128.244])
	by alsa0.perex.cz (Postfix) with ESMTP id DE07E1037FE
	for <alsa-devel@alsa-project.org>; Mon, 23 Feb 2009 12:27:33 +0100 (CET)
In-Reply-To: <20090222222228.GE5893@buzzloop.caiaq.de>
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

On Sunday 22 February 2009 22:22, Daniel Mack wrote:
> On Sun, Feb 22, 2009 at 10:15:56PM +0000, Liam Girdwood wrote:
> > > With alsa-lib and alsa-utils cross-compiled for ARM by
> > > buildroot (currently version 1.0.19, but earlier versions
> > > seem to be equally affected), I encounter the effect that
> > > snd_pcm_hw_params_get_period_size() does not write the expected
> > > value to the given snd_pcm_uframes_t pointer. In fact, this
> > > variable is not written at all. This makes aplay calculate 0
> > > for chunk_bytes in set_params() and then exit with the bogus error
> > > message "Not enough memory". I did some tracing and found out that
> > > the function called for snd_pcm_hw_params_get_period_size() is in
> > > fact __old_snd_pcm_hw_params_get_period_size() which has a different
> > > footprint and hence the pointer given to it is leaved untouched.
> > >
> > > As I don't fully understand all the system behind the symbol names
> > > remapping, I'm stuck here. Can anybody reproduce this bug?
> >
> > AFAICT, buildroot builds a broken ALSA ARM userspace. I've had driver
> > bug reports from numerous users for about 2 years now due to buildoot
> > building a faulty ARM ALSA userspace. I've also asked each bug reporter
> > to report this to buildroot bugzilla. Seems it's not fixed yet.
>
> Interesting, thanks for pointing that out.
>
> > Please either build alsa-lib natively or with OpenEmbedded.
>
> This is rather unpracticable for us as we build the whole system with
> buildroot. Hence, I'd rather go and fix it. Any hint about what could
> possibily go wrong during the build phase which would explain that bug
> to happen? A missing/wrong define, bogus configure arguments?

Just thought I would chip in from the sidelines here; we have successfully =

built for ARM (AT91 though) using Buildroot.

Looking back to my posting on devel list dated 12.08.08, one problem was:

"We are currently using the Buildroot system which uses the uClibc librarie=
s. =A0
 Simply, uClibc does not support versioned symbols. =A0Therefore it is nece=
ssary =

 to override the ALSA-lib default by adding
=A0=A0=A0=A0=A0=A0=A0=A0--with-versioned=3Dno
 to the build. =A0Aplay, Alsamixer etc run without problems.

 I think the gcc optimisation bug may be fixed on recent gcc versions; it =

 didn't in the end turn out to be causing us any problems.

 We also noticed that it would be easy to accidentally build kernel and lib=
s =

 with different settings of -mabi, which would also cause problems. "

Just in case that is any help.

Alan
