From: Dmitry <dbaryshkov@gmail.com>
Subject: Re: [PATCH 10/17] Don't lock the codec list in
	snd_soc_dapm_new_widgets()
Date: Wed, 16 Jan 2008 02:40:55 +0300
Message-ID: <bc64b4640801151540n4cb66f99u68ba0d42c91b5ff6@mail.gmail.com>
References: <1199971035-13553-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-9-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-10-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 0BD122448D
	for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2008 00:40:57 +0100 (CET)
Received: by py-out-1112.google.com with SMTP id w49so52529pyg.36
	for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2008 15:40:56 -0800 (PST)
In-Reply-To: <1199971035-13553-10-git-send-email-broonie@opensource.wolfsonmicro.com>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I'm sorry, but I tested this patch only now. And I just got another
message from lockdep:

=======================================================
[ INFO: possible circular locking dependency detected ]
2.6.24-rc7-dirty #79
-------------------------------------------------------
alsactl/953 is trying to acquire lock:
 (&codec->mutex){--..}, at: [<c01d03f0>] snd_soc_dapm_put_volsw+0xc4/0x218

but task is already holding lock:
 (&card->controls_rwsem){----}, at: [<c01bcfac>] snd_ctl_elem_write+0x24/0x13c

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&card->controls_rwsem){----}:
       [<c0058d84>] lock_acquire+0x6c/0x84
       [<c0243eb4>] down_write+0x30/0x40
       [<c01bd28c>] snd_ctl_add+0x54/0x1dc
       [<c01d2b78>] tosa_ac97_init+0x60/0xec
       [<c01ce5a0>] snd_soc_register_card+0x58/0x210
       [<c01d193c>] wm9712_soc_probe+0x1f0/0x280
       [<c01cf46c>] soc_probe+0x98/0x188
       [<c015e998>] platform_drv_probe+0x20/0x24
       [<c015d1dc>] driver_probe_device+0x100/0x1b8
       [<c015d2a4>] __device_attach+0x10/0x14
       [<c015c3a0>] bus_for_each_drv+0x48/0x84
       [<c015d344>] device_attach+0x70/0x9c
       [<c015c308>] bus_attach_device+0x38/0x88
       [<c015b068>] device_add+0x274/0x4bc
       [<c015ee40>] platform_device_add+0x100/0x158
       [<c0016e04>] tosa_init+0x60/0x90
       [<c00087e4>] kernel_init+0xc8/0x298
       [<c0039cf0>] do_exit+0x0/0x760

-> #0 (&codec->mutex){--..}:
       [<c0058d84>] lock_acquire+0x6c/0x84
       [<c0243b48>] mutex_lock_nested+0xf8/0x2bc
       [<c01d03f0>] snd_soc_dapm_put_volsw+0xc4/0x218
       [<c01bd080>] snd_ctl_elem_write+0xf8/0x13c
       [<c01bde2c>] snd_ctl_ioctl+0x720/0xbfc
       [<c0099314>] do_ioctl+0x38/0x98
       [<c0099620>] vfs_ioctl+0x2ac/0x2dc
       [<c0099690>] sys_ioctl+0x40/0x64
       [<c001cf60>] ret_fast_syscall+0x0/0x2c

other info that might help us debug this:

2 locks held by alsactl/953:
 #0:  (&card->power_lock){--..}, at: [<c01bde08>] snd_ctl_ioctl+0x6fc/0xbfc
 #1:  (&card->controls_rwsem){----}, at: [<c01bcfac>]
snd_ctl_elem_write+0x24/0x13c

stack backtrace:
[<c00217d4>] (dump_stack+0x0/0x14) from [<c0056848>]
(print_circular_bug_tail+0x78/0x94)
[<c00567d0>] (print_circular_bug_tail+0x0/0x94) from [<c0058520>]
(__lock_acquire+0x970/0xcf4)
 r6:c3f02538 r5:00000001 r4:c3f02560
[<c0057bb0>] (__lock_acquire+0x0/0xcf4) from [<c0058d84>]
(lock_acquire+0x6c/0x84)
[<c0058d18>] (lock_acquire+0x0/0x84) from [<c0243b48>]
(mutex_lock_nested+0xf8/0x2bc)
 r7:c3f02220 r6:60000013 r5:c3d6eda8 r4:c3f9bd04
[<c0243a50>] (mutex_lock_nested+0x0/0x2bc) from [<c01d03f0>]
(snd_soc_dapm_put_volsw+0xc4/0x218)
[<c01d032c>] (snd_soc_dapm_put_volsw+0x0/0x218) from [<c01bd080>]
(snd_ctl_elem_write+0xf8/0x13c)
[<c01bcf88>] (snd_ctl_elem_write+0x0/0x13c) from [<c01bde2c>]
(snd_ctl_ioctl+0x720/0xbfc)
[<c01bd70c>] (snd_ctl_ioctl+0x0/0xbfc) from [<c0099314>] (do_ioctl+0x38/0x98)
[<c00992dc>] (do_ioctl+0x0/0x98) from [<c0099620>] (vfs_ioctl+0x2ac/0x2dc)
 r6:bed526d8 r5:c3ed8288 r4:c3e93140
[<c0099374>] (vfs_ioctl+0x0/0x2dc) from [<c0099690>] (sys_ioctl+0x40/0x64)
 r9:c3f9a000 r8:c001d108 r6:c2c85513 r5:fffffff7 r4:c3e93140
[<c0099650>] (sys_ioctl+0x0/0x64) from [<c001cf60>] (ret_fast_syscall+0x0/0x2c)
 r6:00000002 r5:00000000 r4:00000000

2008/1/10, Mark Brown <broonie@opensource.wolfsonmicro.com>:
> snd_soc_dapm_new_widgets() takes the codec lock when adding new widgets,
> causing lockdep warnings when applications later call down through ALSA
> to adjust controls.  Since widgets are only added during probe this lock
> should be unneeded so don't take it.
>
> Thanks to Dmitry Baryshkov <dbaryshkov@gmail.com> for reporting this issue.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>
> ---
>  sound/soc/soc-dapm.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index a4ce882..f99cac1 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -972,7 +972,6 @@ int snd_soc_dapm_new_widgets(struct snd_soc_codec *codec)
>  {
>         struct snd_soc_dapm_widget *w;
>
> -       mutex_lock(&codec->mutex);
>         list_for_each_entry(w, &codec->dapm_widgets, list)
>         {
>                 if (w->new)
> @@ -1007,7 +1006,6 @@ int snd_soc_dapm_new_widgets(struct snd_soc_codec *codec)
>         }
>
>         dapm_power_widgets(codec, SND_SOC_DAPM_STREAM_NOP);
> -       mutex_unlock(&codec->mutex);
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(snd_soc_dapm_new_widgets);
> --
> 1.5.3.8
>
>


-- 
With best wishes
Dmitry
