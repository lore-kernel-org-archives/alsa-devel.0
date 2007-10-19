From: Jan-Simon =?iso-8859-1?q?M=F6ller?= <dl9pf@gmx.de>
Subject: Re:
	=?iso-8859-1?q?hda-intel=3A_no_soundcard_with_curren?=
	=?iso-8859-1?q?t_linus=27_git=09tree?=
Date: Fri, 19 Oct 2007 12:46:34 +0200
Message-ID: <200710191246.34401.dl9pf@gmx.de>
References: <471538C2.80806@m3y3r.de> <200710181819.25496.dl9pf@gmx.de>
	<s5hir53elsd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id A4962243B7
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Oct 2007 12:46:27 +0200 (CEST)
In-Reply-To: <s5hir53elsd.wl%tiwai@suse.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Am Freitag 19 Oktober 2007 07:05:54 schrieb Takashi Iwai:
>
> Try model=3Dfujitsu or model=3Dlaptop.  This will activate the
> auto-muting.

model=3Dlaptop worked, model=3Dfujitsu did not.

> If it works, let me know the PCI SSID (from the output of lspci -vv).

I did already, here's the copy:

00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio =

Controller (rev 03)
        Subsystem: Fujitsu Siemens Computer GmbH Unknown device 110e
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =

Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =

<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 22
        Region 0: Memory at fc400000 (64-bit, non-prefetchable) [size=3D16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D55mA =

PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ =

Queue=3D0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] Express Unknown type IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTa=
g-
                Device: Latency L0s <64ns, L1 <1us
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                Link: Supported Speed unknown, Width x0, ASPM unknown, Port=
 0
                Link: Latency L0s <64ns, L1 <1us
                Link: ASPM Disabled CommClk- ExtSynch-
                Link: Speed unknown, Width x0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)



Model name is FSC Esprimo Mobile Edition9 V5505 T7300, details here:
http://www.notebookzentrale.de/eshop.php?action=3Darticle_detail&s_supplier=
_aid=3D1366417&position=3D9&anzahl_treffer=3D9


Thanks again, great work! I patched my 10.3 default kernel and it works =

also :D . Linux is great - have phun !

Best regards
Jan-Simon M=F6ller
