From: "Vrihad Shoonya" <vrihad@softhome.net>
Subject: Re: Is there plans to support SiS7019?
Date: Tue, 17 Aug 2004 10:34:57 +0530 (IST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <34342.192.168.0.10.1092719097.squirrel@dev.datamax.co.in>
References: <200408190732.i7J7WcoW020750@www3.pobox.sk>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200408190732.i7J7WcoW020750@www3.pobox.sk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Zubaj <pzad@pobox.sk>
Cc: alsa-devel@lists.sourceforge.net, clemens@ladisch.de, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Hi,

> These errors are not related to changes you made.
>
> unregister_sound_special
> register_sound_special
>
> These are definied in soundcore module.
>
> I think you need this in modules.conf too
>
> alias char-major-116 snd
>
> before these lines
> alias snd-card-0 snd-trident
> alias sound-slot-0 snd-trident

Done. Now more unresolved symbols.

insmod: unresolved symbol snd_pcm_new
insmod: unresolved symbol snd_card_set_pm_callback
insmod: unresolved symbol snd_seq_device_new
insmod: unresolved symbol snd_hidden_kcalloc
insmod: unresolved symbol snd_ctl_notify
insmod: unresolved symbol snd_dma_alloc_pages
insmod: unresolved symbol snd_verbose_printk
insmod: unresolved symbol snd_util_memhdr_new
insmod: unresolved symbol snd_hidden_vfree
insmod: unresolved symbol snd_pcm_format_width
insmod: unresolved symbol snd_card_pci_resume
insmod: unresolved symbol snd_util_mem_avail
insmod: unresolved symbol snd_pcm_set_sync
insmod: unresolved symbol snd_pcm_lib_free_pages
insmod: unresolved symbol __snd_util_memblk_new
insmod: unresolved symbol __snd_util_mem_free
insmod: unresolved symbol snd_ctl_add
insmod: unresolved symbol snd_device_new
insmod: unresolved symbol snd_pcm_lib_malloc_pages
insmod: unresolved symbol snd_pcm_period_elapsed
insmod: unresolved symbol snd_ac97_suspend
insmod: unresolved symbol snd_mpu401_uart_interrupt
insmod: unresolved symbol snd_card_proc_new
insmod: unresolved symbol snd_pcm_lib_preallocate_pages
insmod: unresolved symbol snd_hidden_kfree
insmod: unresolved symbol snd_pcm_hw_constraint_minmax
insmod: unresolved symbol snd_pcm_suspend_all
insmod: unresolved symbol __snd_util_mem_alloc
insmod: unresolved symbol snd_iprintf
insmod: unresolved symbol snd_device_free
insmod: unresolved symbol snd_pcm_lib_preallocate_free_for_all
insmod: unresolved symbol snd_pcm_set_ops
insmod: unresolved symbol snd_hidden_vmalloc
insmod: unresolved symbol snd_util_memhdr_free
insmod: unresolved symbol snd_ac97_mixer
insmod: unresolved symbol snd_pcm_lib_ioctl
insmod: unresolved symbol snd_card_register
insmod: unresolved symbol snd_pcm_format_signed
insmod: unresolved symbol snd_ctl_new1
insmod: unresolved symbol snd_ac97_resume
insmod: unresolved symbol snd_pcm_sgbuf_ops_page
insmod: unresolved symbol snd_ac97_bus
insmod: unresolved symbol snd_card_free
insmod: unresolved symbol snd_pcm_lib_preallocate_pages_for_all
insmod: unresolved symbol snd_card_new
insmod: unresolved symbol snd_dma_free_pages
insmod: unresolved symbol snd_card_pci_suspend
insmod: unresolved symbol snd_mpu401_uart_new
modprobe: failed to load module snd-trident

I know that all modules to satisfy these symbols are compiled and
installed. I think my modules.conf file is not perfect. Can I get
a sample moudles.conf file? Does any such sample exist at alsa
site?

Thanks.

-vrihad



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
