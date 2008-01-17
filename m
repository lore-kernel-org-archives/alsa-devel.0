From: forwind <forward@forwind.net>
Subject: problems with Intel Corporation 82801H (ICH8 Family)
	HD Audio	Controller (rev 03)
Date: Thu, 17 Jan 2008 23:30:37 +0000
Message-ID: <1200612637.5741.29.camel@localhost>
Reply-To: forward@forwind.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from harwood.textdrive.com (harwood.textdrive.com [207.7.108.201])
	by alsa0.perex.cz (Postfix) with ESMTP id EDDEE24736
	for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2008 00:30:44 +0100 (CET)
Received: from [192.168.1.101] (i-83-67-85-6.freedom2surf.net [83.67.85.6])
	by harwood.textdrive.com (Postfix) with ESMTP id 050B234279
	for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2008 23:30:38 +0000 (GMT)
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

Hi folks,

I am having difficulty getting a friends on-board speakers working on
her laptop. After some reading of forums I'm not sure whether there is a
solution for this or not ?

The setup and details can be read below. The headphones work fine but
the speakers are mute even though nothing is muted. I installed from
source alsa version 1.0.15rc3 but to no avail.


ALSA Audio Debug v0.1.0 - Thu Jan 17 23:21:23 GMT 2008
http://alsa.opensrc.org/aadebug
http://www.gnu.org/licenses/gpl.txt

Kernel ----------------------------------------------------
Linux laura-laptop 2.6.22-14-rt #1 SMP PREEMPT RT Tue Dec 18 10:01:34
UTC
2007 i686 GNU/Linux

Loaded Modules --------------------------------------------
snd_rtctimer            4384  1
snd_hda_intel         291616  1
snd_pcm_oss            43264  0
snd_mixer_oss          17664  1 snd_pcm_oss
snd_pcm                80132  2 snd_hda_intel,snd_pcm_oss
snd_page_alloc         11400  2 snd_hda_intel,snd_pcm
snd_hwdep              10500  1 snd_hda_intel
snd_seq_dummy           4740  0
snd_seq_oss            33792  0
snd_seq_midi            9600  0
snd_rawmidi            25728  1 snd_seq_midi
snd_seq_midi_event      8576  2 snd_seq_oss,snd_seq_midi
snd_seq                54128  7
snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq_midi_event
snd_timer              24324  3 snd_rtctimer,snd_pcm,snd_seq
snd_seq_device          9228  5
snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_rawmidi,snd_seq
snd                    55428  13
snd_hda_intel,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_hwdep,snd_seq_oss,snd_rawmidi,snd_seq,snd_timer,snd_seq_device

Modprobe Conf ---------------------------------------------
Warning: module config file does not exist
This means any kernel modules will not be auto loaded
See your linux distro docs on how to create this file

Proc Asound -----------------------------------------------
Advanced Linux Sound Architecture Driver Version 1.0.15rc3.
 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xfc200000 irq 22
  2:        : timer
  3:        : sequencer
  4: [ 0- 2]: digital audio capture
  5: [ 0- 1]: digital audio playback
  6: [ 0- 0]: digital audio playback
  7: [ 0- 0]: digital audio capture
  8: [ 0- 1]: hardware dependent
  9: [ 0- 0]: hardware dependent
 10: [ 0]   : control
00-01: HDA Codec 1
00-00: HDA Codec 0
00-02: ALC883 Analog : ALC883 Analog : capture 2
00-01: ALC883 Digital : ALC883 Digital : playback 1
00-00: ALC883 Analog : ALC883 Analog : playback 1 : capture 2
Client info
  cur  clients : 4
  peak clients : 4
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
Client 128 : "TiMidity" [User]
  Port   0 : "TiMidity port 0" (-We-)
  Port   1 : "TiMidity port 1" (-We-)
  Port   2 : "TiMidity port 2" (-We-)
  Port   3 : "TiMidity port 3" (-We-)
  Output pool :
    Pool size          : 500
    Cells in use       : 0
    Peak cells in use  : 0
    Alloc success      : 0
    Alloc failures     : 0
  Input pool :
    Pool size          : 1000
    Cells in use       : 0
    Peak cells in use  : 0
    Alloc success      : 0
    Alloc failures     : 0

Dev Snd ---------------------------------------------------
controlC0  hwC0D0  hwC0D1  pcmC0D0c  pcmC0D0p  pcmC0D1p  pcmC0D2c  seq 
timer

CPU -------------------------------------------------------
model name      : Intel(R) Core(TM)2 Duo CPU     T7300  @ 2.00GHz
cpu MHz         : 2001.000
model name      : Intel(R) Core(TM)2 Duo CPU     T7300  @ 2.00GHz
cpu MHz         : 2001.000

RAM -------------------------------------------------------
MemTotal:      1028132 kB
SwapTotal:     3028212 kB

Hardware --------------------------------------------------
00:00.0 Host bridge: Intel Corporation Mobile PM965/GM965/GL960 Memory
Controller Hub (rev 03)

does this sound familiar or is everybody blue in the face from hearing
about this 'bug' :)?

Best regards,
Conor
