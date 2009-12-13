From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: hw_ptr accuracy with intel8x0 -> PulseAudio issue
Date: Sun, 13 Dec 2009 10:50:11 +0800
Message-ID: <4f3252890912121850m66cce315laf890b6bfb7088c7@mail.gmail.com>
References: <6160a5130912020115t45bd4635hceb0ac3de4fb1efe@mail.gmail.com>
	<6160a5130912030828m5b2401f3w31a67b6b51e8d8b6@mail.gmail.com>
	<4f3252890912031442i56ccc905g935a4d6ed48f40c6@mail.gmail.com>
	<6160a5130912031650u5949c921jc86d0847b2844803@mail.gmail.com>
	<4f3252890912041817u7ab83a3eh7643476d64d709f3@mail.gmail.com>
	<s5h4oo1sisn.wl%tiwai@suse.de>
	<4f3252890912090355n70a2b5cfu4fbb74d473480a94@mail.gmail.com>
	<s5hr5r4ntus.wl%tiwai@suse.de>
	<4f3252890912091941y34509e3brd235360485c8c967@mail.gmail.com>
	<6160a5130912100644m7f090fdaxaa193737441c337d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 80FA81037FE
	for <alsa-devel@alsa-project.org>; Sun, 13 Dec 2009 03:50:13 +0100 (CET)
Received: by pwi18 with SMTP id 18so4223183pwi.32
	for <alsa-devel@alsa-project.org>; Sat, 12 Dec 2009 18:50:11 -0800 (PST)
In-Reply-To: <6160a5130912100644m7f090fdaxaa193737441c337d@mail.gmail.com>
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

2009/12/10 pl bossart <bossart.nospam@gmail.com>

> > 2) why PA use  snd_pcm_hw_params_get_buffer_size_max() instead of
> > snd_pcm_hw_params_get_buffer_size() after snd_pcm_hw_params() ?
>
> Precisely to use the maximum preallocated buffer size.
>


D: module-alsa-sink.c: latency set to 46.44ms
D: module-alsa-sink.c: hwbuf_unused_frames=1
D: module-alsa-sink.c: setting avail_min=4662
D: module-alsa-sink.c: Requesting rewind due to latency change.
D: module-alsa-sink.c: Requested to rewind 8192 bytes.
D: module-alsa-sink.c: Limited to 3712 bytes.
D: module-alsa-sink.c: before: 928

The driver only allocated the requested buffer size at hw_param callback

As you can see , PA only rewind 8192 bytes only instead of 371 ms ?
