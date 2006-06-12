From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: open /dev/snd/seq failed
Date: Mon, 12 Jun 2006 10:51:02 -0400
Message-ID: <1150123863.22720.30.camel@mindpipe>
References: <E1FpPt7-0001Z8-7E@localhost.localdomain>
	<1150045861.14253.119.camel@mindpipe>
	<20060611183043.GA6409@localhost.localdomain>
	<1150055462.14253.162.camel@mindpipe>
	<20060612080951.GA2632@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060612080951.GA2632@localhost.localdomain>
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

On Mon, 2006-06-12 at 09:09 +0100, John Rigg wrote:
> On Sun, Jun 11, 2006 at 03:51:01PM -0400, Lee Revell wrote:
> > I can't see why udev does not load this module on demand when the
> > sequencer is first used.
> 
> Debian testing and unstable kernels are now using initramfs instead
> of initrd. According to initramfs docs there are possible issues
> with hotplug. I fixed the problem temporarily by adding snd_seq_midi
> to /etc/modules, but I'll try changing back to initrd.

What do initramfs and initrd have to do with it?  I do not use either
one, and snd-seq-midi does not autoload for me.

Lee
