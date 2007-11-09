From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Getting XRUN after writei in RUNNING state?
Date: Fri, 9 Nov 2007 17:49:00 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0711091746060.8935@tm8103-a.perex-int.cz>
References: <47348C2D.7020509@cs.ucl.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id E16562432D
	for <alsa-devel@alsa-project.org>; Fri,  9 Nov 2007 17:49:01 +0100 (CET)
In-Reply-To: <47348C2D.7020509@cs.ucl.ac.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Piers O'Hanlon <p.ohanlon@cs.ucl.ac.uk>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 9 Nov 2007, Piers O'Hanlon wrote:

> ===snd_pcm_dump_setup:===============
>   stream       : PLAYBACK
>   access       : RW_INTERLEAVED
>   format       : S16_LE
>   subformat    : STD
>   channels     : 1
>   rate         : 16000
>   exact rate   : 16000 (16000/1)
>   msbits       : 16
>   buffer_size  : 2048
>   period_size  : 341
>   period_time  : 21333
>   tick_time    : 0
>   tstamp_mode  : NONE
>   period_step  : 1
>   sleep_min    : 0
>   avail_min    : 341
>   xfer_align   : 1
>   start_threshold  : 341
>   stop_threshold   : 2048
>   silence_threshold: 0
>   silence_size : 0
>   boundary     : 536870912

Could you do whole dump (snd_pcm_dump()) to see all plugins in chain?
I judge from period_size that we have another problem with rate plugin.
It would be better to do rate resampling in RAT.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project
