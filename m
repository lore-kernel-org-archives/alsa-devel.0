From: Mark Knecht <markknecht@attbi.com>
Subject: Re: PCI_DEVICE_ID_XILINX_HAMMERFALL_DSP
Date: 09 Dec 2002 20:53:44 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1039496025.1342.62.camel@Godzilla>
References: <20021210040452.VTPP17908.rwcrgwc51.attbi.com@newmx3.fast.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20021210040452.VTPP17908.rwcrgwc51.attbi.com@newmx3.fast.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>, Alsa-List <linux-audio-user@music.columbia.edu>
List-Id: alsa-devel@alsa-project.org

Thanks Paul. 

I'm still struggling with getting this new card going. Fernanado and I
are working through the issues one at a time by doing a Planet RPM for
the newest version alsa and have applied the one line patch that you
pointed me at the other day. However, I'm still not running.

1) Fernando applied the one line patch applied:


--- hdsp.c-orig 2002-12-03 19:28:40.000000000 +0000
+++ hdsp.c      2002-12-03 19:28:06.000000000 +0000
@@ -2966,6 +2966,7 @@

        switch (rev & 0xff) {
        case 0xa:
+       case 0x64:
                /* hdsp_initialize_firmware() will reset this */
                hdsp->card_name = "RME Hammerfall DSP";
                break;


2) Alsaconf works, sort of. modules.conf gets built, but my machine will
not reboot after running it. Don't know why.


3) When I boot I see the following message in /var/log/messages

Dec  9 12:39:40 Godzilla kernel: Hammerfall memory allocator: buffers
allocated for 1 cards
Dec  9 12:39:40 Godzilla kernel: RME Hammerfall-DSP: no cards found
Dec  9 12:39:40 Godzilla insmod:
/lib/modules/2.4.19-1.ll/kernel/drivers/sound/pci/rme9652/snd-hdsp.o:
init_module: No such device



4) lspci -v shows the card is there:

00:0f.0 Multimedia audio controller: Xilinx, Inc.: Unknown device 3fc5
(rev 64)
        Flags: bus master, medium devsel, latency 32, IRQ 10
        Memory at f6000000 (32-bit, non-prefetchable) [size=64K]


I'm completely puzzled. What are we doing wrong?


Thanks,
Mark



On Mon, 2002-12-09 at 20:11, Paul Davis wrote:
> >   Where are the definitions for PCI_DEVICE_ID_XILINX_HAMMERFALL_DSP and
> >PCI_VENDOR_ID_XILINX kept in the alsa code? 
> 
> one of two places. either in the kernel source (if you have a much,
> much newer kernel (2.5)) or at the top of either rme9652.c or hdsp.c
> (there are conditional #define's there to check if they are already
> defined in the kernel's PCI ID header.
> 
> --p




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
