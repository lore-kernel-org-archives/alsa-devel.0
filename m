From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: /dev/dsp exclusive open?
Date: Wed, 19 Apr 2006 16:05:21 -0400
Message-ID: <1145477122.31023.17.camel@mindpipe>
References: <F23ABFFDB8261D40A6F6D30EA0148825308F62@VS6.EXCHPROD.USA.NET>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <F23ABFFDB8261D40A6F6D30EA0148825308F62@VS6.EXCHPROD.USA.NET>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Steve Finney <sfinney@healthhero.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-04-19 at 12:06 -0600, Steve Finney wrote:
> In various docs, I thought I had seen references to the fact that
> only one process should be able to open /dev/dsp (OSS). I'm running
> ALSA 1.0.10rc1
> (Linux kernel 2.6.14.3), and it appears as if it is possible to open
> /dev/dsp twice (two separate processes), but the _third_ open will
> return EBUSY. Is this a bug or a feature?
> 
It depends on the hardware.  If the device does hardware mixing like
emu10k1 or some VIA chips then multiple open will be possible.  If the
hardware only handles a single stereo stream like most new devices then
only one process can open it.

Since your hardware supports two streams I am guessing this is a VIA
chipset?

Lee



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
