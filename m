From: Mike Ood <jh1ood@gmail.com>
Subject: snd-bebob and PrismSound Orpheus fails with
	snd_pcm_hw_params_set_channels
Date: Thu, 23 Apr 2015 21:13:46 +0900
Message-ID: <CAJ0eYfU2GbYMZe=RpEecA15OBcVGt=q2xchykrCXLUZcf=886g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vn0-f51.google.com (mail-vn0-f51.google.com
 [209.85.216.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 4385F2615F7
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 14:13:48 +0200 (CEST)
Received: by vnbf129 with SMTP id f129so1067021vnb.9
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 05:13:47 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi All,

I have been using my PrismSound Orpheus successfully with juju+ffado+jackd
as:

% jackd -R -dfirewire -r44100 -p4096 -n3 &

% aplay -D pcm.jack test.wav
or
% alsaplayer -i text -o jack -d "system:playback_1,system:playback_2"
test.wav

on Ubuntu 14.04 with kernel 3.13 or so.

***

Today I clean installed ubuntu 14.10 wishing to use snd-bebob, but
unfortunately

% sudo aplay -D hw:2,0 --channels=2 test.wav

does not work with the following messages:

Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
aplay: set_params:1239: Channels count non available

aplay.c:
1237   err = snd_pcm_hw_params_set_channels(handle, params,
hwparams.channels);
1238   if (err < 0) {
1239     error(_("Channels count non available"));
1240     prg_exit(EXIT_FAILURE);
1241   }

My short capture program, which works fine with USB audio devices,
does not work either at the same place.

myprog.cpp:
    /* set the count of channels */
    err = snd_pcm_hw_params_set_channels(handle, params, channels);
    if (err < 0) {
        cout << "Sound::asound_set_hwparams: Channels count " << channels
            << " is not available for playbacks." << snd_strerror(err)
            << endl;
        return err;
    }

Does anybody have any suggestions for me?

Mike ODD

*** (for your information) ***

% uname -a
Linux host 3.16.0-34-generic #47-Ubuntu SMP Fri Apr 10 18:02:58 UTC 2015
x86_64 x86_64 x86_64 GNU/Linux

% ls -l /dev/fw*
crw-------  1 root root  250, 0 Apr 23 13:57 /dev/fw0
crw-rw----+ 1 root video 250, 1 Apr 23 13:57 /dev/fw1

% lsmod | grep snd_bebob
snd_bebob              40777  0
snd_firewire_lib       29081  1 snd_bebob
snd_hwdep              17698  3 snd_usb_audio,snd_bebob,snd_hda_codec
snd_pcm               104102  8
snd_firewire_lib,snd_usb_audio,snd_bebob,snd_hda_codec_hdmi,snd_hda_codec,snd_hda_intel,snd_hda_controller
snd_rawmidi            30876  4
snd_firewire_lib,snd_bebob,snd_usbmidi_lib,snd_seq_midi
snd                    87611  31
snd_hda_codec_realtek,snd_usb_audio,snd_bebob,snd_hwdep,snd_timer,snd_hda_codec_hdmi,snd_pcm,snd_seq,snd_rawmidi,snd_hda_codec_generic,snd_usbmidi_lib,snd_hda_codec,snd_hda_intel,snd_seq_device
firewire_core          68671  3 snd_firewire_lib,snd_bebob,firewire_ohci

% ls -l /proc/asound
total 0
dr-xr-xr-x 6 root root 0 Apr 23 21:02 card0
dr-xr-xr-x 3 root root 0 Apr 23 21:02 card1
dr-xr-xr-x 5 root root 0 Apr 23 21:02 card2
dr-xr-xr-x 4 root root 0 Apr 23 21:02 card3
-r--r--r-- 1 root root 0 Apr 23 21:02 cards
lrwxrwxrwx 1 root root 5 Apr 23 21:02 CODEC -> card3
-r--r--r-- 1 root root 0 Apr 23 21:02 devices
lrwxrwxrwx 1 root root 5 Apr 23 21:02 HDMI -> card1
-r--r--r-- 1 root root 0 Apr 23 21:02 hwdep
lrwxrwxrwx 1 root root 5 Apr 23 21:02 MID -> card0
-r--r--r-- 1 root root 0 Apr 23 21:02 modules
lrwxrwxrwx 1 root root 5 Apr 23 21:02 Orpheus -> card2
dr-xr-xr-x 2 root root 0 Apr 23 21:02 oss
-r--r--r-- 1 root root 0 Apr 23 21:02 pcm
dr-xr-xr-x 2 root root 0 Apr 23 21:02 seq
-r--r--r-- 1 root root 0 Apr 23 21:02 timers
-r--r--r-- 1 root root 0 Apr 23 21:02 version

% ls -l /proc/asound/card2
total 0
dr-xr-xr-x 2 root root 0 Apr 23 21:02 firewire
-r--r--r-- 1 root root 0 Apr 23 21:02 id
-r--r--r-- 1 root root 0 Apr 23 21:02 midi0
dr-xr-xr-x 3 root root 0 Apr 23 21:02 pcm0c
dr-xr-xr-x 3 root root 0 Apr 23 21:02 pcm0p

% cat /proc/asound/card2/id
Orpheus

% ls -l /proc/asound/card2/firewire
total 0
-r--r--r-- 1 root root 0 Apr 23 21:03 clock
-r--r--r-- 1 root root 0 Apr 23 21:03 firmware
-r--r--r-- 1 root root 0 Apr 23 21:03 formation

% cat /proc/asound/card2/firewire/clock
Sampling rate: 44100
Clock Source: External (MSU-dest: 7)

% cat /proc/asound/card2/firewire/firmware
Manufacturer: bridgeCo
Protocol Ver: 3
Build Ver: 0
GUID: 0x00119800010001F9
Model ID: 0x13
Model Rev: 0
Firmware Date: 20100205
Firmware Time: 105129
Firmware ID: 0x10048
Firmware Ver: 6572
Base Addr: 0x400C0080
Max Size: 1519984
Loader Date: 20070118
Loader Time: 101440

% cat /proc/asound/card2/firewire/formation
Output Stream from device:
Rate PCM MIDI
32000 0 0
44100 10 1
48000 10 1
88200 10 1
96000 10 1
176400 10 1
192000 10 1
Input Stream to device:
Rate PCM MIDI
32000 0 0
44100 12 1
48000 12 1
88200 12 1
96000 12 1
176400 12 1
192000 12 1

% ls -l /proc/asound/card2/pcm0c
total 0
-r--r--r-- 1 root root 0 Apr 23 21:05 info
dr-xr-xr-x 2 root root 0 Apr 23 21:05 sub0

% ls -l /proc/asound/card2/pcm0p
total 0
-r--r--r-- 1 root root 0 Apr 23 21:06 info
dr-xr-xr-x 2 root root 0 Apr 23 21:06 sub0

% cat /proc/asound/card2/pcm0c/info
card: 2
device: 0
subdevice: 0
stream: CAPTURE
id: BeBoB
name: Orpheus PCM
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

% cat /proc/asound/card2/pcm0p/info
card: 2
device: 0
subdevice: 0
stream: PLAYBACK
id: BeBoB
name: Orpheus PCM
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1

*** (end of information) ***
