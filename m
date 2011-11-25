From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd_pcm_drain and partial periods
Date: Fri, 25 Nov 2011 18:38:56 +0100
Message-ID: <4ECFD2B0.9050703@ladisch.de>
References: <CA+7tXihfkZd6+UmnwJiyLgwo+6PoU9fWvzNhz7FKzy7DNgAWMw@mail.gmail.com>
	<CA+7tXii1Ah5Z7UxyHr0=jNALt-qORQ0fG8WcNiAGWuSxbMq=7g@mail.gmail.com>
	<4ECE5206.4060408@ladisch.de>
	<CA+7tXihNEmsjq=xkb5T22smnCcVM8vdBxMYwHSz4YFbMWo5_5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 7BA26103EEC
	for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2011 18:38:02 +0100 (CET)
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 21CE5202E2
	for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2011 12:37:59 -0500 (EST)
In-Reply-To: <CA+7tXihNEmsjq=xkb5T22smnCcVM8vdBxMYwHSz4YFbMWo5_5g@mail.gmail.com>
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
> When the driver schedules the final period, couldn't it check if the
> device is draining, and if so try to end playback at the right time.

The ALSA framework was designed for cards where DMA doesn't need to
be scheduled continuously, so it is assumed that stopping happens
asynchronously.

You could try to check the PCM state, but it's possible that the call
to snd_pcm_drain() happens after you've scheduled the final period.


Regards,
Clemens
