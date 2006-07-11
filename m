From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: OSS driver removal, 2nd round (v2)
Date: Tue, 11 Jul 2006 11:52:56 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0607111110280.9147@tm8103.perex-int.cz>
References: <20060707231716.GE26941@stusta.de> <p737j2potzr.fsf@verdi.suse.de>
	<1152458300.28129.45.camel@mindpipe>
	<20060710132810.551a4a8d.atlka@pg.gda.pl>
	<1152571717.19047.36.camel@mindpipe> <44B2E4FF.9000502@pg.gda.pl>
	<20060710235934.GC26528@dspnet.fr.eu.org>
	<1152578344.21909.12.camel@mindpipe>
	<20060711085952.f1254229.atlka@pg.gda.pl>
	<Pine.LNX.4.61.0607110937160.9147@tm8103.perex-int.cz>
	<20060711110811.947e15ed.atlka@pg.gda.pl>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1798431545-1152611576=:9147"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2DCE9220
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Jul 2006 11:52:57 +0200 (MEST)
In-Reply-To: <20060711110811.947e15ed.atlka@pg.gda.pl>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Adam =?ISO-8859-2?B?VGxhs2th?= <atlka@pg.gda.pl>
Cc: alsa-devel@alsa-project.org, rlrevell@joe-job.com, galibert@pobox.com, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1798431545-1152611576=:9147
Content-Type: TEXT/PLAIN; charset=iso8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 11 Jul 2006, Adam Tla=B3ka wrote:

> OSS kernel compatibility is only partial and aoss method is not fully=20

Partial? Elaborate please. And talk about OSS drivers in 2.6 kernel.

> > b) you're requestion to avoid scheduler participation in the audio=20
> >    processing and yes, we have this solution already (dmix), but not in=
=20
> >    kernel
>=20
> just the contrary - scheduler participation is needed to avoid sound=20
> distortion and missing samples

Nope. You're missing that dmix does not add any extra latencies, because
samples are written directly to the DMA buffer.

> > c) as you said, the kernel should contain only critical code to drive
> >    hardware, sample rate conversion, sample format conversions and so o=
n
> >    are NOT part of this code in my opinion
>=20
> if doing this operations behind application back can lead to not deliveri=
ng
> data to kernel driver in time then these are time critical operations too=
!

Sorry, but you have limited resources (CPU power). It's completely=20
irrelevant, if you do processing in the user space or in kernel (in my=20
opinion it's even worse to do such things in the interrupt context).
It's probably better to think how to instruct scheduler to wake up
the sound applications as soon as possible.

> > > ALSA in lib way has its limitations and drawbacks and adding more=20
> > > feaures this way leads to more complications only IMHO.
> >=20
> > Which limitations? We can do all things like OSS API. The whole point o=
f=20
> > all problems is that OSS has the API entry point in syscalls which is=
=20
> > quite bad so the redirection is problematic.
>=20
> Yes but what a complicated way. And you cannot use kernel OSS emulation
> and ALSA aware apps at the same time. Also aoss with dmix are in
> conflict with jackd for example.

??? Elaborate. It should work.

> Kernel redirector is not a bad solution - there should be some kind of=20
> interface for such redirectors for different purposes. netlink device=20
> maybe? For example you should redirect all these traffic to some RT=20
> daemon doing all job.

I would prefer probably a network lowlevel ALSA driver. You'll get the=20
network transparency as benefit.

> Same with filesystem redirections. I hate these special gnomevfs or kdeio
> helpers which forces to rebuilding apps with more and more libs.
> Change LD_PRELOAD or LD_LIBRARY_PATH and you app will go to hell.
> This is the Windows way of doing uncontrolled mess.
> This plugin architecture without mandatory kernel access control leads
> to serious security risc.

Unfortunately, more functionality requires more code. You have to deal=20
with bloating the user or kernel space.

=09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
--8323584-1798431545-1152611576=:9147
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

--8323584-1798431545-1152611576=:9147
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--8323584-1798431545-1152611576=:9147--
