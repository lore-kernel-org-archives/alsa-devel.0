From: Raymond <rayau@netvigator.com>
Subject: Re: au88x0_synth
Date: Thu, 28 Apr 2005 18:21:45 +0800
Message-ID: <4270B939.8050405@netvigator.com>
References: <423CCDAC.80401@netvigator.com> <200503301013.30400.alien999999999@users.sourceforge.net> <4269C953.4050504@netvigator.com> <200504230928.06494.alien999999999@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200504230928.06494.alien999999999@users.sourceforge.net>
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
List-Id: alsa-devel@alsa-project.org

Alien wrote:
>
> 
> 
>>Would you provide the result of "lspci -vvvn" to find out the content of
>>PCI BAR0 of your au8810 card ?
> 
> 
> ok:
> 
> []# lspci -vvvn

> 00:00.0 Class 0600: 1106:3188 (rev 01)
> 	Subsystem: 1043:80a3
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping-
> SERR- FastB2B-
> 	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort-
> <MAbort+ >SERR- <PERR-
> 	Latency: 8
> 	Region 0: Memory at 00000000e0000000 (32-bit, prefetchable) [size=256M]
> 	Capabilities: [80] AGP version 3.5
> 		Status: RQ=32 Iso- ArqSz=0 Cal=2 SBA+ ITACoh- GART64- HTrans- 
64bit- FW+
> AGP3+ Rate=x8
> 		Command: RQ=1 ArqSz=0 Cal=2 SBA+ AGP+ GART64- 64bit- FW- Rate=x8
> 	Capabilities: [c0] #08 [0060]
> 	Capabilities: [68] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 	Capabilities: [58] #08 [8001]

> 
> 00:0f.0 Class 0104: 1106:3149 (rev 80)
> 	Subsystem: 1043:80ed
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
> SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
> <MAbort- >SERR- <PERR-
> 	Latency: 64
> 	Interrupt: pin B routed to IRQ 10
> 	Region 0: I/O ports at e400 [size=8]
> 	Region 1: I/O ports at e000 [size=4]
> 	Region 2: I/O ports at d800 [size=8]
> 	Region 3: I/O ports at d400 [size=4]
> 	Region 4: I/O ports at d000 [size=16]
> 	Region 5: I/O ports at c800 [size=256]
> 	Capabilities: [c0] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:0f.1 Class 0101: 1106:0571 (rev 06) (prog-if 8a [Master SecP PriP])
> 	Subsystem: 1043:80ed
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
> SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
> <MAbort- >SERR- <PERR-
> 	Latency: 32
> 	Interrupt: pin A routed to IRQ 11
> 	Region 4: I/O ports at fc00 [size=16]
> 	Capabilities: [c0] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 

> 
> 00:10.4 Class 0c03: 1106:3104 (rev 86) (prog-if 20)
> 	Subsystem: 1043:80ed
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- 
> SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
> <MAbort- >SERR- <PERR-
> 	Latency: 64, cache line size 40
> 	Interrupt: pin C routed to IRQ 3
> 	Region 0: Memory at 00000000fdf00000 (32-bit, non-prefetchable) [size=256]
> 	Capabilities: [80] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:11.0 Class 0601: 1106:3227
> 	Subsystem: 1043:80ed
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ 
> SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
> <MAbort- >SERR- <PERR-
> 	Latency: 0
> 	Capabilities: [c0] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 
> 
>>>BUT: sometimes not only that happens, but also when i try to kill the
>>>apps it will not kill. when that happens, all kill, killall, top, ps
>>>aux commands hang at the command line and cannot be killed by CTRL-C
>>>or otherwise, i have been able to see that when i stopped my display
>>>managener I did an lsmod and it gave something like this:
>>>


http://lists.nongnu.org/archive/html/openvortex-dev/2003-08/msg00014.html

May be your problem is related to the well-known conflict between
Vortex cards and VIA chipsets ?

You better post your problem on the openvortex-dev mailing list and
remember to mention that you are using VIA chipset.

















-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
