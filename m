From: "Ted T. Logian" <tedtheologian@gmail.com>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Thu, 09 Oct 2008 13:49:58 -0500
Message-ID: <1223578198.7091.1.camel@home>
References: <s5hy70xsl46.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.170])
	by alsa0.perex.cz (Postfix) with ESMTP id C3833245B9
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Oct 2008 20:50:23 +0200 (CEST)
Received: by wf-out-1314.google.com with SMTP id 24so243076wfg.23
	for <alsa-devel@alsa-project.org>; Thu, 09 Oct 2008 11:50:02 -0700 (PDT)
In-Reply-To: <s5hy70xsl46.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hmm,

I have a fedora 9 machine and I installed your alsa-driver snapshot,
which does have snd-sbxfi.

However, I am getting tons of errors

modprobe snd-pcm
FATAL: Error inserting snd_pcm
(/lib/modules/2.6.26.5-45.fc9.i686/kernel/sound/acore/snd-pcm.ko):
Unknown symbol in module, or unknown parameter (see dmesg)
FATAL: Error running install command for snd_pcm
snd_pcm: Unknown symbol snd_info_register
snd_pcm: Unknown symbol snd_info_create_module_entry
snd_pcm: Unknown symbol snd_timer_notify
snd_pcm: Unknown symbol snd_timer_interrupt
snd_pcm: Unknown symbol snd_info_free_entry
snd_pcm: Unknown symbol snd_add_device_sysfs_file
snd_pcm: Unknown symbol snd_info_get_str
snd_pcm: Unknown symbol snd_verbose_printk
snd_pcm: Unknown symbol snd_ctl_register_ioctl
snd_pcm: Unknown symbol snd_card_file_add
snd_pcm: Unknown symbol snd_iprintf
snd_pcm: Unknown symbol snd_major
snd_pcm: Unknown symbol snd_unregister_device
snd_pcm: Unknown symbol snd_timer_new
snd_pcm: Unknown symbol snd_device_new
snd_pcm: Unknown symbol snd_ctl_unregister_ioctl
snd_pcm: Unknown symbol snd_lookup_minor_data
snd_pcm: Unknown symbol snd_info_create_card_entry
snd_pcm: Unknown symbol snd_power_wait
snd_pcm: Unknown symbol snd_device_free
snd_pcm: Unknown symbol snd_card_file_remove
snd_pcm: Unknown symbol snd_register_device_for_dev
snd_pcm: Unknown symbol snd_device_register
snd_pcm: Unknown symbol snd_info_get_line
snd: Unknown symbol unregister_sound_special
snd: Unknown symbol register_sound_special_device
snd: Unknown symbol sound_class
snd_timer: Unknown symbol snd_info_register
snd_timer: Unknown symbol snd_info_create_module_entry
snd_timer: Unknown symbol snd_info_free_entry
snd_timer: Unknown symbol snd_verbose_printk
snd_timer: Unknown symbol snd_iprintf
snd_timer: Unknown symbol snd_ecards_limit
snd_timer: Unknown symbol snd_oss_info_register
snd_timer: Unknown symbol snd_unregister_device
snd_timer: Unknown symbol snd_device_new
snd_timer: Unknown symbol snd_register_device_for_dev
snd: Unknown symbol unregister_sound_special
snd: Unknown symbol register_sound_special_device
snd: Unknown symbol sound_class
snd_timer: Unknown symbol snd_info_register
snd_timer: Unknown symbol snd_info_create_module_entry
snd_timer: Unknown symbol snd_info_free_entry
snd_timer: Unknown symbol snd_verbose_printk
snd_timer: Unknown symbol snd_iprintf
snd_timer: Unknown symbol snd_ecards_limit
snd_timer: Unknown symbol snd_oss_info_register
snd_timer: Unknown symbol snd_unregister_device
snd_timer: Unknown symbol snd_device_new
snd_timer: Unknown symbol snd_register_device_for_dev
snd_pcm: Unknown symbol snd_info_register
snd_pcm: Unknown symbol snd_info_create_module_entry
snd_pcm: Unknown symbol snd_timer_notify
snd_pcm: Unknown symbol snd_timer_interrupt
snd_pcm: Unknown symbol snd_info_free_entry
snd_pcm: Unknown symbol snd_add_device_sysfs_file
snd_pcm: Unknown symbol snd_info_get_str
snd_pcm: Unknown symbol snd_verbose_printk
snd_pcm: Unknown symbol snd_ctl_register_ioctl
snd_pcm: Unknown symbol snd_card_file_add
snd_pcm: Unknown symbol snd_iprintf
snd_pcm: Unknown symbol snd_major
snd_pcm: Unknown symbol snd_unregister_device
snd_pcm: Unknown symbol snd_timer_new
snd_pcm: Unknown symbol snd_device_new
snd_pcm: Unknown symbol snd_ctl_unregister_ioctl
snd_pcm: Unknown symbol snd_lookup_minor_data
snd_pcm: Unknown symbol snd_info_create_card_entry
snd_pcm: Unknown symbol snd_power_wait
snd_pcm: Unknown symbol snd_device_free
snd_pcm: Unknown symbol snd_card_file_remove
snd_pcm: Unknown symbol snd_register_device_for_dev
snd_pcm: Unknown symbol snd_device_register
snd_pcm: Unknown symbol snd_info_get_line



what do i do?
On Thu, 2008-10-09 at 20:02 +0200, Takashi Iwai wrote:

> Hi,
> 
> $SUBJECT is now on my sound-unstable git tree:
>     git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-unstable-2.6.git
> together with other experimental patches.
> 
> If you're using 2.6.27-rc* git tree, pull the master branch of the
> tree above into yours, and run make oldconfig.  That is,
>     % cd /your/git-tree
>     % git pull git://...../sound-unstable-2.6.git master
> 
> If you are not using 2.6.27-rc*, or not familiar with git, you can try
> alsa-driver-unstable snapshot tarball available at
>     ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/
> Run configure, make and make install as usual ALSA-driver tarball.
> 
> (I didn't check whether the tarball correctly includes the sbxfi
>  stuff.  It should have been generated automatically.  If not, wait
>  for a while.  If it still doesn't include sbxfi code, please report.
>  I'll fix it tomorrow morning.)
> 
> The driver is built only for 2.6.26 or later.  If you have an older
> kernel, edit alsa-driver*/kconfig-vers and change the version of
> CONFIG_SND_SBXFI to 2.6.24 or whatever you want.  Then run
> ./gitcompile, instead of configure in this case to update the
> configure script.
> 
> **NOTE**
> The driver is totally untested.  It's just compiled without errors,
> but not reviewed after a quick writing.  So, don't expect it ever runs
> at the first try.  A crash is highly possible.
> 
> There are some build conditions found in sound/pci/sbxfi/sbxfi.c,
> starting with XXX_*.  You can change it if you want.  As default, it's
> for non-fullduplex but accept different rates.  Not sure whether this
> works at all.
> 
> Any test- (and better debugging-) reports are appreciated.
> 
> 
> thanks,
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
