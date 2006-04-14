From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002000]: Sound continually cuts in and out
Date: Fri, 14 Apr 2006 22:07:50 +0200
Message-ID: <a5ab37113f192c76934f179ff8521595@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 41EDB18D
	for <alsa-devel@alsa-project.org>; Fri, 14 Apr 2006 22:07:50 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2000> 
======================================================================
Reported By:                spm
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2000
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               Ubuntu 5.10 Breezy
Kernel Version:             2.6.12-10-386
======================================================================
Date Submitted:             04-04-2006 19:22 CEST
Last Modified:              04-14-2006 22:07 CEST
======================================================================
Summary:                    Sound continually cuts in and out
Description: 
And it makes a pop sound when cutting out.

I thought it was an IRQ conflict, but it is not (I checked with "cat
/proc/interrupts".

This actually started to occur after plugging in a USB mouse. Mouse is no
longer in, but problem persists. I have redone "alsaconf" problem still
persists...pulling my hair out here...
======================================================================

----------------------------------------------------------------------
 spm - 04-14-06 22:06 
----------------------------------------------------------------------
Output for aadebug:

ALSA Audio Debug v0.1.0 - Fri Apr 14 16:05:35 EDT 2006
http://alsa.opensrc.org/index.php?page=aadebug
http://www.gnu.org/licenses/gpl.txt

Kernel ----------------------------------------------------
Linux htpc 2.6.16.060414.4 #1 Fri Apr 14 14:08:11 EDT 2006 i686 GNU/Linux

Loaded Modules --------------------------------------------
snd_seq_dummy           3844  0
snd_seq_oss            29440  0
snd_seq_midi            8352  0
snd_seq_midi_event      6656  2 snd_seq_oss,snd_seq_midi
snd_seq                44752  6
snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq_midi_event
snd_via82xx            24852  1
snd_ac97_codec         82976  1 snd_via82xx
snd_ac97_bus            2304  1 snd_ac97_codec
snd_pcm_oss            46112  0
snd_mixer_oss          16640  1 snd_pcm_oss
snd_pcm                78600  3 snd_via82xx,snd_ac97_codec,snd_pcm_oss
snd_timer              21892  2 snd_seq,snd_pcm
snd_page_alloc         10248  2 snd_via82xx,snd_pcm
snd_mpu401_uart         6912  1 snd_via82xx
snd_rawmidi            22944  2 snd_seq_midi,snd_mpu401_uart
snd_seq_device          8204  5
snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq,snd_rawmidi
snd                    47716  13
snd_seq_oss,snd_seq,snd_via82xx,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device

Modprobe Conf ---------------------------------------------
Warning: module config file does not exist
This means any kernel modules will not be auto loaded
See your linux distro docs on how to create this file

Proc Asound -----------------------------------------------
Advanced Linux Sound Architecture Driver Version 1.0.11rc2 (Wed Jan 04
08:57:20 2006 UTC).
 0 [V8237          ]: VIA8237 - VIA 8237
                      VIA 8237 with VIA1617A at 0xe500, irq 10
  0: [ 0]   : control
  1:        : sequencer
 16: [ 0- 0]: digital audio playback
 17: [ 0- 1]: digital audio playback
 24: [ 0- 0]: digital audio capture
 25: [ 0- 1]: digital audio capture
 33:        : timer
cat: /proc/asound/hwdep: No such file or directory
00-01: VIA 8237 : VIA 8237 : playback 1 : capture 1
00-00: VIA 8237 : VIA 8237 : playback 4 : capture 1
Client info
  cur  clients : 3
  peak clients : 3
  max  clients : 192

Client   0 : "System" [Kernel]
  Port   0 : "Timer" (Rwe-)
  Port   1 : "Announce" (R-e-)
    Connecting To: 15:0
Client  14 : "Midi Through" [Kernel]
  Port   0 : "Midi Through Port-0" (RWe-)
Client  15 : "OSS sequencer" [Kernel]
  Port   0 : "Receiver" (-we-)
    Connected From: 0:1

Dev Snd ---------------------------------------------------
controlC0  pcmC0D0c  pcmC0D0p  pcmC0D1c  pcmC0D1p  seq  timer

CPU -------------------------------------------------------
model name    : Intel(R) Celeron(R) CPU 2.93GHz
cpu MHz       : 2936.165

RAM -------------------------------------------------------
MemTotal:       516424 kB
SwapTotal:      979956 kB

Hardware --------------------------------------------------
0000:00:00.0 Host bridge: VIA Technologies, Inc. P4M266 Host Bridge
0000:00:05.0 Multimedia controller: Philips Semiconductors SAA7130 Video
Broadcast Decoder (rev 01)
0000:00:07.0 Multimedia video controller: Brooktree Corporation Bt878
Video Capture (rev 11)
0000:00:07.1 Multimedia controller: Brooktree Corporation Bt878 Audio
Capture (rev 11)
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)

----------------------------------------------------------------------
 spm - 04-14-06 22:07 
----------------------------------------------------------------------
Just noticed something...

cat: /proc/asound/hwdep: No such file or directory

Is that normal?  

Help please...this is driving me batty...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-04-06 19:22 spm            New Issue                                    
04-04-06 19:22 spm            Distribution              => Ubuntu 5.10 Breezy
04-04-06 19:22 spm            Kernel Version            => 2.6.12-10-386   
04-04-06 19:45 rlrevell       Note Added: 0009114                          
04-14-06 04:22 spm            Note Added: 0009281                          
04-14-06 22:06 spm            Note Added: 0009288                          
04-14-06 22:07 spm            Note Added: 0009289                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
