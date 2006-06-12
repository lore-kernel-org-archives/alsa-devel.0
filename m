From: John Rigg <ad@sound-man.co.uk>
Subject: Re: open /dev/snd/seq failed
Date: Mon, 12 Jun 2006 09:09:51 +0100
Message-ID: <20060612080951.GA2632@localhost.localdomain>
References: <E1FpPt7-0001Z8-7E@localhost.localdomain>
	<1150045861.14253.119.camel@mindpipe>
	<20060611183043.GA6409@localhost.localdomain>
	<1150055462.14253.162.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1150055462.14253.162.camel@mindpipe>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, Jun 11, 2006 at 03:51:01PM -0400, Lee Revell wrote:
> I can't see why udev does not load this module on demand when the
> sequencer is first used.

Debian testing and unstable kernels are now using initramfs instead
of initrd. According to initramfs docs there are possible issues
with hotplug. I fixed the problem temporarily by adding snd_seq_midi
to /etc/modules, but I'll try changing back to initrd.

John
