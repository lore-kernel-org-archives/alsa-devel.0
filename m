From: Justin Mattock <justinmattock@gmail.com>
Subject: no sound with imac kernel=2.6.29
Date: Mon, 6 Apr 2009 23:00:17 -0700
Message-ID: <dd18b0c30904062300o27b4bcd4n4fd28f31fb5cec3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f132.google.com (mail-qy0-f132.google.com
	[209.85.221.132])
	by alsa0.perex.cz (Postfix) with ESMTP id 8671324179
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Apr 2009 08:00:18 +0200 (CEST)
Received: by qyk38 with SMTP id 38so4406656qyk.16
	for <alsa-devel@alsa-project.org>; Mon, 06 Apr 2009 23:00:17 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Is there a patch that I can test out for the latest imac.
At the moment I have no sound in either external/internal
speakers.

I've applied the imac91.patch submitted a few days ago(everything compiled
fine)but didn't realize it for a different card(or so I think)
below is lspci  -vvv
I can attach dmesg and supply info if need be.

00:08.0 Audio device: nVidia Corporation MCP79 High Definition Audio (rev b1)
        Subsystem: nVidia Corporation Device cb79
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0 (500ns min, 1250ns max)
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at d3480000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: HDA Intel
        Kernel modules: snd-hda-intel



-- 
Justin P. Mattock
