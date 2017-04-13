From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 2/8] firewire-tascam: remove callback
 function from async midi port (fwd)
Date: Thu, 13 Apr 2017 17:10:34 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1704131709270.3342@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C4552670A1
 for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2017 17:10:35 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, kbuild-all@01.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hello,

I haven't checked on the type, but it may be worth looking into (line
201).

julia

---------- Forwarded message ----------
Date: Thu, 13 Apr 2017 18:20:17 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [alsa-devel] [PATCH 2/8] firewire-tascam: remove callback function
    from async midi port

In-Reply-To: <20170413051527.21396-3-o-takashi@sakamocchi.jp>

Hi Takashi,

[auto build test WARNING on sound/for-next]
[also build test WARNING on v4.11-rc6 next-20170413]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Takashi-Sakamoto/ALSA-firewire-lib-firewire-tascam-localize-async-midi-port/20170413-154647
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
:::::: branch date: 3 hours ago
:::::: commit date: 3 hours ago

>> sound/firewire/tascam/tascam-transaction.c:201:5-24: WARNING: Unsigned expression compared with zero: port -> consume_bytes <= 0

git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout b866eaa9a02893e6383eb5177c11078a16af4e80
vim +201 sound/firewire/tascam/tascam-transaction.c

741f7c77a Takashi Sakamoto 2017-04-13  185  	/* Nothing to do. */
741f7c77a Takashi Sakamoto 2017-04-13  186  	if (substream == NULL || snd_rawmidi_transmit_empty(substream))
741f7c77a Takashi Sakamoto 2017-04-13  187  		return;
741f7c77a Takashi Sakamoto 2017-04-13  188
741f7c77a Takashi Sakamoto 2017-04-13  189  	/* Do it in next chance. */
741f7c77a Takashi Sakamoto 2017-04-13  190  	if (ktime_after(port->next_ktime, ktime_get())) {
741f7c77a Takashi Sakamoto 2017-04-13  191  		schedule_work(&port->work);
741f7c77a Takashi Sakamoto 2017-04-13  192  		return;
741f7c77a Takashi Sakamoto 2017-04-13  193  	}
741f7c77a Takashi Sakamoto 2017-04-13  194
741f7c77a Takashi Sakamoto 2017-04-13  195  	/*
741f7c77a Takashi Sakamoto 2017-04-13  196  	 * Fill the buffer. The callee must use snd_rawmidi_transmit_peek().
741f7c77a Takashi Sakamoto 2017-04-13  197  	 * Later, snd_rawmidi_transmit_ack() is called.
741f7c77a Takashi Sakamoto 2017-04-13  198  	 */
741f7c77a Takashi Sakamoto 2017-04-13  199  	memset(port->buf, 0, port->len);
b866eaa9a Takashi Sakamoto 2017-04-13  200  	port->consume_bytes = fill_message(substream, port->buf);
741f7c77a Takashi Sakamoto 2017-04-13 @201  	if (port->consume_bytes <= 0) {
741f7c77a Takashi Sakamoto 2017-04-13  202  		/* Do it in next chance, immediately. */
741f7c77a Takashi Sakamoto 2017-04-13  203  		if (port->consume_bytes == 0) {
741f7c77a Takashi Sakamoto 2017-04-13  204  			port->next_ktime = 0;
741f7c77a Takashi Sakamoto 2017-04-13  205  			schedule_work(&port->work);
741f7c77a Takashi Sakamoto 2017-04-13  206  		} else {
741f7c77a Takashi Sakamoto 2017-04-13  207  			/* Fatal error. */
741f7c77a Takashi Sakamoto 2017-04-13  208  			port->error = true;
741f7c77a Takashi Sakamoto 2017-04-13  209  		}

:::::: The code at line 201 was first introduced by commit
:::::: 741f7c77a1a15d04ebafcce4e079cfe1cfb612ff firewire-lib/firewire-tascam: localize async midi port

:::::: TO: Takashi Sakamoto <o-takashi@sakamocchi.jp>
:::::: CC: 0day robot <fengguang.wu@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
