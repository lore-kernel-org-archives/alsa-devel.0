From: Uros Bizjak <uros@kss-loka.si>
Subject: Re: sb16 gets wedged when doing overlapped i/o (full
 duplex)
Date: Fri, 6 Dec 2002 08:14:40 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.05.10212060748420.3576-100000@pulsar.kss-loka.si>
References: <3DEF9BFF.2050200@monmouth.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DEF9BFF.2050200@monmouth.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "John S. Denker" <jsd@monmouth.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello!

> >   From the error message you posted about this bug, it looks that driver
> > is trying to call prepare() operator on a substream that is still
> > in SNDRV_PCM_STATE_RUNNING state. Perhaps Jaroslav could tell us if this
> > can happen if hardware pointers are not updated anymore (because sb16 DMA
> > engine gets stucked somehow). Do you get an XRUN message in
> > /var/log/messages?
> 
> 2) My program intentionally causes an overrun on input once
> every 0.5 seconds.  It catches this condition, and recovers
> by calling snd_pcm_prepare().  It does not print a message
> about this (unless super-specially requested).

  ISA SoundBlasters have numerous hardware problems in full-duplex mode,
one of them is triggered by switching capture channel from 8bit full
duplex to 16bit (this can be avoided by setting "16bit DMA allocation"
switch), sample transfers will be corrupt on overclocked ISA bus. In
your case, it looks that in full duplex mode, sometimes stopping one
channel stops the other too, and then sb16 chip won't react on
DMA_ON/DMA_OFF commands anymore. Strange.

  Could you put a printk() in snd_sb16_*_pointer() functions
(sb16_main.c souce)? This printk() should print dma channel and value of
ptr, so we can see when/if DMA channels gets stuck.

  BTW: It looks like another sb16 hardware bug to me. On module re-load,
drivers reset sb16 chip, that is why module reload helps.

  Perhaps you can derive a small test case from your application, which
will help developers to stresstest soundcard and perhaps PCM layer?

	Uros.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
