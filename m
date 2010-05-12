From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [RFC] disabling ALSA period interrupts
Date: Wed, 12 May 2010 22:08:57 +0900
Message-ID: <AANLkTimF0qrCaiIk6-cjkxm1s-hA3bOgKdmsDe8PdV1a@mail.gmail.com>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id AE1D524410
	for <alsa-devel@alsa-project.org>;
	Wed, 12 May 2010 15:08:58 +0200 (CEST)
Received: by vws16 with SMTP id 16so10396vws.38
	for <alsa-devel@alsa-project.org>; Wed, 12 May 2010 06:08:58 -0700 (PDT)
In-Reply-To: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 30, 2010 at 7:38 AM, pl bossart <bossart.nospam@gmail.com> wrote:
> Howdy,
> When PulseAudio is used and all PCM is routed through PulseAudio
> (Fedora, Meego, etc), the notion of ALSA periods isn't very useful.
> PulseAudio uses a timer to refill buffers and the period interrupts
> are not used at all.

It seems the requirement is just to have as least wakeups as possible
in order to
maximize power savings.
If so, then how about setting the period size slightly smaller than
the ring-buffer: the
difference being just enough to refill the ring buffer. Of course, you
would have to
enforce full-buffer-size as the start threshold.
We do just that to implement low-power-audio-mode for latest Samsung
SoC's I2S blocks.
