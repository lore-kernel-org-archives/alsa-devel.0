From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Bug #952 - MIDI lockup
Date: Mon, 03 Jul 2006 12:07:09 -0400
Message-ID: <1151942829.25802.114.camel@mindpipe>
References: <1151880360.25802.44.camel@mindpipe> <s5hfyhiu1fa.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hfyhiu1fa.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-07-03 at 17:56 +0200, Takashi Iwai wrote:
> At Sun, 02 Jul 2006 18:45:59 -0400,
> Lee Revell wrote:
> > 
> > Can someone take a quick look at:
> > 
> > https://bugtrack.alsa-project.org/alsa-bug/view.php?id=952
> > 
> > There is a nice screenshot of the kernel panic.  The bug has been
> > verified with ALSA 1.0.12-rc1.
> > 
> > It seems to crash while taking a spinlock in snd_timer_interrupt when
> > called from rtc_interrupt - maybe the changes to the ALSA RTC timer a
> > few months ago are involved?
> 
> Does the patch below fix?
> 

Looks like it might.  I could not reproduce the problem myself but I've
attached it to the bug report for testing.

Lee


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
