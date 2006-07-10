From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: OSS driver removal, 2nd round (v2)
Date: Mon, 10 Jul 2006 19:51:44 -0400
Message-ID: <1152575505.19047.52.camel__21732.6163467535$1152575571$gmane$org@mindpipe>
References: <20060707231716.GE26941@stusta.de>
	<p737j2potzr.fsf@verdi.suse.de> <1152458300.28129.45.camel@mindpipe>
	<20060710132810.551a4a8d.atlka@pg.gda.pl>
	<1152571717.19047.36.camel@mindpipe>  <44B2E4FF.9000502@pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id B1EC7223
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Jul 2006 01:52:06 +0200 (MEST)
In-Reply-To: <44B2E4FF.9000502@pg.gda.pl>
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
Cc: alan@lxorguk.ukuu.org.uk, alsa-devel@alsa-project.org, ak@suse.de, perex@suse.cz, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-07-11 at 01:38 +0200, Adam Tla=B3ka wrote:
> U=BFytkownik Lee Revell napisa=B3:
> > On Mon, 2006-07-10 at 13:28 +0200, Adam Tla=B3ka wrote:
> >> >From my point of view ALSA has many advantages if you want to dig in
> >> the card driver buffers/period etc. settings but lacks ease of use and
> >> some of simple in theory functionality is a pain - device enumeration
> >> or switching output mode/device without restarting apps or rewritting
> >> them so they have special function for that purpose.
> >>
> > =

> > Does any available sound driver interface allow switching output devices
> > with no help from the app and without having to restart playback?  OSS
> > does not, and every Windows app I've used has a configuration option to
> > set the sound device, and you must stop and start playback for it to
> > take effect.
> =

> Sorry but is a Windows solution the best on the whole world?
> Is there any problem to imagine an abstract sound device which virtually =

> always works but uses real device chosen by user, network redirection or =

>   emulating work and we have some control panel/app which can control =

> connections/plugins/redirections etc. (also this can be done by some =

> kind of daemon responding to hw change events)?
> Do we really need to program every sound app to have device setting code?
> =


The problem is you trade ease of development for performance, penalizing
the users to save developer time.  Your proposals would require every
app to go through a software buffering layer.

Of course, you're free to develop a system like this.

> >> esd, arts, jackd, polypd and other prove that ALSA is not enough
> >> and its functionality is far from perfect.
> >>
> > =

> > esd and artsd are no longer needed since ALSA began to enable software
> > mixing by default in release 1.0.9.
>  >
> =

> So why they are still exist in so many Linux distributions?
> =


Backwards compatibility, bugs still being worked out, waiting for
upstream to catch up, etc.  Same reason that distros never have the very
latest version of every app.

> > As for jackd and other apps that
> > provide additional functionality - no one ever claimed ALSA would handle
> > every audio related function imaginable.  It's just a low level HAL.
> =

> Format changing, resampling, mixing and supporting additional plugins
> does not seems to be just low level HAL for hw device. It creates some =

> kind of virtual functionality which means more then this provided by =

> hardware device itself.

OK, but my point is that it does not make sense to put every imaginable
audio feature in ALSA.

Lee



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
