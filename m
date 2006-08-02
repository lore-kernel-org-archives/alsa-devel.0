From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001612]: Ubuntu5.10 not configured for
	Alsa device:surround51?
Date: Wed, 2 Aug 2006 20:15:07 +0200
Message-ID: <5a5e55dfb1906db06b8e7ec24cc97ee1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 452DE189
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Aug 2006 20:15:08 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1612> 
======================================================================
Reported By:                Manolo
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1612
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Ubuntu 5.10 Breezy
Kernel Version:             Linux 2.6.12
======================================================================
Date Submitted:             12-02-2005 17:51 CET
Last Modified:              08-02-2006 20:15 CEST
======================================================================
Summary:                    Ubuntu5.10 not configured for Alsa
device:surround51?
Description: 
Hardware
  Motherboard: Abit Ic7, Audio: Onboard (Intel ICH5) RealTek
    ALC650F 6-Channel AC97 CODEC.
  uP: Pentium4, Hyperthreading, 3Ghz

Software
  Ubuntu 5.10
  Custom compiled kernel from 'linux-source-2.6.12 2.6.12-10.24'
    make menuconfig
      Device Drivers
        Sound
          <M> Sound card support
          Advanced Linux Sound Architecture --->
            <M> Advanced Linux Sound Architecture
            <M>   Sequencer support
            <M>     Sequencer dummy client
            <M>   OSS Mixer API
            <M>   OSS PCM (digital audio) API
            [*]   OSS Sequencer API
            <M>   RTC Timer support
            PCI devices --->
              <M>  All drivers <M> when option available.
          Open Sound System --->
            < > Open Sound System
  Compiled Alsa packages:
    alsa-driver-1.0.10
    alsa-lib-1.0.10
    alsa-utils-1.0.10 # configure --disable-nls: configure fails
otherwise.
    alsa-oss
    alsa-plugins-1.0.10 # configure,pcm/Makefile.in:Modified to compile
without
      jack.
    Note: At boot, if file /var/lib/alsa/asound.state does not exist,
file
      /etc/asound.state is overwritten with default values (No surround
sound!).
      Alsa package is not responsible for this (Ubuntu5.10 or
Kernel2.6.12??).

Sound Applications
  aplay (alsa-utils-1.0.10)
  audacity 1.2.3 #Device /dev/dsp
  xmms 1.2.10 #plugin /usr/lib/xmms/Input/libwav.so (does not accept
    5.1ChannelFile.wav) replaced by older version (Ubuntu 4.10).
  mplayer 4.0.2
  xine v0.99.3

esd daemon running:
  aplay -Dsurround51 File.wav #GnomePanel or gnome-terminal
    5.1ChannelFile.wav, 2ChannelFile.wav: Sound Ok.
    .xsession-errors fills with:
      ALSA lib pcm_dmix.c:819:(snd_pcm_dmix_open) unable to open slave
  aplay -Ddefault File.wav # GnomePanel or gnome-terminal
    2ChannelFile.wav: Sound Ok.
    No output sent to .xsession-errors
  audacity #GnomePanel
    Error Message: There was an error initializing the audio i/o
      layer. You will not be able to play or record audio.
      Error: Host error.
  audacity #gnome-terminal
    Most of the times application starts without error message.
  xmms #OutputPlugin:Alsa;AudioDevice:default.GnomePanel or
gnome-terminal
    Application starts without error message
    No output sent to .xsession-errors
    2ChannelFile.wav: Sound Ok.
  xmms #OutputPlugin:Alsa;AudioDevice:surround51.GnomePanel
    Error Message: Couldn't open audio. Please check that:
      Your soundcard is configured properly
      You have the correct output plugin selected
      No other program is blocking the soundcard.
    After several Play/ErrorMessage:
      5.1ChannelFile.wav, 2ChannelFile.wav: Sound Ok.
      .xsession-errors fills with:
        ALSA lib pcm_dmix.c:819:(snd_pcm_dmix_open) unable to open slave
  xmms #OutputPlugin:Alsa;AudioDevice:surround51.gnome-terminal
    Most of the times application starts without error message.
    5.1ChannelFile.wav, 2ChannelFile.wav: Sound Ok.
    .xsession-errors fills with:
      ALSA lib pcm_dmix.c:819:(snd_pcm_dmix_open) unable to open slave
  mplayer # 'mplayer -v -ao alsa:device=surround51 -channels 6'
    No StdError error messages (-v)
    All kinds of files and DVDs (Multichannel AC3) play Ok.
    .xsession-errors fills with:
      ALSA lib pcm_dmix.c:819:(snd_pcm_dmix_open) unable to open slave
  xine # 'xine --verbose --audio-driver
alsa';SpeakerArrangement:Surround5.1
    Error Message: The audio device is unavailable. Please verify if
