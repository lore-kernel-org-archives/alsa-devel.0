From: "Yon Mercury" <swirlee@stickist.com>
Subject: Re: Re: Echo driver
Date: Mon, 22 Nov 2004 17:02:56 -0700
Message-ID: <20041123000256.M61049@stickist.com>
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

I ran System Explorer on the Ricoh Bridge (Echo card was plugged in and 
working) and it produced the registers in a table format:

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

Paul Davis mentioned on one of the lists that it's possible to get/set the 
CardBus registers using lspci/setpci. I will have a look.

On Mon, 22 Nov 2004 17:29:23 +0100 (CET), Giuliano Pochini wrote
> I wrote to one of the people that had a similar problems
> some time ago with a RME card. He sent me the attached
> program. It should display the cardbus registers setting
> under windos. We can try to copy it under Linux, maybe
> it works. I also found some infos about the bridge chip.
> It has some custom registers that may need a proper
> setting.
> 
> --
> Giuliano.





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
