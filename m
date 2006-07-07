From: Adrian Bunk <bunk@stusta.de>
Subject: OSS driver removal, 2nd round (v2)
Date: Sat, 8 Jul 2006 01:17:16 +0200
Message-ID: <20060707231716.GE26941__30896.2925490507$1152432925$gmane$org@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6D5E9293
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Jul 2006 10:15:08 +0200 (MEST)
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by gate.perex.cz (Perex's E-mail Delivery System) with SMTP id
	E8205998CB for <alsa-devel@alsa-project.org>;
	Sat,  8 Jul 2006 01:18:15 +0200 (MEST)
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

Now that I've sent the first round of actually removing the code for OSS 
drivers where ALSA drivers without regressions exist for the same 
hardware, it's time for a second round amongst the remaining drivers.


Removing OSS drivers where ALSA drivers for the same hardware exists has 
two reasons:

1. remove obsolete and mostly unmaintained code
2. get bugs in the ALSA drivers reported that weren't previously
   reported due to the possible workaround of using the OSS drivers


The list below divides the OSS drivers into the following three
categories:
1. ALSA drivers for the same hardware
2. ALSA drivers for the same hardware with known problems
3. no ALSA drivers for the same hardware


My proposed timeline is:
- 2.6.18: let the drivers under 1. in the list below depend on
          OSS_OBSOLETE_DRIVER
- 2.6.20: remove the options depending on OSS_OBSOLETE_DRIVER
- 2.6.22: remove the code for the drivers that were depending on
          OSS_OBSOLETE_DRIVER from the kernel tree


To make a long story short:

If you are using an OSS driver because the ALSA driver doesn't work 
equally well on your hardware listed under 1. below, send me an email 
with a bug number in the ALSA bug tracking system now.


A small FAQ:

Q: But OSS is kewl and ALSA sucks!
A: The decision for the OSS->ALSA move was four years ago.
   If ALSA sucks, please help to improve ALSA.

Q: What about the OSS emulation in ALSA?
A: The OSS emulation in ALSA is not affected by my patches
   (and it's not in any way scheduled for removal).


Please review the following list:


1. ALSA drivers for the same hardware

DMASOUND_PMAC
SOUND_ACI_MIXER and RADIO_MIROPCM20
SOUND_AD1816
SOUND_AD1889
SOUND_ADLIB
SOUND_FUSION
SOUND_NM256
SOUND_OPL3SA2

2. ALSA drivers for the same hardware with known problems

SOUND_CS4232
- ALSA #1520 (Soundchip was not detected on HP Omnibook 5700 CTX)

SOUND_EMU10K1
- ALSA #1782 (really poor sound with my SB Live 1024 and ALSA)

SOUND_ES1371
- ALSA #1774 (missing joystick connector support for PCI Ensoniq ES1371)

SOUND_ICH
- ALSA #1764 (Recording signal quality is inacceptable (using OSS API))
- Alan Cox:
  ALSA driver lacks "support for AC97 wired touchscreens and the like"

SOUND_SSCAPE
- ALSA #2234 (driver does not find Soundscape Elite)

SOUND_TRIDENT
- ALSA #1293 (device supported by OSS but not by ALSA)
- maintainer of the OSS driver wants his driver to stay

SOUND_VIA82CXXX
- ALSA #1906 (1-second overruns reported by arecord,
              complete system hang with jackd -d alsa)


3. no ALSA drivers for the same hardware

DMASOUND_ATARI
DMASOUND_PAULA
DMASOUND_Q40
SOUND_AEDSP16
SOUND_AU1550_AC97
SOUND_BCM_CS4297A
SOUND_HAL2
SOUND_KAHLUA
SOUND_MSNDCLAS
SOUND_MSNDPIN
SOUND_MSS (also due to SOUND_PSS, SOUND_TRIX and perhaps SOUND_AEDSP16)
SOUND_PAS
SOUND_PSS
SOUND_SB (also due to SOUND_KAHLUA, SOUND_PAS and perhaps SOUND_AEDSP16)
SOUND_SH_DAC_AUDIO
SOUND_TRIX
SOUND_VIDC
SOUND_VRC5477
SOUND_VWSND
SOUND_WAVEARTIST

SOUND_IT8172
Ralf Baechle: 
Both board based on the ITE 8172 chipset are on my death list already; I
will probably remove it after 2.6.18 is out unless against all expectation
I receive patches.



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
