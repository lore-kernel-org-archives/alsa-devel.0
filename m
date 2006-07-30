From: "V. Ananda Krishnan" <mansarov@us.ibm.com>
Subject: recording of voice with ALSA driver version 1.0.11-2 -
	problem
Date: Sun, 30 Jul 2006 11:41:43 -0500
Message-ID: <44CCE147.1060400@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi All,

   I am using a Micronas UAC-3556B USB headphone with microphone 
attached to the headset.  I am using IBM ThinkCenter with Intel Pentium 
Processor (3.0GHz)running RHEL4.0-U2 Linux kernel (2.6.9-22.EL). I am 
able to replay audio CDs using the ALSA driver.  However,I am not able 
to record voice and replay the recorded audio.

   I did post the problem to ALSA-User list and got a good response from 
Lee R. and others.  However, the recording of voice/audio is not yet 
possible.  So I am posting my problem in the ALSA-DEVL list. The info on 
the configuration is given below. Any help to solve the recording 
problem is appreciated.  Thanks All

ALSA driver packages info:
   alsa-lib-1.0.11-2
   alsa-utils-1.0.11-2.RHEL4
   alsa-lib-debuginfo-1.0.11-2
   alsa-lib-devel-1.0.11-2
   alsa-utils-debuginfo-1.0.11-2.RHEL4

execution of cmd: aplay -l
   **** List of PLAYBACK Hardware Devices ****
   card 0: ICH5 [Intel ICH5], device 0: Intel ICH [Intel ICH5]
     Subdevices: 1/1
     Subdevice #0: subdevice #0
   card 0: ICH5 [Intel ICH5], device 4: Intel ICH - IEC958 [Intel ICH5 - 
IEC958]
     Subdevices: 1/1
     Subdevice #0: subdevice #0
   card 1: UAC3556B [UAC3556B], device 0: USB Audio [USB Audio]
     Subdevices: 1/1
     Subdevice #0: subdevice #0

playing sound by executing aplay -D hw:1,0 
/usr/share/sounds/shutdown*.wave  works fine. (better than version 1.0.6-5)

executed the command: alsaunmute 1

executed the command and used "F4" to adjust the capture of mic and 
raised  mic channel using "alsamixer -c 1"

However the recording still doesn't work with the command:
  arecord -d 20 -D hw:1,0 -f dat /tmp/foobar.wav
and the dump is below:
  Simple mixer control 'Bass',0
    Capabilities: volume volume-joined
    Playback channels: Mono
    Capture channels: Mono
    Limits: 0 - 48
    Mono: 45 [94%]
  Simple mixer control 'Bass Boost',0
    Capabilities: pswitch pswitch-joined
    Playback channels: Mono
    Mono: Playback [on]
  Simple mixer control 'Treble',0
    Capabilities: volume volume-joined
    Playback channels: Mono
    Capture channels: Mono
    Limits: 0 - 48
    Mono: 24 [50%]
  Simple mixer control 'PCM',0
    Capabilities: pvolume cvolume pswitch pswitch-joined cswitch 
cswitch-joined
    Playback channels: Front Left - Front Right
    Capture channels: Mono
    Limits: Playback 0 - 704 Capture 0 - 15
    Mono: Capture 7 [47%] [off]
    Front Left: Playback 500 [71%] [on]
    Front Right: Playback 500 [71%] [on]
  Simple mixer control 'PCM Capture Source',0
    Capabilities: enum
    Items: 'PCM' 'Mic' 'Input 2'
    Item0: 'Mic'
  Simple mixer control 'PCM',1
    Capabilities: cvolume
    Capture channels: Mono
    Limits: Capture 0 - 656
    Mono: Capture 299 [46%]
  Simple mixer control 'Mic',0
    Capabilities: cvolume
    Capture channels: Mono
    Limits: Capture 0 - 15
    Mono: Capture 10 [67%]
  Simple mixer control 'Auto Gain Control',0
    Capabilities: pswitch pswitch-joined
    Playback channels: Mono
    Mono: Playback [on]

Please let me know if I have anything set in the wrong way.  Let me also 
know if we have to login a defect at ALSA-project site.  Hope I have 
switched on the capture this time.  "space bar" doesn't work and so is 
the case with "m" to unmute the channel.  Also with 1.0.11 version, 
"F2", "F3", "F4" and "F5" function keys WORK.


Regards,
V.A.Krishnan

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
