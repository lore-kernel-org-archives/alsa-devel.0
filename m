From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: "Resource temporarily unavailable" while reading
 although poll returns POLLIN event
Date: Wed, 21 Apr 2010 19:18:29 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1004211917120.16336@eeebox2.perex-int.cz>
References: <4BCEE140.5060704@gmail.com> <4BCF24AC.3000301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 532D5103838
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Apr 2010 19:18:30 +0200 (CEST)
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
To: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 21 Apr 2010, Stefan Schoenleitner wrote:

> Stefan Schoenleitner wrote:
>> Since a POLLIN event only occurs after at least a full period is available for
>> reading (as set up by snd_pcm_sw_params_set_avail_min() above)
>> and I only read after a POLLIN event occured on the capture device fd,
>> I really do not understand why I get the above error.
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

It might be. Could you post snd_pcm_dump() when you read less frames?

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
