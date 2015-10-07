From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 4/5] ALSA: firewire-lib: add throttle for
	MIDI data rate
Date: Wed, 7 Oct 2015 10:27:16 +0900
Message-ID: <561474F4.4050600@sakamocchi.jp>
References: <201510070839.tyT2Cc7D%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id DB044260832
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 03:27:20 +0200 (CEST)
In-Reply-To: <201510070839.tyT2Cc7D%fengguang.wu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: kbuild test robot <lkp@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, kbuild-all@01.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Oct 7 2015 09:32, kbuild test robot wrote:
> Hi Takashi,
>
> [auto build test ERROR on v4.3-rc4 -- if it's inappropriate base, please ignore]
>
> config: i386-randconfig-x009-201540 (attached as .config)
> reproduce:
>          # save the attached .config to linux build tree
>          make ARCH=i386
>
> Note: the linux-review/Takashi-Sakamoto/ALSA-add-helper-functions-for-MIDI-message-transmission-on-IEEE-1394-asynchronous-transaction HEAD f058371b5831baa9749177001cbbdcdf47753f3d builds fine.
>        It only hurts bisectibility.
>
> All errors (new ones prefixed by >>):
>
>     sound/firewire/lib.c: In function 'snd_fw_async_midi_port_init':
>>> sound/firewire/lib.c:181:6: error: 'struct snd_fw_async_midi_port' has no member named 'error'
>       port->error = false;
>           ^
>
> vim +181 sound/firewire/lib.c
>
>     175	
>     176		port->parent = fw_parent_device(unit);
>     177		port->addr = addr;
>     178		port->fill = fill;
>     179		port->idling = true;
>     180		port->next_ktime = ktime_set(0, 0);
>   > 181		port->error = false;
>     182	
>     183		INIT_WORK(&port->work, midi_port_work);
>     184	

Oops! I had wrong rebase operations to generate this patch. This line 
should be in the next patch, sorry...

Regards

Takashi Sakamoto
