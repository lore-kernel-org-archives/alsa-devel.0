From: =?ISO-8859-1?Q?Erik_Inge_Bols=F8?= <knan@mo.himolde.no>
Subject: CMIPCI @ Asus A7M266-D bug...
Date: Tue, 26 Feb 2002 17:55:36 +0100 (CET)
Message-ID: <Pine.LNX.4.44.0202261735340.20105-100000@yme.mo.himolde.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
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

Greets.

On my new PC, there's a cmipci chip built-in to the mainboard. It's noisy,
but that's as expected.

But there's a weird issue with it. I can play 16bit stereo 44.1khz sound
just fine. 22 khz, though, is inaudible. In fact, everything but 44khz
stereo 16bit gives me either white noise or inaudibility.

Facts about the board: The sound part has three jacks... which can be
configured as 6-channel output, or output/mic/line_in. No SPDIF, no
joystick/midi port, no FM part.

Board: Asus A7M266-D

ALSA version: 0.9.0beta11

Hope this gives someone an idea what to look for? More info available on
request, just ask...

root@monster:/home/knan# lspci -n -s 02:04
02:04.0 Class 0401: 13f6:0111 (rev 10)

root@monster:/home/knan# lspci -vvvx -s 02:04.0
02:04.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
        Subsystem: Asustek Computer, Inc.: Unknown device 8077
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at c800 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: f6 13 11 01 85 00 10 02 10 00 01 04 00 20 00 00
10: 01 c8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 77 80
30: 00 00 00 00 c0 00 00 00 00 00 00 00 0a 01 02 18

knan@monster:~$ cat /proc/asound/cmi/cmipci
C-Media PCI CMI8738-MC6 (model 55) at 0xc800, irq 10

00: 02 00 00 00
04: c4 28 00 00
08: 0f 00 09 00
0c: 00 00 00 0a
10: c0 00 00 00
14: 00 60 c0 00
18: 00 00 c9 04
1c: 00 00 fe ff
20: 10 40 00 00
24: a3 30 00 06
28: ff ff ff ff
2c: ff ff ff ff
30: 00 00 00 00
34: 00 00 00 00
38: 00 00 00 00
3c: 00 00 00 00

When playing silently at 22khz:
knan@monster:~$ cat /proc/asound/cmi/pcm0p/sub0/hw_params
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 22050 (22050/1)
period_size: 2048
buffer_size: 16384
tick_time: 10000
OSS format: S16_LE
OSS channels: 2
OSS rate: 22050
OSS period bytes: 8192
OSS periods: 8

knan@monster:~$ cat /proc/asound/cmi/pcm0p/sub0/sw_params
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 2048
xfer_align: 1
start_threshold: 1
stop_threshold: 16384
silence_threshold: 0
silence_size: 0
boundary: 1073741824

knan@monster:~$ cat /proc/asound/cmi/cmipci
C-Media PCI CMI8738-MC6 (model 55) at 0xc800, irq 10

00: 02 00 01 00
04: c4 28 00 00
08: 0f 00 09 00
0c: 00 00 01 0a
10: c0 00 00 00
14: 00 60 c0 00
18: 00 00 c9 04
1c: 00 00 fe ff
20: 10 40 00 00
24: a3 30 00 06
28: ff ff ff ff
2c: ff ff ff ff
30: 00 00 00 00
34: 00 00 00 00
38: 00 00 00 00
3c: 00 00 00 00


When playing just fine at 44kHz:
knan@monster:~$ cat /proc/asound/cmi/cmipci
C-Media PCI CMI8738-MC6 (model 55) at 0xc800, irq 10

00: 02 00 01 00
04: c4 2d 00 00
08: 0f 00 09 00
0c: 00 00 01 0a
10: c0 00 00 00
14: 00 60 c0 00
18: 00 00 c9 04
1c: 00 00 fe ff
20: 10 40 00 00
24: a3 30 00 06
28: ff ff ff ff
2c: ff ff ff ff
30: 00 00 00 00
34: 00 00 00 00
38: 00 00 00 00
3c: 00 00 00 00


--
Erik I. Bolsø | email: <knan at mo.himolde.no>
The UNIX philosophy basically involves giving you enough rope to
hang yourself.  And then a couple of feet more, just to be sure.



_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
