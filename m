From: Raymond <rayau@netvigator.com>
Subject: Re: [ALSA - driver 0001138]: errors when installing au8820 modules
Date: Thu, 09 Jun 2005 16:49:02 +0800
Message-ID: <42A8027E.1090404@netvigator.com>
References: <add360993204c8039097fe7085524651@bugtrack.alsa-project.org> <s5hwtp6w2nw.wl@alsa2.suse.de> <42A6B51F.20405@netvigator.com> <200506081223.03802.alien999999999@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200506081223.03802.alien999999999@users.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: openvortex-dev@nongnu.org
List-Id: alsa-devel@alsa-project.org

It seem that no one has informed the bug reporter about the patch and he 
is using Intel X86_64 instead of your AMD 64

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1138

Alien wrote:
> I don't think it'll be faster, gcc -O2 will have changed it accordingly 
> anyway, without optimization it might be faster, but the thing is that it 
> just looks cleaner...
> 
> Op woensdag 8 juni 2005 11:06, schreef Raymond:
> 
>>au8830 can be loaded after I change "unsigned long __iomem *mmio" to
>>"void __iomem *mmio" on my 32 bits machine.
>>
>>How can I obtain the disassembly of snd-au8830.o to prove that it run
>>faster than before ( without bitshift ) ?
>>
>>alsa-kernel/pci/au88x0/au88x0.h
>>
>>@@ -41,8 +41,8 @@
>>
>>  #define        VORTEX_DMA_MASK 0xffffffff
>>
>>
>>-#define        hwread(x,y) readl((x)+((y)>>2))
>>-#define        hwwrite(x,y,z) writel((z),(x)+((y)>>2))
>>+#define        hwread(x,y) readl((x)+(y))
>>+#define        hwwrite(x,y,z) writel((z),(x)+(y))
>>
>>@@ -172,7 +172,7 @@
>>
>>         /* PCI hardware resources */
>>         unsigned long io;
>>-       unsigned long __iomem *mmio;
>>+       void __iomem *mmio;
>>         unsigned int irq;
>>         spinlock_t lock;
>>
>>
>>
>>I don't have any MPU401 device to test this change.
>>
>>
>>alsa-kernel/pci/au88x0/au88x0_mpu401.c
>>@@ -95,7 +95,7 @@
>>                 return temp;
>>         }
>>  #else
>>-       port = (unsigned long)(vortex->mmio + (VORTEX_MIDI_DATA >> 2));
>>+       port = (unsigned long)(vortex->mmio + VORTEX_MIDI_DATA);
>>         if ((temp =
>>              snd_mpu401_uart_new(vortex->card, 0, MPU401_HW_AUREAL, port,
>>                                  1, 0, 0, &rmidi)) != 0) {
>>@@ -105,7 +105,7 @@
>>                 return temp;
>>         }
>>         mpu = rmidi->private_data;
>>-       mpu->cport = (unsigned long)(vortex->mmio + (VORTEX_MIDI_CMD >>
>>2)); +       mpu->cport = (unsigned long)(vortex->mmio + VORTEX_MIDI_CMD);
>>#endif
>>         vortex->rmidi = rmidi;
>>         return 0;
>>
>>



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
