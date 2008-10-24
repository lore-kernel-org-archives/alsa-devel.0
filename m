From: "Sean McNamara" <smcnam@gmail.com>
Subject: Re: bluetooth alsa and software mixing
Date: Fri, 24 Oct 2008 14:34:34 -0400
Message-ID: <74eb1fe20810241134r238d21eatfdf130c6376d8fe9@mail.gmail.com>
References: <49020841.5020802@powercraft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 8996E245E4
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Oct 2008 20:34:53 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id l35so531360waf.16
	for <alsa-devel@alsa-project.org>; Fri, 24 Oct 2008 11:34:34 -0700 (PDT)
In-Reply-To: <49020841.5020802@powercraft.nl>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jelle de Jong <jelledejong@powercraft.nl>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Is this another one of your open-ended questions where you already
know of the problems with your question and the potential solutions,
but you actually have a bug using one of the solutions? If so, can I
have some more money? ;-)

Well, basically, only a very small subset of audio devices out there
(some older Creative soundblaster cards, and some newer pro audio
cards) have hardware mixing on-chip. ALSA's default raw interfaces do
not provide any software mixing, so unless the hardware supports
hardware mixing and the driver takes advantage of that, you won't have
the ability to open multiple streams at once on *any* ALSA device.

That's why we have:

1. Dmix, and
2. PulseAudio.

There is ample documentation out there about how to set up and
configure dmix and pulseaudio. To add dmix to your example, you would
just have to define a dmix instance with a slave of your softvol PCM,
and a dsnoop device with a slave of the softvol device. If softvol
doesn't work this way, try making the slave the headset device.

Pulseaudio could also use the raw headset device in module-alsa-sink.

Have you tried these with no success? If so, what sorts of issues are
you getting?

I just thought I'd point out that, with the configuration you posted,
there is no expectation that you'll get any sort of mixing of streams
at all; that's by design. But based on your previous posts I think you
already know that...?

Sean

2008/10/24 Jelle de Jong <jelledejong@powercraft.nl>:
> Hello everybody,
>
> I have a bunch of bluetooth audio devices, and I can currently only play
> one audio stream as once, and i would like to be able to listen to radio
> and other sounds at the same time. So i think some sort of software
> mixing is needed to get this working. I attached my .asound / also
> configuration. How can I configure my bluetooth system so that I can
> listen to different sources of audio at the same time?
>
> Thank for any information in advance,
>
> Kind regards,
>
> Jelle
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
