From: Rafal Dejewski <lardel@interia.pl>
Subject: Re: Ali5451 on HP VT6200 notebook not working
Date: Fri, 29 Nov 2002 11:19:40 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200211291119.41218.lardel@interia.pl>
References: <200211211230.00392.lardel@interia.pl> <200211291053.15510.lardel@interia.pl> <s5h4ra0znul.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4ra0znul.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Friday 29 November 2002 11:12, you wrote:
> At Fri, 29 Nov 2002 10:53:15 +0100,
>
> ah, perhaps your chip has some different pci id?
> please check lspci -n whether a device 10b9:7101 exists.
>
I think this is it! I should have noticed! 
Here is mine lspci -vvn for this device:
00:04.0 Class 0401: 10b9:5451 (rev 02)
        Subsystem: 103c:0027
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR+ <PERR+
        Latency: 64 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 7
        Region 0: I/O ports at 1000 [size=256]
        Region 1: Memory at e0001000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

and just to confirm that it's really it:
00:04.0 Multimedia audio controller: Acer Laboratories Inc. [ALi] M5451 PCI 
AC-Link Controller Audio Device (rev 02)
        Subsystem: Hewlett-Packard Company: Unknown device 0027

Can't wait to try your patch :)

Rafal

----------------------------------------------------------------------
Powiedz sobie dobre "Dzien dobry"!http://link.interia.pl/f168b




-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
