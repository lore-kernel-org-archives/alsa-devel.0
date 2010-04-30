From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: [RFC] disabling ALSA period interrupts
Date: Fri, 30 Apr 2010 12:39:07 -0500
Message-ID: <s2l6160a5131004301039r5da20135vc024bb1e0b1fb7cc@mail.gmail.com>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
	<1272645879.3220.177.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f189.google.com (mail-iw0-f189.google.com
	[209.85.223.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 9DCE6103907
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 19:39:09 +0200 (CEST)
Received: by iwn27 with SMTP id 27so481033iwn.5
	for <alsa-devel@alsa-project.org>; Fri, 30 Apr 2010 10:39:08 -0700 (PDT)
In-Reply-To: <1272645879.3220.177.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Liam,

> How do you handle any clock drift here between the HDA hardware
> interface clock and the PA timer ?

Good question. This is already handled by PulseAudio. The timer isn't
programmed with a fixed value but is adapted precisely to track
differences between system time and audio time. PulseAudio relies on
snd_pcm_avail() to query the number of samples played, and correlates
timer values with samples. There's a longer blurb on this at [1]. The
use of timers has pretty much broken most of the drivers as the values
returned by snd_pcm_avail weren't precise enough. However it's been a
year and a half now and things are ok on most hardware. The main
reason why this is interesting is that you can vary the latency on the
fly simply by reprogramming the timer. Having to define a fixed period
size for all use cases is a real problem for us. You end-up with a
compromise between latency and power that makes things suboptimal
across the board.
Cheers
-Pierre

[1] http://0pointer.de/blog/projects/pulse-glitch-free.html
