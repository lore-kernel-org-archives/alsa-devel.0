From: Adam =?ISO-8859-2?B?VGxhs2th?= <atlka@pg.gda.pl>
Subject: Re: OSS driver removal, 2nd round (v2)
Date: Tue, 11 Jul 2006 08:15:28 +0200
Message-ID: <20060711081528.4d3ab197.atlka@pg.gda.pl>
References: <20060707231716.GE26941@stusta.de> <p737j2potzr.fsf@verdi.suse.de>
	<1152458300.28129.45.camel@mindpipe>
	<20060710132810.551a4a8d.atlka@pg.gda.pl>
	<1152571717.19047.36.camel@mindpipe> <44B2E4FF.9000502@pg.gda.pl>
	<200607110209.k6B29psN007504@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sunrise.pg.gda.pl (sunrise.pg.gda.pl [153.19.40.230])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0F12323F
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Jul 2006 08:13:24 +0200 (MEST)
In-Reply-To: <200607110209.k6B29psN007504@turing-police.cc.vt.edu>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Valdis.Kletnieks@vt.edu
Cc: alsa-devel@alsa-project.org, ak@suse.de, linux-kernel@vger.kernel.org, rlrevell@joe-job.com, perex@suse.cz, alan@lxorguk.ukuu.org.uk
List-Id: alsa-devel@alsa-project.org

On Mon, 10 Jul 2006 22:09:51 -0400
Valdis.Kletnieks@vt.edu wrote:

> On Tue, 11 Jul 2006 01:38:39 +0200, =3D?ISO-8859-2?Q?Adam_Tla=3DB3ka?=3D =
said:
> > U=BFytkownik Lee Revell napisa=B3:
> >
> > > esd and artsd are no longer needed since ALSA began to enable software
> > > mixing by default in release 1.0.9.
> >  >
> > =

> > So why they are still exist in so many Linux distributions?
> =

> As soon as somebody writes a patch to make the e16 window manager talk AL=
SA
> rather than use esd, I'm heaving esd over the side.

Sorry to say but it is just not that way. Window manager is for managing wi=
ndows
and it shouldn't depend on any audio system. It should use an external app =
using exec call
to play sounds (aplay, sox, wavplay etc.) configured by some config option.
Generally it is a big mess in may distros where desktop apps depends on sou=
nd.
Yes, it is nice to have sound but it is not absolutly needed to use an edit=
or for example. =


> Of course, I've been saying that since ALSA 1.0.9 came out.  (And don't
> suggest I write it myself - I could if I was motivated enough, but I'm not
> motivated at the current time. :)
> =


If you are the author then I just suggest to use exec(3) call, for example:

if (!fork()){
	execvp("aplay","beep.wav");
	exit(0);
}

Simple, and you don't need to know anything about sound programming ;-).

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
