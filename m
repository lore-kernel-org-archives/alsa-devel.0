From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: bug report: aloop: potential signedness bug in
 loopback_prepare()
Date: Sat, 9 Oct 2010 14:14:30 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1010091413020.17757@eeebox2.perex-int.cz>
References: <20101009114218.GQ11681@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 110DA24471
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Oct 2010 14:14:31 +0200 (CEST)
In-Reply-To: <20101009114218.GQ11681@bicker>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <error27@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 9 Oct 2010, Dan Carpenter wrote:

> Hi Jaroslav,
>
> sound/drivers/aloop.c +287 loopback_prepare(10)
> 	warn: bogus compare against zero: 'bps'
>   282          unsigned int bps, salign;
>   283
>   284          salign = (snd_pcm_format_width(runtime->format) *
>   285							runtime->channels) / 8;
>   286          bps = salign * runtime->rate;
>   287          if (bps <= 0 || salign <= 0)
>                    ^^^^^^^^^^^^^^^^^^^^^^^
>
>
> 	Both "bps" and "salign" are unsigned and are never less than
> 	zero.  Should this just be checking for == 0?  Or was the check
> 	supposed to catch integer overflows?

The condition works for both signed and unsigned values. That was only 
reason why I did not write '==' there.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
