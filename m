From: Alex Pintilie <pintilee@gmx.net>
Subject: Native Instruments - Audio Kontrol 1 - snd_usb_caiaq
	module
Date: Mon, 28 May 2007 16:37:39 +0200
Message-ID: <465AE933.60605@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 73F1224735
	for <alsa-devel@alsa-project.org>;
	Mon, 28 May 2007 16:37:38 +0200 (CEST)
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

Hallo!

I just registered to this mailing list because a developer kindly 
advised me to do so. I own the external sound card Audio Kontrol 1 from 
Native Instruments and I was happy to find that drivers for it are 
already in the making.

I downloaded alsa-driver-1.0.14rc4 and compiled successfully with 
./hgcompile, then I installed the module with:

# install -m 644 snd-usb-caiaq.ko /lib/modules/`uname 
-r`/kernel/drivers/snd-usb-caiaq.ko

# /sbin/depmod -a

After the command:

# modprobe snd-usb-caiaq

I get the following error:

FATAL: Error inserting snd_usb_caiaq 
(/lib/modules/2.6.20-15-lowlatency/kernel/drivers/snd-usb-caiaq.ko): 
Unknown symbol in module, or unknown parameter (see dmesg)

dmesg shows the following:

[10095.330000] snd_usb_caiaq: disagrees about version of symbol snd_pcm_new
[10095.330000] snd_usb_caiaq: Unknown symbol snd_pcm_new
[10095.330000] snd_usb_caiaq: disagrees about version of symbol 
snd_pcm_limit_hw_rates
[10095.330000] snd_usb_caiaq: Unknown symbol snd_pcm_limit_hw_rates
[10095.331000] snd_usb_caiaq: disagrees about version of symbol 
snd_pcm_lib_preallocate_pages_for_all
[10095.331000] snd_usb_caiaq: Unknown symbol 
snd_pcm_lib_preallocate_pages_for_all
[10095.331000] snd_usb_caiaq: Unknown symbol snd_hidden_kfree
[10095.331000] snd_usb_caiaq: Unknown symbol snd_verbose_printk
[10095.331000] snd_usb_caiaq: disagrees about version of symbol 
snd_pcm_lib_malloc_pages
[10095.332000] snd_usb_caiaq: Unknown symbol snd_pcm_lib_malloc_pages
[10095.332000] snd_usb_caiaq: disagrees about version of symbol 
snd_pcm_lib_ioctl
[10095.332000] snd_usb_caiaq: Unknown symbol snd_pcm_lib_ioctl
[10095.332000] snd_usb_caiaq: disagrees about version of symbol 
snd_pcm_lib_free_pages
[10095.332000] snd_usb_caiaq: Unknown symbol snd_pcm_lib_free_pages
[10095.332000] snd_usb_caiaq: disagrees about version of symbol 
snd_pcm_set_ops
[10095.332000] snd_usb_caiaq: Unknown symbol snd_pcm_set_ops
[10095.333000] snd_usb_caiaq: Unknown symbol snd_hidden_kmalloc
[10095.333000] snd_usb_caiaq: disagrees about version of symbol 
snd_pcm_period_elapsed
[10095.333000] snd_usb_caiaq: Unknown symbol snd_pcm_period_elapsed

This may not look like much but it's the effort from a couple of days 
searching, reading and testing. I hope you can help me.

--
Alex
