From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: BUG: possible deadlock detected! (sound) [Was:
	2.6.17-rc5-mm1]
Date: Tue, 30 May 2006 13:06:28 +0200
Message-ID: <1148987188.3636.52.camel@laptopd505.fenrus.org>
References: <20060530022925.8a67b613.akpm@osdl.org>
	<447C22CE.2060402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C5C8914F
	for <alsa-devel@alsa-project.org>;
	Tue, 30 May 2006 13:06:35 +0200 (MEST)
In-Reply-To: <447C22CE.2060402@gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org, tiwai@suse.de, James@superbug.demon.co.uk, linux-kernel@vger.kernel.org, emu10k1-devel@lists.sourceforge.net, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-05-30 at 147 +0159, Jiri Slaby wrote:

(I've turned your backtrace upside down to show it "chronological")

 [<c05911e0>] alsa_emu10k1_synth_init+0x22/0x24
 [<c0333d04>] snd_seq_device_register_driver+0x8f/0xeb

this one does:

       mutex_lock(&ops->reg_mutex);
       ...
       list_for_each(head, &ops->dev_list) {
                struct snd_seq_device *dev = list_entry(head, struct snd_seq_device, list);
                init_device(dev, ops);
       }
       mutex_unlock(&ops->reg_mutex);

 [<c0333537>] init_device+0x2c/0x94
  which calls into the driver
 [<c0352c39>] snd_emu10k1_synth_new_device+0xe7/0x14e
 [<c0353f50>] snd_emux_register+0x10d/0x13f
 [<c0358260>] snd_emux_init_seq_oss+0x35/0x9c
 [<c0333aa0>] snd_seq_device_new+0x96/0x111

and this one does
        mutex_lock(&ops->reg_mutex);
        list_add_tail(&dev->list, &ops->dev_list);
        ops->num_devices++;
        mutex_unlock(&ops->reg_mutex);


so... on first sight this looks like a real deadlock;
unless the ALSA folks can tell me why "ops" is always different,
and what the lock ordering rules between those is...
