From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Playback and capture synchronization
Date: Wed, 09 Nov 2011 12:55:14 +0100
Message-ID: <4EBA6A22.6090308@ladisch.de>
References: <4EB9E331.8070401@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 64C8E24484
	for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2011 12:54:33 +0100 (CET)
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 679E620E52
	for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2011 06:54:30 -0500 (EST)
In-Reply-To: <4EB9E331.8070401@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmciro.com>
List-Id: alsa-devel@alsa-project.org

Patrick Lai wrote:
> I have a use case requiring playback and capture starting at the same
> time. Latency between starting of playback and capture streams need to
> be less than few PCM samples. Base on my understanding on ALSA which
> does not have the concept of grouping multiple streams,

snd_pcm_link()

> the best I can do is getting playback and capture to prepared state
> then trigger start two streams one after the other. Then, the latency
> would be the time for trigger start of first stream to complete.

If the driver doesn't actually implement starting of linked streams
(which would be pointless if the hardware doesn't support it), ALSA
calls the second trigger callback after the first one.

It might be possible to implement simultaneous starting of two streams.
What hardware (driver) are you using?


Regards,
Clemens
