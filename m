From: "Yon Mercury" <swirlee@stickist.com>
Subject: Re: Re: Echo driver
Date: Mon, 22 Nov 2004 17:45:18 -0700
Message-ID: <20041123004518.M39311@stickist.com>
References: <20041122021637.M69154@stickist.com> <XFMail.20041122172923.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <XFMail.20041122172923.pochini@shiny.it>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Giuliano,

OK, here's a comparison of the CardBus registers between Linux and Windows.
As you can see, some registers are different-- take 0D for example.

The question is, what registers are likely to be the ones we have to change?

Linux
-----

localhost:~# lspci -s 00:0f.0 -xxx
0000:00:0f.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
00: 80 11 76 04 07 00 10 02 80 00 07 06 00 a8 82 00
10: 00 00 00 10 dc 00 00 22 00 02 05 b0 00 00 40 10
20: 00 f0 7f 10 00 00 80 10 00 f0 bf 10 00 40 00 00
30: fc 40 00 00 00 44 00 00 fc 44 00 00 0a 01 00 05
40: cf 10 9a 10 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 82 08 00 03 00 00 63 04 63 04 00 00 00 30
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 0f 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: cf 10 9a 10 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 19 fe
e0: 00 c0 c0 24 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

localhost:~# lspci -s 00:0f.1 -xxx
0000:00:0f.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
00: 80 11 76 04 07 00 10 02 80 00 07 06 00 a8 82 00
10: 00 10 00 10 dc 00 00 02 00 06 09 b0 00 00 c0 10
20: 00 f0 ff 10 00 00 00 11 00 f0 3f 11 00 48 00 00
30: fc 48 00 00 00 4c 00 00 fc 4c 00 00 0a 02 80 05
40: cf 10 9a 10 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 82 08 00 03 00 00 63 04 63 04 00 00 00 30
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 0f 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: cf 10 9a 10 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 19 fe
e0: 00 40 c0 24 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Windows
-------

__ Device __     CardBus Bridge
                                                                              
                                                                              
  00 00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F   Refresh    : ON        
  00 80 11 76 04 07 00 10 02 80 00 07 06 00 40 82 00                          
  10 00 00 00 00 DC 00 00 02 00 02 02 B0 00 00 10 0C   Rev ID        : 80     
  20 00 F0 1F 0C 00 00 00 00 00 00 00 00 FC FF 00 00   Int Line (IRQ): 0A     
  30 00 00 00 00 00 00 00 00 00 00 00 00 0A 01 00 04   Int Pin       : 01     
  40 CF 10 9A 10 01 00 00 00 00 00 00 00 00 00 00 00   Latency Timer : 40     
  50 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   Sub.Vendor ID : FFFC   
  60 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   Subsystem ID  : 0000   
  70 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00                          
  80 00 00 82 08 00 03 00 00 63 04 63 04 00 00 00 30   #0: 00000000 FFFFF000  
  90 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   #1: 020000DC 020000DC  
  A0 00 00 00 00 00 00 00 00 00 00 0F 00 00 00 00 00   #2: B0020200 F8FFFFFF  
  B0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   #3: 0C100000 FFFFF000  
  C0 CF 10 9A 10 00 00 00 00 00 00 00 00 00 00 00 00   #4: 0C1FF000 FFFFF000  
  D0 00 00 00 00 00 00 00 00 00 00 00 00 01 00 19 FE   #5: 00000000 FFFFF000  
  E0 00 C0 C0 24 00 00 00 00 00 00 00 00 00 00 00 00                          
  F0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ROM: 00000000          
                                                                              
  Type: PCI        Bus: 00  Device: 0F  Function: 00                          
  Type value to modify.                                                       

  __ Device __     CardBus Bridge


  30 00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F   Refresh    : ON
  00 80 11 76 04 07 00 10 02 80 00 07 06 00 40 82 00
  10 00 10 00 0C DC 00 00 02 00 03 03 B0 00 F0 FF FF   Rev ID        : 80
  20 00 00 00 00 00 F0 FF FF 00 00 00 00 FC FF FF FF   Int Line (IRQ): 0A
  30 00 00 00 00 FC FF 00 00 00 00 00 00 0A 02 80 04   Int Pin       : 02
  40 CF 10 9A 10 01 00 00 00 00 00 00 00 00 00 00 00   Latency Timer : 40
  50 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   Sub.Vendor ID : FFFC
  60 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   Subsystem ID  : FFFF
  70 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  80 00 00 82 08 00 03 00 00 63 04 63 04 00 00 00 30   #0: 0C001000 FFFFF000
  90 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   #1: 020000DC 020000DC
  A0 00 00 00 00 00 00 00 00 00 00 0F 00 00 00 00 00   #2: B0030300 F8FFFFFF
  B0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   #3: FFFFF000 FFFFF000
  C0 CF 10 9A 10 00 00 00 00 00 00 00 00 00 00 00 00   #4: 00000000 FFFFF000
  D0 00 00 00 00 00 00 00 00 00 00 00 00 01 00 19 FE   #5: FFFFF000 FFFFF000
  E0 00 40 C0 24 00 00 00 00 00 00 00 00 00 00 00 00
  F0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ROM: 00000000

  Type: PCI        Bus: 00  Device: 0F  Function: 01

Perhaps the pcmcia-cs people can identify the registers that would affect 
card-initiated DMA transfer into the comm page..?

-Mercury



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
