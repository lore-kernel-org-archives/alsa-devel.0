From: uaca@alumni.uv.es
Subject: intel8x0: no sound in 2.6.11 rc3 & 4 (fine with 2.6.10)]
Date: Sat, 19 Feb 2005 22:23:23 +0100
Message-ID: <20050219212323.GA26882@pusa.informat.uv.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from postin.uv.es (postin.uv.es [147.156.1.90])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 41683223
	for <alsa-devel@alsa-project.org>; Sat, 19 Feb 2005 22:23:28 +0100 (MET)
Received: from sello.uv.es (sello.ci.uv.es [147.156.1.112])
	by postin.uv.es (8.12.11/8.12.11) with ESMTP id j1JLNQ3I020242
	for <alsa-devel@alsa-project.org>; Sat, 19 Feb 2005 22:23:26 +0100
Received: from pusa.informat.uv.es (pusa.informat.uv.es [147.156.10.98])
	by sello.uv.es (8.12.2/8.12.2) with ESMTP id j1JLNNY4021237
	for <alsa-devel@alsa-project.org>; Sat, 19 Feb 2005 22:23:24 +0100
Received: from ulisses by pusa.informat.uv.es with local (Exim 3.36 #1 (Debian))
	id 1D2c4R-00071Q-00
	for <alsa-devel@alsa-project.org>; Sat, 19 Feb 2005 22:23:23 +0100
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hello

I forgot to send the following report to alsa-devel. I already sent it
to lkml.

Thanks

	Ulisses
	
On Sat, 2005-02-19 at 13:11 +0100, uaca@alumni.uv.es wrote:
> Hello
> 
> I have read a post in lkml.org that states that the problem experienced in
> rc3 has gone (1). That is not the case for me.
> 
> My audio device is
> 
> 0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
>         Subsystem: IBM: Unknown device 0554
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin B routed to IRQ 11
>         Region 0: I/O ports at 1c00 [size=256]
>         Region 1: I/O ports at 18c0 [size=64]
>         Region 2: Memory at d0100c00 (32-bit, non-prefetchable) [size=512]
>         Region 3: Memory at d0100800 (32-bit, non-prefetchable) [size=256]
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> In 2.6.10 and in 2.6.11-rc3 & 4 the clock is set to 48khz.
> 
> eg:
> 
> intel8x0_measure_ac97_clock: measured 49502 usecs
> intel8x0: clocking to 48000
> 
> It uses an Analog Devices AD1981B
> 
> I have put a tar file of the /proc/asound directory of 2.6.10 and 2.6.11-rc4 in
> 
> 	http://pusa.uv.es/~ulisses/asound-intel8x0/
> 
> the tar files were done while playing pcm audio, (not being eard in rc4).
> 
> I have found that I had to Mute __both__ "Headphone Jack Sense" and
> "Line Jack Sense" in order to ear the audio in rc4.
> 
> Please let me know if you need further info or you want a tester
> 
> All this is on a IBM Thinkpad R51 - Type 2887 -AVG
> 
> (tot toc: IBM, we're buying your laptops too)
> 
> Thanks in advance
> 
> 	Ulisses			
> 
> (1) http://lkml.org/lkml/2005/2/18/93											


                Debian GNU/Linux: a dream come true
-----------------------------------------------------------------------------
"Computers are useless. They can only give answers."            Pablo Picasso

"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
