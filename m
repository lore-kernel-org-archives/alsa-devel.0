From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Trying to get alsa-driver to build on a 2.6.x kernel.
Date: Fri, 30 Jan 2004 14:48:35 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <401A6EC3.5040901@superbug.demon.co.uk>
References: <401963AC.8080603@superbug.demon.co.uk>	<s5hekthsnlx.wl@alsa2.suse.de>	<401A6488.9060108@superbug.demon.co.uk> <s5h7jz9sewo.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050505070403060807010205"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7jz9sewo.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050505070403060807010205
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> At Fri, 30 Jan 2004 14:04:56 +0000,
> James Courtier-Dutton wrote:
> 
>>[1  <text/plain; us-ascii (7bit)>]
>>Takashi Iwai wrote:
>>
>>>At Thu, 29 Jan 2004 19:49:00 +0000,
>>>James Courtier-Dutton wrote:
>>>
>>>
>>>>[1  <text/plain; us-ascii (7bit)>]
>>>>I have been told that one should be able to build alsa-driver on a 2.6.x 
>>>>kernel, but it fails here.
>>>>
>>>>I attach config.log for your information.
>>>>I also attach the console output from running
>>>>./configure --with-cards=emu10k1,intel8x0,usb-audio
>>>>
>>>>Can anyone help?
>>>
>>>
>>>how about the patch below?
>>>
>>>
>>>Takashi
>>
>>Much better, configure finishes now, but compile fails.
>>Now I get a PDE error. See attachment.
>>It would be nice if configure could somehow check for and work around 
>>the PDE error.
> 
> 
> please show config.log.  configure didn't detect PDE by some reason.
> 
> 
> Takashi
> 
> 
I also attach the console output from the configure command.


--------------050505070403060807010205
Content-Type: text/plain;
 name="configure-output.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="configure-output.txt"

loading cache ./config.cache
checking for gcc... (cached) gcc
checking whether the C compiler (gcc  ) works... yes
checking whether the C compiler (gcc  ) is a cross-compiler... no
checking whether we are using GNU C... (cached) yes
checking whether gcc accepts -g... (cached) yes
checking for ranlib... (cached) ranlib
checking for a BSD compatible install... (cached) /usr/bin/install -c
checking how to run the C preprocessor... (cached) gcc -E
checking for ANSI C header files... (cached) yes
checking for working const... (cached) yes
checking for inline... (cached) inline
checking whether time.h and sys/time.h may both be included... (cached) yes
checking whether gcc needs -traditional... (cached) no
checking for current directory... /usr/local/alsacvs/alsa-driver
checking cross compile... 
checking for directory with kernel source... /lib/modules/2.6.2-rc2/build
checking for kernel version... 2.6.2-rc2
checking for GCC version... Kernel compiler: gcc 3.3.2 20031218 (Gentoo Linux 3.3.2-r5, propolice-3.3-7) Used compiler: gcc (GCC) 3.3.2 20031218 (Gentoo Linux 3.3.2-r5, propolice-3.3-7)
checking for built-in ALSA... no
checking for existing ALSA module... yes
checking for Red Hat kernel... auto
checking for Red Hat kernel... no
checking to modify of kernel linux/kmod.h... no
checking for kernel linux/compiler.h... yes
checking for kernel linux/pm.h... yes
checking for kernel linux/spinlock.h... yes
checking for kernel linux/irq.h... yes
checking for kernel linux/threads.h... yes
checking for kernel linux/rwsem.h... yes
checking for kernel linux/gameport.h... yes
checking for kernel linux/devfs_fs_kernel.h... yes
checking for kernel linux/highmem.h... yes
checking for kernel linux/workqueue.h... yes
checking for kernel asm/hw_irq.h... yes
checking for kernel linux/device.h... yes
checking for kernel linux/jiffies.h... yes
checking for kernel linux/compat.h... yes
checking for kernel linux/adb.h... yes
checking for kernel linux/cuda.h... yes
checking for kernel linux/pmu.h... yes
checking for kernel module symbol versions... no
checking for PCI support in kernel... yes
checking for SGI/MIPS (HAL2) architecture... no
checking for directory to store kernel modules... /lib/modules/2.6.2-rc2/kernel/sound
checking for verbose printk... on
checking for debug level... none
checking for ISA support in kernel... yes
checking for processor type... i686
checking for i386 machine type... default
checking for SMP... yes
checking for Video device support in kernel... yes
checking for ISA PnP driver in kernel... yes
checking for PnP driver in kernel... yes
checking for Kernel ISA-PnP support... no
checking for Kernel ISA-PnP module support... no
checking for strlcpy... yes
checking for snprintf... yes
checking for vmalloc_to_page... no
checking for old kmod... no
checking for PDE... no
checking for pci_set_consistent_dma_mask... no
checking for tty->count is the atomic type... no
checking for driver version... 1.0.2
checking for sequencer support... yes
checking for OSS/Free emulation... yes
checking for RTC callback support in kernel... yes
checking for USB support... yes
checking for kernel PCMCIA
checking for PCMCIA support... no
checking for PCMCIA module support... no
checking for PC9800 support in kernel... no
checking for which soundcards to compile driver for... emu10k1 intel8x0 usb-audio
creating ./config.status
creating version
creating Makefile.conf
creating snddevices
creating utils/alsa-driver.spec
creating utils/buildrpm
creating toplevel.config
creating utils/alsasound
creating utils/alsasound.posix
creating include/config.h
include/config.h is unchanged
creating include/config1.h
include/config1.h is unchanged
creating include/version.h
include/version.h is unchanged
creating include/autoconf-extra.h
include/autoconf-extra.h is unchanged
Hacking autoconf.h...

--------------050505070403060807010205--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
