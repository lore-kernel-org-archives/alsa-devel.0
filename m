From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: pulseaudio eats 19% CPU power in Fedora 12
Date: Wed, 21 Apr 2010 08:30:09 +0800
Message-ID: <u2l4f3252891004201730g94e709abs8ebf34b00d9ed505@mail.gmail.com>
References: <20100414075658.GA26283@localhost>
	<20100419032856.GA13629@tango.0pointer.de>
	<k2q604760771004182038n72eec9bdy77a9e4faf2152ee4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 646C81037F1
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Apr 2010 02:30:10 +0200 (CEST)
Received: by pvh1 with SMTP id 1so399725pvh.38
	for <alsa-devel@alsa-project.org>; Tue, 20 Apr 2010 17:30:09 -0700 (PDT)
In-Reply-To: <k2q604760771004182038n72eec9bdy77a9e4faf2152ee4@mail.gmail.com>
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

2010/4/19 Daniel Chen <seven.steps@gmail.com>

>  but, like
> Lennart suggests, these are by no means *caused* by PulseAudio.
>
> Best,
> -Dan
>
>
There are other factor affecting CPU usage  significantly

1) the number of pulseaudio clients connected to PA server (i.e. number of
audio stream need to be mixed )
2) the accuracy of system timer and the clock of the sound chip
3) the latency requirement of the different PA clients
4) the resampling method
5) the cpu loading of the system
6) the period time/period size selected by PA server to configure the alsa
driver

why do you ruled out the cause ?

>> If you use "pacat" you can play audio with almost zero CPU
usage

do you get the zero CPU usage in  Ubuntu 9.04/Ubuntu 9.10 with pacat on your
machines ?
