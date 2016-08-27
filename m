From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/2] ALSA: fireworks: accessing to user space outside
 spinlock
Date: Sat, 27 Aug 2016 10:50:36 +0900
Message-ID: <50967028-7781-7426-c243-cf0b4cfc1f33@sakamocchi.jp>
References: <201608270552.3vMoYwQr%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <201608270552.3vMoYwQr%fengguang.wu@intel.com>
Sender: stable-owner@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, clemens@ladisch.de, tiwai@suse.de, vaishali.thakkar@oracle.com, alsa-devel@alsa-project.org, stable@vger.kernel.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Aug 27 2016 06:34, kbuild test robot wrote:
> Hi Takashi,
> 
> [auto build test WARNING on sound/for-next]
> [also build test WARNING on v4.8-rc3 next-20160825]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> [Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
> [Check https://git-scm.com/docs/git-format-patch for more information]
> 
> url:    https://github.com/0day-ci/linux/commits/Takashi-Sakamoto/ALSA-fireworks-accessing-to-user-space-outside-spinlock/20160827-045250
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
> config: tile-allyesconfig (attached as .config)
> compiler: tilegx-linux-gcc (GCC) 4.6.2
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=tile 
> 
> All warnings (new ones prefixed by >>):
> 
>    sound/firewire/fireworks/fireworks_hwdep.c: In function 'hwdep_read_locked':
>>> sound/firewire/fireworks/fireworks_hwdep.c:86:8: warning: missing braces around initializer [-Wmissing-braces]
>    sound/firewire/fireworks/fireworks_hwdep.c:86:8: warning: (near initialization for 'event.common') [-Wmissing-braces]
> 
> vim +86 sound/firewire/fireworks/fireworks_hwdep.c
> 
>     70				count += till_end;
>     71				remained -= till_end;
>     72			}
>     73	
>     74			efw->resp_queues--;
>     75		}
>     76	
>     77		spin_unlock_irq(&efw->lock);
>     78	
>     79		return count;
>     80	}
>     81	
>     82	static long
>     83	hwdep_read_locked(struct snd_efw *efw, char __user *buf, long count,
>     84			  loff_t *offset)
>     85	{
>   > 86		union snd_firewire_event event = {0};

Mm. I should have indicate actual data type of this union for desinated
initialization.
https://gcc.gnu.org/onlinedocs/gcc/Designated-Inits.html

So as for firewire-tascam module. I'll post revised version of them.
Sorry for stable developers but please ignore this patchset...

>     87	
>     88		event.lock_status.type = SNDRV_FIREWIRE_EVENT_LOCK_STATUS;
>     89	
>     90		spin_lock_irq(&efw->lock);
>     91	
>     92		event.lock_status.status = (efw->dev_lock_count > 0);
>     93		efw->dev_lock_changed = false;
>     94	


Regards

Takashi Sakamoto
