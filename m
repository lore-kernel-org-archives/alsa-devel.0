From: "D. Sen" <dsen@homemail.com>
Subject: intel8x0: changing characteristics after an APM suspend-resume cycle
Date: Tue, 07 Jan 2003 15:40:10 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E1B3B2A.4070204@homemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
To: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I am using the snd-intel8x0 drivers (0.9.0rc6) on my IBM Thinkpad 
running Linux 2.4.20. Everything seems to run fine until the machine 
goes through a suspend/resume cycle when mono files/streams seem to get 
played back at a much faster rate.

A cold reboot resolves the problem.

Any ideas on how I can solve this?

Thanks,
DS

lspci --vv output for the Audio Chipset:

00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio 
(rev 02)
	Subsystem: IBM: Unknown device 0508
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 11
	Region 0: I/O ports at 1c00 [size=256]
	Region 1: I/O ports at 18c0 [size=64]



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
