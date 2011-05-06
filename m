From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd_pcm_avail_update() returning large values
Date: Fri, 6 May 2011 11:05:04 +0800
Message-ID: <BANLkTimzxiYAqcmPywZtp3mV-bi=tGoQ0g@mail.gmail.com>
References: <BANLkTinbySDA6g40WcWYt-Yo0B-g6_B83w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id A15BE103A11
	for <alsa-devel@alsa-project.org>;
	Fri,  6 May 2011 05:05:04 +0200 (CEST)
Received: by fxm5 with SMTP id 5so2255468fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 05 May 2011 20:05:04 -0700 (PDT)
In-Reply-To: <BANLkTinbySDA6g40WcWYt-Yo0B-g6_B83w@mail.gmail.com>
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

2011/5/6 Baek Chang <baeksan@ccrma.stanford.edu>

> Hi,
>
> Occasionally, when using pulseaudio I see the following message:
>
> snd_pcm_avail_update() returned a value that is exceptionally large.
>
> This seems to be an issue with the ALSA driver itself.  My question is how
> does snd_pcm_avail_update(), get updated? It uses hw buffer positions
> correct?  Is there an example driver that implements snd_pcm_avail_update()
> correctly and updates buffer positions correctly?
>
> Thanks
> Baek
>


You have to provide a test case which can reproduce the problem

(e.g.http://thread.gmane.org/gmane.linux.alsa.devel/78521 )


To debug,  you need to enable DEBUG_TIMING in
pulseaudio/src/modules/alsa/alsa-sink.c and
pulseaudio/src/modules/alsa/alsa-source.c

and follow
http://colin.guthr.ie/2010/09/compiling-and-running-pulseaudio-from-git/


The free-glitch mode is tailor made for snd-hda-intel , so it should be the
example driver


aplay can use minimum period size without any xrun on my snd-hda-intel

aplay -Dhw:CARD=Intel  -v --period-size=32 any.wav
