From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: Fast Track Ultra latency and new streaming logic.
Date: Tue, 1 May 2012 15:09:09 +0200
Message-ID: <CAFz=ag4fk1r6Y--6Xjwfog5dW4x6ch_4eX4qPyQ8uhoPHnXJWA@mail.gmail.com>
References: <CACckToWK=Si8-8rPKgo-ZWA+ncTVb7zW8jHZvf7VbKT1sMM32Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B7B6D1042A9
	for <alsa-devel@alsa-project.org>;
	Tue,  1 May 2012 15:09:10 +0200 (CEST)
Received: by yhnn12 with SMTP id n12so1913130yhn.38
	for <alsa-devel@alsa-project.org>; Tue, 01 May 2012 06:09:09 -0700 (PDT)
In-Reply-To: <CACckToWK=Si8-8rPKgo-ZWA+ncTVb7zW8jHZvf7VbKT1sMM32Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Diffey <gdiffey@gmail.com>
Cc: alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

Am 01.05.2012 02:18 schrieb "Grant Diffey" <gdiffey@gmail.com>:
> I can't seem to get below 512frames in flight (2 256sample frames or 4
128 or 8 64's) without consistant overruns.

Yes, I noticed this, too. I carelessly attributed this to the kernel used
for my testing being non-realtime, non-lowlatency. Somehow I forgot to
further investigate...

What could you achieve with the old streaming logic? I think I could go
down to 2x128 frames.

(I'm typing this on my phone and can't tell reliably. I will post an update
as soon as I'm back at my machines/FTU.)

Regards,
Felix
