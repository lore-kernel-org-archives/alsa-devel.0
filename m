From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Prodigy 7.1 ?
Date: Sat, 18 Oct 2003 02:07:12 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F909240.8040505@superbug.demon.co.uk>
References: <3FF3EBB8.6020503@aei.ca>	<1066221700.7989.63.camel@caernarfon>	<s5hzng2irjx.wl@alsa2.suse.de>	<200310151535.00442.mark@egghead.free-online.co.uk> <s5hvfqqin6b.wl@alsa2.suse.de> <3F8F8EEB.4000303@aei.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F8F8EEB.4000303@aei.ca>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Apostolos Dimitromanolakis <apostolos@aei.ca>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Does this card have something to do with EGOSYS ?

Apostolos Dimitromanolakis wrote:
> 
> Takashi Iwai wrote:
> 
>>> The Prodigy 7.1 is identically the same card as the Aureon Space 
>>> 7.1....just different firmware and digital coaxial instead of toslink.
>>>   
>>
>>
>> then you can fake the subvendor id (VT1724_SUBDEVICE_AUREON71_SPACE)
>> defined in aureon.h by replacing it with your card's id, which is
>> shown in the EEPROM output in /proc/asound/card0/ice1724.
>>
>> we might need to tune up eeprom entries to match with the actual
>> hardware, but in theory it should be ok as it is.
>>  
>>
> 
> Unfortunately I tried that and it doesn't work. A patch was needed since 
> the reported eeprom size was 120 and no provision was made for that. I 
> was able to get an eeprom dump and it doesn't look quite as the data for 
> the aureon eeprom:
> 
> EEPROM dump: 45 53 49 33 78 78 78 78 45 47 4f 53 59 53 ff ff ff ff ff ff 

in ASCII: ESI3xxxxEGOSYS   (Do EGOSYS make the card?)

> 
> Module loads and report ICE1724 at ALSA but no sound at all. The 
> following errors appear:
> 
> PCI: Found IRQ 11 for device 00:0a.0
> invalid EEPROM version 120
> AC'97 0:0 does not respond - RESET
> ice1712: cannot initialize pro ac97, skipped
> 
> and here is the lspci data (after module loaded):
> 
> 00:0a.0 Multimedia audio controller: IC Ensemble Inc ICE1724 [Envy24HT] 
> (rev 01)
>        Subsystem: Unknown device 4933:4553
>        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Stepping- SERR- FastB2B-
>        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>        Latency: 32
>        Interrupt: pin A routed to IRQ 11
>        Region 0: I/O ports at a000 [size=32]
>        Region 1: I/O ports at 9800 [size=128]
>        Capabilities: [80] Power Management version 1
>                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA 
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 00: 12 14 24 17 05 00 10 02 01 00 01 04 00 20 00 00
> 10: 01 a0 00 00 01 98 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 33 49 53 45
ASCII: 3ISE ( The exact reverse of ESI3 in the EEPROM.)




-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
