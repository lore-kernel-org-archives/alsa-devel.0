From: John covici <covici@ccs.covici.com>
Subject: Re: rc2 stereo problem with via8233
Date: Thu, 27 Jun 2002 10:14:41 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <15643.7633.177373.448813@ccs.covici.com>
References: <m31yav1b40.fsf@ccs.covici.com>
	<s5hk7om563k.wl@alsa2.suse.de>
	<15642.10186.820516.331246@ccs.covici.com>
	<s5h66046gnp.wl@alsa2.suse.de>
Reply-To: covici@ccs.covici.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h66046gnp.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

OK, here is -xvv for that controller.

00:11.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 30)
	Subsystem: VIA Technologies, Inc.: Unknown device 4511
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 11
	Region 0: I/O ports at ec00 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 59 30 01 00 10 02 30 00 01 04 00 00 00 00
10: 01 ec 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 11 45
30: 00 00 00 00 c0 00 00 00 00 00 00 00 0b 03 00 00

and here is the -nvv
00:11.5 Class 0401: 1106:3059 (rev 30)
	Subsystem: 1106:4511
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 11
	Region 0: I/O ports at ec00 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

When I was using it, a stereo sample did play on both channels, from
the cd, from pcm, they were mono -- I didn't test with stereo for the
pcm.  Is this sound card a multi channel and if so, how do I use more
than one channel?



on Thursday 06/27/2002 Takashi Iwai(tiwai@suse.de) wrote
 > Hi,
 > 
 > At Wed, 26 Jun 2002 16:44:58 -0400,
 > John covici wrote:
 > > 
 > > Here is what I get from the lspci -- I don't think that the via8233
 > > is multi-channel at all and I didn't see any controls to utilize such
 > > a thing in my asound.state file.
 > 
 > in fact via8233 has capability to output up to 6 channels (and spdif),
 > although most of motherboards have only two output channels.
 > 
 > the difference is only the implementation of the driver, so no change
 > will appear on /etc/asound.state.
 > the channels are configured dynamically according to the requested
 > channels of pcm.
 > 
 > 
 > > 00:11.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio
 > > Controller (rev 30)
 > > 
 > > I can send you the verbose version if that would help.
 > > 
 > 
 > yes, could you get more detailed info with -xvv and -nvv options?
 > 
 > and, please recheck under which condition this happens,
 > whether with the stereo samples or with the mono samples, or
 > whatever.
 > 
 > i can revert the codes only for certain chip models.
 > since via8233 has _only_ multi-channel playback mode, it must use
 > this.  but other chip models have another mode, which was used by the
 > old driver.  this can be enabled conditionally by checking the chip
 > revision number.
 > 
 > 
 > Takashi

-- 
         John Covici
         covici@ccs.covici.com


-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
