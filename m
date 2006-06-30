From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: OSS driver removal, 2nd round
Date: Fri, 30 Jun 2006 17:29:26 -0400
Message-ID: <1151702966.32444.57.camel__35681.2111837373$1151703017$gmane$org@mindpipe>
References: <20060629192128.GE19712@stusta.de>
	<44A54D8E.3000002@superbug.co.uk>
	<20060630163114.GA12874@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id B3A6F29D
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jun 2006 23:29:26 +0200 (MEST)
In-Reply-To: <20060630163114.GA12874@dspnet.fr.eu.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Olivier Galibert <galibert@pobox.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Olaf Hering <olh@suse.de>, James Courtier-Dutton <James@superbug.co.uk>, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-06-30 at 18:31 +0200, Olivier Galibert wrote:
> On Fri, Jun 30, 2006 at 05:13:02PM +0100, James Courtier-Dutton wrote:
> > Adrian Bunk wrote:
> > >- ALSA #1735 (OSS emulation 4-channel mode rear channels not working)
> > 
> > As the MAINTAINER of EMU10K1, I am happy for EMU10K1 driver to be 
> > removed from the kernel.
> > 
> > ALSA #1735 is now closed. All the apps the user was trying also support 
> > ALSA natively now, so OSS is not needed.
> 
> Are you joking ?
> 

Even if you reject this argument, the bug is in ALSA's in-kernel OSS
emulation, not the emu10k1 driver.

As sound hardware gets dumber and cheaper, kernel OSS emulation will
become increasingly useless.  The cheap onboard devices (and even mid
range stuff like the SBLive! 24 bit) require sample rate conversion,
mixing, and even volume control to be handled in software.  ALSA's
in-kernel OSS emulation does not have these features and never will.

(I wish the authors of Skype, Flash, TeamSpeak, Enemy Territory, and
other proprietary OSS-only apps would understand this ;-)

Lee


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
