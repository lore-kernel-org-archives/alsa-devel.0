From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: OSS driver removal, 2nd round (v2)
Date: Tue, 11 Jul 2006 20:58:13 -0400
Message-ID: <1152665894.21909.106.camel@mindpipe>
References: <20060707231716.GE26941@stusta.de>
	<p737j2potzr.fsf@verdi.suse.de> <1152458300.28129.45.camel@mindpipe>
	<20060710132810.551a4a8d.atlka@pg.gda.pl>
	<1152571717.19047.36.camel@mindpipe> <44B2E4FF.9000502@pg.gda.pl>
	<200607110209.k6B29psN007504@turing-police.cc.vt.edu>
	<20060711081528.4d3ab197.atlka@pg.gda.pl>
	<200607111430.k6BEUUus006736@turing-police.cc.vt.edu>
	<1152637064.21909.61.camel@mindpipe>  <44B426CB.4010405@pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id EB7DF161
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Jul 2006 02:58:20 +0200 (MEST)
In-Reply-To: <44B426CB.4010405@pg.gda.pl>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Adam =?iso-8859-2?Q?Tla=B3ka?= <atlka@pg.gda.pl>
Cc: alsa-devel@alsa-project.org, Valdis.Kletnieks@vt.edu, alan@lxorguk.ukuu.org.uk, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-07-12 at 00:31 +0200, Adam Tla=B3ka wrote:
> True - and that makes things more complicated. I don't know if it is =

> worth it just for bells and whistles. In other cases you do need to =

> program more sophisticated sound support and RT thread probably will be =

> your solution. Or some kind of sound server which holds your sound =

> samples so you can fire them at the proper time.
> ALSA lib is a low level library. Sometimes we need more abstract =

> functions like load(s, "sound.wav) and then play(s) without bothering =

> about all these parameters settings. So maybe OpenAL is a some kind of a =

> solution but I don't know its current status.

Let's remove linux-kernel from the CC list, as this thread is now OT.

Lee



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
