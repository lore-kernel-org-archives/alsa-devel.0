From: didi@tau.ac.il (Yedidyah Bar-David)
Subject: via82xx on CLE266
Date: Wed, 13 Apr 2005 21:57:11 +0300
Message-ID: <20050413185711.GA4587@nova.cs.tau.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from cs.tau.ac.il (nova.cs.tau.ac.il [132.67.192.133])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2A1CF24C
	for <alsa-devel@alsa-project.org>; Wed, 13 Apr 2005 20:57:13 +0200 (MEST)
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

Hi all,

I recently bought a Matsonic MSCLE266-f board, based on VIA CLE266.
When insmoding, I got a message asking to report if dxs_support
works. So I do. If that's not the right address, sorry.

lspci:
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 50)

lspci -nvv:
-----------------------------------------------------------------------
0000:00:11.5 0401: 1106:3059 (rev 50)
        Subsystem: 1019:a101
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 5
        Region 0: I/O ports at e000 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
-----------------------------------------------------------------------

dxs_support=4 does work. That is, it allows to record/play in freqs
other than 48k.

I might add that it took me quite a lot of time to figure out that
the driver works (with or without dxs_support), mainly because the
mixer settings were very unintuitive (at least for me) - to hear
sound, I had to turn off "IEC958 Capture Monitor". The "master"
does not affect anything I could see. Maybe the real master is
confused to be "IEC958 Capture Monitor"?

Anyway, now sound seems to work pretty well on this board. Thanks
a lot for your efforts.

I am not subcribed to the list, so CC me if you want (e.g. to make
some more tests).
-- 
Didi



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
