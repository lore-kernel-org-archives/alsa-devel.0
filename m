From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: ALSA/pulseaudio problem workaround
Date: Thu, 17 Mar 2011 21:40:08 +0800
Message-ID: <AANLkTikipaEf8RUfqL0=UDPW79ChDo-rw2qkSutnYmDQ@mail.gmail.com>
References: <AANLkTinGB1-Ft0B98_Z9TnFkL+Pqd8VPVKy4bEC57c8n@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 44FF62437D
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 14:40:09 +0100 (CET)
Received: by fxm6 with SMTP id 6so2553112fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 06:40:09 -0700 (PDT)
In-Reply-To: <AANLkTinGB1-Ft0B98_Z9TnFkL+Pqd8VPVKy4bEC57c8n@mail.gmail.com>
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

2011/3/14 Craig Bourne <craigbourne@gmail.com>

> Here is a workaround for the problem I described in my email to you
> yesterday:
>
>
> Symptoms alsactl fails carping about pulseaudio,


seem alsactl is replaced by a stub program which does not perform anything

you have to file bug or ask in fedora forum


> audacity can be started on its own but no longer wants to cooperate with
> JACK and ALSA resulting in horribly distorted sound from something horked
> together in the background as a "favor" to the user,


Cannot connect to server  socket err= no such file or directory
Cannot connect to server socket
Jack server is not running or cannot be started
Expression 'stream->capture.pcm' failed in
'src/hostapi/share/alsa/pa_linux.c' line:3503

seem bug in portaudio


QjackCtl runs, produces messages, and blinks its cute
> little meter display but evidently does this off on the sidelines reporting
> 0 XRUNS even as every little jot and tiddle of computation produces a
> surprising audio result.
>
>
This look like bug since install Qjackctl-0.3.7-1-fc14 require to install
portaudio-9-19-fc12 as qjackctl only require jack-audio-connection

>
>
