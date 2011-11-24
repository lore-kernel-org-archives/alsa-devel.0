From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_pcm_drain and partial periods
Date: Thu, 24 Nov 2011 15:17:42 +0100
Message-ID: <4ECE5206.4060408@ladisch.de>
References: <CA+7tXihfkZd6+UmnwJiyLgwo+6PoU9fWvzNhz7FKzy7DNgAWMw@mail.gmail.com>
	<CA+7tXii1Ah5Z7UxyHr0=jNALt-qORQ0fG8WcNiAGWuSxbMq=7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 2BF4624424
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 15:16:46 +0100 (CET)
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 8225A21312
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 09:16:43 -0500 (EST)
In-Reply-To: <CA+7tXii1Ah5Z7UxyHr0=jNALt-qORQ0fG8WcNiAGWuSxbMq=7g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <tpiepho@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Trent Piepho wrote:
> Say an application does not write a full multiple of the period size
> with snd_pcm_writei().  It's playing a clip and the clip ends and it
> doesn't happen to end on a multiple of 6000 frames or whatever the
> period size is.
>
> Now the application calls snd_pcm_drain() to wait for the clip to finish.
>
> How does the driver know to stop when it gets to the end of the
> supplied data?

It doesn't.

> It seems like the driver will keep playing until it calls
> snd_pcm_period_elapsed() at the end of the final period.  Then the
> alsa pcm layer will call the ->trigger() method and stop the stream.

Yes.

> Hopefully before the driver has started the next DMA for the next
> period!

Let's hope that the FIFOs are large enough so that the actual playback
hasn't yet reached the period boundary ...

> I don't see any documentation for snd_pcm_drain() that says it will
> keep playing until it finishes a period, even if the data runs out
> before hand.  "For playback wait for all pending frames to be played
> and then stop the PCM."  Seems pretty clear that only the pending
> frames are played and not the rest of a period.

ALSA will stop the device when it realizes that it has run out of data
(just like an underrun).  This might happen before the period boundary
if there is some call to snd_pcm_status() or _delay() that reads the
current position (and if the hardware also supports reading the current
position).


It's racy and undocumented, but there's nothing a driver can do about
this.


Regards,
Clemens
