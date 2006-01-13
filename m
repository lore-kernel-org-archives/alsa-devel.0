From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001517]: No sound on hda-intel on Acer TravelMate 4061NLMi
Date: Fri, 13 Jan 2006 01:11:04 +0100
Message-ID: <7c78e15a2628666cb64b18111693c66e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A412613A
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2006 01:11:04 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The issue 0001618 has been set as DUPLICATE OF the following issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1517> 
======================================================================
Reported By:                er-ku
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1517
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu Breezy
Kernel Version:             2.6.12-9-686
======================================================================
Date Submitted:             10-31-2005 00:19 CET
Last Modified:              01-13-2006 01:11 CET
======================================================================
Summary:                    No sound on hda-intel on Acer TravelMate 4061NLMi
Description: 
This will be very much like other reports around.

Just bought a new laptop and installed Ubuntu Linux on it, and updated it.
Sound modules load silently, no complainments, alsamixer works and
channels are unmuted, but I get absolutely no sound from speakers of
headphones.

I'm not the only one having this issue
(http://ubuntuforums.org/showthread.php?p=450628), however, all the info I
managed to google either didn't help me, or was simply unfinished (like
forum questions that aren't answered).

I tried the stock drivers provided by the Ubuntu kernel, then I tried
1.0.10rc2, and cvs builds i made myself (created them as .debs though). In
all cases the result was the same - absolute silence.

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001618 No Sound on Acer with Intel ICH6 HDA an...
======================================================================

----------------------------------------------------------------------
 rlrevell - 12-19-05 02:28 
----------------------------------------------------------------------
Please test the latest ALSA release (1.0.11-rc1), this should be fixed.

----------------------------------------------------------------------
 OnO - 12-24-05 03:28 
----------------------------------------------------------------------
Acer 4061NLMi
Linux acer 2.6.14-kanotix-6

No sound on both headphones and speakers while driver seems to be working
fine, all programs working wihtout any complainment.

I'm attaching the AADEBUG dump using latest CVS from NOW (2005.12.23
0:00)

ALSA Audio Debug v0.1.0 - Sat Dec 24 03:20:33 EST 2005
http://alsa.opensrc.org/index.php?page=aadebug
http://www.gnu.org/licenses/gpl.txt

Kernel ----------------------------------------------------
Linux acer 2.6.14-kanotix-6 #1 PREEMPT Thu Dec 15 17:42:57 CET 2005 i686
GNU/Linux

Loaded Modules --------------------------------------------
snd_hda_intel          13712  0 
snd_hda_codec          82944  1 snd_hda_intel
snd_pcm_oss            47392  0 
snd_mixer_oss          15744  1 snd_pcm_oss
snd_pcm                77064  3 snd_hda_intel,snd_hda_codec,snd_pcm_oss
snd_timer              20868  1 snd_pcm
snd                    46564  6
snd_hda_intel,snd_hda_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
snd_page_alloc          8072  2 snd_hda_intel,snd_pcm

