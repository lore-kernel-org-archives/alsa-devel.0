From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: Release method?
Date: Wed, 23 Oct 2002 19:50:45 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0210231932150.27945-100000@ecabase.localdomain>
References: <20021023170553.3511839f.matthias@rpmforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20021023170553.3511839f.matthias@rpmforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Matthias Saou <matthias@rpmforge.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 23 Oct 2002, Matthias Saou wrote:

> Seeing how the 0.9.0rc4 release went, I was wondering if the ALSA people
> wouldn't mind re-thinking the release method?

Yes, but...

> - Would it be possible to release some tarballs, supposedly identical to
> the final ones but a few hours/days before public release and announce?

I'd suggest just the opposite. I'd say it's better to follow the 
Linux-style and release early and _often_. It's just a fact of OSS life, 
that any release that is a ...

	1) CVS- or some other snapshot
	2) pre-version
	3) beta-version
	4) equipped with "development!" warnings

... is only going to be tested by the same limited group of people who
have been testing for the last x monts/years. And even those doing
testing only report really annoying bugs, as there's "no sense to report
little things when testing development releases"...

Only way around is to put out real releases (that are real and look real!
:)) and put on the flame suit. Yes, sometimes embarrasing bugs will be
found (as has happened numerous times with kernel releases), but this is
unavoidable. If something like this happens, you fix it, "make dist" and
put out a another release.  As a result, development as a whole just goes
faster and the developers feel mentally much healthies (no
release-pressure).

I got caught into this trap with ecasound (eleven 2.1devX releases during
one year, and judging from the download-logs, lots of downloads but done
by a the same _very_ small group of people). I feel that ALSA has been
caught in this trap, too (0.6 -> 0.9 development has been a bit painful).

And as part of ALSA is driver development, this issue is much more
serious. It will never be possible to fully test an ALSA driver release.  
There's just too many hardware combinations out there. You have to release
and wait for the results.

>   1) Many people (including me) would more easily find time to test these
>      then to test the current CVS tree

Would there be so many and would it really make the procedure more 
efficient? For instance, I found and reported the libtool issue quite some 
time ago, but neither I or the ALSA guys thought it to be something really 
serious. Well now, there have been so many about this issue that it's 
clear it has to be handled in some way.

>   2) Some problems may show up not in the actual source, but in the way
>      it is packaged (like the automake links)

Although, I admit, this is a very good point. But I'd still just prefer
more regular releases. You could compare this to the kernel releases that
from time to time have the wrong version number. ;)

> - Would it be possible to have a different versioning scheme? For
> packagers, and I am one, versions like "0.9.0rc4" < "0.9.0" are horrible

I've tried to get around this by using x.ydevt style versioning (and other
experiments), but unfortunately people are used to the
x.y.z-{rc,pre,beta}t version numbers. If you use something else, then
people won't test the almost stable versions or you confuse users about
what is stable and what is development.

> since they mean that some ugly hacking is needed (namely Epoch: tags for
> rpm packages). It would have been so much easier if the versions had been
> 0.8.1, 0.8.2 etc. Especially as nearly everyone uses 0.9.0x anyway, and
> that 0.5.0 is unmaintained...

Yup, I know it's annoying.

-- 
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
