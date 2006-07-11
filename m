From: Adam =?ISO-8859-2?B?VGxhs2th?= <atlka@pg.gda.pl>
Subject: Re: OSS driver removal, 2nd round (v2)
Date: Tue, 11 Jul 2006 08:59:52 +0200
Message-ID: <20060711085952.f1254229.atlka@pg.gda.pl>
References: <20060707231716.GE26941@stusta.de> <p737j2potzr.fsf@verdi.suse.de>
	<1152458300.28129.45.camel@mindpipe>
	<20060710132810.551a4a8d.atlka@pg.gda.pl>
	<1152571717.19047.36.camel@mindpipe> <44B2E4FF.9000502@pg.gda.pl>
	<20060710235934.GC26528@dspnet.fr.eu.org>
	<1152578344.21909.12.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sunrise.pg.gda.pl (sunrise.pg.gda.pl [153.19.40.230])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 52C8D1AC
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Jul 2006 08:57:44 +0200 (MEST)
In-Reply-To: <1152578344.21909.12.camel@mindpipe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, galibert@pobox.com, perex@suse.cz, alan@lxorguk.ukuu.org.uk, ak@suse.de
List-Id: alsa-devel@alsa-project.org

On Mon, 10 Jul 2006 20:39:03 -0400
Lee Revell <rlrevell@joe-job.com> wrote:

> On Tue, 2006-07-11 at 01:59 +0200, Olivier Galibert wrote:
> > ALSA lib has something like 7 different methods just to play a sound.
> > Their view of "low level" is quite interesting.  Using it is pure
> > hell.  Debugging what you've done is worse.  And don't bother to hope
> > that your code will still work in six months.
> > =

> =

> A small FAQ:
> =

> Q: But OSS is kewl and ALSA sucks!
> A: The decision for the OSS->ALSA move was four years ago.
>    If ALSA sucks, please help to improve ALSA.

The problem is that ALSA is done a Windows way with too many not always wor=
king ways
of obtaining sound and lack of user docs. So there is still the general que=
stion:
Is it the proper way? How I can help improve ALSA if I just dislike its des=
ign?

I spent some time improving dmix and aoss in the past. I have a version of =
aoss
which uses callbacks and works properly with some not properly written OSS =
apps.
It's very interesting that with some apps aoss method gives better sound A/=
V synchronization then using native ALSA app support ;-).
But callbacks not always work and LD_PRELOAD method is generally not secure
and some kind of a hack. So I just don't think it could be improved with it=
's current design.
In my opinion it should work out of the box without need to rewrite old or =
proprietary apps
and messing with LD_PRELOAD. So /dev/dsp compatibility is a must. But with =
all input/output
mixing of course. Userspace thread method leads to many problems - swapping=
 and rescheduling leads to bad acustic effects. Of course if an app can't s=
upply data when it should we can't do anything but if scheduling or swappin=
g causes problems the design seems to be bad.

There are many devices which need to be served at the some critical point i=
n time
- sound cards, video and tv grabbers, some dedicated lab cards, i/o ports e=
tc.
Generally on the really low level this is a kernel driver which sticks to t=
he hardware and should ``know'' how critical is to serve hw requests just i=
n time. If we have data in a buffer programing DMA transfer is a quite quic=
k operation but must be done at the proper moment.
So maybe we should delay a bit other io for example and just do it. But it =
must be done in kernel because kernel should know these critical time param=
eters for all devices in the system and decide which to serve and when. May=
be this is not needed for all devices but for audio/video devices it's a mu=
st. Better kernel support for these kind of devices is absolutely needed.

ALSA in lib way has its limitations and drawbacks and adding more feaures t=
his way
leads to more complications only IMHO.

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