Proc Config -----------------------------------------------
CONFIG_SOUND=m
# CONFIG_SND is not set
CONFIG_SOUND_PRIME=m
CONFIG_SOUND_BT878=m
CONFIG_SOUND_CMPCI=m
CONFIG_SOUND_CMPCI_FM=y
CONFIG_SOUND_CMPCI_MIDI=y
CONFIG_SOUND_CMPCI_JOYSTICK=y
CONFIG_SOUND_EMU10K1=m
CONFIG_SOUND_FUSION=m
CONFIG_SOUND_CS4281=m
CONFIG_SOUND_ES1370=m
CONFIG_SOUND_ES1371=m
CONFIG_SOUND_ESSSOLO1=m
CONFIG_SOUND_MAESTRO=m
CONFIG_SOUND_MAESTRO3=m
CONFIG_SOUND_ICH=m
CONFIG_SOUND_SONICVIBES=m
CONFIG_SOUND_TRIDENT=m
CONFIG_SOUND_MSNDCLAS=m
CONFIG_SOUND_MSNDPIN=m
CONFIG_SOUND_VIA82CXXX=m
CONFIG_SOUND_OSS=m
# CONFIG_SOUND_TRACEINIT is not set
# CONFIG_SOUND_DMAP is not set
CONFIG_SOUND_AD1816=m
CONFIG_SOUND_AD1889=m
CONFIG_SOUND_SGALAXY=m
CONFIG_SOUND_ADLIB=m
CONFIG_SOUND_ACI_MIXER=m
CONFIG_SOUND_CS4232=m
CONFIG_SOUND_SSCAPE=m
CONFIG_SOUND_GUS=m
CONFIG_SOUND_GUS16=y
CONFIG_SOUND_GUSMAX=y
CONFIG_SOUND_VMIDI=m
CONFIG_SOUND_TRIX=m
CONFIG_SOUND_MSS=m
CONFIG_SOUND_MPU401=m
CONFIG_SOUND_NM256=m
CONFIG_SOUND_MAD16=m
CONFIG_SOUND_PAS=m
CONFIG_SOUND_PSS=m
CONFIG_SOUND_SB=m
CONFIG_SOUND_AWE32_SYNTH=m
CONFIG_SOUND_WAVEFRONT=m
CONFIG_SOUND_MAUI=m
CONFIG_SOUND_YM3812=m
CONFIG_SOUND_OPL3SA1=m
CONFIG_SOUND_OPL3SA2=m
CONFIG_SOUND_YMFPCI=m
CONFIG_SOUND_YMFPCI_LEGACY=y
CONFIG_SOUND_UART6850=m
CONFIG_SOUND_AEDSP16=m
CONFIG_SOUND_TVMIXER=m
CONFIG_SOUND_KAHLUA=m
CONFIG_SOUND_ALI5455=m
CONFIG_SOUND_FORTE=m
CONFIG_SOUND_RME96XX=m
CONFIG_SOUND_AD1980=m

Modprobe Conf ---------------------------------------------
alias char-major-116	snd
### update-modules: start processing /etc/modutils/linux-sound-base_noOSS
alias sound off
alias dmasound_core off
alias dmasound_pmac off
alias soundcard off
### update-modules: end processing /etc/modutils/linux-sound-base_noOSS

Proc Asound -----------------------------------------------
Advanced Linux Sound Architecture Driver Version 1.0.10.
Compiled on Dec 16 2005 for kernel 2.6.14-kanotix-6.
0 [Intel          ]: HDA-Intel - HDA Intel
                     HDA Intel at 0xd000c000 irq 10
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  0: [0- 0]: ctl
 33:       : timer
00-00: ALC260 Analog : ALC260 Analog : playback 1 : capture 1

Dev Snd ---------------------------------------------------
controlC0  pcmC0D0c  pcmC0D0p  timer

CPU -------------------------------------------------------
model name	: Intel(R) Pentium(R) M processor 1.60GHz
cpu MHz		: 800.047

RAM -------------------------------------------------------
MemTotal:       505376 kB
SwapTotal:      634556 kB

Hardware --------------------------------------------------
0000:00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML
Express Processor to DRAM Controller (rev 03)

0000:00:1b.0 Audio device: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) High Definition Audio Controller (rev 04)
	Subsystem: Acer Incorporated [ALI]: Unknown device 008f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d000c000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] #10 [0091]

Please fix it ASAP. I believe it is related to this specific model
connections routing. Thank you for your support.

----------------------------------------------------------------------
 OnO - 12-24-05 03:32 
----------------------------------------------------------------------
Just forget to mention that even AADEBUG reports that ALSA is compiled on
16th Dec actually modules are compiled from latest CVS HEAD. So it is
rather not fixed in 1.0.11-rc1 for this laptop model.

