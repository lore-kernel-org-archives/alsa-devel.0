From: Luca Capello <luca@pca.it>
Subject: Re: Fw: [Alsa-devel] drivers in alsa-driver tree with 2.6 kernels
Date: Sat, 20 Mar 2004 11:11:40 +0100
Message-ID: <405C18DC.7080504@pca.it>
References: <20040311180122.30343d89@sashak.lan>	<405638E0.5030209@pca.it> <s5hvfl5f501.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010202030506010906060609"
Return-path: <discuss-return-13477-lindows=m.gmane.org@linmodems.org>
In-Reply-To: <s5hvfl5f501.wl@alsa2.suse.de>
To: "linmodems.org" <discuss@linmodems.org>
Cc: ML ALSA-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010202030506010906060609
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

on 03/16/04 11:41, Takashi Iwai wrote:
> thanks everyone who reported about intel8x0m driver.
> it's already in the alsa-kernel tree and Linus' 2.6.5-rc1.
>
> please give a try.
I tried 'intel8x0m' in the latest 2.6.5-rc1 on my new ASUS M6842NWH (M6800N) and
I got 'NO DIALTONE' in wvdial:
=====
gismo:/usr/src/kernel/modem/slmodem-2.9.6/modem# modprobe snd-intel8x0m
gismo:/usr/src/kernel/modem/slmodem-2.9.6/modem# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: I82801DBICH4 [Intel 82801DB-ICH4], device 0: Intel ICH [Intel 82801DB-ICH4]
  Subdevices: 0/1
  Subdevice #0: subdevice #0
card 0: I82801DBICH4 [Intel 82801DB-ICH4], device 4: Intel ICH - IEC958 [Intel
82801DB-ICH4 - IEC958]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
**** List of PLAYBACK Hardware Devices ****
card 1: Modem [Intel 82801DB-ICH4 Modem], device 0: Intel ICH - Modem [Intel
82801DB-ICH4 Modem - Modem]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

