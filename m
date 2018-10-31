From: Robert Giaraffa <Robert.Giaraffa@silabs.com>
Subject: Re: [EXT] Re: Simultaneous play/record on implicit
 feedback device causes 'endpoint in use' error
Date: Wed, 31 Oct 2018 19:45:07 +0000
Message-ID: <DM6PR11MB2761AF2D51CECFC2951C97259CCD0@DM6PR11MB2761.namprd11.prod.outlook.com>
References: <BN7PR11MB2755B1BC150703C0DFC2DA919CCC0@BN7PR11MB2755.namprd11.prod.outlook.com>
 <s5hy3aeuy4v.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on0078.outbound.protection.outlook.com [104.47.38.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 599E32677E4
 for <alsa-devel@alsa-project.org>; Wed, 31 Oct 2018 20:45:10 +0100 (CET)
In-Reply-To: <s5hy3aeuy4v.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Thank you very much for your prompt response.



I tested the CP2615 and Fast Track Ultra by running aplay and arecord sequentially on my RPi2 v4.14.72 (with patched snd-usb-audio.ko that includes implicit feedback quirk for CP2615).  Although there were minor differences in the system logs for the two devices (e.g. 'cannot submit urb'), but otherwise both devices behaved the same: whichever operation is started last resulted in the 'Endpoint already in use' error, regardless of sequence.  Detailed info below:



=========================================

// CP2615: Run arecord first, then aplay:

=========================================

- No console error after starting 'arecord':

    $ sudo arecord -fdat -d5 junk.wav

        Recording WAVE 'junk.wav' :

        Signed 16 bit Little Endian, Rate 48000 Hz, Stereo

- System log messages after starting 'arecord' (no errors present, printks are for info only):

    [Oct31 10:52] snd_usb_hw_params->set_format()

    [  +0.000021] set_format(): dev:b6f1f000 alts:b7a62864 ifnum: 4

    [  +0.001655] set_format()->usb_set_interface 4:1

    [  +0.000006] Re-using EP 83 in iface 4:1

    [  +0.000004] set_sync_endpoint() early return (NumEP=01)

    [  +0.000034] snd_usb_pcm_prepare->set_format()

    [  +0.000005] set_format(): dev:b6f1f000 alts:b7a62864 ifnum: 4

    [  +0.000002] set_format() early return (fmt==subs->cur_audiofmt)

    [  +0.000782] Setting params for EP 83 (type 0, 12 urbs), ret=0

    [  +0.001106] Starting DATA_EP 83 @b6cb4000



- After starting aplay, console reports 'Unable to install hw params'

  and system log reports 'EP #83: already in use':

  $ sudo aplay -fdat 997Hz_-3dB_48kHz_16bit_10s.wav

      Playing WAVE '997Hz_-3dB_48kHz_16bit_10s.wav' :

      Signed 16 bit Little Endian, Rate 48000 Hz, Stereo

==> aplay: set_params:1363: Unable to install hw params:

    ACCESS:  RW_INTERLEAVED

    FORMAT:  S16_LE

    SUBFORMAT:  STD

    SAMPLE_BITS: 16

    FRAME_BITS: 32

    CHANNELS: 2

    RATE: 48000

    PERIOD_TIME: 125000

    PERIOD_SIZE: 6000

    PERIOD_BYTES: 24000

    PERIODS: 4

    BUFFER_TIME: 500000

    BUFFER_SIZE: 24000

    BUFFER_BYTES: 96000

    TICK_TIME: 0



    [  +1.466748] snd_usb_hw_params->set_format()

    [  +0.000018] set_format(): dev:b6f1f000 alts:b7a628a4 ifnum: 3

    [  +0.001550] set_format()->usb_set_interface 3:1

    [  +0.000005] Re-using EP 3 in iface 3:1

    [  +0.000006] *** CP2615 setting sync EP quirk

    [  +0.000003] Re-using EP 83 in iface 4:1

    [  +0.000003] set_sync_endpoint() early return (NumEP=01)

    [  +0.000036] snd_usb_pcm_prepare->set_format()

    [  +0.000005] set_format(): dev:b6f1f000 alts:b7a628a4 ifnum: 3

    [  +0.000002] set_format() early return (fmt==subs->cur_audiofmt)

    [  +0.004645] Setting params for EP 03 (type 0, 12 urbs), ret=0

==> [  +0.000006] *** snd_usb_endpoint_set_params(): EP #83: already in use

    [  +0.000003] configure_sync_endpoint->endpoint_set_params: err=FFFFFFF0

    [  +0.000003] snd_usb_pcm_prepare()->configure_endpoint(): err = FFFFFFF0

    [  +3.532988] Stopping data EP

    [  +0.000035] Setting FLAG_STOPPING on EP83

    [  +0.000011] Waiting for EP 83 to stop



=========================================

// CP2615: Run aplay first, then arecord:

=========================================

- No console error after starting aplay:

    $ sudo aplay -fdat 997Hz_-3dB_48kHz_16bit_10s.wav

        Playing WAVE '997Hz_-3dB_48kHz_16bit_10s.wav' :

        Signed 16 bit Little Endian, Rate 48000 Hz, Stereo



- dmesg after starting aplay (info only, no errors):

    [Oct31 11:14] snd_usb_hw_params->set_format()

    [  +0.000018] set_format(): dev:b6f1f000 alts:b7a628a4 ifnum: 3

    [  +0.001630] set_format()->usb_set_interface 3:1

    [  +0.000005] Re-using EP 3 in iface 3:1

    [  +0.000005] *** CP2615 setting sync EP quirk

    [  +0.000003] Re-using EP 83 in iface 4:1

    [  +0.000004] set_sync_endpoint() early return (NumEP=01)

    [  +0.000036] snd_usb_pcm_prepare->set_format()

    [  +0.000004] set_format(): dev:b6f1f000 alts:b7a628a4 ifnum: 3

    [  +0.000003] set_format() early return (fmt==subs->cur_audiofmt)

    [  +0.000768] Setting params for EP 03 (type 0, 12 urbs), ret=0

    [  +0.000031] Setting params for EP 83 (type 0, 12 urbs), ret=0

    [  +0.000004] Starting DATA_EP 03 @b6cb0000

    [  +0.000004] snd_usb_endpoint_implicit_feedback_sink (03) is TRUE

    [  +0.001588] Starting SYNC_EP 83 @b6cb4000



- Console error after starting arecord:

    $ sudo arecord -fdat -d5 junk.wav

        Recording WAVE 'junk.wav' :

        Signed 16 bit Little Endian, Rate 48000 Hz, Stereo

==>   arecord: set_params:1363: Unable to install hw params:

      ACCESS:  RW_INTERLEAVED

      FORMAT:  S16_LE

      SUBFORMAT:  STD

      SAMPLE_BITS: 16

      FRAME_BITS: 32

      CHANNELS: 2

      RATE: 48000

      PERIOD_TIME: 125000

      PERIOD_SIZE: 6000

      PERIOD_BYTES: 24000

      PERIODS: 4

      BUFFER_TIME: 500000

      BUFFER_SIZE: 24000

      BUFFER_BYTES: 96000

      TICK_TIME: 0



- dmesg after starting arecord ('EP #83 already in use'):

    [  +2.410222] snd_usb_hw_params->set_format()

    [  +0.000017] set_format(): dev:b6f1f000 alts:b7a62864 ifnum: 4

    [  +0.001487] set_format()->usb_set_interface 4:1

    [  +0.000005] Re-using EP 83 in iface 4:1

    [  +0.000004] set_sync_endpoint() early return (NumEP=01)

    [  +0.000032] snd_usb_pcm_prepare->set_format()

    [  +0.000004] set_format(): dev:b6f1f000 alts:b7a62864 ifnum: 4

    [  +0.000003] set_format() early return (fmt==subs->cur_audiofmt)

==> [  +0.003509] *** snd_usb_endpoint_set_params(): EP #83: already in use

    [  +0.000008] configure_endpoint->endpoint_set_params: err=FFFFFFF0

    [  +0.000004] snd_usb_pcm_prepare()->configure_endpoint(): err = FFFFFFF0



- After arecord failed, aplay did nothing for ~45s, after which this console

  error appeared:

    aplay: pcm_write:2011: write error: Input/output error



  These messages then appeared in the system log, and aplay exited:

    [Oct31 11:15] Stopping sync EP

    [  +0.000011] Setting FLAG_STOPPING on EP83

    [  +0.000002] Stopping data EP

    [  +0.000003] Setting FLAG_STOPPING on EP03

    [  +0.000012] Waiting for EP 83 to stop

    [  +0.000003] Waiting for EP 03 to stop



=================================================

// FastTrackUltra: Run arecord first, then aplay:

=================================================

- No console error after starting 'arecord':

    $ sudo arecord -c2 -Dplughw:Ultra -r48000 -fS24_3LE -d5 junk.wav

        Recording WAVE 'junk.wav' :

        Signed 24 bit Little Endian in 3bytes, Rate 48000 Hz, Stereo



- System log messages after starting 'arecord' (???: Is the '-75' an error?):

    [Oct31 13:46] snd_usb_hw_params->set_format()

    [  +0.000019] set_format(): dev:b6f87400 alts:b6c019a4 ifnum: 2

    [  +0.000331] set_format()->usb_set_interface 2:1

    [  +0.000006] Creating new capture data endpoint 81

    [  +0.000012] set_sync_endpoint() early return (NumEP=01)

    [  +0.000127] snd_usb_pcm_prepare->set_format()

    [  +0.000005] set_format(): dev:b6f87400 alts:b6c019a4 ifnum: 2

    [  +0.000003] set_format() early return (fmt==subs->cur_audiofmt)

    [  +0.000586] Setting params for EP 81 (type 0, 12 urbs), ret=0

    [  +0.001588] Starting DATA_EP 81 @b9cc0000

??? [  +0.001360] usb 1-1.4: frame 1 active: -75



- After starting aplay, console reports 'Unable to install hw params'

  and system log reports 'EP #83: already in use' (similar to CP2615 case).

    $ sudo aplay -c2 -Dplughw:Ultra -r48000 -fS24_3LE 24bit.wav

    Playing WAVE '24bit.wav' : Signed 24 bit Little Endian in 3bytes, Rate 48000 Hz, Stereo

==> aplay: set_params:1363: Unable to install hw params:

    ACCESS:  RW_INTERLEAVED

    FORMAT:  S24_3LE

    SUBFORMAT:  STD

    SAMPLE_BITS: 24

    FRAME_BITS: 48

    CHANNELS: 2

    RATE: 48000

    PERIOD_TIME: 125000

    PERIOD_SIZE: 6000

    PERIOD_BYTES: 36000

    PERIODS: 4

    BUFFER_TIME: 500000

    BUFFER_SIZE: 24000

    BUFFER_BYTES: 144000

    TICK_TIME: 0



=================================================

// FastTrackUltra: Run aplay first, then arecord:

=================================================

- No console error after starting aplay:

     $ sudo aplay -c2 -Dplughw:Ultra -r48000 -fS24_3LE 24bit.wav

         Playing WAVE '24bit.wav' :

         Signed 24 bit Little Endian in 3bytes, Rate 48000 Hz, Stereo



- dmesg after starting aplay (info only, no errors):

    [Oct31 13:55] snd_usb_hw_params->set_format()

    [  +0.000017] set_format(): dev:b6f87400 alts:b6cbc264 ifnum: 1

    [  +0.000260] set_format()->usb_set_interface 1:1

    [  +0.000006] Re-using EP 1 in iface 1:1

    [  +0.000005] Re-using EP 81 in iface 2:1

    [  +0.000004] set_sync_endpoint(): mode is Playback with adaptive FB

    [  +0.000119] snd_usb_pcm_prepare->set_format()

    [  +0.000006] set_format(): dev:b6f87400 alts:b6cbc264 ifnum: 1

    [  +0.000002] set_format() early return (fmt==subs->cur_audiofmt)

    [  +0.000499] Setting params for EP 01 (type 0, 12 urbs), ret=0

    [  +0.000031] Setting params for EP 81 (type 0, 12 urbs), ret=0

    [  +0.000004] Starting DATA_EP 01 @b9cc6000

    [  +0.000005] snd_usb_endpoint_implicit_feedback_sink (01) is TRUE

    [  +0.000247] Starting SYNC_EP 81 @b9cc0000



- After starting arecord, console reports 'Unable to install hw params' and arecord exits:

    $ sudo arecord -c2 -Dplughw:Ultra -r48000 -fS24_3LE -d5 junk.wav

        Recording WAVE 'junk.wav' : Signed 24 bit Little Endian in 3bytes, Rate 48000 Hz, Stereo

==>     arecord: set_params:1363: Unable to install hw params:

        ACCESS:  RW_INTERLEAVED

        FORMAT:  S24_3LE

        SUBFORMAT:  STD

        SAMPLE_BITS: 24

        FRAME_BITS: 48

        CHANNELS: 2

        RATE: 48000

        PERIOD_TIME: 125000

        PERIOD_SIZE: 6000

        PERIOD_BYTES: 36000

        PERIODS: 4

        BUFFER_TIME: 500000

        BUFFER_SIZE: 24000

        BUFFER_BYTES: 144000

        TICK_TIME: 0



- ... and the system log reports 'EP already in use' and 'cannot submit urb' errors:

    [  +1.364234] snd_usb_hw_params->set_format()

    [  +0.000018] set_format(): dev:b6f87400 alts:b6c019a4 ifnum: 2

==> [  +0.000037] usb 1-1.4: cannot submit urb (err = -2)

    [  +0.000004] ERROR snd_complete_urb(): Cannot submit urb (err = -2)

    [  +0.000225] set_format()->usb_set_interface 2:1

    [  +0.000005] Re-using EP 81 in iface 2:1

    [  +0.000006] set_sync_endpoint() early return (NumEP=01)

    [  +0.000091] snd_usb_pcm_prepare->set_format()

    [  +0.000005] set_format(): dev:b6f87400 alts:b6c019a4 ifnum: 2

    [  +0.000002] set_format() early return (fmt==subs->cur_audiofmt)

==> [  +0.000564] *** snd_usb_endpoint_set_params(): EP #81: already in use

    [  +0.000004] configure_endpoint->endpoint_set_params: err=FFFFFFF0

    [  +0.000003] snd_usb_pcm_prepare()->configure_endpoint(): err = FFFFFFF0



- After arecord failed and exited, aplay did nothing (i.e. was hung) and

  had to be terminated with ^c. Console message after terminating aplay:

    Aborted by signal Interrupt...

    aplay: pcm_write:2011: write error: Interrupted system call



- System log messages after terminating aplay:

    [Oct31 14:00] Stopping sync EP

    [  +0.000012] Setting FLAG_STOPPING on EP81

    [  +0.000004] Stopping data EP

    [  +0.000003] Setting FLAG_STOPPING on EP01

    [  +0.000150] Waiting for EP 81 to stop

    [  +0.000004] Waiting for EP 01 to stop
