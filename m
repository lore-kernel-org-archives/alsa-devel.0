From: Raymond <rayau@netvigator.com>
Subject: Re: problems with snd_au8830 module under mandriva 2005
Date: Fri, 02 Sep 2005 11:39:22 +0800
Message-ID: <4317C96A.9020008@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Erik <assie2@zonnet.nl>
Cc: Alien <alien999999999@users.sourceforge.net>, Igor Kovalenko <garrison@mail.ru>, openvortex-dev@nongnu.org, alsa-devel@lists.sourceforge.net, Manuel Jander <manuel.jander@gmail.com>
List-Id: alsa-devel@alsa-project.org


There are 3 bug reports for AMD64 in ALSA BTS.
1047 - au8810
1138 - au8820
1025 - au8830

au8810/au8820/au8830 driver is tightly coupled in ALSA au88x0

1) EQ, SPDIF of au8810/au8830 are not present in au8820,
2) WT of au8820/au8830 are not present in au8810,
3) SoftModem of au8810 are not present in au8820/au8830.

Please correct me if I am wrong, I think au8810 do not have any 3D 
effect hardware.

The essential part of the patch is

void __iomem *mmio
#define    hwread(x,y) readl((x)+(y))
#define    hwwrite(x,y,z) writel((z),(x)+(y))

There are 32bits and 64bits data type difference need to be fixed.

1) DMA, SRC, Mixer, Equalizer, Capturing
2) MPU401, Gameport, SPDIF
3) 3D, XTALK

Please clearly describe your volume bar problem.

The volume issue may be relate to the equalizer, hardware mixer, xtalk 
or codec initialization.

The EQ part in diff11.diff is not tested since EQ is not present in au8820.

Please post the output

lspci -vvn

cat /proc/asound/au8830/codec97#0/ac97#0-0+regs

I am not sure Alien's au8810 patch is as same as Igor Kovalenko 's 
au8820 patch. They seem to have their own patches.


The error is properly forget to change the functions declared in 
au88x0_xtalk.h

If the code in au88x0_xtalk.c is arranged in correct order, it is 
possible to delete all those function declaration in au88x0_xtalk.h

It's diffcult to say the XTALK part in diff1.diff is right or wrong.

Any hint on how to test the xtalk canceller ?

I think any patch to the stable ALSA driver in alsa-kernel is to fix 
bugs instead of introducing more confusion.

Any side effect if keeping the XTALK part unchanged ?

or

Implement a kcontrol to test the XTALK



It's great to have an user with au8830 and AMD64 to test all features in 
au8830, this allow nearly all implemented features in au88x0 to be tested.

http://savannah.nongnu.org/patch/download.php?item_id=3948


You should cc your reply to openvortex-dev@nongnu.org so that the other 
developers know the problem.


 > this is what i get when compiling the kernel
 > but maybe i have to delete the kernel source tree
 > because i can remember that i had allready patched the alsa part before
 > a long time ago
 > it was in june i posted the error and not long after that alien from
 > nongnu list contacted me and told me about a patch/.diff
 > i have a working alsa driver with that diff but the only problem still
 > is that the volume bar is acting strange so i think i have allready done
 > this patch
 > but i was glad i could compile it under 64 bit kernel
 >
 > do you know if this is the same patch if not i will clean all sources
 > and compile the kernel again.
 >
 > Erik
 >
 >
 >
 > CC [M]  sound/pci/au88x0/au8830.o
 > In file included from sound/pci/au88x0/au8830.c:17:
 > sound/pci/au88x0/au88x0_xtalk.c:645: error: conflicting types for
 > 'vortex_XtalkHw_SetSampleRate'
 > sound/pci/au88x0/au88x0_xtalk.h:51: error: previous declaration of
 > 'vortex_XtalkHw_SetSampleRate' was here
 > sound/pci/au88x0/au88x0_xtalk.c:645: error: conflicting types for
 > 'vortex_XtalkHw_SetSampleRate'
 > sound/pci/au88x0/au88x0_xtalk.h:51: error: previous declaration of
 > 'vortex_XtalkHw_SetSampleRate' was here
 > sound/pci/au88x0/au88x0_xtalk.h:51: warning:
 > 'vortex_XtalkHw_SetSampleRate' declared `static' but never defined
 > sound/pci/au88x0/au88x0_xtalk.c:645: warning:
 > 'vortex_XtalkHw_SetSampleRate' defined but not used
 > make[3]: *** [sound/pci/au88x0/au8830.o] Error 1
 > make[2]: *** [sound/pci/au88x0] Error 2
 > make[1]: *** [sound/pci] Error 2
 > make: *** [sound] Error 2
 >
 >


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
