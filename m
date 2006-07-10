From: Olivier Galibert <galibert@pobox.com>
Subject: Re: OSS driver removal, 2nd round (v2)
Date: Tue, 11 Jul 2006 01:59:35 +0200
Message-ID: <20060710235934.GC26528@dspnet.fr.eu.org>
References: <20060707231716.GE26941@stusta.de> <p737j2potzr.fsf@verdi.suse.de>
	<1152458300.28129.45.camel@mindpipe>
	<20060710132810.551a4a8d.atlka@pg.gda.pl>
	<1152571717.19047.36.camel@mindpipe> <44B2E4FF.9000502@pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from dspnet.fr.eu.org (dspnet.fr.eu.org [213.186.44.138])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2CEB0223
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Jul 2006 01:59:37 +0200 (MEST)
Content-Disposition: inline
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
To: Adam Tla?ka <atlka@pg.gda.pl>
Cc: alsa-devel@alsa-project.org, ak@suse.de, linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>, perex@suse.cz, alan@lxorguk.ukuu.org.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 11, 2006 at 01:38:39AM +0200, Adam Tla?ka wrote:
> Sorry but is a Windows solution the best on the whole world?

ALSA, with its "the API is a DLL", is a Windows solution.


> >esd and artsd are no longer needed since ALSA began to enable software
> >mixing by default in release 1.0.9.
> 
> So why they are still exist in so many Linux distributions?

That's an extremely recent change in distribution-time.


> Format changing, resampling, mixing and supporting additional plugins
> does not seems to be just low level HAL for hw device. It creates some 
> kind of virtual functionality which means more then this provided by 
> hardware device itself.

ALSA lib has something like 7 different methods just to play a sound.
Their view of "low level" is quite interesting.  Using it is pure
hell.  Debugging what you've done is worse.  And don't bother to hope
that your code will still work in six months.

  OG.



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
