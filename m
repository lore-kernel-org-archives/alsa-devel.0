From: Trent Piepho <tpiepho@gmail.com>
Subject: Re: snd_pcm_drain and partial periods
Date: Sun, 27 Nov 2011 01:05:28 -0500
Message-ID: <CA+7tXijW+81Pc96cRfZha_sJhqEx19KWRpF6xLBn59=mQNahVQ@mail.gmail.com>
References: <CA+7tXihfkZd6+UmnwJiyLgwo+6PoU9fWvzNhz7FKzy7DNgAWMw@mail.gmail.com>
	<CA+7tXii1Ah5Z7UxyHr0=jNALt-qORQ0fG8WcNiAGWuSxbMq=7g@mail.gmail.com>
	<4ECE5206.4060408@ladisch.de>
	<CA+7tXihNEmsjq=xkb5T22smnCcVM8vdBxMYwHSz4YFbMWo5_5g@mail.gmail.com>
	<4ECFD2B0.9050703@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A2C7A2482A
	for <alsa-devel@alsa-project.org>; Sun, 27 Nov 2011 07:05:29 +0100 (CET)
Received: by iafi7 with SMTP id i7so7448042iaf.38
	for <alsa-devel@alsa-project.org>; Sat, 26 Nov 2011 22:05:28 -0800 (PST)
In-Reply-To: <4ECFD2B0.9050703@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Interesting, what the correct way to stop playing then?

The ALSA core could pad the stream with silence up to the end of the
period when drain is called.  It knows what the hw ptr value should be
at the next interrupt, which doesn't appear to be available to user
space.

On Fri, Nov 25, 2011 at 12:38 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Trent Piepho wrote:
>> When the driver schedules the final period, couldn't it check if the
>> device is draining, and if so try to end playback at the right time.
>
> The ALSA framework was designed for cards where DMA doesn't need to
> be scheduled continuously, so it is assumed that stopping happens
> asynchronously.
>
> You could try to check the PCM state, but it's possible that the call
> to snd_pcm_drain() happens after you've scheduled the final period.
>
>
> Regards,
> Clemens
