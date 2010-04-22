From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: "Resource temporarily unavailable" while reading
	although poll returns POLLIN event
Date: Thu, 22 Apr 2010 12:28:51 +0800
Message-ID: <y2n4f3252891004212128x22c1be90pd22a4fa58a31a57c@mail.gmail.com>
References: <4BCEE140.5060704@gmail.com> <4BCF24AC.3000301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id 6536B24441
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Apr 2010 06:28:53 +0200 (CEST)
Received: by pwj8 with SMTP id 8so5064014pwj.38
	for <alsa-devel@alsa-project.org>; Wed, 21 Apr 2010 21:28:52 -0700 (PDT)
In-Reply-To: <4BCF24AC.3000301@gmail.com>
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

2010/4/22 Stefan Schoenleitner <dev.c0debabe@gmail.com>

> Stefan Schoenleitner wrote:
> > Since a POLLIN event only occurs after at least a full period is
> available for
> > reading (as set up by snd_pcm_sw_params_set_avail_min() above)
> > and I only read after a POLLIN event occured on the capture device fd,
> > I really do not understand why I get the above error.
>
> By using snd_pcm_avail_update() I found out that polling on the PCMs
> *does not work at all*.
>
> Although I verified that avail_min is 160 frames, polling on the
> capture/playback PCMs returns a POLLIN/POLLOUT event even if the number
> of frames for reading/writing *is less than avail_main*.
>
> I also tried snd_pcm_wait() which should also wait until there are at
> least avail_min frames available for reading/writing.
> The result is the same: snd_pcm_avail_update() shows that it returns
> even if there are far less than avail_min frames available for processing.
>
> I suspect that this is a bug in ALSA ?
>
>
> cheers,
> stefan
>


your program expect the driver support 2 periods per buffer but does not
expicitly set the period

8000 Hz , S16_LE and mono

>> I verified that avail_min is 160 frames

is there any specific reason to choose 160 frames ?
