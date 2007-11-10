From: "Piers O'Hanlon" <p.ohanlon@cs.ucl.ac.uk>
Subject: Re: Getting XRUN after writei in RUNNING state?
Date: Sat, 10 Nov 2007 11:46:40 +0000
Message-ID: <abe39f780711100346r2b71c664u777c96f60f1db0e8@mail.gmail.com>
References: <47348C2D.7020509@cs.ucl.ac.uk>
	<Pine.LNX.4.61.0711091746060.8935@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.231])
	by alsa0.perex.cz (Postfix) with ESMTP id CC73924759
	for <alsa-devel@alsa-project.org>; Sat, 10 Nov 2007 12:46:41 +0100 (CET)
Received: by wx-out-0506.google.com with SMTP id t11so633822wxc
	for <alsa-devel@alsa-project.org>; Sat, 10 Nov 2007 03:46:40 -0800 (PST)
In-Reply-To: <Pine.LNX.4.61.0711091746060.8935@tm8103-a.perex-int.cz>
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
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Jaroslav,

Just to let you know I'm running this on Ubuntu 7.10
(alsa-lib-1.0.14), though I've been seeing this underrun problem for a
while on a few systems (Ubuntu 7.04/6.10, and Gentoo 2006.1). It
hasn't been clear to me what the key parameters are that control
underrun behaviour. (It would be great if someone wrote a
comprehensive book/article on ALSA....)

BTW you mentioned doing the rate resampling in RAT - which it can do -
how does one discover if rate conversion is occurring in ALSA and
obtain that 'base' rate? (Though I has assumed that ALSA would do the
better job of rate resampling if it was necessary...).

Thanks,

Piers.

On 09/11/2007, Jaroslav Kysela <perex@perex.cz> wrote:
> On Fri, 9 Nov 2007, Piers O'Hanlon wrote:
>
> > ===snd_pcm_dump_setup:===============
> >   stream       : PLAYBACK
> >   access       : RW_INTERLEAVED
> >   format       : S16_LE
> >   subformat    : STD
> >   channels     : 1
> >   rate         : 16000
> >   exact rate   : 16000 (16000/1)
> >   msbits       : 16
> >   buffer_size  : 2048
> >   period_size  : 341
> >   period_time  : 21333
> >   tick_time    : 0
> >   tstamp_mode  : NONE
> >   period_step  : 1
> >   sleep_min    : 0
> >   avail_min    : 341
> >   xfer_align   : 1
> >   start_threshold  : 341
> >   stop_threshold   : 2048
> >   silence_threshold: 0
> >   silence_size : 0
> >   boundary     : 536870912
>
> Could you do whole dump (snd_pcm_dump()) to see all plugins in chain?
> I judge from period_size that we have another problem with rate plugin.
> It would be better to do rate resampling in RAT.
>
>                                                 Jaroslav
>
> -----
> Jaroslav Kysela <perex@perex.cz>
> Linux Kernel Sound Maintainer
> ALSA Project
>
