From: "Axel Braun" <Axel.Braun@gmx.de>
Subject: No sound on ASRock-board with AC97 controller
Date: Thu, 27 Jan 2005 10:56:14 +0100 (MET)
Message-ID: <16945.1106819774@www50.gmx.net>
References: <7701.1106654063@www7.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-user@lists.sourceforge.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

One more on my question below:

It seems that the chipset is a C-Media cmaudio cmi9761:

http://www.cmedia.com.tw/download/OS_e-cmi9761_index.htm

Is there any option I can set to get alsa closer to that chipset?
The documentation on the via82xxx seems not to be up to date, as there are
some option offered by SuSE, which are not documented
here:
http://www.alsa-project.org/alsa-doc/doc-php/template.php?company=VIA&card=.&chip=VIA82C686%2C+VIA8233%2C+VIA8233A%2C+VIA8235&module=via82xx#opt

Thanks
Axel

-----
Hi,
I have a new PC with an ASRock K7VT4A+ Mainboard, it claims to have an
AC97controller on board:

0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
        Subsystem: ASRock Incorporation: Unknown device 9761
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 3
        Region 0: I/O ports at e000
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


lsmod | grep snd
snd_pcm_oss            57896  0
snd_mixer_oss          19200  1 snd_pcm_oss
snd_via82xx            26276  1
snd_ac97_codec         69728  1 snd_via82xx
snd_pcm                96776  3 snd_pcm_oss,snd_via82xx,snd_ac97_codec
snd_timer              24708  1 snd_pcm
snd_mpu401_uart         7552  1 snd_via82xx
snd_rawmidi            24356  1 snd_mpu401_uart
snd_seq_device          8716  1 snd_rawmidi
snd                    60164

11
snd_pcm_oss,snd_mixer_oss,snd_via82xx,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device
snd_page_alloc         10248  2 snd_via82xx,snd_pcm
gameport                4608  1 snd_via82xx
soundcore               9056  1 snd

I've installed SuSE 9.2 and Alsa 1.0.8, alsaconf works fine, alsamixer has
volume on nearly full power, but no sound is available.

Can somebody give me a hint what to do?
Thanks
Axel

PS: Under knoppix 3.7 sound works, but it is not using alsa,,,,,


-- 
Sparen beginnt mit GMX DSL: http://www.gmx.net/de/go/dsl


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
