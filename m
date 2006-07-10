From: =?ISO-8859-2?Q?Adam_Tla=B3ka?= <atlka@pg.gda.pl>
Subject: Re: OSS driver removal, 2nd round (v2)
Date: Tue, 11 Jul 2006 01:38:39 +0200
Message-ID: <44B2E4FF.9000502@pg.gda.pl>
References: <20060707231716.GE26941@stusta.de>	 <p737j2potzr.fsf@verdi.suse.de>
	<1152458300.28129.45.camel@mindpipe>	
	<20060710132810.551a4a8d.atlka@pg.gda.pl>
	<1152571717.19047.36.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sunrise.pg.gda.pl (sunrise.pg.gda.pl [153.19.40.230])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 95549223
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Jul 2006 01:39:33 +0200 (MEST)
In-Reply-To: <1152571717.19047.36.camel@mindpipe>
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
Cc: alan@lxorguk.ukuu.org.uk, alsa-devel@alsa-project.org, ak@suse.de, perex@suse.cz, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

U=BFytkownik Lee Revell napisa=B3:
> On Mon, 2006-07-10 at 13:28 +0200, Adam Tla=B3ka wrote:
>> >From my point of view ALSA has many advantages if you want to dig in
>> the card driver buffers/period etc. settings but lacks ease of use and
>> some of simple in theory functionality is a pain - device enumeration
>> or switching output mode/device without restarting apps or rewritting
>> them so they have special function for that purpose.
>>
> =

> Does any available sound driver interface allow switching output devices
> with no help from the app and without having to restart playback?  OSS
> does not, and every Windows app I've used has a configuration option to
> set the sound device, and you must stop and start playback for it to
> take effect.

Sorry but is a Windows solution the best on the whole world?
Is there any problem to imagine an abstract sound device which virtually =

always works but uses real device chosen by user, network redirection or =

  emulating work and we have some control panel/app which can control =

connections/plugins/redirections etc. (also this can be done by some =

kind of daemon responding to hw change events)?
Do we really need to program every sound app to have device setting code?

>> esd, arts, jackd, polypd and other prove that ALSA is not enough
>> and its functionality is far from perfect.
>>
> =

> esd and artsd are no longer needed since ALSA began to enable software
> mixing by default in release 1.0.9.
 >

So why they are still exist in so many Linux distributions?

> As for jackd and other apps that
> provide additional functionality - no one ever claimed ALSA would handle
> every audio related function imaginable.  It's just a low level HAL.

Format changing, resampling, mixing and supporting additional plugins
does not seems to be just low level HAL for hw device. It creates some =

kind of virtual functionality which means more then this provided by =

hardware device itself.

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
