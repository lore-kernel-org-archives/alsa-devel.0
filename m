From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [sound:topic/core-fixes 21/21]
 sound/core/seq/seq_virmidi.c:192:6-12: preceding lock on line 176
Date: Wed, 3 Feb 2016 07:36:42 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1602030736030.2067@localhost6.localdomain6>
References: <201602030826.fJM3cvVl%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by alsa0.perex.cz (Postfix) with ESMTP id 089C926154E
 for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2016 07:36:43 +0100 (CET)
In-Reply-To: <201602030826.fJM3cvVl%fengguang.wu@intel.com>
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

Looks suspicious, please check.

julia

On Wed, 3 Feb 2016, kbuild test robot wrote:

> CC: kbuild-all@01.org
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git topic/core-fixes
> head:   be33492635ee8fc19a185f37293b533069e5cc8f
> commit: be33492635ee8fc19a185f37293b533069e5cc8f [21/21] ALSA: rawmidi: Make snd_rawmidi_transmit() race-free
> :::::: branch date: 2 hours ago
> :::::: commit date: 2 hours ago
> 
> >> sound/core/seq/seq_virmidi.c:192:6-12: preceding lock on line 176
> 
> git remote add sound https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
> git remote update sound
> git checkout be33492635ee8fc19a185f37293b533069e5cc8f
> vim +192 sound/core/seq/seq_virmidi.c
> 
> ^1da177e Linus Torvalds 2005-04-16  170  		if (vmidi->event.type != SNDRV_SEQ_EVENT_NONE) {
> 62c5549e Takashi Iwai   2006-02-22  171  			if (snd_seq_kernel_client_dispatch(vmidi->client, &vmidi->event, in_atomic(), 0) < 0)
> ^1da177e Linus Torvalds 2005-04-16  172  				return;
> ^1da177e Linus Torvalds 2005-04-16  173  			vmidi->event.type = SNDRV_SEQ_EVENT_NONE;
> ^1da177e Linus Torvalds 2005-04-16  174  		}
> ^1da177e Linus Torvalds 2005-04-16  175  		while (1) {
> be334926 Takashi Iwai   2016-01-31 @176  			spin_lock_irqsave(&substream->runtime->lock, flags);
> be334926 Takashi Iwai   2016-01-31  177  			count = __snd_rawmidi_transmit_peek(substream, buf, sizeof(buf));
> ^1da177e Linus Torvalds 2005-04-16  178  			if (count <= 0)
> ^1da177e Linus Torvalds 2005-04-16  179  				break;
> ^1da177e Linus Torvalds 2005-04-16  180  			pbuf = buf;
> ^1da177e Linus Torvalds 2005-04-16  181  			while (count > 0) {
> ^1da177e Linus Torvalds 2005-04-16  182  				res = snd_midi_event_encode(vmidi->parser, pbuf, count, &vmidi->event);
> ^1da177e Linus Torvalds 2005-04-16  183  				if (res < 0) {
> ^1da177e Linus Torvalds 2005-04-16  184  					snd_midi_event_reset_encode(vmidi->parser);
> ^1da177e Linus Torvalds 2005-04-16  185  					continue;
> ^1da177e Linus Torvalds 2005-04-16  186  				}
> be334926 Takashi Iwai   2016-01-31  187  				__snd_rawmidi_transmit_ack(substream, res);
> ^1da177e Linus Torvalds 2005-04-16  188  				pbuf += res;
> ^1da177e Linus Torvalds 2005-04-16  189  				count -= res;
> ^1da177e Linus Torvalds 2005-04-16  190  				if (vmidi->event.type != SNDRV_SEQ_EVENT_NONE) {
> 62c5549e Takashi Iwai   2006-02-22  191  					if (snd_seq_kernel_client_dispatch(vmidi->client, &vmidi->event, in_atomic(), 0) < 0)
> ^1da177e Linus Torvalds 2005-04-16 @192  						return;
> ^1da177e Linus Torvalds 2005-04-16  193  					vmidi->event.type = SNDRV_SEQ_EVENT_NONE;
> ^1da177e Linus Torvalds 2005-04-16  194  				}
> ^1da177e Linus Torvalds 2005-04-16  195  			}
> 
> :::::: The code at line 192 was first introduced by commit
> :::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2
> 
> :::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
> :::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
