From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: pulseaudio eats 19% CPU power in Fedora 12
Date: Tue, 20 Apr 2010 13:36:07 +0800
Message-ID: <q2u4f3252891004192236z28134ef7ubacaf0331a539745@mail.gmail.com>
References: <20100414075658.GA26283@localhost>
	<20100419032856.GA13629@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DD21C1037EA
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Apr 2010 07:36:08 +0200 (CEST)
Received: by pwj8 with SMTP id 8so3517338pwj.38
	for <alsa-devel@alsa-project.org>; Mon, 19 Apr 2010 22:36:07 -0700 (PDT)
In-Reply-To: <20100419032856.GA13629@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/4/19 Lennart Poettering <mznyfn@0pointer.de>

>
> Yes, sure. If you use "pacat" you can play audio with almost zero CPU
> usage, because it is one of the few clients that actually asks for
> sensible latency (2s), which allows us to minimize the wakeup intervals
> to less than a second.
>
>
> Lennart
>
>
Just test it on Fedora 10

CPU usage of pulseuadio is above 3% when using pacat

CPU usage of pulseaudio is below 2% when using aplay

CPU usage of pulseaudio is below 3% when using paplay

the test audio is stereo 44100Hz pcm wav

Do you have any figures on Fedora 12 or 13 ?
