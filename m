From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: Input/output error while playing a file using aplay
Date: Mon, 25 Jun 2007 14:26:44 +0530
Message-ID: <61445c750706250156p42de468vecbf7ca4f373f2b0@mail.gmail.com>
References: <61445c750706221312t4449c847p72523339f228a101@mail.gmail.com>
	<1182754597.9211.1196859135@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 432DF24389
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Jun 2007 10:56:46 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so1733895wag
	for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2007 01:56:44 -0700 (PDT)
In-Reply-To: <1182754597.9211.1196859135@webmail.messagingengine.com>
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
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>The ALSA framework will stop the stream and return the error code EIO
>when there was no interrupt for ten seconds, i.e., when
>snd_pcm_period_elapsed() was not called.

I am getting the interrupts, but why there wont be any interrupt for
10 seconds?
I am setting the periods in prepare as periods = runtime->period, so
interrupts should
at period boundaries.

May be s->active got corrupted.


On 6/25/07, Clemens Ladisch <cladisch@fastmail.net> wrote:
> Pharaoh . wrote:
> > ...
> > It waits here for sometime and then I get
> > snd_omap_alsa_trigger starte error: Input/output error
>
> The ALSA framework will stop the stream and return the error code EIO
> when there was no interrupt for ten seconds, i.e., when
> snd_pcm_period_elapsed() was not called.
>
> Either s->active got corrupted, or your interrupt handler never got
> called.
>
> BTW: snd_pcm_period_elapsed() can stop the stream in some situations,
> so you should move this call to the end of the interrupt handler, or
> check s->active again after calling it.
>
>
> HTH
> Clemens
>
