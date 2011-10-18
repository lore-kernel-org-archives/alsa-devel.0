From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Writing a DMA-less PCM audio driver
Date: Tue, 18 Oct 2011 20:16:20 +0200
Message-ID: <4E9DC274.5040302@perex.cz>
References: <20111018175652.31ca3756@archvile>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [77.48.224.245])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E24B24381
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Oct 2011 20:16:21 +0200 (CEST)
In-Reply-To: <20111018175652.31ca3756@archvile>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Jander <david.jander@protonic.nl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Date 18.10.2011 17:56, David Jander wrote:
> 
> Hi all,
> 
> I am writing a PCM audio driver for a piece of (embedded) hardware that has no
> DMA, only a FIFO capable of holding 2048 samples. I was trying to use a
> kthread with high realtime (SCHED_FIFO) priority to keep the FIFO filled, and
> sleep with schedule_timeout(x), where "x" is depending on the current FIFO fill
> level. The same thread also calls snd_pcm_period_elapsed() on every completed
> period. It seems to work, but I get sporadic audio skips and I am trying to
> figure out where they come from. Most of the time schedule_timeout(1) takes
> almost exactly 1ms (1 jiffy at HZ=1000) to complete, but sometimes it takes up
> to 30ms. It seems related to file-IO (via NFS) happening on the system, but
> the effect is far bigger if the program that is playing the audio (mplayer)
> itself is producing file-IO. When using a large cache parameter on mplayer
> (effectively preloading the entire MP3 file into RAM), the problem is almost
> gone.
> Before deciding whether I should debug the network driver to see if it could
> produce such tremendous amounts of latency, is there a better way to solve this
> problem? Are there any other DMA-less audio drivers I could look at as an
> example?
> Any suggestion is welcome.

Any pure PCMCIA driver has to handle FIFOs (see the sound/pcmcia tree).
They use hardware interrupts for a better timing.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
