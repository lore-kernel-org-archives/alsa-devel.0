From: TS Lura <tslura@gmail.com>
Subject: Media players report 96khz, proc reports 44khz
Date: Sun, 3 Apr 2011 23:58:45 +0200
Message-ID: <BANLkTindWcA4WpVf79aDL-43eqWUvMa2XA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E031B1037FC
	for <alsa-devel@alsa-project.org>;
	Sun,  3 Apr 2011 23:58:46 +0200 (CEST)
Received: by pvf33 with SMTP id 33so1303253pvf.38
	for <alsa-devel@alsa-project.org>; Sun, 03 Apr 2011 14:58:46 -0700 (PDT)
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

Hey,

 I am trying to play a 96kHz/24-bit pcm file:


 {{{
 [2309][root@ubuntu:~]# file test.wav
 test.wav: RIFF (little-endian) data, WAVE audio, Microsoft PCM, 32 bit,
 stereo 96000 Hz
 }}}


 Which plays with full 96kHz resolution under aplay. But under any other
 player as VLC, mplayer, totem it plays at 44kHz reported by
 /proc/asound/card1/stream0, even if the player is reporting to be playing
 at 96kHz.

 Others have reported the same problem:

http://www.head-fi.org/forum/thread/243027/how-to-make-m-audio-transit-worn-in-ubuntu

 Some people at mplayer @ irc.freenode.net encouraged me to file a bug
 report on this issue. Hope it is useful.

 Cheers,
 TSLura

