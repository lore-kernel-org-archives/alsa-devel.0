From: Stephen Glow <sag@ollies.net>
Subject: Ensoniq 1371 datasheet
Date: Tue, 27 Aug 2002 21:58:11 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D6C2E33.6090900@ollies.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from ollie.embeddedintelligence.com (sglow.ne.client2.attbi.com [24.91.81.130])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id DAA28539
	for <alsa-devel@alsa-project.org>; Wed, 28 Aug 2002 03:50:14 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  I've been unable to generate any sound from the built-in sound card on 
my system (reported as Sound Blaster AudioPCI 128 by Windows). The 
0.9.0rc3 ens1371 drivers install without complaint, and the mixer seems 
to be happy setting the levels, but no sound.

I'd be happy to try to debug this problem myself, but I can't seem to 
find any technical documentation on the Ensoniq 1371 chip on the 'net. 
Can someone point me at the datasheet for this chip.

The lspci -vv output for this card is:

00:0e.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 08)
	Subsystem: Micron Tazer
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32 (3000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at c800 [size=64]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-





-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
