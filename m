From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] Wrong latency in pulseaudio plugin breaks
 Adobe Flash Player
Date: Thu, 23 Feb 2012 09:24:26 +0100
Message-ID: <4F45F7BA.2000705@canonical.com>
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
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 65BC12412E
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 09:24:29 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/23/2012 03:50 AM, Philip Spencer wrote:
> What is the "right" behaviour in the following scenario?
>
> 1. An app writes samples, at least one I/O period's worth, but not
> a full buffer's worth.
>
> 2. The app then calls pcm_snd_wait, or calls poll or select on the
> polling file descriptors.
>
> 3. What should happen?
>
> (a) The call returns immediately, since there's lots of room
> in the buffer.
>
> (b) The call returns after one I/O period's worth of data has
> been drained from the buffer.

I would say that (a) is the correct one. According to the documentation, 
snd_pcm_wait says:

/**
  * \brief Wait for a PCM to become ready
  * \param pcm PCM handle
  * \param timeout maximum time in milliseconds to wait,
  *        a negative value means infinity
  * \return a positive value on success otherwise a negative error code
  *         (-EPIPE for the xrun and -ESTRPIPE for the suspended status,
  *          others for general errors)
  * \retval 0 timeout occurred
  * \retval 1 PCM stream is ready for I/O
  */

Since the PCM stream is ready for I/O (the buffer is not full, you can 
write more data to it), it is correct for it to return.

> If the correct answer is (a) (ALSA's current behaviour), then is there
> any mechanism for an app to achieve (b) -- get woken up after one I/O
> period's worth of data have been drained (other than just doing some
> infinite loop of sleeping then checking snd_pcm_avail periodically)?

Good question, I'm not really sure. Well, setting a system timer is 
obviously more power efficient than checking snd_pcm_avail every ms or so.

> If the correct answer is (b), then things would need to be changed in
> ALSA, but would this break any existing apps that wait or poll before
> filling up the buffer?
>
> If ALSA were to be changed to behave as (b), then an app can easily
> achieve the old behaviour (a) by simply doing
>
> if (snd_pcm_avail(...) < ...) snd_pcm_wait(...)
>
> instead of a plain snd_pcm_wait, but I don't see how to easily achieve (b)
> if ALSA behaves as (a).

Well, changing the behaviour in all applications is not trivial 
considering the amount of applications out there, including closed 
source ones ;-)

As for Flash, it looks to me that they should reduce the total length of 
the buffer to the latency they want to achieve. If they need to change 
the latency while playing back, I don't think there is a way to do that 
in ALSA without closing and re-opening the stream. If you use the 
PulseAudio client API directly, you can use pa_stream_set_buffer_attr.

That is, try working with filled buffers and change the buffer length if 
needed, rather than working with almost empty buffers.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
