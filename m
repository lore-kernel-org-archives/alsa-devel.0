From: Olivier Langlois <olivier@trillion01.com>
Subject: need help with loopback driver
Date: Wed, 11 Dec 2013 01:33:11 -0500
Message-ID: <1386743591.753.9.camel@Wailaba2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from alt-proxy31.mail.unifiedlayer.com
 (alt-proxy31.mail.unifiedlayer.com [74.220.221.129])
 by alsa0.perex.cz (Postfix) with SMTP id B8CC4261AE2
 for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2013 07:33:15 +0100 (CET)
Received: from [173.179.63.169] (port=35405 helo=[192.168.1.104])
 by box610.bluehost.com with esmtpsa (TLSv1:RC4-SHA:128) (Exim 4.80)
 (envelope-from <olivier@trillion01.com>) id 1VqdM9-0001KQ-7v
 for alsa-devel@alsa-project.org; Tue, 10 Dec 2013 23:33:13 -0700
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

Hi,

I am trying to split a pcm stream and send it to my sound card and send
a downmixed/downsampled copy to the playback device of the loopback
card.

I am using speaker-test to test my config. the sound goes to the
speakers and I am able to record the downmixed signal through the
loopback capture device but I am seeing a bunch of error messages in the
speaker-test output which makes me doubt that there is maybe something
wrong in what I am doing.

So I am asking help from the experts:

My conf:

pcm.loop_44100_16 {
    type plug
    slave {
       pcm "hw:1,0,0"
       format S16_LE
       rate 44100
    }
}

pcm.loop_capture {
    type hw
    card 1
    device 1
    subdevice 0
}

pcm.split {
    type plug
    slave.pcm {
        type multi
        slaves {
            a { channels 8 pcm "hdmi:0,0" } # hdmi output
            b { channels 2 pcm "loop_44100_16" } # loopback record
        }
        bindings {
          0 { slave a channel 0 } # Front Left
          1 { slave a channel 1 } # Front Right
          2 { slave a channel 2 } # Rear  Left
          3 { slave a channel 3 } # Rear right
          4 { slave a channel 4 } # center
          5 { slave a channel 5 } # LFE
          6 { slave a channel 6 } # Side Left
          7 { slave a channel 7 } # Side right
          8 { slave b channel 0 } # left
          9 { slave b channel 1 } # right
        }
    }
    ttable [
[ 1 0 0 0 0 0 0 0 0.38 0    ] # Front left
[ 0 1 0 0 0 0 0 0 0    0.38 ] # Front right
[ 0 0 1 0 0 0 0 0 0.22 0    ] # Rear left
[ 0 0 0 1 0 0 0 0 0    0.22 ] # Rear right
[ 0 0 0 0 1 0 0 0 0.18 0.18 ] # center
[ 0 0 0 0 0 1 0 0 0    0    ] # LFE
[ 0 0 0 0 0 0 1 0 0.22 0    ] # Side left
[ 0 0 0 0 0 0 0 1 0    0.22 ] # Side right
]
}


$ speaker-test -Dsplit -c8 -r192000 -F S32_LE

speaker-test 1.0.27.2

Playback device is split
Stream parameters are 192000Hz, S32_LE, 8 channels
Using 16 octaves of pink noise
Rate set to 192000Hz (requested 192000Hz)
Buffer size range from 296 to 131072
Period size range from 148 to 65536
Using max buffer size 131072
Periods = 4
was set period_size = 65536
was set buffer_size = 131072
 0 - Front Left
Write error: -32,Broken pipe
Can't recovery from underrun, prepare failed: Device or resource busy
Write error: -32,Broken pipe
Can't recovery from underrun, prepare failed: Device or resource busy
 4 - Center
Write error: -32,Broken pipe
Write error: -32,Broken pipe
Can't recovery from underrun, prepare failed: Device or resource busy
Write error: -32,Broken pipe
Can't recovery from underrun, prepare failed: Device or resource busy
Write error: -32,Broken pipe
Can't recovery from underrun, prepare failed: Device or resource busy
 1 - Front Right
Write error: -32,Broken pipe
Write error: -32,Broken pipe
Can't recovery from underrun, prepare failed: Device or resource busy
Write error: -32,Broken pipe
Can't recovery from underrun, prepare failed: Device or resource busy
Write error: -32,Broken pipe
Can't recovery from underrun, prepare failed: Device or resource busy
 7 - Side Right
Write error: -32,Broken pipe
Write error: -32,Broken pipe
Can't recovery from underrun, prepare failed: Device or resource busy

lano1106@whippet2 ~ $ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: HDMI [HDA ATI HDMI], device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: HDMI [HDA ATI HDMI], device 7: HDMI 1 [HDMI 1]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: HDMI [HDA ATI HDMI], device 8: HDMI 2 [HDMI 2]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: HDMI [HDA ATI HDMI], device 9: HDMI 3 [HDMI 3]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: HDMI [HDA ATI HDMI], device 10: HDMI 4 [HDMI 4]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: HDMI [HDA ATI HDMI], device 11: HDMI 5 [HDMI 5]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: Loopback [Loopback], device 0: Loopback PCM [Loopback PCM]
  Subdevices: 8/8
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
  Subdevice #4: subdevice #4
  Subdevice #5: subdevice #5
  Subdevice #6: subdevice #6
  Subdevice #7: subdevice #7
card 1: Loopback [Loopback], device 1: Loopback PCM [Loopback PCM]
  Subdevices: 8/8
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
  Subdevice #4: subdevice #4
  Subdevice #5: subdevice #5
  Subdevice #6: subdevice #6
  Subdevice #7: subdevice #7

Thank you,
