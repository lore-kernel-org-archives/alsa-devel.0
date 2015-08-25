From: Alexnader Kuleshov <kuleshovmail@gmail.com>
Subject: Re: ALSA/usb-audio: snd_usb_autoresume possible recursive locking
 detected
Date: Tue, 25 Aug 2015 23:15:23 +0600
Message-ID: <20150825171523.GA1413@localhost>
References: <20150825133256.GA1804@localhost>
 <s5hbndvmqb9.wl-tiwai@suse.de>
 <s5h4mjnmnfh.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5h4mjnmnfh.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Alexnader Kuleshov <kuleshovmail@gmail.com>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hello Takashi, just tested it on my linux box against 4.2.0-rc8+ and there is
the same 'possible recursive locking detected', but another:

[   13.422080] =============================================
[   13.422081] [ INFO: possible recursive locking detected ]
[   13.422082] 4.2.0-rc8+ #61 Not tainted
[   13.422083] ---------------------------------------------
[   13.422084] systemd-udevd/533 is trying to acquire lock:
[   13.422085]  (&chip->shutdown_rwsem){.+.+.+}, at: [<ffffffffa0253da3>] snd_usb_autoresume+0x1d/0x52 [snd_usb_audio]
[   13.422094] 
               but task is already holding lock:
[   13.422094]  (&chip->shutdown_rwsem){.+.+.+}, at: [<ffffffffa0257377>] snd_usb_mixer_set_ctl_value+0xd0/0x1ad [snd_usb_audio]
[   13.422100] 
               other info that might help us debug this:
[   13.422101]  Possible unsafe locking scenario:

[   13.422102]        CPU0
[   13.422102]        ----
[   13.422103]   lock(&chip->shutdown_rwsem);
[   13.422104]   lock(&chip->shutdown_rwsem);
[   13.422105] 
                *** DEADLOCK ***

[   13.422106]  May be due to missing lock nesting notation

[   13.422107] 4 locks held by systemd-udevd/533:
[   13.422108]  #0:  (&dev->mutex){......}, at: [<ffffffff813b3414>] __driver_attach+0x30/0x80
[   13.422112]  #1:  (&dev->mutex){......}, at: [<ffffffff813b342c>] __driver_attach+0x48/0x80
[   13.422115]  #2:  (register_mutex#4){+.+.+.}, at: [<ffffffffa0253670>] usb_audio_probe+0xa3/0x7b9 [snd_usb_audio]
[   13.422120]  #3:  (&chip->shutdown_rwsem){.+.+.+}, at: [<ffffffffa0257377>] snd_usb_mixer_set_ctl_value+0xd0/0x1ad [snd_usb_audio]
[   13.422125] 
               stack backtrace:
[   13.422127] CPU: 7 PID: 533 Comm: systemd-udevd Not tainted 4.2.0-rc8+ #61
[   13.422128] Hardware name: Gigabyte Technology Co., Ltd. Z97X-UD5H-BK/Z97X-UD5H-BK, BIOS F6 06/17/2014
[   13.422129]  0000000000000000 0000000071d6ca78 ffff880407bf7538 ffffffff815ba622
[   13.422131]  0000000000000000 ffffffff8239a680 ffff880407bf75f8 ffffffff810dd54e
[   13.422133]  ffff880409db64a8 ffffffff00000000 0000000182000201 ffffffff8239a680
[   13.422135] Call Trace:
[   13.422137]  [<ffffffff815ba622>] dump_stack+0x4c/0x65
[   13.422140]  [<ffffffff810dd54e>] validate_chain.isra.9+0x75d/0xf59
[   13.422142]  [<ffffffff810de69c>] ? mark_held_locks+0x5f/0x76
[   13.422144]  [<ffffffff810e0964>] __lock_acquire+0x753/0xabf
[   13.422146]  [<ffffffff810e1131>] lock_acquire+0x7b/0x9c
[   13.422151]  [<ffffffffa0253da3>] ? snd_usb_autoresume+0x1d/0x52 [snd_usb_audio]
[   13.422153]  [<ffffffff815c4896>] down_read+0x44/0x8d
[   13.422156]  [<ffffffffa0253da3>] ? snd_usb_autoresume+0x1d/0x52 [snd_usb_audio]
[   13.422160]  [<ffffffffa0253da3>] snd_usb_autoresume+0x1d/0x52 [snd_usb_audio]
[   13.422162]  [<ffffffff815c48d6>] ? down_read+0x84/0x8d
[   13.422167]  [<ffffffffa025738c>] snd_usb_mixer_set_ctl_value+0xe5/0x1ad [snd_usb_audio]
[   13.422171]  [<ffffffffa025784a>] get_min_max_with_quirks+0x155/0x5e4 [snd_usb_audio]
[   13.422176]  [<ffffffffa02581c1>] build_feature_ctl+0x33a/0x419 [snd_usb_audio]
[   13.422181]  [<ffffffffa02586f9>] parse_audio_unit+0x459/0xa03 [snd_usb_audio]
[   13.422186]  [<ffffffffa02590f4>] snd_usb_mixer_controls+0xe8/0x169 [snd_usb_audio]
[   13.422190]  [<ffffffffa02593b4>] snd_usb_create_mixer+0xb4/0x261 [snd_usb_audio]
[   13.422194]  [<ffffffffa02535ba>] ? snd_usb_create_stream+0x151/0x164 [snd_usb_audio]
[   13.422197]  [<ffffffffa0253ccd>] usb_audio_probe+0x700/0x7b9 [snd_usb_audio]
[   13.422199]  [<ffffffff81413bb7>] usb_probe_interface+0x139/0x1c3
[   13.422201]  [<ffffffff813b329a>] driver_probe_device+0xd0/0x21a
[   13.422203]  [<ffffffff813b3441>] __driver_attach+0x5d/0x80
[   13.422205]  [<ffffffff813b33e4>] ? driver_probe_device+0x21a/0x21a
[   13.422207]  [<ffffffff813b1850>] bus_for_each_dev+0x77/0xa5
[   13.422210]  [<ffffffff813b2f94>] driver_attach+0x19/0x1b
[   13.422212]  [<ffffffff813b2a87>] bus_add_driver+0xe8/0x1da
[   13.422213]  [<ffffffff813b3a26>] driver_register+0x86/0xc3
[   13.422215]  [<ffffffff81412b6c>] usb_register_driver+0xa8/0x146
[   13.422216]  [<ffffffffa0345000>] ? 0xffffffffa0345000
[   13.422220]  [<ffffffffa034501e>] usb_audio_driver_init+0x1e/0x20 [snd_usb_audio]
[   13.422222]  [<ffffffff81000380>] do_one_initcall+0x17f/0x194
[   13.422225]  [<ffffffff810c31cd>] ? __might_sleep+0x71/0x79
[   13.422228]  [<ffffffff815b96ad>] do_init_module+0x56/0x1d7
[   13.422230]  [<ffffffff81109a8b>] load_module+0x17f5/0x1c1e
[   13.422234]  [<ffffffff8117994b>] ? kernel_read+0x4b/0x6d
[   13.422236]  [<ffffffff8110a066>] SyS_finit_module+0x6f/0x90
[   13.422239]  [<ffffffff815c6a57>] entry_SYSCALL_64_fastpath+0x12/0x6f


