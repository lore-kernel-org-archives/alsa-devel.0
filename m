From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: OSS driver removal, 2nd round (v2)
Date: Mon, 10 Jul 2006 18:48:37 -0400
Message-ID: <1152571717.19047.36.camel@mindpipe>
References: <20060707231716.GE26941@stusta.de>
	<p737j2potzr.fsf@verdi.suse.de> <1152458300.28129.45.camel@mindpipe>
	<20060710132810.551a4a8d.atlka@pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id A4796153
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Jul 2006 00:49:00 +0200 (MEST)
In-Reply-To: <20060710132810.551a4a8d.atlka@pg.gda.pl>
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

On Mon, 2006-07-10 at 13:28 +0200, Adam Tla=B3ka wrote:
> >From my point of view ALSA has many advantages if you want to dig in
> the card driver buffers/period etc. settings but lacks ease of use and
> some of simple in theory functionality is a pain - device enumeration
> or switching output mode/device without restarting apps or rewritting
> them so they have special function for that purpose.
> =


Does any available sound driver interface allow switching output devices
with no help from the app and without having to restart playback?  OSS
does not, and every Windows app I've used has a configuration option to
set the sound device, and you must stop and start playback for it to
take effect.

> esd, arts, jackd, polypd and other prove that ALSA is not enough
> and its functionality is far from perfect.
> =


esd and artsd are no longer needed since ALSA began to enable software
mixing by default in release 1.0.9.  As for jackd and other apps that
provide additional functionality - no one ever claimed ALSA would handle
every audio related function imaginable.  It's just a low level HAL.

Lee



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
