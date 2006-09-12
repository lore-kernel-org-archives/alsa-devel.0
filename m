From: Lee Revell <rlrevell@joe-job.com>
Subject: Driver design question
Date: Tue, 12 Sep 2006 16:27:18 -0400
Message-ID: <1158092839.16327.34.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

I have a device here that can play PCM, but it's a weird implementation.
Only 2 periods of 0x2000 words per buffer are supported, and there is no
DMA - the driver must poll a status register, and when the chip is
ready, deliver all 0x2000 words using outw() then send an end xfer
command.

I think I need to use an intermediate buffer, and implement copy/silence
callbacks that write to this.  Then I plan to use a tasklet or workqueue
to do the actual xfer of PCM data to the hardware.  A timer callback
will periodically check whether at least 0x2000 words are in the buffer
and if so, schedule the tasklet to drain it.

I presume this implementation cannot support mmap() as there's no random
access to the hardware buffer.  Is this correct?

Do I call snd_pcm_period_elapsed() from the timer, immediately before
scheduling the tasklet, or from the tasklet, after the data has been
transferred to the hw?

In general, does this seem like a reasonable implementation?

Lee


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