js@acer:~$ ls -al /lib/modules/2.6.14-kanotix-6/kernel/sound/pci/hda/
total 169
drwxr-xr-x  2 root root    112 Dec 24 02:57 .
drwxr-xr-x 23 root root   1264 Dec 24 02:57 ..
-rw-r--r--  1 root root 148312 Dec 24 02:57 snd-hda-codec.ko
-rw-r--r--  1 root root  18557 Dec 24 02:57 snd-hda-intel.ko
js@acer:~$

Do we need another model for ALC260 routing hardcoded in sources ?
Regards.

----------------------------------------------------------------------
 er-ku - 12-26-05 17:07 
----------------------------------------------------------------------
I forgot to mention one thing that might be important. That's a part of
"dmidecode" output:
Handle 0x000D
        DMI type 10, 6 bytes.
        On Board Device Information
                Type: Sound
                Status: Disabled
                Description: ADI

Notice: the Status says "Disabled". And the problem is that there are no
relevant configuration entries in BIOS... However, snd-hda-intel doesn't
complain about missing devices. 

Could this be the root cause of sound problems?



----------------------------------------------------------------------
 morigane - 01-06-06 17:22 
----------------------------------------------------------------------
I've exactly the same problem on an Acer Aspire 1641 (laptop) with sound
card Intel (chipset Realtek ALC260). I'm on a Mandriva 2006. I've made a
bugtrack to Mandriva, who gave me the latest developer versions kernels
(2.6.12-15 (containing an hda patch) and 2.6.15), with no result. I've
tried the Realtek drivers for linux (which had totally damaged the audio
config and obliged me to reinstall the system), and the alsa drivers
1.0.10 and 1.0.11rc2. I've still no sound. The dmidecode give me the same
result : Status Disabled.
Morigane

----------------------------------------------------------------------
 er-ku - 01-06-06 18:38 
----------------------------------------------------------------------
interestingly though, one user has a dual boot system. For him, sound works
well in Windows, and doesn't work in Linux, with the same status in
dmidecode - disabled. Seems like it's not BIOS, but rather the driver that
has to turn the device on...

----------------------------------------------------------------------
 rlrevell - 01-06-06 19:39 
----------------------------------------------------------------------
AFAIK all features of the Realtek driver were merged into the ALSA driver
recently so there should be no difference.

If Realtek's own driver does not work maybe you can report the problem to
them.

----------------------------------------------------------------------
 er-ku - 01-06-06 19:46 
----------------------------------------------------------------------
strange. One user of a laptop of the same model as mine said he had the
sound in Linux. I haven't heard anything more detailed from him though....

----------------------------------------------------------------------
 morigane - 01-06-06 19:56 
----------------------------------------------------------------------
I've turned on Windows only one time before installing linux on my laptop
and I had system sound a te boot of the system, so the sound worked under
windows. I think too that it's a problem of activation of the card by the
driver. I will write to Realtek to expose them the problem.

----------------------------------------------------------------------
 eudoxos - 01-06-06 20:04 
----------------------------------------------------------------------
Sorry to add more to the scream that it does not work. Same here, Acer
TravelMate 4061. Under windows fine. Same dmi output. ICH6 chipset, kernel
2.6.15-notfinal (that is, -10 ubuntu) and packed alsa drivers.

----------------------------------------------------------------------
 OnO - 01-07-06 17:19 
----------------------------------------------------------------------
What are You think about?
device 10ec:0260 is listed by DXDiag but not by lspci ?
device 8086:2668 is listed by both.

[DXDiag]
-------------
Sound Devices
-------------
            Description: Realtek HD Audio output
            Hardware ID:
HDAUDIO\FUNC_01&VEN_10EC&DEV_0260&SUBSYS_1025160D&REV_1004
        Manufacturer ID: 1
             Product ID: 100
                   Type: WDM
            Driver Name: RtkHDAud.sys
         Driver Version: 5.10.0000.5148 (English)
      Driver Attributes: Final Retail
