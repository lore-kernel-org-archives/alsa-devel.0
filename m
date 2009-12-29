From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: DMA and delay feedback
Date: Tue, 29 Dec 2009 09:05:25 +0800
Message-ID: <4f3252890912281705r356200afp7e5bfefb369fae22@mail.gmail.com>
References: <ad2655cb0912140602s138b7246u6db75e40a699c729@mail.gmail.com>
	<6160a5130912140646g3738731fqbc5caacc153b9da8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 989AC10380A
	for <alsa-devel@alsa-project.org>; Tue, 29 Dec 2009 02:05:26 +0100 (CET)
Received: by pwi18 with SMTP id 18so26938536pwi.32
	for <alsa-devel@alsa-project.org>; Mon, 28 Dec 2009 17:05:25 -0800 (PST)
In-Reply-To: <6160a5130912140646g3738731fqbc5caacc153b9da8@mail.gmail.com>
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

2009/12/14 pl bossart <bossart.nospam@gmail.com>

> > For transfer purposes, one only needs to know that DMA transfer is
> > complete on period X so that period X can now be over-written.
>
> That's the 'traditional' view. ALSA is now used in different ways.
> PulseAudio sets a timer and relies on snd_pcm_avail() to query how
> many samples it can write to the ring buffer, the notion of period
> isn't used at all. I think we could use additional information in the
> way the hw_ptr position is reported, namely hints on how precise this
> information is and the granularity of the updates.
> - Pierre
>


Pulseaudio need more than a timer and relies on snd_pcm_avail() to query how
many samples it can write to the ring buffer,

Refer to http://0pointer.de/blog/projects/pulse-glitch-free.html

The third basic idea is to allow rewriting of the hardware buffer at any
time. .


>> For example, If the playback position is 0, the hardware has probably
>> already transferred one period of the sound card.
>> So, one cannot write to playback position 2 and expect it to be output
>> to the sound card if the period size is 1024

Using mmap only can allow writing of the hardware buffer at any time but
rewriting of the hardware buffer depend on the two new function
snd_pcm_rewind() and snd_pcm_rewindable()
