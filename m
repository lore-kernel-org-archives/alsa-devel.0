From: Jeremy Hall <jhall@maoz.com>
Subject: problems with unresolved symbols in 2.4.25 and intel8x0
Date: Mon, 15 Mar 2004 11:33:05 -0500 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200403151633.i2FGX5CL020642@sith.maoz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

I just did a cvs update -dP on my CVS because I was experiencing lockups 
when using intel8x0 and my drivers were a bit old.

When I had finished running ./cvscompile in alsa-driver, alsa-lib, and 
alsa-tools along with appropriate make install's, this is the output I got 
when trying to run modprobe snd-intel8x0
/lib/modules/2.4.25/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_info_unregister_R8ae0c1c7
/lib/modules/2.4.25/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_info_register_R41618e6b
/lib/modules/2.4.25/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_card_file_add_Rebed1e7f
/lib/modules/2.4.25/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_info_create_card_entry_R1c1b2f3e
/lib/modules/2.4.25/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_card_file_remove_Rea2826fe
/lib/modules/2.4.25/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_device_register_Rdb26d168
/lib/modules/2.4.25/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_major_R8f595b11
/lib/modules/2.4.25/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_info_create_module_entry_R0088747e
/lib/modules/2.4.25/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_register_device_R478a1e3e
/lib/modules/2.4.25/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_kcalloc_R4da9e78a
/lib/modules/2.4.25/kernel/sound/acore/snd-pcm.o: unresolved symbol _snd_magic_kcalloc_R2061fcb1
/lib/modules/2.4.25/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_device_new_R8feb987a
/lib/modules/2.4.25/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_unregister_device_Rb9a10896
/lib/modules/2.4.25/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_magic_kfree_R734de7d7
/lib/modules/2.4.25/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_ctl_register_ioctl_R2aa42294
/lib/modules/2.4.25/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_hidden_kfree_R3d62778c
/lib/modules/2.4.25/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_ctl_unregister_ioctl_Rb7f8e374
/lib/modules/2.4.25/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_info_get_str_Rb213fe8b
/lib/modules/2.4.25/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_device_free_R8ab7612c
/lib/modules/2.4.25/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_hidden_kmalloc_R91c87dfa
/lib/modules/2.4.25/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_timer_interrupt_R37d5b4d3
/lib/modules/2.4.25/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_verbose_printd_R85cd4e0b
/lib/modules/2.4.25/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_compat_strlcpy_Rb4409a1e
/lib/modules/2.4.25/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_timer_new_R76b38309
/lib/modules/2.4.25/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_iprintf_R2f0b152f
/lib/modules/2.4.25/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_info_free_entry_R90332a07
/lib/modules/2.4.25/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_power_wait_Rd759a60d
/lib/modules/2.4.25/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_timer_notify_R21f43916
/lib/modules/2.4.25/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_info_get_line_R0a6fd27b
/lib/modules/2.4.25/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_verbose_printk_Rf52a421e
/lib/modules/2.4.25/kernel/sound/acore/snd-pcm.o: insmod /lib/modules/2.4.25/kernel/sound/acore/snd-pcm.o failed
/lib/modules/2.4.25/kernel/sound/acore/snd-pcm.o: insmod snd-intel8x0 failed

Perhaps something isn't getting built, or I've missed something quite 
large.  Assistance appreciated.

_J


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