I have also filed a ticked with pulseAudio
--
Ticket URL: <http://pulseaudio.org/ticket/930>
PulseAudio <http://pulseaudio.org/>
The PulseAudio Sound Server


 {{{

 [2336][torstefan@ubuntu:/proc/asound/card1]$ aplay -l
 **** List of PLAYBACK Hardware Devices ****
 card 0: Intel [HDA Intel], device 0: STAC92xx Analog [STAC92xx Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
 card 0: Intel [HDA Intel], device 1: STAC92xx Digital [STAC92xx Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
 card 1: USB [Transit USB], device 0: USB Audio [USB Audio]
  Subdevices: 0/1
  Subdevice #0: subdevice #0
 card 1: USB [Transit USB], device 1: USB Audio [USB Audio #1]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
 }}}





 {{{
 [2329][root@ubuntu:~]# aplay -D plughw:1,0 test.wav Playing WAVE
 'test.wav' : Signed 32 bit Little Endian, Rate 96000 Hz, Stereo

 Every 0.5s: cat stream0
 Sun Apr  3 23:29:28 2011

 M-Audio Transit USB at usb-0000:00:1d.7-1.2.3, full speed : USB Audio

 Playback:
  Status: Running
    Interface = 1
    Altset = 1
    URBs = 3 [ 8 8 8 ]
    Packet Size = 576
    Momentary freq = 96000 Hz (0x60.0000)
  Interface 1
    Altset 1
    Format: S24_3LE
    Channels: 2
    Endpoint: 3 OUT (ADAPTIVE)
    Rates: 48001 - 96000 (continuous)
  Interface 1
    Altset 2
    Format: S24_3LE
    Channels: 2
    Endpoint: 3 OUT (NONE)

 }}}

 {{{
 [2329][root@ubuntu:~]# mplayer test.wav
 MPlayer 1.0rc4-4.4.5 (C) 2000-2010 MPlayer Team
 mplayer: could not connect to socket
 mplayer: No such file or directory
 Failed to open LIRC support. You will not be able to use your remote
 control.

 Playing test.wav.
 Audio only file format detected.
 ==========================================================================
 Opening audio decoder: [pcm] Uncompressed PCM audio decoder
 AUDIO: 96000 Hz, 2 ch, s32le, 6144.0 kbit/100.00% (ratio: 768000->768000)
 Selected audio codec: [pcm] afm: pcm (Uncompressed PCM)
 ==========================================================================
 AO: [pulse] 96000Hz 2ch s32le (4 bytes per sample)
 Video: no video
 Starting playback...
 }}}

 {{{
 Every 0.5s: cat stream0
 Sun Apr  3 23:30:40 2011

 M-Audio Transit USB at usb-0000:00:1d.7-1.2.3, full speed : USB Audio

 Playback:
  Status: Running
    Interface = 1
    Altset = 3
    URBs = 6 [ 4 4 4 4 4 4 ]
    Packet Size = 196
    Momentary freq = 44100 Hz (0x2c.199a)
  Interface 1
    Altset 1
    Format: S24_3LE
    Channels: 2
    Endpoint: 3 OUT (ADAPTIVE)
    Rates: 48001 - 96000 (continuous)
  Interface 1
    Altset 2
    Format: S24_3LE
    Channels: 2
    Endpoint: 3 OUT (NONE)
 }}}

 {{{
 [2330][torstefan@ubuntu:~]$ vlc test.wav
 VLC media player 1.1.4 The Luggage (revision exported)
 Blocked: call to unsetenv("DBUS_ACTIVATION_ADDRESS")
 Blocked: call to unsetenv("DBUS_ACTIVATION_BUS_TYPE")
 [0x9894914] main libvlc: Running vlc with the default interface. Use
 'cvlc' to use vlc without interface.
 Blocked: call to setlocale(6, "")
 Blocked: call to sigaction(17, 0xb48ff0d4, 0xb48ff048)
 Warning: call to signal(13, 0x1)
 Warning: call to signal(13, 0x1)
 Warning: call to srand(1302210069)
 Warning: call to rand()
 Blocked: call to setlocale(6, "")

 (process:11503): Gtk-WARNING **: Locale not supported by C library.
        Using the fallback 'C' locale.
 Warning: call to signal(13, 0x1)
 Warning: call to signal(13, 0x1)
 }}}

 {{{
 Every 0.5s: cat stream0
 Sun Apr  3 23:31:17 2011

 M-Audio Transit USB at usb-0000:00:1d.7-1.2.3, full speed : USB Audio

 Playback:
  Status: Running
    Interface = 1
    Altset = 3
    URBs = 6 [ 4 4 4 4 4 4 ]
    Packet Size = 196
    Momentary freq = 44100 Hz (0x2c.199a)
  Interface 1
    Altset 1
    Format: S24_3LE
    Channels: 2
    Endpoint: 3 OUT (ADAPTIVE)
    Rates: 48001 - 96000 (continuous)
  Interface 1
    Altset 2
    Format: S24_3LE
    Channels: 2
    Endpoint: 3 OUT (NONE)
    Rates: 8000 - 48000 (continuous)
  Interface 1
    Altset 3
    Format: S16_LE
    Channels: 2
    Endpoint: 3 OUT (ASYNC)
    Rates: 8000 - 48000 (continuous)

 Capture:
  Status: Stop
  Interface 2
    Altset 1
    Format: S24_3LE
    Channels: 2
    Endpoint: 5 IN (ASYNC)
    Rates: 48001 - 96000 (continuous)
  Interface 2
    Altset 2
    Format: S24_3LE
    Channels: 2
    Endpoint: 5 IN (ASYNC)
    Rates: 8000 - 48000 (continuous)
  Interface 2
    Altset 3
    Format: S16_LE
    Channels: 2
    Endpoint: 5 IN (ASYNC)
    Rates: 8000 - 48000 (continuous)

 }}}

 {{{
 [2332][torstefan@ubuntu:~]$ totem test.wav


 Every 0.5s: cat stream0
 Sun Apr  3 23:32:33 2011

 M-Audio Transit USB at usb-0000:00:1d.7-1.2.3, full speed : USB Audio

 Playback:
  Status: Running
    Interface = 1
    Altset = 3
    URBs = 6 [ 4 4 4 4 4 4 ]
    Packet Size = 196
    Momentary freq = 44100 Hz (0x2c.199a)
  Interface 1
    Altset 1
    Format: S24_3LE
    Channels: 2
    Endpoint: 3 OUT (ADAPTIVE)
    Rates: 48001 - 96000 (continuous)
  Interface 1
    Altset 2
    Format: S24_3LE
    Channels: 2
    Endpoint: 3 OUT (NONE)
    Rates: 8000 - 48000 (continuous)
  Interface 1
    Altset 3
    Format: S16_LE
    Channels: 2
    Endpoint: 3 OUT (ASYNC)
    Rates: 8000 - 48000 (continuous)

 Capture:
  Status: Stop
  Interface 2
    Altset 1
    Format: S24_3LE
    Channels: 2
    Endpoint: 5 IN (ASYNC)
    Rates: 48001 - 96000 (continuous)
  Interface 2
    Altset 2
    Format: S24_3LE
    Channels: 2
    Endpoint: 5 IN (ASYNC)
    Rates: 8000 - 48000 (continuous)
  Interface 2
    Altset 3
    Format: S16_LE
    Channels: 2
    Endpoint: 5 IN (ASYNC)
    Rates: 8000 - 48000 (continuous)
 }}}



 System dmsg
 http://pastebin.com/SmWamhja

--
Ticket URL: <http://pulseaudio.org/ticket/930>
PulseAudio <http://pulseaudio.org/>
The PulseAudio Sound Server
