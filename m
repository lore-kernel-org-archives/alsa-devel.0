From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: disabling full duplex in oss emulation
Date: Tue, 15 Aug 2006 10:56:45 +0100
Message-ID: <200608151056.45853.gineera@aspect135.co.uk>
References: <1155504459.8241.4.camel@Rainsong>
	<1155514074.19474.7.camel@mindpipe>
	<1155522219.11308.4.camel@Rainsong>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1155522219.11308.4.camel@Rainsong>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Monday 14 August 2006 03:23, James C Georgas wrote:
> The problem is a game called Terminus. It spawns separate threads to
> handle each half of the duplex. However, one of the threads has a bug in
> it I think, because it goes into an endless loop and hangs the whole
> app. It works fine with native OSS drivers, because the OSS emu10k1
> driver doesn't implement full duplex, and the program skips spawning the
> thread.
>
> So basically, I need a way to turn off full duplex before running this
> program.

I have posted to this list about 'Linux Duplex bug', which arises because the 
OSS control can only set one value for DSP_NUMBER_OF_CHANNELS.  Problems 
occur if the duplex stream has different record and playback numbers of 
channels.  Just in case this is relevant here, look up the posting.

Alan


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
