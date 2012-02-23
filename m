From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] Wrong latency in pulseaudio plugin breaks
 Adobe Flash Player
Date: Thu, 23 Feb 2012 10:01:09 +0100
Message-ID: <4F460055.2010508@ladisch.de>
References: <alpine.LFD.2.00.1202161015470.19707@lpc8.fields.utoronto.ca>
	<4F3DAC41.4000602@canonical.com>
	<alpine.LFD.2.00.1202162248280.21549@fields.fields.utoronto.ca>
	<4F3E1A04.9080404@canonical.com>
	<alpine.LFD.2.00.1202171351300.11808@lpc8.fields.utoronto.ca>
	<4F42323E.1030204@canonical.com>
	<alpine.LFD.2.00.1202222059170.29627@fields.fields.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 61BD524344
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 09:58:32 +0100 (CET)
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 9EB8F21607
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 03:58:29 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1202222059170.29627@fields.fields.utoronto.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Philip Spencer <pspencer@fields.utoronto.ca>
Cc: alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Philip Spencer wrote:
>     3. What should happen?
>
>            (a) The call returns immediately, since there's lots of room
>                in the buffer.
>
>            (b) The call returns after one I/O period's worth of data has
>                been drained from the buffer.

(a)

> If the correct answer is (a) (ALSA's current behaviour), then is there
> any mechanism for an app to achieve (b) -- get woken up after one I/O
> period's worth of data have been drained (other than just doing some
> infinite loop of sleeping then checking snd_pcm_avail periodically)?

Adjust avail_min (but note that wakeups happen only at period
boundaries).


Regards,
Clemens
