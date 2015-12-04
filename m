From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [sound:for-linus 29/29]
 sound/pci/rme96.c:1035:1-7: preceding lock on line 991
Date: Fri, 4 Dec 2015 18:39:17 +0100 (CET)
Message-ID: <alpine.DEB.2.10.1512041837440.2797@hadrien>
References: <201512050138.Hx1BUH8H%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by alsa0.perex.cz (Postfix) with ESMTP id 28463264F52
 for <alsa-devel@alsa-project.org>; Fri,  4 Dec 2015 18:39:19 +0100 (CET)
In-Reply-To: <201512050138.Hx1BUH8H%fengguang.wu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

Looks suspicious. Please check.

julia

On Sat, 5 Dec 2015, kbuild test robot wrote:

> CC: kbuild-all@01.org
> CC: alsa-devel@alsa-project.org
> TO: Takashi Iwai <tiwai@suse.de>
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-linus
> head:   ec20c9c7a63f7b8676eb574406a8bc8f32b7ba7e
> commit: ec20c9c7a63f7b8676eb574406a8bc8f32b7ba7e [29/29] ALSA: rme96: Fix unexpected volume reset after rate changes
> :::::: branch date: 2 hours ago
> :::::: commit date: 2 hours ago
>
> >> sound/pci/rme96.c:1035:1-7: preceding lock on line 991
>
> git remote add sound https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
> git remote update sound
> git checkout ec20c9c7a63f7b8676eb574406a8bc8f32b7ba7e
> vim +1035 sound/pci/rme96.c
>
> ^1da177e Linus Torvalds  2005-04-16   985
> 4d23359b Clemens Ladisch 2005-09-05   986  	runtime->dma_area = (void __force *)(rme96->iobase +
> 4d23359b Clemens Ladisch 2005-09-05   987  					     RME96_IO_PLAY_BUFFER);
> ^1da177e Linus Torvalds  2005-04-16   988  	runtime->dma_addr = rme96->port + RME96_IO_PLAY_BUFFER;
> ^1da177e Linus Torvalds  2005-04-16   989  	runtime->dma_bytes = RME96_BUFFER_SIZE;
> ^1da177e Linus Torvalds  2005-04-16   990
> ^1da177e Linus Torvalds  2005-04-16  @991  	spin_lock_irq(&rme96->lock);
> ^1da177e Linus Torvalds  2005-04-16   992  	if (!(rme96->wcreg & RME96_WCR_MASTER) &&
> ^1da177e Linus Torvalds  2005-04-16   993              snd_rme96_getinputtype(rme96) != RME96_INPUT_ANALOG &&
> ^1da177e Linus Torvalds  2005-04-16   994  	    (rate = snd_rme96_capture_getrate(rme96, &dummy)) > 0)
> ^1da177e Linus Torvalds  2005-04-16   995  	{
> ^1da177e Linus Torvalds  2005-04-16   996                  /* slave clock */
> ^1da177e Linus Torvalds  2005-04-16   997                  if ((int)params_rate(params) != rate) {
> ec20c9c7 Takashi Iwai    2015-12-04   998  			err = -EIO;
> ec20c9c7 Takashi Iwai    2015-12-04   999  			goto error;
> ^1da177e Linus Torvalds  2005-04-16  1000  		}
> ec20c9c7 Takashi Iwai    2015-12-04  1001  	} else {
> ec20c9c7 Takashi Iwai    2015-12-04  1002  		err = snd_rme96_playback_setrate(rme96, params_rate(params));
> ec20c9c7 Takashi Iwai    2015-12-04  1003  		if (err < 0)
> ec20c9c7 Takashi Iwai    2015-12-04  1004  			goto error;
> ec20c9c7 Takashi Iwai    2015-12-04  1005  		apply_dac_volume = err > 0; /* need to restore volume later? */
> ^1da177e Linus Torvalds  2005-04-16  1006  	}
> ec20c9c7 Takashi Iwai    2015-12-04  1007  	if ((err = snd_rme96_playback_setformat(rme96, params_format(params))) < 0)
> ec20c9c7 Takashi Iwai    2015-12-04  1008  		goto error;
> ^1da177e Linus Torvalds  2005-04-16  1009  	snd_rme96_setframelog(rme96, params_channels(params), 1);
> ^1da177e Linus Torvalds  2005-04-16  1010  	if (rme96->capture_periodsize != 0) {
> ^1da177e Linus Torvalds  2005-04-16  1011  		if (params_period_size(params) << rme96->playback_frlog !=
> ^1da177e Linus Torvalds  2005-04-16  1012  		    rme96->capture_periodsize)
> ^1da177e Linus Torvalds  2005-04-16  1013  		{
> ec20c9c7 Takashi Iwai    2015-12-04  1014  			err = -EBUSY;
> ec20c9c7 Takashi Iwai    2015-12-04  1015  			goto error;
> ^1da177e Linus Torvalds  2005-04-16  1016  		}
> ^1da177e Linus Torvalds  2005-04-16  1017  	}
> ^1da177e Linus Torvalds  2005-04-16  1018  	rme96->playback_periodsize =
> ^1da177e Linus Torvalds  2005-04-16  1019  		params_period_size(params) << rme96->playback_frlog;
> ^1da177e Linus Torvalds  2005-04-16  1020  	snd_rme96_set_period_properties(rme96, rme96->playback_periodsize);
> ^1da177e Linus Torvalds  2005-04-16  1021  	/* S/PDIF setup */
> ^1da177e Linus Torvalds  2005-04-16  1022  	if ((rme96->wcreg & RME96_WCR_ADAT) == 0) {
> ^1da177e Linus Torvalds  2005-04-16  1023  		rme96->wcreg &= ~(RME96_WCR_PRO | RME96_WCR_DOLBY | RME96_WCR_EMP);
> ^1da177e Linus Torvalds  2005-04-16  1024  		writel(rme96->wcreg |= rme96->wcreg_spdif_stream, rme96->iobase + RME96_IO_CONTROL_REGISTER);
> ^1da177e Linus Torvalds  2005-04-16  1025  	}
> ^1da177e Linus Torvalds  2005-04-16  1026  	spin_unlock_irq(&rme96->lock);
> ec20c9c7 Takashi Iwai    2015-12-04  1027  	err = 0;
> ^1da177e Linus Torvalds  2005-04-16  1028
> ec20c9c7 Takashi Iwai    2015-12-04  1029   error:
> ec20c9c7 Takashi Iwai    2015-12-04  1030  	if (apply_dac_volume) {
> ec20c9c7 Takashi Iwai    2015-12-04  1031  		usleep_range(3000, 10000);
> ec20c9c7 Takashi Iwai    2015-12-04  1032  		snd_rme96_apply_dac_volume(rme96);
> ec20c9c7 Takashi Iwai    2015-12-04  1033  	}
> ec20c9c7 Takashi Iwai    2015-12-04  1034
> ec20c9c7 Takashi Iwai    2015-12-04 @1035  	return err;
> ^1da177e Linus Torvalds  2005-04-16  1036  }
> ^1da177e Linus Torvalds  2005-04-16  1037
> ^1da177e Linus Torvalds  2005-04-16  1038  static int
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>
