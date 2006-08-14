From: James C Georgas <jgeorgas@rogers.com>
Subject: Re: disabling full duplex in oss emulation
Date: Sun, 13 Aug 2006 22:23:39 -0400
Message-ID: <1155522219.11308.4.camel@Rainsong>
References: <1155504459.8241.4.camel@Rainsong>
	<1155504662.19474.2.camel@mindpipe> <1155509598.8211.5.camel@Rainsong>
	<1155514074.19474.7.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from smtp103.rog.mail.re2.yahoo.com (smtp103.rog.mail.re2.yahoo.com
	[206.190.36.81])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id C0B02194
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Aug 2006 04:22:59 +0200 (MEST)
In-Reply-To: <1155514074.19474.7.camel@mindpipe>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2006-13-08 at 17:31 -0400, Lee Revell wrote:
> On Sun, 2006-08-13 at 17:27 -0400, James C Georgas wrote:
> > Is there a way to disable full duplex mode at runtime for OSS emulation?
> > Perhaps a writable /proc entry or an environment variable? I have a
> > SBLive, which uses the emu10k1 driver.
> 
> I don't think so.  What problem are you trying to solve?
> 
> Lee

The problem is a game called Terminus. It spawns separate threads to
handle each half of the duplex. However, one of the threads has a bug in
it I think, because it goes into an endless loop and hangs the whole
app. It works fine with native OSS drivers, because the OSS emu10k1
driver doesn't implement full duplex, and the program skips spawning the
thread.

So basically, I need a way to turn off full duplex before running this
program.


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
