From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: OSS driver removal, 2nd round (v2)
Date: Tue, 11 Jul 2006 12:57:43 -0400
Message-ID: <1152637064.21909.61.camel@mindpipe>
References: <20060707231716.GE26941@stusta.de>
	<p737j2potzr.fsf@verdi.suse.de> <1152458300.28129.45.camel@mindpipe>
	<20060710132810.551a4a8d.atlka@pg.gda.pl>
	<1152571717.19047.36.camel@mindpipe> <44B2E4FF.9000502@pg.gda.pl>
	<200607110209.k6B29psN007504@turing-police.cc.vt.edu>
	<20060711081528.4d3ab197.atlka@pg.gda.pl>
	<200607111430.k6BEUUus006736@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 9929D253
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Jul 2006 18:57:42 +0200 (MEST)
In-Reply-To: <200607111430.k6BEUUus006736@turing-police.cc.vt.edu>
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
Cc: Adam =?iso-8859-2?Q?Tla=B3ka?= <atlka@pg.gda.pl>, alsa-devel@alsa-project.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-07-11 at 10:30 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 11 Jul 2006 08:15:28 +0200, Adam =?ISO-8859-2?B?VGxhs2th?= said:
> > Sorry to say but it is just not that way. Window manager is for managing windows
> > and it shouldn't depend on any audio system. It should use an external app using exec call
> > to play sounds (aplay, sox, wavplay etc.) configured by some config option.
> 
> So what you're saying is that something like 'esd' *is* needed.  (It's
> certainly silly to keep doing fork/exec for every little sound sample when
> you can just leave the app running and hand it requests...)

That approach also won't be reliable as it ignores the realtime
constraint that is inherent in audio playback.  It will probably work on
a fast/lightly loaded machine but will glitch out under load.

It's how GDM plays startup/shutdown sounds and it sucks - on shutdown
the sound is choppy.  You either need a dedicated daemon running
SCHED_FIFO or an RT thread for reliable audio playback.

Lee



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
