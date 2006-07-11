From: =?ISO-8859-2?Q?Adam_Tla=B3ka?= <atlka@pg.gda.pl>
Subject: Re: OSS driver removal, 2nd round (v2)
Date: Wed, 12 Jul 2006 00:31:39 +0200
Message-ID: <44B426CB.4010405__42437.5117327601$1152657318$gmane$org@pg.gda.pl>
References: <20060707231716.GE26941@stusta.de>	 <p737j2potzr.fsf@verdi.suse.de>
	<1152458300.28129.45.camel@mindpipe>	
	<20060710132810.551a4a8d.atlka@pg.gda.pl>	
	<1152571717.19047.36.camel@mindpipe> <44B2E4FF.9000502@pg.gda.pl>	
	<200607110209.k6B29psN007504@turing-police.cc.vt.edu>	
	<20060711081528.4d3ab197.atlka@pg.gda.pl>	
	<200607111430.k6BEUUus006736@turing-police.cc.vt.edu>
	<1152637064.21909.61.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sunrise.pg.gda.pl (sunrise.pg.gda.pl [153.19.40.230])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 07A8123C
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Jul 2006 00:32:35 +0200 (MEST)
In-Reply-To: <1152637064.21909.61.camel@mindpipe>
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
Cc: alan@lxorguk.ukuu.org.uk, alsa-devel@alsa-project.org, Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

U=BFytkownik Lee Revell napisa=B3:
> On Tue, 2006-07-11 at 10:30 -0400, Valdis.Kletnieks@vt.edu wrote:
>> On Tue, 11 Jul 2006 08:15:28 +0200, Adam =3D?ISO-8859-2?B?VGxhs2th?=3D s=
aid:
>>> Sorry to say but it is just not that way. Window manager is for managin=
g windows
>>> and it shouldn't depend on any audio system. It should use an external =
app using exec call
>>> to play sounds (aplay, sox, wavplay etc.) configured by some config opt=
ion.
>> So what you're saying is that something like 'esd' *is* needed.  (It's
>> certainly silly to keep doing fork/exec for every little sound sample wh=
en
>> you can just leave the app running and hand it requests...)
> =

> That approach also won't be reliable as it ignores the realtime
> constraint that is inherent in audio playback.  It will probably work on
> a fast/lightly loaded machine but will glitch out under load.

Yes, that is true. It was just simple example how you can get simple =

sound effects without many lines of code. In case of heavy load or too =

many events in short period of time this method is not working correctly =

but this is not the main functionality of a window manager program.
Anyway you can aggregate events if there are too many of them and play =

only one sound or not play anything at all. For this kind of program
it is quite acceptable and not breaks main functionality.

> It's how GDM plays startup/shutdown sounds and it sucks - on shutdown
> the sound is choppy.  You either need a dedicated daemon running
> SCHED_FIFO or an RT thread for reliable audio playback.

True - and that makes things more complicated. I don't know if it is =

worth it just for bells and whistles. In other cases you do need to =

program more sophisticated sound support and RT thread probably will be =

your solution. Or some kind of sound server which holds your sound =

samples so you can fire them at the proper time.
ALSA lib is a low level library. Sometimes we need more abstract =

functions like load(s, "sound.wav) and then play(s) without bothering =

about all these parameters settings. So maybe OpenAL is a some kind of a =

solution but I don't know its current status.

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
