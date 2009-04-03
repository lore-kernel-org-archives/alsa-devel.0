From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: 0 or EAGAIN from snd_pcm_update_avail()?
Date: Fri, 3 Apr 2009 09:04:08 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0904030901390.17368@eeebox2.perex-int.cz>
References: <7337540c0904022320s2b40bf79r2ad00bd80569ffba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id E8DD91037F3
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Apr 2009 09:04:08 +0200 (CEST)
In-Reply-To: <7337540c0904022320s2b40bf79r2ad00bd80569ffba@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ludovico Cavedon <ludovico.cavedon@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2 Apr 2009, Ludovico Cavedon wrote:

> Hi all,
>
> if snd_pcm_update_avail() gets called on a PCM device in non-blocking
> mode when no data is availabe jet, what is the expected return value?
> -0
> -EAGAIN
> -either is valid
>
> I am asking this question because pulseaudio expect to receive 0, but
> the the bluetooth headset pcm transfer callback returns EAGAIN, so I
> want to find out against whoms I should open a bug :)

0.

-EAGAIN should be returned only for R/W operations but not for buffer 
position routines. They should return always immediatelly with 
useable value (thus EAGAIN does not make sense).

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
