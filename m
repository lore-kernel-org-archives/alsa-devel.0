From: "Jeffrey W. Baker" <jwbaker@acm.org>
Subject: ALSA drivers for USB audio devices
Date: 19 Mar 2002 14:24:06 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1016576646.23423.40.camel@heat>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Recently on this very list, Paul Barton-Davis proposed that one could
build a driver for a USB audio device entirely in user space.  I think
this is an interesting idea, as I own an Edirol UA-5 USB audio device. 
Naturally I would like to use it with ALSA to acheive the best
performance and lowest latency.

I hope someone on this list can describe how such a driver would work. 
I am not aware of any user-space drivers for ALSA.  If there is one,
that would be a nice example.  Would the driver take the form of a
userspace daemon?  How would the ALSA library communicate with the
daemon?  Or, would the driver instead take the form of a shared library
which ALSA libraries would load?

In the daemon case, I have trouble imagining that a userspace
implementation would acheive low latency.  The client application, say a
mixing board program, would have to write some data to the ALSA PCM
handle, then wait for the daemon to get scheduled.  The latency would be
all over the place.

In the case of a library that ALSA loads, that scheduling problem would
not exist.

In any case, it seems almost MORE straightforward to write an kernel
driver like the other supported output devices use.  A 24-bit/96KHz
stereo audio stream requires driving the USB bus at nearly full
throttle.  I doubt a userspace implementation could deal with it.

Thoughts?

-jwb

PS: even at 16-bit/48KHz the USB audio device driver in Linux 2.4.18
taxes the CPU significantly.


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
