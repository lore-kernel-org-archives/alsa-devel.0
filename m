From: Pieter Palmers <pieter.palmers@student.kuleuven.ac.be>
Subject: source tree
Date: Fri, 24 Jan 2003 12:19:48 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E312154.1060205@student.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

I'm writing a driver for the Maxisound ISIS and I have the following
question: how do I get it into my local source tree and get it compiled?
I manage to compile the module, but I get 'unresolved depencies':
depmod: *** Unresolved symbols in snd-isis.o
depmod:         snd_pcm_period_elapsed_R464d6116
depmod:         snd_ctl_add_R4783579c
depmod:         snd_card_register_Rec576d24
depmod:         snd_malloc_pci_pages_fallback_R391ee959
depmod:         snd_device_new_R1ae93b48
depmod:         snd_verbose_printk_R49d4e4d1
depmod:         snd_pcm_new_R0affc2e1
depmod:         snd_mpu401_uart_interrupt_R4ea4dc60
depmod:         snd_pcm_format_width_R55eb2175
depmod:         snd_kcalloc_R4da9e78a
depmod:         snd_pcm_set_ops_R5bc58ea3
depmod:         snd_ctl_new1_R15f3f808
depmod:         snd_free_pci_pages_Rff2abb0b
depmod:         snd_card_free_R58fc32d2
depmod:         snd_ac97_mixer_R68e0ce82
depmod:         snd_card_new_R429f855e
depmod:         snd_pcm_lib_ioctl_Rabc0ac86
depmod:         snd_mpu401_uart_new_Refff4aee

Aren't these ALSA symbols? What do I change to get this resolved?

Pieter




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
