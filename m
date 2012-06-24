From: "Patrick Shirkey" <pshirkey@boosthardware.com>
Subject: Re: 2.6.18 unknown symbol ksize error
Date: Sun, 24 Jun 2012 03:56:51 +0200 (CEST)
Message-ID: <61144.175.39.33.120.1340503011.squirrel@boosthardware.com>
References: <28300.101.169.127.232.1339918064.squirrel@boosthardware.com>
	<4FDEE5E2.70604@ladisch.de> <s5hfw9tnevr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from boosthardware.localdomain (boosthardware.com [88.198.122.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 9BA482415D
	for <alsa-devel@alsa-project.org>;
	Sun, 24 Jun 2012 03:56:55 +0200 (CEST)
In-Reply-To: <s5hfw9tnevr.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Mon, June 18, 2012 11:33 am, Takashi Iwai wrote:
> At Mon, 18 Jun 2012 10:25:06 +0200,
> Clemens Ladisch wrote:
>>
>> Patrick Shirkey wrote:
>> > I have compiled the latest stable alsa drivers against 2.6.18 kernel
>> with
>> > gcc-4.1.
>> >
>> > I am getting an error when I insert the sound card modules.
>> >
>> >     snd_rawmidi: Unknown symbol ksize
>> >
>> > As far as I can tell 2.6.18 has support for ksize so I am not sure
>> where
>> > this error is coming from.
>>
>> That kernel didn't export ksize.
>>
>> Try --with-debug=memory to get a separate allocator implementation.
>
> Indeed.  The patch below (untested) forces to enable
> CONFIG_SND_DEBUG_MEMORY on older kernels.  Let me know if this helps.
>

Seems to be worse now. Compiling with gcc-4.1 because that is the latest
version of gcc we can get on this old system without having to go
wholesale LFS on it. Upgrading alsa and jack is a big step for this
machine. If this is in the too hard basket I'll compile a new kernel
instead.

Now seeing the following errors from dmesg:

snd_hidden_kmalloc
snd_timer: Unknown symbol snd_register_device_for_dev
snd_pcm: Unknown symbol snd_hidden_kzalloc
snd_pcm: Unknown symbol snd_info_register
snd_pcm: Unknown symbol snd_info_create_module_entry
snd_pcm: Unknown symbol snd_timer_notify
snd_pcm: Unknown symbol snd_timer_interrupt
snd_pcm: Unknown symbol snd_info_free_entry
snd_pcm: Unknown symbol snd_add_device_sysfs_file
snd_pcm: Unknown symbol snd_info_get_str
snd_pcm: Unknown symbol snd_hidden_kcalloc
snd_pcm: Unknown symbol snd_hidden_kfree
snd_pcm: Unknown symbol snd_ctl_register_ioctl
snd_pcm: Unknown symbol snd_card_file_add
snd_pcm: Unknown symbol __snd_printk
snd_pcm: Unknown symbol snd_iprintf
snd_pcm: Unknown symbol snd_major
snd_pcm: Unknown symbol snd_unregister_device
snd_pcm: Unknown symbol snd_timer_new
snd_pcm: Unknown symbol snd_device_new
snd_pcm: Unknown symbol snd_ctl_unregister_ioctl
snd_pcm: Unknown symbol snd_lookup_minor_data
snd_pcm: Unknown symbol snd_info_create_card_entry
snd_pcm: Unknown symbol snd_power_wait
snd_pcm: Unknown symbol snd_hidden_kmalloc
snd_pcm: Unknown symbol snd_device_free
snd_pcm: Unknown symbol snd_card_file_remove
snd_pcm: Unknown symbol snd_register_device_for_dev
snd_pcm: Unknown symbol gcd
snd_pcm: Unknown symbol snd_device_register
snd_pcm: Unknown symbol snd_info_get_line
snd_ac97_codec: Unknown symbol snd_hidden_kzalloc
snd_ac97_codec: Unknown symbol snd_info_register
snd_ac97_codec: Unknown symbol snd_ctl_add
snd_ac97_codec: Unknown symbol snd_info_free_entry
snd_ac97_codec: Unknown symbol snd_hidden_kcalloc
snd_ac97_codec: Unknown symbol snd_interval_refine
snd_ac97_codec: Unknown symbol snd_hidden_kfree
snd_ac97_codec: Unknown symbol snd_ctl_find_id
snd_ac97_codec: Unknown symbol snd_ctl_new1
snd_ac97_codec: Unknown symbol snd_ctl_remove_id
snd_ac97_codec: Unknown symbol snd_component_add
snd_ac97_codec: Unknown symbol snd_ctl_make_virtual_master
snd_ac97_codec: Unknown symbol snd_pcm_hw_rule_add
snd_ac97_codec: Unknown symbol __snd_printk
snd_ac97_codec: Unknown symbol snd_iprintf
snd_ac97_codec: Unknown symbol snd_ctl_boolean_mono_info
snd_ac97_codec: Unknown symbol snd_device_new
snd_ac97_codec: Unknown symbol _snd_ctl_add_slave
snd_ac97_codec: Unknown symbol snd_info_create_card_entry
snd_ac97_codec: Unknown symbol snd_info_get_line
snd: Unknown symbol unregister_sound_special
snd: Unknown symbol register_sound_special_device
snd: Unknown symbol sound_class
snd_seq_device: Unknown symbol snd_hidden_kzalloc
snd_seq_device: Unknown symbol snd_info_register
usb 3-1: new low speed USB device using uhci_hcd and address 3
snd_seq_device: Unknown symbol snd_info_create_module_entry
snd_seq_device: Unknown symbol snd_info_free_entry
snd_seq_device: Unknown symbol snd_seq_root
snd_seq_device: Unknown symbol snd_hidden_kfree
snd_seq_device: Unknown symbol __snd_printk
snd_seq_device: Unknown symbol snd_iprintf
snd_seq_device: Unknown symbol snd_device_new
snd: Unknown symbol unregister_sound_special
snd: Unknown symbol register_sound_special_device
snd: Unknown symbol sound_class
snd_seq_device: Unknown symbol snd_hidden_kzalloc
snd_seq_device: Unknown symbol snd_info_register
snd_seq_device: Unknown symbol snd_info_create_module_entry
snd_seq_device: Unknown symbol snd_info_free_entry
snd_seq_device: Unknown symbol snd_seq_root
snd_seq_device: Unknown symbol snd_hidden_kfree
snd_seq_device: Unknown symbol __snd_printk
snd_seq_device: Unknown symbol snd_iprintf
snd_seq_device: Unknown symbol snd_device_new
snd_rawmidi: Unknown symbol snd_hidden_kzalloc
snd_rawmidi: Unknown symbol snd_info_register
snd_rawmidi: Unknown symbol snd_hidden_ksize
snd_rawmidi: Unknown symbol snd_seq_device_new
snd_rawmidi: Unknown symbol snd_info_free_entry
snd_rawmidi: Unknown symbol snd_hidden_kfree
snd_rawmidi: Unknown symbol snd_unregister_oss_device
snd_rawmidi: Unknown symbol snd_register_oss_device
snd_rawmidi: Unknown symbol snd_ctl_register_ioctl
snd_rawmidi: Unknown symbol snd_card_file_add
snd_rawmidi: Unknown symbol __snd_printk
snd_rawmidi: Unknown symbol snd_iprintf
snd_rawmidi: Unknown symbol snd_major
snd_rawmidi: Unknown symbol snd_oss_info_register
snd_rawmidi: Unknown symbol snd_unregister_device


>
> Takashi
>
> ---
> diff --git a/configure.in b/configure.in
> index 13d29c7..bdc3eb0 100644
> --- a/configure.in
> +++ b/configure.in
> @@ -812,6 +812,14 @@ case "$debug" in
>      ;;
>  esac
>
> +dnl ksize() is almost mandatory now
> +if test "$CONFIG_SND_DEBUG_MEMORY" != "y"; then
> +    if test $kvernum -le 206022; then
> +        CONFIG_SND_DEBUG_MEMORY=y
> +        AC_DEFINE(CONFIG_SND_DEBUG_MEMORY)
> +    fi
> +fi
> +
>  dnl Check for ISA support (for 2.4 kernel)...
>  if test $kvernum -ge 203000; then
>  CHECK_KERNEL_CONFIG(CONFIG_ISA, [ISA support in kernel])
>


--
Patrick Shirkey
Boost Hardware Ltd