...
        Driver Provider: Realtek Semiconductor Corp.
         HW Accel Level: Full
              Cap Flags: 0xF5F
    Min/Max Sample Rate: 100, 192000
Static/Strm HW Mix Bufs: 33, 32
 Static/Strm HW 3D Bufs: 33, 32
              HW Memory: 0
       Voice Management: No
 EAX(tm) 2.0 Listen/Src: Yes, Yes
   I3DL2(tm) Listen/Src: Yes, Yes
Sensaura(tm) ZoomFX(tm): No
               Registry: OK
-------------
     Name: Microsoft UAA Bus Driver for High Definition Audio
Device ID: PCI\VEN_8086&DEV_2668&SUBSYS_008F1025&REV_04\3&B1BFB68&0&D8
   Driver: F:\WINDOWS\system32\DRIVERS\hdaudbus.sys, 5.10.0001.5013
(English), 1/7/2005 17:07:18, 138752 bytes
-------------


[lspci]
-------------
0000:00:00.0 0600: 8086:2590 (rev 03)
0000:00:02.0 0300: 8086:2592 (rev 03)
0000:00:02.1 0380: 8086:2792 (rev 03)
0000:00:1b.0 0403: 8086:2668 (rev 04)
0000:00:1c.0 0604: 8086:2660 (rev 04)
0000:00:1c.1 0604: 8086:2662 (rev 04)
0000:00:1c.2 0604: 8086:2664 (rev 04)
0000:00:1d.0 0c03: 8086:2658 (rev 04)
0000:00:1d.1 0c03: 8086:2659 (rev 04)
0000:00:1d.2 0c03: 8086:265a (rev 04)
0000:00:1d.3 0c03: 8086:265b (rev 04)
0000:00:1d.7 0c03: 8086:265c (rev 04)
0000:00:1e.0 0604: 8086:2448 (rev d4)
0000:00:1f.0 0601: 8086:2641 (rev 04)
0000:00:1f.1 0101: 8086:266f (rev 04)
0000:00:1f.3 0c05: 8086:266a (rev 04)
0000:06:01.0 0607: 104c:ac56
0000:06:04.0 0280: 8086:4220 (rev 05)
0000:06:08.0 0200: 10ec:8139 (rev 10)
-------------

----------------------------------------------------------------------
 er-ku - 01-12-06 13:45 
----------------------------------------------------------------------
Is issue 1618 a dupe of this?

----------------------------------------------------------------------
 OnO - 01-13-06 01:07 
----------------------------------------------------------------------
yes, it is.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-31-05 00:19 er-ku          New Issue                                    
10-31-05 00:19 er-ku          Distribution              => Ubuntu Breezy   
10-31-05 00:19 er-ku          Kernel Version            => 2.6.12-9-686    
10-31-05 00:21 er-ku          Issue Monitored: er-ku                       
12-19-05 02:28 rlrevell       Note Added: 0007083                          
12-24-05 03:28 OnO            Note Added: 0007139                          
12-24-05 03:32 OnO            Note Added: 0007140                          
12-26-05 17:06 er-ku          Note Added: 0007160                          
12-26-05 17:07 er-ku          Note Edited: 0007160                         
01-04-06 14:59 eudoxos        Issue Monitored: eudoxos                     
01-06-06 17:22 morigane       Note Added: 0007489                          
01-06-06 18:38 er-ku          Note Added: 0007492                          
01-06-06 19:39 rlrevell       Note Added: 0007495                          
01-06-06 19:46 er-ku          Note Added: 0007496                          
01-06-06 19:56 morigane       Note Added: 0007497                          
01-06-06 20:04 eudoxos        Note Added: 0007498                          
01-07-06 17:19 OnO            Note Added: 0007517                          
01-12-06 13:45 er-ku          Note Added: 0007585                          
01-13-06 01:07 OnO            Note Added: 0007610                          
01-13-06 01:11 rlrevell       Relationship added       has duplicate 0001618
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
