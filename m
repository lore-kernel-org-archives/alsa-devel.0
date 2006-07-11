From: Adam =?ISO-8859-2?B?VGxhs2th?= <atlka@pg.gda.pl>
Subject: Re: OSS driver removal, 2nd round (v2)
Date: Tue, 11 Jul 2006 13:29:46 +0200
Message-ID: <20060711132946.890d7941.atlka@pg.gda.pl>
References: <20060707231716.GE26941@stusta.de> <p737j2potzr.fsf@verdi.suse.de>
	<1152458300.28129.45.camel@mindpipe>
	<20060710132810.551a4a8d.atlka@pg.gda.pl>
	<1152571717.19047.36.camel@mindpipe> <44B2E4FF.9000502@pg.gda.pl>
	<20060710235934.GC26528@dspnet.fr.eu.org>
	<1152578344.21909.12.camel@mindpipe>
	<20060711085952.f1254229.atlka@pg.gda.pl>
	<Pine.LNX.4.61.0607110937160.9147@tm8103.perex-int.cz>
	<20060711110811.947e15ed.atlka@pg.gda.pl>
	<Pine.LNX.4.61.0607111110280.9147@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sunrise.pg.gda.pl (sunrise.pg.gda.pl [153.19.40.230])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 89BDB21E
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Jul 2006 13:27:38 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.61.0607111110280.9147@tm8103.perex-int.cz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@alsa-project.org, rlrevell@joe-job.com, galibert@pobox.com, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, 11 Jul 2006 11:52:56 +0200 (CEST)
Jaroslav Kysela <perex@suse.cz> wrote:

> On Tue, 11 Jul 2006, Adam Tla=B3ka wrote:
> =

> > OSS kernel compatibility is only partial and aoss method is not fully =

> =

> Partial? Elaborate please. And talk about OSS drivers in 2.6 kernel.

I don't remember the case exactly - original OSS as stated in pdf describing
its behaviour locks buffer size after some ioctls. So you can't change para=
meters
unless you do reset or reopen the device. aoss does it differently.
Also aoss has no mixer ioctls working with audio stream fd implemented.

> > > b) you're requestion to avoid scheduler participation in the audio =

> > >    processing and yes, we have this solution already (dmix), but not =
in =

> > >    kernel
> > =

> > just the contrary - scheduler participation is needed to avoid sound =

> > distortion and missing samples
> =

> Nope. You're missing that dmix does not add any extra latencies, because
> samples are written directly to the DMA buffer.

That is true but it is a process (thread exactly but in Linux world it is a=
 special kind of process) so it can be scheduled down or swapped off.
 =

> > > c) as you said, the kernel should contain only critical code to drive
> > >    hardware, sample rate conversion, sample format conversions and so=
 on
> > >    are NOT part of this code in my opinion
> > =

> > if doing this operations behind application back can lead to not delive=
ring
> > data to kernel driver in time then these are time critical operations t=
oo!
> =

> Sorry, but you have limited resources (CPU power). It's completely =

> irrelevant, if you do processing in the user space or in kernel (in my =

> opinion it's even worse to do such things in the interrupt context).
> It's probably better to think how to instruct scheduler to wake up
> the sound applications as soon as possible.

If I have enough resources to do this in kernel space and obtain good resul=
ts
why not do it?

> > > > ALSA in lib way has its limitations and drawbacks and adding more =

> > > > feaures this way leads to more complications only IMHO.
> > > =

> > > Which limitations? We can do all things like OSS API. The whole point=
 of =

> > > all problems is that OSS has the API entry point in syscalls which is =

> > > quite bad so the redirection is problematic.
> > =

> > Yes but what a complicated way. And you cannot use kernel OSS emulation
> > and ALSA aware apps at the same time. Also aoss with dmix are in
> > conflict with jackd for example.
> =

> ??? Elaborate. It should work.

There was reports of jack mixing problems with dmix active. Proposed soluti=
on was to use jack attached directly to alsa hw device and not to the defau=
lt.

> =

> > Kernel redirector is not a bad solution - there should be some kind of =

> > interface for such redirectors for different purposes. netlink device =

> > maybe? For example you should redirect all these traffic to some RT =

> > daemon doing all job.
> =

> I would prefer probably a network lowlevel ALSA driver. You'll get the =

> network transparency as benefit.
>

Quite nice conception.
 =

> > Same with filesystem redirections. I hate these special gnomevfs or kde=
io
> > helpers which forces to rebuilding apps with more and more libs.
> > Change LD_PRELOAD or LD_LIBRARY_PATH and you app will go to hell.
> > This is the Windows way of doing uncontrolled mess.
> > This plugin architecture without mandatory kernel access control leads
> > to serious security risc.
> =

> Unfortunately, more functionality requires more code. You have to deal =

> with bloating the user or kernel space.

Of course.

As I said it could be done by a small kernel message passing redirector con=
nected
to a bloated user space RT process which does the rest. But some kernel sup=
port for proper waking up, rescheduling etc. is a must.

Regards
-- =

Adam Tla=B3ka       mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
Computer Center,  Gda=F1sk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
