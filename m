From: Olivier Langlois <olivier@trillion01.com>
Subject: Re: need help with loopback driver
Date: Thu, 26 Dec 2013 15:07:45 -0500
Message-ID: <1388088465.18597.29.camel@Wailaba2>
References: <1386743591.753.9.camel@Wailaba2>
 <1386911522.753.43.camel@Wailaba2>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-WvE2BNePe1mGT6TBTaC6"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from alt-proxy6.mail.unifiedlayer.com
 (alt-proxy6.mail.unifiedlayer.com [66.147.245.65])
 by alsa0.perex.cz (Postfix) with SMTP id B824B2619E0
 for <alsa-devel@alsa-project.org>; Thu, 26 Dec 2013 21:07:52 +0100 (CET)
Received: from [173.179.63.169] (port=33477 helo=[192.168.1.104])
 by box610.bluehost.com with esmtpsa (SSLv3:RC4-SHA:128) (Exim 4.80)
 (envelope-from <olivier@trillion01.com>) id 1VwHDi-0005do-Ll
 for alsa-devel@alsa-project.org; Thu, 26 Dec 2013 13:07:50 -0700
In-Reply-To: <1386911522.753.43.camel@Wailaba2>
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


--=-WvE2BNePe1mGT6TBTaC6
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Concerning my attempts to use the aloop driver in a mildly complex ALSA
setup, after spending hours reading ALSA code and playing with it with
interactive gdb session, I have somehow progressed a little bit.

1. I have understood that because connecting one side of the snd_aloop
was setting the hw params for the other side, this could explain the
difference of behavior when changing the sequence of connecting the
playback stream and the capture stream of the aloop.

2. I did some tweaks in my alsa conf

a. Replace the plugin used to downsample my playback stream from type
'plug' to the simpler type 'rate' because this is really just what I
needed.

b. Changed the downsampled rate from 44100 to 48000 since 48000 being a
multiple of 192000 has the potential to ease the hw params refinements
related to the rate value.

c. Enforce multi client rate param to 192000 or else slave 'a' params
were used for refining slave b params. This had the effect of using the
full rate interval of slave 'a' to calculate slave 'b' buffer size
[32000 192000] and for the upsampling case, the required buffer size was
exceeding the client buffer size interval. 

my conf now looks like this:

