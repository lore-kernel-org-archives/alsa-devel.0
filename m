From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: IEC958 / SPDIF raw capture
Date: Fri, 12 Feb 2010 08:03:43 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002120802520.28127@eeebox2.perex-int.cz>
References: <325dd9ac1002101514u73929570l51a12d28ecddd7b@mail.gmail.com>
	<4B73B12A.7030508@ladisch.de>
	<325dd9ac1002111944h182fbcfbm9658a6106939448e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 3858E2413F
	for <alsa-devel@alsa-project.org>; Fri, 12 Feb 2010 08:03:44 +0100 (CET)
In-Reply-To: <325dd9ac1002111944h182fbcfbm9658a6106939448e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Donald Tournier <d.tournier@brain.org.au>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Fri, 12 Feb 2010, Donald Tournier wrote:

> Thanks Clemens, that very helpful. We'll try to source one of these
> C-Media cards as soon as possible.
>
> Also nice to know about the "hw:x" trick, although I'm not too sure
> how to use that in practice. I've just tried this command, with no
> success:
>
> $ arecord -D hw:x -t raw output.raw
> ALSA lib pcm_hw.c:1435:(_snd_pcm_hw_open) Invalid value for card
> arecord: main:608: audio open error: No such device
>
> How exactly should this be used?

Note that 'x' means card number or name. Just use 0 if you have only one 
card in system or use 'arecord -l' to list cards.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