another program
      already uses it.
    StdError error messages (--verbose):
      audio_alsa_out: snd_pcm_open() of plug:surround51:0 failed: Device
or
        resource busy
      audio_alsa_out: >>> check if another program already uses PCM <<<
    After several Play/ErrorMessage:
      All kinds of files and DVDs (Multichannel AC3) play Ok.
      .xsession-errors fills with:
        ALSA lib pcm_dmix.c:819:(snd_pcm_dmix_open) unable to open slave
  xine # 'xine --verbose --audio-driver
alsa';SpeakerArrangement:Stereo2.0
    No error Message
    No StdError error messages
    All kinds of files and DVDs play Ok. Multichannel AC3 downshifted to 2
Channels.
    No output sent to .xsession-errors

esd daemon NOT running (killall esd):
  aplay -Dsurround51 File.wav #GnomePanel or gnome-terminal
    5.1ChannelFile.wav, 2ChannelFile.wav: Sound Ok.
    .xsession-errors fills with:
      ALSA lib pcm_dmix.c:819:(snd_pcm_dmix_open) unable to open slave
  aplay -Ddefault File.wav # GnomePanel or gnome-terminal
    2ChannelFile.wav: Sound Ok.
    No output sent to .xsession-errors
  audacity #GnomePanel or gnome-terminal
    Application starts without error message
  xmms #OutputPlugin:Alsa;AudioDevice:default.GnomePanel or
gnome-terminal
    Application starts without error message
    No output sent to .xsession-errors
    2ChannelFile.wav: Sound Ok.
  xmms #OutputPlugin:Alsa;AudioDevice:surround51.GnomePanel or
gnome-terminal
    Application starts without error message
    5.1ChannelFile.wav, 2ChannelFile.wav: Sound Ok.
    .xsession-errors fills with:
      ALSA lib pcm_dmix.c:819:(snd_pcm_dmix_open) unable to open slave
  mplayer # 'mplayer -v -ao alsa:device=surround51 -channels 6'
    No StdError error messages (-v)
    All kinds of files and DVDs (Multichannel AC3) play Ok.
    .xsession-errors fills with:
      ALSA lib pcm_dmix.c:819:(snd_pcm_dmix_open) unable to open slave
  xine # 'xine --verbose --audio-driver
alsa';SpeakerArrangement:Surround5.1
    Error Message: The audio device is unavailable. Please verify if
another program
      already uses it.
    StdError error messages (--verbose):
      audio_alsa_out: snd_pcm_open() of plug:surround51:0 failed: Device
or
        resource busy
      audio_alsa_out: >>> check if another program already uses PCM <<<
    After several Play/ErrorMessage:
      All kinds of files and DVDs (Multichannel AC3) play Ok.
      .xsession-errors fills with:
        ALSA lib pcm_dmix.c:819:(snd_pcm_dmix_open) unable to open slave
  xine # 'xine --verbose --audio-driver
alsa';SpeakerArrangement:Stereo2.0
    No error Message
    No StdError error messages
    All kinds of files and DVDs play Ok. Multichannel AC3 downshifted to 2
Channels.
    No output sent to .xsession-errors

======================================================================

----------------------------------------------------------------------
 Raymond - 07-28-06 05:39 
----------------------------------------------------------------------
The intel8x0 does not support hardware mixing, dmix only support stereo.
This means you can only one instance of surround51.

esd - stop any sound server
audacity - use portaudio=v19 which support alsa
xmms - use alsa output plugin
mplayer - use -ao alsa
xine - use alsa

Do you have the channels swap problem as described in
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1369 ?

----------------------------------------------------------------------
 Manolo - 08-02-06 20:15 
----------------------------------------------------------------------
Thank you Raymond,
It is more than a year since I reported this bug and yours is the first
reply.

With just one instance of surround51 .xsession-errors still fills with:
  ALSA lib pcm_dmix.c:819:(snd_pcm_dmix_open) unable to open slave

All applications are configured as you suggest except for audacity
(portaudiolib is installed in my system but I don't know how to use it
with audacity).

Please have a look to:
https://launchpad.net/distros/ubuntu/+source/alsa-lib/+bug/26483
Another report of the bug with same results as in
bugtrack.alsa-project.org (I.E.: No useful suggestions).

Don't have the channels swap problem.

Kind regards,
Manolo.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-02-05 17:51 Manolo         New Issue                                    
12-02-05 17:51 Manolo         Distribution              => Ubuntu 5.10 Breezy
12-02-05 17:51 Manolo         Kernel Version            => Linux 2.6.12    
12-03-05 13:54 Manolo         Note Added: 0006898                          
07-28-06 05:39 Raymond        Note Added: 0011283                          
08-02-06 20:15 Manolo         Note Added: 0011390                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
