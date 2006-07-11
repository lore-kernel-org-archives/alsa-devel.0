From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: OSS driver removal, 2nd round (v2)
Date: Tue, 11 Jul 2006 09:58:26 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0607110937160.9147@tm8103.perex-int.cz>
References: <20060707231716.GE26941@stusta.de> <p737j2potzr.fsf@verdi.suse.de>
	<1152458300.28129.45.camel@mindpipe>
	<20060710132810.551a4a8d.atlka@pg.gda.pl>
	<1152571717.19047.36.camel@mindpipe> <44B2E4FF.9000502@pg.gda.pl>
	<20060710235934.GC26528@dspnet.fr.eu.org>
	<1152578344.21909.12.camel@mindpipe>
	<20060711085952.f1254229.atlka@pg.gda.pl>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-303525050-1152604706=:9147"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 48D60220
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Jul 2006 09:58:27 +0200 (MEST)
In-Reply-To: <20060711085952.f1254229.atlka@pg.gda.pl>
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
Cc: ALSA development <alsa-devel@alsa-project.org>, Lee Revell <rlrevell@joe-job.com>, galibert@pobox.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-303525050-1152604706=:9147
Content-Type: TEXT/PLAIN; charset=iso8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 11 Jul 2006, Adam Tla=B3ka wrote:

> On Mon, 10 Jul 2006 20:39:03 -0400
> Lee Revell <rlrevell@joe-job.com> wrote:
>=20
> > On Tue, 2006-07-11 at 01:59 +0200, Olivier Galibert wrote:
> > > ALSA lib has something like 7 different methods just to play a sound.
> > > Their view of "low level" is quite interesting.  Using it is pure
> > > hell.  Debugging what you've done is worse.  And don't bother to hope
> > > that your code will still work in six months.
> > >=20
> >=20
> > A small FAQ:
> >=20
> > Q: But OSS is kewl and ALSA sucks!
> > A: The decision for the OSS->ALSA move was four years ago.
> >    If ALSA sucks, please help to improve ALSA.
>=20
> The problem is that ALSA is done a Windows way with too many not always=
=20
> working ways of obtaining sound and lack of user docs. So there is still=
=20

The docs are available:=20
http://www.alsa-project.org/alsa-doc/alsa-lib/pcm.html

If you have some comment or idea to improve it, please, post it to=20
the relevant mailing list.

> the general question: Is it the proper way? How I can help improve ALSA=
=20
> if I just dislike its design?

Then it is your problem. I've not seen a single problematic technical=20
information from your mails.

> I spent some time improving dmix and aoss in the past. I have a version=
=20
> of aoss which uses callbacks and works properly with some not properly=20
> written OSS apps. It's very interesting that with some apps aoss method=
=20
> gives better sound A/V synchronization then using native ALSA app=20
> support ;-). But callbacks not always work and LD_PRELOAD method is=20
> generally not secure and some kind of a hack. So I just don't think it=20
> could be improved with it's current design. In my opinion it should work=
=20
> out of the box without need to rewrite old or proprietary apps and=20
> messing with LD_PRELOAD. So /dev/dsp compatibility is a must. But with=20
> all input/output mixing of course. Userspace thread method leads to many=
=20
> problems - swapping and rescheduling leads to bad acustic effects. Of=20
> course if an app can't supply data when it should we can't do anything=20
> but if scheduling or swapping causes problems the design seems to be=20
> bad.
>
> There are many devices which need to be served at the some critical=20
> point in time
> - sound cards, video and tv grabbers, some dedicated lab cards, i/o=20
>   ports etc.  Generally on the really low level this is a kernel driver=
=20
>   which sticks to the hardware and should ``know'' how critical is to=20
>   serve hw requests just in time. If we have data in a buffer programing=
=20
>   DMA transfer is a quite quick operation but must be done at the proper=
=20
>   moment.  So maybe we should delay a bit other io for example and just=
=20
>   do it. But it must be done in kernel because kernel should know these=
=20
>   critical time parameters for all devices in the system and decide=20
>   which to serve and when. Maybe this is not needed for all devices but=
=20
>   for audio/video devices it's a must. Better kernel support for these=20
>   kind of devices is absolutely needed.

You're a bit mixing things:

a) we're not trying to be more compatible than OSS code in kernel, if you=
=20
   like to do the mixing in kernel, simply write a new ALSA lowlevel=20
   driver which will do it; I'm sure when the quality of your code will be=
=20
   good,  we'll include it to the ALSA tree, but we are not going this
   way unless someone else will maintain this code
b) you're requestion to avoid scheduler participation in the audio=20
   processing and yes, we have this solution already (dmix), but not in=20
   kernel
c) as you said, the kernel should contain only critical code to drive
   hardware, sample rate conversion, sample format conversions and so on
   are NOT part of this code in my opinion

> ALSA in lib way has its limitations and drawbacks and adding more=20
> feaures this way leads to more complications only IMHO.

Which limitations? We can do all things like OSS API. The whole point of=20
all problems is that OSS has the API entry point in syscalls which is=20
quite bad so the redirection is problematic.

=09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
--8323584-303525050-1152604706=:9147
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

--8323584-303525050-1152604706=:9147
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--8323584-303525050-1152604706=:9147--