gismo:/usr/src/kernel/modem/slmodem-2.9.6/modem# SmartLink Soft Modem: version
2.9.6 Mar 20 2004 09:59:09
modem `hw:1' created. TTY is `/dev/pts/19'
symbolic link `/dev/ttySL0' -> `/dev/pts/19' created.
Use `/dev/ttySL0' as modem device, Ctrl+C for termination.

gismo:/usr/src/kernel/modem/slmodem-2.9.6/modem# wvdialconf /etc/wvdial.conf
Scanning your serial ports for a modem.

Port Scan<*1>: S0
ttyS1<*1>: ATQ0 V1 E1 -- failed with 2400 baud, next try: 9600 baud
ttyS1<*1>: ATQ0 V1 E1 -- failed with 9600 baud, next try: 115200 baud
ttyS1<*1>: ATQ0 V1 E1 -- and failed too at 115200, giving up.
Port Scan<*1>: S2   S3   S4   S5   S6   S7
ttySL0<*1>: ATQ0 V1 E1 -- OK
ttySL0<*1>: ATQ0 V1 E1 Z -- OK
ttySL0<*1>: ATQ0 V1 E1 S0=0 -- OK
ttySL0<*1>: ATQ0 V1 E1 S0=0 &C1 -- OK
ttySL0<*1>: ATQ0 V1 E1 S0=0 &C1 &D2 -- OK
ttySL0<*1>: ATQ0 V1 E1 S0=0 &C1 &D2 +FCLASS=0 -- OK
ttySL0<*1>: Modem Identifier: ATI -- 56000
ttySL0<*1>: Speed 4800: AT -- OK
ttySL0<*1>: Speed 9600: AT -- OK
ttySL0<*1>: Speed 19200: AT -- OK
ttySL0<*1>: Speed 38400: AT -- OK
ttySL0<*1>: Speed 57600: AT -- OK
ttySL0<*1>: Speed 115200: AT -- OK
ttySL0<*1>: Speed 230400: AT -- OK
ttySL0<*1>: Speed 460800: AT -- OK
ttySL0<*1>: Max speed is 460800; that should be safe.
ttySL0<*1>: ATQ0 V1 E1 S0=0 &C1 &D2 +FCLASS=0 -- OK

Found a modem on /dev/ttySL0.
Modem configuration written to /etc/wvdial.conf.
ttySL0<Info>: Speed 460800; init "ATQ0 V1 E1 S0=0 &C1 &D2 +FCLASS=0"

gismo:/usr/src/kernel/modem/slmodem-2.9.6/modem# wvdial
- --> WvDial: Internet dialer version 1.54.0
- --> Initializing modem.
- --> Sending: ATZ
ATZ
OK
- --> Sending: ATQ0 V1 E1 S0=0 &C1 &D2 +FCLASS=0
ATQ0 V1 E1 S0=0 &C1 &D2 +FCLASS=0
OK
- --> Modem initialized.
- --> Sending: ATDT0840555555
- --> Waiting for carrier.
ATDT0840555555
NO DIALTONE
- --> No dial tone.
- --> Disconnecting at Sat Mar 20 10:01:21 2004
=====

Just to be sure (this is the first time I get 'NO DIALTONE' in my tests), I
tried the /normal/ 'slamr' driver and it's the same. So I tried 'slamr' (with no
success) as suggested here:
	http://linmodems.technion.ac.il/post-install.html
=====
gismo:~# wvdial
- --> WvDial: Internet dialer version 1.54.0
- --> Initializing modem.
- --> Sending: ATZ
ATZ
OK
- --> Sending: ATQ0 V1 E1 S0=0 &C1 &D2 +FCLASS=0 ATH1
ATQ0 V1 E1 S0=0 &C1 &D2 +FCLASS=0 ATH1
- --> Sending: ATQ0
NO CARRIER
- --> Re-Sending: ATQ0 V1 E1 S0=0 &C1 &D2 +FCLASS=0 ATH1
ATQ0 V1 E1 S0=0 &C1 &D2 +FCLASS=0 ATH1
- --> Modem not responding.

gismo:~# wvdial
- --> WvDial: Internet dialer version 1.54.0
- --> Initializing modem.
- --> Sending: ATZ
ATZ
OK
- --> Sending: ATQ0 V1 E1 S0=0 &C1 &D2 +FCLASS=0 AT+CGI=59
ATQ0 V1 E1 S0=0 &C1 &D2 +FCLASS=0 AT+CGI=59
- --> Sending: ATQ0
NO CARRIER
- --> Re-Sending: ATQ0 V1 E1 S0=0 &C1 &D2 +FCLASS=0 AT+CGI=59
ATQ0 V1 E1 S0=0 &C1 &D2 +FCLASS=0 AT+CGI=59
- --> Modem not responding.

gismo:~# wvdial
- --> WvDial: Internet dialer version 1.54.0
- --> Initializing modem.
- --> Sending: ATZ
ATZ
OK
- --> Sending: ATQ0 V1 E1 S0=0 &C1 &D2 +FCLASS=0 AT+CGI=A6
ATQ0 V1 E1 S0=0 &C1 &D2 +FCLASS=0 AT+CGI=A6
- --> Sending: ATQ0
NO CARRIER
- --> Re-Sending: ATQ0 V1 E1 S0=0 &C1 &D2 +FCLASS=0 AT+CGI=A6
ATQ0 V1 E1 S0=0 &C1 &D2 +FCLASS=0 AT+CGI=A6
- --> Modem not responding.
=====

On XP Home, the modem works :-( Here the diagnostic informations:
=====
ATQ0V1E0 - OK
AT+GMM - +GMM: AC97 SoftV92 Data Fax Modem with SmartCP
AT+FCLASS=? - 0,1
AT#CLS=? - Comando non supportato
AT+GCI? - +GCI: B5
AT+GCI=? - +GCI:
(00,01,02,03,04,05,06,07,09,0A,0B,0C,0D,0E,0F,10,11,12,13,14,15,16,19,1A,1B,1C,1D,1E,1F,20,21,22,23,24,25,26,27,28,29,2A,2B,2C,2D,2E,2F,30,31,32,33,34,35,36,37,38,39,3A,3B,3C,3D,3E,40,41,42,43,44,45,46,47,48,49,4B,4C,4D,4E,4F,50,51,52,53,54,55,56,57,58,59,5A,5B,5C,5E,5F,60,61,62,63,64,65,66,67,68,69,6A,6B,6C,6D,6E,6F,70,71,72,73,74,75,76,77,78,79,7A,7B,7C,7D,7E,7F,80,81,82,83,84,85,86,87,88,89,8A,8B,8C,8D,8E,8F,90,92,93,94,96,97,98,99,9A,9B,9C,9D,9E,9F,A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,AA,AB,AC,AD,AE,AF,B0,B1,B2,B3,B4,B5,B6,B7,B8,B9,BA,BB,BC,BD,BE,BF,C1,C2,C3,C4,C5,C7,C8,C9,CA,CB,CC,CD,CE,CF,D0,D1,D2,D3,D4,D5,D6,D7,D8,D9,DA,DB,DC,DD,DE,DF,E0,E1,E2,E3,E4,E5,E6,E7,E8,EB,EC,ED,EE,EF,F0,F1,F2,F3,F4,F5,F7,F8,F9,FA,FB,FC,FE)
ATI1 - 255
ATI2 - OK
ATI3 - SoftK56V_B2.1_V7.03.00
ATI4 - AC97 SoftV92 Data Fax Modem with SmartCP
ATI5 - 181
ATI6 - SoftK56
       CModem Version 12
       Rksample Version 342
ATI7 - 255
=====

My modem:
=====
00:1f.6 Modem: Intel Corp. 82801DB AC'97 Modem Controller (rev 03) (prog-if 00
[Generic])
        Subsystem: Asustek Computer, Inc.: Unknown device 1826
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 4
        Region 0: I/O ports at e400 [size=256]
        Region 1: I/O ports at e080 [size=128]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
=====

I started 'scanModem', attached 'ModemData.txt'.

Thx, bye,
Gismo / Luca

PS to the ALSA-devel mailing-list: I'll stop to post until I could connect to
the net with my modem, as IMHO this is not a specific problem of the
'snd-intel8x0m' driver (as with the 'slamr' one is the same). Please let me know
if I should continue double posting...
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAXBjbVAp7Xm10JmkRAtH5AKCPf5rijc2/IKup2/br4hvE73tPIwCeLtdv
KF20mOWdJpIv5DgLgbIg3qs=
=c6zi
-----END PGP SIGNATURE-----

--------------010202030506010906060609
Content-Type: application/x-gzip;
 name="ASUS-M6842NWH_ModemData_20040320.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="ASUS-M6842NWH_ModemData_20040320.txt.gz"

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
p4vJ6OPs0/nFrKqVZ3X7H4u7QSurIQAA
--------------010202030506010906060609--
