From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: problems with Maestro3 / NEC LM800J/7
Date: 28 Mar 2003 16:29:07 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1048897747.2386.64.camel@cmn37.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: rsegnini@ccrma.Stanford.EDU
List-Id: alsa-devel@alsa-project.org

Hi gurus... I'm having problems getting sound out of this laptop:
  NEC LM800J/7
I'm using 2.4.20-pre6 + current alsa cvs (post 0.9.2)... After
installing everything is fine, drivers load perfectly, I unmute all
controls, raise all volumes and aplay seems happy playing a soundfile,
except I get no sound (from the speakers or the headphone connection). I
tried tweaking all controls in gamix with no success...

Here is the lspci -v -v for the audio controller:

00:04.0 Multimedia audio controller: ESS Technology ES1988 Allegro-1 (rev 12)
	Subsystem: NEC Corporation: Unknown device 80f1
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 1400 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Any suggestions? There must be _one_ pin that is not being turned on :-)
Anything I could post that would enable debugging this?
Thanks!
-- Fernando




-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
