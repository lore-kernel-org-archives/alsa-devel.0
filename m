From: David Jander <david.jander@protonic.nl>
Subject: Writing a DMA-less PCM audio driver
Date: Tue, 18 Oct 2011 17:56:52 +0200
Message-ID: <20111018175652.31ca3756@archvile>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from protonic.xs4all.nl (protonic.xs4all.nl [213.84.116.84])
	by alsa0.perex.cz (Postfix) with ESMTP id CA001103958
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Oct 2011 17:56:40 +0200 (CEST)
Received: from archvile (archvile.prtnl [192.168.1.153])
	by protonic.xs4all.nl (Postfix) with ESMTP id D438E29EC4
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Oct 2011 17:53:51 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi all,

I am writing a PCM audio driver for a piece of (embedded) hardware that has no
DMA, only a FIFO capable of holding 2048 samples. I was trying to use a
kthread with high realtime (SCHED_FIFO) priority to keep the FIFO filled, and
sleep with schedule_timeout(x), where "x" is depending on the current FIFO fill
level. The same thread also calls snd_pcm_period_elapsed() on every completed
period. It seems to work, but I get sporadic audio skips and I am trying to
figure out where they come from. Most of the time schedule_timeout(1) takes
almost exactly 1ms (1 jiffy at HZ=1000) to complete, but sometimes it takes up
to 30ms. It seems related to file-IO (via NFS) happening on the system, but
the effect is far bigger if the program that is playing the audio (mplayer)
itself is producing file-IO. When using a large cache parameter on mplayer
(effectively preloading the entire MP3 file into RAM), the problem is almost
gone.
Before deciding whether I should debug the network driver to see if it could
produce such tremendous amounts of latency, is there a better way to solve this
problem? Are there any other DMA-less audio drivers I could look at as an
example?
Any suggestion is welcome.

Best regards,

-- 
David Jander
Protonic Holland.
