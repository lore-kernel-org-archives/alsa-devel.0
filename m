From: Olivier Ricordeau <olivier.ricordeau@wanadoo.fr>
Subject: Re: [BUG] buggy ali5451 driver
Date: Mon, 04 Nov 2002 17:31:41 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DC6A0ED.6080202@wanadoo.fr>
References: <m24raxpndj.fsf@vador.mandrakesoft.com> <s5hu1ixa0eu.wl@alsa2.suse.de> <3DC68350.2040208@wanadoo.fr> <3DC68814.6070700@wanadoo.fr> <20021104112035.GA14883@dogsolitude.org> <3DC6903B.1070309@wanadoo.fr> <3DC69817.80300@wanadoo.fr> <20021104122851.GA15552@dogsolitude.org>
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

drclaw@dogsolitude.org wrote:
> Ick, that's not what I was hoping would happen.  Well, I guess my
> solution won't work.  Just out of curiosity, can you post your
> /proc/interrupts and /proc/ioports?  I'm interested in just exactly what
> is being shared by what, and what your ide chipset is supposed to be.  

Here is what you've asked for:

cat /proc/interrupts:
            CPU0
   0:     150359          XT-PIC  timer
   1:        197          XT-PIC  keyboard
   2:          0          XT-PIC  cascade
   5:          0          XT-PIC  Texas Instruments PCI1410 PC card 
Cardbus Controller
   8:          1          XT-PIC  rtc
   9:          3          XT-PIC  acpi
  11:          3          XT-PIC  eth0
  12:        280          XT-PIC  PS/2 Mouse
  14:       5506          XT-PIC  ide0
  15:          4          XT-PIC  ide1
NMI:          0
LOC:     150304
ERR:        170
MIS:          0



cat /proc/ioports:

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vesafb
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
4000-40ff : PCI CardBus #02
4400-44ff : PCI CardBus #02
8000-803f : Acer Laboratories Inc. [ALi] M7101 PMU
8040-805f : Acer Laboratories Inc. [ALi] M7101 PMU
8080-808f : Acer Laboratories Inc. [ALi] M5229 IDE
   8080-8087 : ide0
   8088-808f : ide1
8090-8093 : PCI device 1002:cab0 (ATI Technologies Inc)
8098-809f : Conexant HSF 56k HSFi Modem
8400-84ff : Acer Laboratories Inc. [ALi] M5451 PCI AC-Link Controller 
Audio Devi
ce
8800-88ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C
   8800-88ff : 8139too
9000-9fff : PCI Bus #01
   9000-90ff : PCI device 1002:4336 (ATI Technologies Inc)



Hope it will help...
Note that this is wat I got after a "normal" boot (no kernel option, dma 
still active).

It would be just great not to be obliged to install a window$ on this 
laptop... I've not used Microsoft's products for several months and I 
feel just fine with it! ;-)

Oliv

-- 

  -= *Olivier RICORDEAU* =-   |  ICQ: 65452304
  Ing1 EPITA Millesime 2005   | Phone: 0686720852
           olivier.ricordeau@wanadoo.fr
          _Might the source be with you_



-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
