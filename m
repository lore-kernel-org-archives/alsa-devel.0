From: Nigel Gilbert <norb@dscape.freeserve.co.uk>
Subject: Hard lock up when using ALSA midi in
Date: Wed, 03 May 2006 11:33:27 +0100
Message-ID: <1146652407.7497.4.camel@maltbury3.norbnet.org>
Mime-Version: 1.0
Content-Type: text/plain
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

  I've been trying to use Rosegarden or Museseq to compose some music
and have discovered that, when software connects to the MIDI IN on my
sound card, the machine locks up totally (a reboot is required).

  I've done the following tests:
  - Installed vkeybd (virtual midi keyboard) and fluidsynth (virtual
synth). 

  - Initially, aconnect shows the following as input and output MIDI
ports:

    nige@sully ~ $ aconnect -i -o 
    client 0: 'System' [type=kernel] 
        0 'Timer           ' 
        1 'Announce        ' 
    client 14: 'Midi Through' [type=kernel] 
        0 'Midi Through Port-0' 
    client 16: 'MPU-401 MIDI 0-0' [type=kernel] 
        0 'MPU-401 MIDI 0-0'

  - After starting vkeybd and fluidsynth:
    nige@sully ~ $ aconnect -i -o 
    client 0: 'System' [type=kernel] 
        0 'Timer           ' 
        1 'Announce        ' 
    client 14: 'Midi Through' [type=kernel] 

        0 'Midi Through Port-0' 
    client 16: 'MPU-401 MIDI 0-0' [type=kernel] 
        0 'MPU-401 MIDI 0-0' 
    client 128: 'Virtual Keyboard' [type=user] 
        0 'Virtual Keyboard' 
    client 129: 'FLUID Synth (7495)' [type=user] 
        0 'Synth input port (7495:0)' 

  - Hooking together the keyboard and fluidsynth works (after loading a
soundfont into fluidsynth). Playing notes on the virtual keyboard makes
audio from the sound card: 
    nige@sully ~ $ aconnect 128:0 129:0

  - Disconnect fluidsynth and vkeybd and connect vkeybd to the MIDI port
(with a hardware synth attached). Playing notes on the virtual keyboard
makes noises from the external synth: 
    nige@sully ~ $ aconnect -d 128:0 129:0 
    nige@sully ~ $ aconnect 128:0 16:0 

  - Trying to connect the MIDI port (with external keyboard attached) to
fluidsynth causes the system lock up: 
    nige@sully ~ $ aconnect 16:0 129:0

  An even simpler way to get the system to lock up is to use aseqdump,
this can be done straight after boot up without having to start X or
anything: 
    nige@sully ~ $ aseqdump -p 16:0

  I presume that the system locking up means it's a kernel thing (in
either a module or the main kernel).
  Oddly, it has worked in the past. Though possibly using OSS only
rather than ALSA (it was a while ago).

  I have a C-Media 8378 card and am using cmipci as my sound card in the
kernel (2.6.16).
    lspci | grep audio
    00:0b.0 Multimedia audio controller: C-Media Electronics Inc CM8738
(rev 10)

  My kernel config:

    Device Drivers
      Sound
        <*> Sound card support
          Advanced Linux Sound Architecture
            <M> Advanced Linux Sound Architecture
            <M>   Sequencer support
            <M>     Sequencer dummy client
            <M>   OSS Mixer API
            <M>   OSS PCM (digital audio) API
            [ ]   OSS Sequencer API
            [ ]   Support old ALSA API
            Generic devices
              <M> Generic MPU-401 UART driver
            PCI devices
              <M> C-Media 8738, 8338
          Open Sound System
            < > Open Sound System (DEPRECATED)

  Any insight into this problem or help getting it working again would
be greatly appreciated. I've definitely hit the limit of my
understanding of how MIDI should work under ALSA!

Thanks in advance, 
  -Nige

-- 
Nigel Gilbert <norb@dscape.freeserve.co.uk>




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
