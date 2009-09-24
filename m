From: Halim Sahin <halim.sahin@freenet.de>
Subject: hda-intel: low volume with nvidia mcp7a hdmi
Date: Thu, 24 Sep 2009 19:01:12 +0000 (UTC)
Message-ID: <20090924190111.GA7812@halim>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id F15F42437C
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Sep 2009 21:01:37 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.50) id 1MqtZR-0004eX-Md
	for alsa-devel@alsa-project.org; Thu, 24 Sep 2009 21:01:37 +0200
Received: from pd9e3e78b.dip.t-dialin.net ([217.227.231.139])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2009 21:01:37 +0200
Received: from halim.sahin by pd9e3e78b.dip.t-dialin.net with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2009 21:01:37 +0200
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,
The volume of the mentioned card is really too low.
used kernel: 2.6.31-rc6 from opensuse factory.
lspci reports:
00:08.0 Audio device: nVidia Corporation MCP79 High Definition Audio
(rev b1)
        Subsystem: nVidia Corporation Device cb84
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Ste
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort-
        Latency: 0 (500ns min, 1250ns max)
        Interrupt: pin A routed to IRQ 21
        Region 0: Memory at fad78000 (32-bit, non-prefetchable)
[size=16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3ho
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: HDA Intel

Output from /proc/asound/cards:
 0 [NVidia         ]: HDA-Intel - HDA NVidia
                      HDA NVidia at 0xfad78000 irq 21

I didn't give any cmdline params to snd-ihda-intel.
Any ideas how to get more power out of this card?
regards
halim
