From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: OSS driver removal, 2nd round
Date: Fri, 30 Jun 2006 17:54:37 -0400
Message-ID: <1151704479.32444.72.camel@mindpipe>
References: <20060629192128.GE19712@stusta.de>
	<44A54D8E.3000002@superbug.co.uk>
	<20060630163114.GA12874@dspnet.fr.eu.org>
	<1151702966.32444.57.camel@mindpipe>
	<1151703286.11434.61.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 08006228
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jun 2006 23:54:29 +0200 (MEST)
In-Reply-To: <1151703286.11434.61.camel@laptopd505.fenrus.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Arjan van de Ven <arjan@infradead.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Olivier Galibert <galibert@pobox.com>, Adrian Bunk <bunk@stusta.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Olaf Hering <olh@suse.de>, James Courtier-Dutton <James@superbug.co.uk>, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-06-30 at 23:34 +0200, Arjan van de Ven wrote:
> On Fri, 2006-06-30 at 17:29 -0400, Lee Revell wrote:
> > As sound hardware gets dumber and cheaper, kernel OSS emulation will
> > become increasingly useless.  The cheap onboard devices (and even mid
> > range stuff like the SBLive! 24 bit) require sample rate conversion,
> > mixing, and even volume control to be handled in software.  ALSA's
> > in-kernel OSS emulation does not have these features and never will.
> > 
> > (I wish the authors of Skype, Flash, TeamSpeak, Enemy Territory, and
> > other proprietary OSS-only apps would understand this ;-)
> 
> 
> maybe it's time to start printing a warning to users of OSS api (rate
> limited etc etc)

It might help, but I'm not so sure.  The users have been complaining for
years (the most common complaint by far on #alsa is that OSS apps block
the soundcard) but these vendors don't seem to listen.  I doubt that
complaints in the kernel log will have an effect if they won't listen to
their users.

I've heard that one reason they won't port to ALSA is that they think
the in-kernel OSS emulation will be "fixed" someday.  Maybe we need to
make it clearer that this won't happen?

Lee


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
