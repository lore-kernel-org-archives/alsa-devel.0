From: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Subject: Re: ALSA 1.0.5
Date: Sun, 30 May 2004 18:29:26 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200405301829.27071.plcl@telefonica.net>
References: <E1BU51D-0005C3-Cx@sc8-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E1BU51D-0005C3-Cx@sc8-sf-list2.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Saturday 29 May 2004 16:40, Jaroslav Kysela wrote:
> Changes:
>
> * alsa-driver
[...]
>   - via82xx
>     - added dxs_support and ac97_quirk entries for Amira notebook
>     - added DXS whitelist for (eMachines) m680x
>     - added the DXS entry for ECS K7VTA3 v8.0
>     - fixed the DXS entry for ASUS A7V8X to NO_VRA
>     - added the DXS entry for Mitac/Vobis/Yakumo laptop

My Gigabyte motherboard's integrated sound interface used to work with this 
driver, but it doesn't with 1.0.5

Any program (amixer info, alsactl restore, alsamixer ...) trying to use the 
control interface hardly hangs, and it is impossible to kill it at all.  
Modprobe/rmmod works, and doesn't report any problem. No error or debug 
messages at syslog.

I would like to help to debug this problem, but if anybody cares, here are 
some details of my hardware environment:

Mobo: Gigabyte 7VT600 with chipset VIA KT600
Sound: Integrated Realtek ALC655 AC97 codec
http://tw.giga-byte.com/MotherBoard/Products/Products_Spec_GA-7VT600.htm

lspci -vv reports:
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235 AC97 
Audio Controller (rev 60)
        Subsystem: Giga-byte Technology GA-7VAX Onboard Audio (Realtek ALC650)
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 22
        Region 0: I/O ports at e400 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

lspci -nv reports:
00:11.5 Class 0401: 1106:3059 (rev 60)
        Subsystem: 1458:a002

Regards,
Pedro



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
