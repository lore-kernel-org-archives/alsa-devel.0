From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: snd_pcm_delay, hw buffers and driver api (v2)
Date: Fri, 14 Aug 2009 11:38:10 +0100
Message-ID: <ad2655cb0908140338q21ed09d6xd750bff561805d5a@mail.gmail.com>
References: <alpine.DEB.1.10.0908140023240.3417@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154])
	by alsa0.perex.cz (Postfix) with ESMTP id C5C5910390C
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Aug 2009 12:38:10 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id e21so362052fga.21
	for <alsa-devel@alsa-project.org>; Fri, 14 Aug 2009 03:38:10 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.10.0908140023240.3417@ecabase.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kai Vehmanen <kvehmanen@eca.cx>
Cc: alsa-devel@alsa-project.org, Ujfalusi Peter <peter.ujfalusi@nokia.com>, ext-eero.nurkkala@nokia.com
List-Id: alsa-devel@alsa-project.org

2009/8/13 Kai Vehmanen <kvehmanen@eca.cx>:
> Hi,
>
>
> Any update/ideas on this topic? Personally I think adding a new driver
> callback would make most sense, as that would allow to take full benefit
> from hardware that allows to query sample-accurate position of playout
> (i.e. not just support exposing a fixed latency). Of course that's
> potentially a big change. In alsa-lib, snd_pcm_hwsync() could call this
> driver callback, and a new variant of snd_pcm_delay() could present the
> information to the applications.

snd_pcm_delay() does not just support exposing a fixed latency. The
value returned is dynamic.

In the current ALSA implementation, the value returns a real time
count of how many samples are already in the hardware buffer.
So, if one makes a call to snd_pcm_delay(), waits for a period of a
few samples, the new value returned in snd_pcm_delay() is going to be
different, but only for sound cards that support this level of
accuracy.

So, I think the snd_pcm_delay() function is already doing what you want.
It was me who originally requested the snd_pcm_delay() function to be
introduced into the API, for the purposes of audio/video sync in the
media player xine.

Kind Regards

James