pcm.loop_44100_16 {
    type rate
    slave {
       pcm "hw:1,0,0"
       format S16_LE
       rate 48000
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
    slave {
        pcm {
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
       rate 192000
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

I have already said it once in the past but again, by having being
forced to spend hours studying the ALSA source code has made me
appreciate the quality of its design and implementation but I find that
requiring this type of devotion to correctly use a system may be a
problem. I'm just throwing a suggestion that could reduce the
problematic opacity. I did find the REFINE_DEBUG output very useful to
understand what was happening to me. Maybe they could be included in the
release build and outputed only when refine fails.

Concerning the last problem. Here it is 'loop_44100_16' refine sometimes
works and sometimes it doesn't. Either something invisible to the param
dumps is different or maybe some uninitialized variables adds some
randomness to the result:

srefine 'loop_44100_16' (client)
ACCESS:  MMAP_INTERLEAVED MMAP_NONINTERLEAVED
FORMAT:  S16_LE S32_LE
SUBFORMAT:  STD
SAMPLE_BITS: ALL
FRAME_BITS: ALL
CHANNELS: 2
RATE: 192000
PERIOD_TIME: (20 682667)
PERIOD_SIZE: [4 131072]
PERIOD_BYTES: ALL
PERIODS: [2 32]
BUFFER_TIME: (41 1365334)
BUFFER_SIZE: [8 262144]
BUFFER_BYTES: ALL
TICK_TIME: ALL
srefine 'loop_44100_16' (slave)
ACCESS:  MMAP_INTERLEAVED MMAP_NONINTERLEAVED MMAP_COMPLEX
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: ALL
FRAME_BITS: ALL
CHANNELS: 2
RATE: [48000 48001)
PERIOD_TIME: (20 682667)
PERIOD_SIZE: ALL
PERIOD_BYTES: ALL
PERIODS: ALL
BUFFER_TIME: ALL
BUFFER_SIZE: [2 65538)
BUFFER_BYTES: ALL
TICK_TIME: ALL
REFINE called:
ACCESS:  MMAP_INTERLEAVED MMAP_NONINTERLEAVED MMAP_COMPLEX
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: ALL
FRAME_BITS: ALL
CHANNELS: 2
RATE: [48000 48001)
PERIOD_TIME: (20 682667)
PERIOD_SIZE: ALL
PERIOD_BYTES: ALL
PERIODS: ALL
BUFFER_TIME: ALL
BUFFER_SIZE: [2 65538)
BUFFER_BYTES: ALL
TICK_TIME: ALL
refine done - result = 0


lano1106@Wailaba2 ~/dev/alsa_debug $ diff refine_success.txt
refine_fail.txt 
49c49,50
< refine done - result = 0
---
> refine done - result = -22

I think that maybe the fact that the slave buffer size min being outside
the client buffer size interval could be the problem but then it should
fail all the time and this would mean that there is an issue with
pcm_rate.c since for rate intervals having single value both for the
client and the slave I think that you cannot have both slave buffer size
interval endpoints being inside the client interval.

I could be wrong as I have not yet totally assimilated the refine
algorithm. I'll report back when I have nailed down this final problem.

Greetings,
Olivier

On Fri, 2013-12-13 at 00:12 -0500, Olivier Langlois wrote:
> I did a small experiment or maybe it was just luck but. I am getting the
> error messages on the playback side if I launch the playback side before
> the capture side.
> 
> By reversing the order, that is launch arecord before speaker-test, the
> errors go away but. ALSA forces me to match the sampling rate of the
> capture side:
> 
> lano1106@whippet2 ~ $ arecord -Dloop_capture -f S16_LE -c2 -r 44100
> alsa.wav
> Recording WAVE 'alsa.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
> Stereo
> 
> lano1106@whippet2 ~/dev/alsa-lib.git $ speaker-test -Dsplit -c8 -r192000
> -F S32_LE
> 
> speaker-test 1.0.27.2
> 
> Playback device is split
> Stream parameters are 192000Hz, S32_LE, 8 channels
> Using 16 octaves of pink noise
> Rate set to 192000Hz (requested 192000Hz)
> Buffer size range from 296 to 131060
> Period size range from 148 to 65476
> Using max buffer size 131060
> Periods = 4
> Unable to set nperiods 4 for playback: Invalid argument
> Setting of hwparams failed: Invalid argument
> lano1106@whippet2 ~/dev/alsa-lib.git :( $ speaker-test -Dsplit -c8
> -r44100 -F S32_LE
> 
> speaker-test 1.0.27.2
> 
> Playback device is split
> Stream parameters are 44100Hz, S32_LE, 8 channels
> Using 16 octaves of pink noise
> Rate set to 44100Hz (requested 44100Hz)
> Buffer size range from 32 to 131072
> Period size range from 16 to 65536
> Using max buffer size 131072
> Periods = 4
> was set period_size = 32768
> was set buffer_size = 131072
>  0 - Front Left
>  4 - Center
>  1 - Front Right
> ^C 7 - Side Right
>  3 - Rear Right
>  2 - Rear Left
>  6 - Side Left
>  5 - LFE
> Time per period = 4.752270
> 
> Am I abusing the plug type plugin? I tough that it was suppose to adapt
> the source params with the sink expected params.
> 
> On Wed, 2013-12-11 at 01:33 -0500, Olivier Langlois wrote:
> > Hi,
> > 
> > I am trying to split a pcm stream and send it to my sound card and send
> > a downmixed/downsampled copy to the playback device of the loopback
> > card.
> > 
> > I am using speaker-test to test my config. the sound goes to the
> > speakers and I am able to record the downmixed signal through the
> > loopback capture device but I am seeing a bunch of error messages in the
> > speaker-test output which makes me doubt that there is maybe something
> > wrong in what I am doing.
> > 
> > So I am asking help from the experts:
> > 
> > My conf:
> > 
> > pcm.loop_44100_16 {
> >     type plug
> >     slave {
> >        pcm "hw:1,0,0"
> >        format S16_LE
> >        rate 44100
> >     }
> > }
> > 
> > pcm.loop_capture {
> >     type hw
> >     card 1
> >     device 1
> >     subdevice 0
> > }
> > 
> > pcm.split {
> >     type plug
> >     slave.pcm {
> >         type multi
> >         slaves {
> >             a { channels 8 pcm "hdmi:0,0" } # hdmi output
> >             b { channels 2 pcm "loop_44100_16" } # loopback record
> >         }
> >         bindings {
> >           0 { slave a channel 0 } # Front Left
> >           1 { slave a channel 1 } # Front Right
> >           2 { slave a channel 2 } # Rear  Left
> >           3 { slave a channel 3 } # Rear right
> >           4 { slave a channel 4 } # center
> >           5 { slave a channel 5 } # LFE
> >           6 { slave a channel 6 } # Side Left
> >           7 { slave a channel 7 } # Side right
> >           8 { slave b channel 0 } # left
> >           9 { slave b channel 1 } # right
> >         }
> >     }
> >     ttable [
> > [ 1 0 0 0 0 0 0 0 0.38 0    ] # Front left
> > [ 0 1 0 0 0 0 0 0 0    0.38 ] # Front right
> > [ 0 0 1 0 0 0 0 0 0.22 0    ] # Rear left
> > [ 0 0 0 1 0 0 0 0 0    0.22 ] # Rear right
> > [ 0 0 0 0 1 0 0 0 0.18 0.18 ] # center
> > [ 0 0 0 0 0 1 0 0 0    0    ] # LFE
> > [ 0 0 0 0 0 0 1 0 0.22 0    ] # Side left
> > [ 0 0 0 0 0 0 0 1 0    0.22 ] # Side right
> > ]
> > }
> > 
> > 
> > $ speaker-test -Dsplit -c8 -r192000 -F S32_LE
> > 
> > speaker-test 1.0.27.2
> > 
> > Playback device is split
> > Stream parameters are 192000Hz, S32_LE, 8 channels
> > Using 16 octaves of pink noise
> > Rate set to 192000Hz (requested 192000Hz)
> > Buffer size range from 296 to 131072
> > Period size range from 148 to 65536
> > Using max buffer size 131072
> > Periods = 4
> > was set period_size = 65536
> > was set buffer_size = 131072
> >  0 - Front Left
> > Write error: -32,Broken pipe
> > Can't recovery from underrun, prepare failed: Device or resource busy
> > Write error: -32,Broken pipe
> > Can't recovery from underrun, prepare failed: Device or resource busy
> >  4 - Center
> > Write error: -32,Broken pipe
> > Write error: -32,Broken pipe
> > Can't recovery from underrun, prepare failed: Device or resource busy
> > Write error: -32,Broken pipe
> > Can't recovery from underrun, prepare failed: Device or resource busy
> > Write error: -32,Broken pipe
> > Can't recovery from underrun, prepare failed: Device or resource busy
> >  1 - Front Right
> > Write error: -32,Broken pipe
> > Write error: -32,Broken pipe
> > Can't recovery from underrun, prepare failed: Device or resource busy
> > Write error: -32,Broken pipe
> > Can't recovery from underrun, prepare failed: Device or resource busy
> > Write error: -32,Broken pipe
> > Can't recovery from underrun, prepare failed: Device or resource busy
> >  7 - Side Right
> > Write error: -32,Broken pipe
> > Write error: -32,Broken pipe
> > Can't recovery from underrun, prepare failed: Device or resource busy
> > 
> > lano1106@whippet2 ~ $ aplay -l
> > **** List of PLAYBACK Hardware Devices ****
> > card 0: HDMI [HDA ATI HDMI], device 3: HDMI 0 [HDMI 0]
> >   Subdevices: 1/1
> >   Subdevice #0: subdevice #0
> > card 0: HDMI [HDA ATI HDMI], device 7: HDMI 1 [HDMI 1]
> >   Subdevices: 1/1
> >   Subdevice #0: subdevice #0
> > card 0: HDMI [HDA ATI HDMI], device 8: HDMI 2 [HDMI 2]
> >   Subdevices: 1/1
> >   Subdevice #0: subdevice #0
> > card 0: HDMI [HDA ATI HDMI], device 9: HDMI 3 [HDMI 3]
> >   Subdevices: 1/1
> >   Subdevice #0: subdevice #0
> > card 0: HDMI [HDA ATI HDMI], device 10: HDMI 4 [HDMI 4]
> >   Subdevices: 1/1
> >   Subdevice #0: subdevice #0
> > card 0: HDMI [HDA ATI HDMI], device 11: HDMI 5 [HDMI 5]
> >   Subdevices: 1/1
> >   Subdevice #0: subdevice #0
> > card 1: Loopback [Loopback], device 0: Loopback PCM [Loopback PCM]
> >   Subdevices: 8/8
> >   Subdevice #0: subdevice #0
> >   Subdevice #1: subdevice #1
> >   Subdevice #2: subdevice #2
> >   Subdevice #3: subdevice #3
> >   Subdevice #4: subdevice #4
> >   Subdevice #5: subdevice #5
> >   Subdevice #6: subdevice #6
> >   Subdevice #7: subdevice #7
> > card 1: Loopback [Loopback], device 1: Loopback PCM [Loopback PCM]
> >   Subdevices: 8/8
> >   Subdevice #0: subdevice #0
> >   Subdevice #1: subdevice #1
> >   Subdevice #2: subdevice #2
> >   Subdevice #3: subdevice #3
> >   Subdevice #4: subdevice #4
> >   Subdevice #5: subdevice #5
> >   Subdevice #6: subdevice #6
> >   Subdevice #7: subdevice #7
> > 
> > Thank you,
> 
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


--=-WvE2BNePe1mGT6TBTaC6
Content-Disposition: attachment; filename="refine_fail.txt"
Content-Type: text/plain; name="refine_fail.txt"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

srefine 'loop_44100_16' (client)
ACCESS:  MMAP_INTERLEAVED MMAP_NONINTERLEAVED
FORMAT:  S16_LE S32_LE
SUBFORMAT:  STD
SAMPLE_BITS: ALL
FRAME_BITS: ALL
CHANNELS: 2
RATE: 192000
PERIOD_TIME: (20 682667)
PERIOD_SIZE: [4 131072]
PERIOD_BYTES: ALL
PERIODS: [2 32]
BUFFER_TIME: (41 1365334)
BUFFER_SIZE: [8 262144]
BUFFER_BYTES: ALL
TICK_TIME: ALL
srefine 'loop_44100_16' (slave)
ACCESS:  MMAP_INTERLEAVED MMAP_NONINTERLEAVED MMAP_COMPLEX
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: ALL
FRAME_BITS: ALL
CHANNELS: 2
RATE: [48000 48001)
PERIOD_TIME: (20 682667)
PERIOD_SIZE: ALL
PERIOD_BYTES: ALL
PERIODS: ALL
BUFFER_TIME: ALL
BUFFER_SIZE: [2 65538)
BUFFER_BYTES: ALL
TICK_TIME: ALL
REFINE called:
ACCESS:  MMAP_INTERLEAVED MMAP_NONINTERLEAVED MMAP_COMPLEX
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: ALL
FRAME_BITS: ALL
CHANNELS: 2
RATE: [48000 48001)
PERIOD_TIME: (20 682667)
PERIOD_SIZE: ALL
PERIOD_BYTES: ALL
PERIODS: ALL
BUFFER_TIME: ALL
BUFFER_SIZE: [2 65538)
BUFFER_BYTES: ALL
TICK_TIME: ALL
refine done - result = -22


--=-WvE2BNePe1mGT6TBTaC6
Content-Disposition: attachment; filename="refine_success.txt"
Content-Type: text/plain; name="refine_success.txt"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

srefine 'loop_44100_16' (client)
ACCESS:  MMAP_INTERLEAVED MMAP_NONINTERLEAVED
FORMAT:  S16_LE S32_LE
SUBFORMAT:  STD
SAMPLE_BITS: ALL
FRAME_BITS: ALL
CHANNELS: 2
RATE: 192000
PERIOD_TIME: (20 682667)
PERIOD_SIZE: [4 131072]
PERIOD_BYTES: ALL
PERIODS: [2 32]
BUFFER_TIME: (41 1365334)
BUFFER_SIZE: [8 262144]
BUFFER_BYTES: ALL
TICK_TIME: ALL
srefine 'loop_44100_16' (slave)
ACCESS:  MMAP_INTERLEAVED MMAP_NONINTERLEAVED MMAP_COMPLEX
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: ALL
FRAME_BITS: ALL
CHANNELS: 2
RATE: [48000 48001)
PERIOD_TIME: (20 682667)
PERIOD_SIZE: ALL
PERIOD_BYTES: ALL
PERIODS: ALL
BUFFER_TIME: ALL
BUFFER_SIZE: [2 65538)
BUFFER_BYTES: ALL
TICK_TIME: ALL
REFINE called:
ACCESS:  MMAP_INTERLEAVED MMAP_NONINTERLEAVED MMAP_COMPLEX
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: ALL
FRAME_BITS: ALL
CHANNELS: 2
RATE: [48000 48001)
PERIOD_TIME: (20 682667)
PERIOD_SIZE: ALL
PERIOD_BYTES: ALL
PERIODS: ALL
BUFFER_TIME: ALL
BUFFER_SIZE: [2 65538)
BUFFER_BYTES: ALL
TICK_TIME: ALL
refine done - result = 0

--=-WvE2BNePe1mGT6TBTaC6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-WvE2BNePe1mGT6TBTaC6--
