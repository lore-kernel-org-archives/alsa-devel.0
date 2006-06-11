From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: open /dev/snd/seq failed
Date: Sun, 11 Jun 2006 15:51:01 -0400
Message-ID: <1150055462.14253.162.camel@mindpipe>
References: <E1FpPt7-0001Z8-7E@localhost.localdomain>
	<1150045861.14253.119.camel@mindpipe>
	<20060611183043.GA6409@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060611183043.GA6409@localhost.localdomain>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: John Rigg <ad@sound-man.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 2006-06-11 at 19:30 +0100, John Rigg wrote:
> On Sun, Jun 11, 2006 at 01:11:00PM -0400, Lee Revell wrote:
> > Of course it won't work, snd-seq-midi is not loaded.
> 
> Thanks. Stupidity caused by lack of sleep.

I can't see why udev does not load this module on demand when the
sequencer is first used.

Lee