Thank you.

On 08-25-15, Takashi Iwai wrote:
> 
> Could you try the patch below?
> 
> 
> Takashi
> 
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: usb-audio: Avoid nested autoresume calls
> 
> Since snd_usb_autoresume() invokes down_read() to shutdown_rwsem, this
> triggers lockdep warnings like
>   =============================================
>   [ INFO: possible recursive locking detected ]
>   4.2.0-rc8+ #61 Not tainted
>   ---------------------------------------------
>   pulseaudio/980 is trying to acquire lock:
>    (&chip->shutdown_rwsem){.+.+.+}, at: [<ffffffffa0355dac>] snd_usb_autoresume+0x1d/0x52 [snd_usb_audio]
>   but task is already holding lock:
>    (&chip->shutdown_rwsem){.+.+.+}, at: [<ffffffffa0355dac>] snd_usb_autoresume+0x1d/0x52 [snd_usb_audio]
> 
> One could avoid this with down_read_nested().  But a quicker solution
> is just to skip snd_usb_autoresume() call and relevant down_read()
> inside the resume path.  This is already marked via chip->in_pm flag,
> so we can check it easily.
> 
> This patch adds the workaround in the regular resume path (via
> snd_usb_mixer_set_ctl_value()).  A more comprehensive coverage to all
> resume paths will follow later.
> 
> Reported-by: Alexnader Kuleshov <kuleshovmail@gmail.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/usb/mixer.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> index c50790cb3f4d..dd9caac4998a 100644
> --- a/sound/usb/mixer.c
> +++ b/sound/usb/mixer.c
> @@ -463,6 +463,7 @@ int snd_usb_mixer_set_ctl_value(struct usb_mixer_elem_info *cval,
>  	struct snd_usb_audio *chip = cval->head.mixer->chip;
>  	unsigned char buf[4];
>  	int idx = 0, val_len, err, timeout = 10;
> +	bool autoresume;
>  
>  	validx += cval->idx_off;
>  
> @@ -485,10 +486,16 @@ int snd_usb_mixer_set_ctl_value(struct usb_mixer_elem_info *cval,
>  	buf[1] = (value_set >> 8) & 0xff;
>  	buf[2] = (value_set >> 16) & 0xff;
>  	buf[3] = (value_set >> 24) & 0xff;
> -	err = snd_usb_autoresume(chip);
> -	if (err < 0)
> -		return -EIO;
> -	down_read(&chip->shutdown_rwsem);
> +
> +	/* do autoresume and lock only when invoked from non-resume path */
> +	autoresume = !chip->in_pm;
> +	if (autoresume) {
> +		err = snd_usb_autoresume(chip);
> +		if (err < 0)
> +			return -EIO;
> +		down_read(&chip->shutdown_rwsem);
> +	}
> +
>  	while (timeout-- > 0) {
>  		if (chip->shutdown)
>  			break;
> @@ -506,8 +513,10 @@ int snd_usb_mixer_set_ctl_value(struct usb_mixer_elem_info *cval,
>  	err = -EINVAL;
>  
>   out:
> -	up_read(&chip->shutdown_rwsem);
> -	snd_usb_autosuspend(chip);
> +	if (autoresume) {
> +		up_read(&chip->shutdown_rwsem);
> +		snd_usb_autosuspend(chip);
> +	}
>  	return err;
>  }
>  
> -- 
> 2.5.0
> 
