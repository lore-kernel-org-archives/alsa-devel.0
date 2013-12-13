From: Olivier Langlois <olivier@trillion01.com>
Subject: Re: need help with loopback driver
Date: Fri, 13 Dec 2013 00:12:02 -0500
Message-ID: <1386911522.753.43.camel@Wailaba2>
References: <1386743591.753.9.camel@Wailaba2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from alt-proxy11.mail.unifiedlayer.com
 (alt-proxy11.mail.unifiedlayer.com [74.220.211.241])
 by alsa0.perex.cz (Postfix) with SMTP id 54DC62610D3
 for <alsa-devel@alsa-project.org>; Fri, 13 Dec 2013 06:12:08 +0100 (CET)
Received: from [173.179.63.169] (port=38720 helo=[192.168.1.104])
 by box610.bluehost.com with esmtpsa (TLSv1:RC4-SHA:128) (Exim 4.80)
 (envelope-from <olivier@trillion01.com>) id 1VrL2j-0007iH-IF
 for alsa-devel@alsa-project.org; Thu, 12 Dec 2013 22:12:05 -0700
In-Reply-To: <1386743591.753.9.camel@Wailaba2>
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

I did a small experiment or maybe it was just luck but. I am getting the
error messages on the playback side if I launch the playback side before
the capture side.

By reversing the order, that is launch arecord before speaker-test, the
errors go away but. ALSA forces me to match the sampling rate of the
capture side:

lano1106@whippet2 ~ $ arecord -Dloop_capture -f S16_LE -c2 -r 44100
alsa.wav
Recording WAVE 'alsa.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Stereo

lano1106@whippet2 ~/dev/alsa-lib.git $ speaker-test -Dsplit -c8 -r192000
-F S32_LE

speaker-test 1.0.27.2

Playback device is split
Stream parameters are 192000Hz, S32_LE, 8 channels
Using 16 octaves of pink noise
Rate set to 192000Hz (requested 192000Hz)
Buffer size range from 296 to 131060
Period size range from 148 to 65476
Using max buffer size 131060
Periods = 4
Unable to set nperiods 4 for playback: Invalid argument
Setting of hwparams failed: Invalid argument
lano1106@whippet2 ~/dev/alsa-lib.git :( $ speaker-test -Dsplit -c8
-r44100 -F S32_LE

speaker-test 1.0.27.2

Playback device is split
Stream parameters are 44100Hz, S32_LE, 8 channels
Using 16 octaves of pink noise
Rate set to 44100Hz (requested 44100Hz)
Buffer size range from 32 to 131072
Period size range from 16 to 65536
Using max buffer size 131072
Periods = 4
was set period_size = 32768
was set buffer_size = 131072
 0 - Front Left
 4 - Center
 1 - Front Right
^C 7 - Side Right
 3 - Rear Right
 2 - Rear Left
 6 - Side Left
 5 - LFE
Time per period = 4.752270

Am I abusing the plug type plugin? I tough that it was suppose to adapt
the source params with the sink expected params.

On Wed, 2013-12-11 at 01:33 -0500, Olivier Langlois wrote:
> Hi,
> 
> I am trying to split a pcm stream and send it to my sound card and send
> a downmixed/downsampled copy to the playback device of the loopback
> card.
> 
> I am using speaker-test to test my config. the sound goes to the
> speakers and I am able to record the downmixed signal through the
> loopback capture device but I am seeing a bunch of error messages in the
> speaker-test output which makes me doubt that there is maybe something
> wrong in what I am doing.
> 
> So I am asking help from the experts:
> 
> My conf:
> 
> pcm.loop_44100_16 {
>     type plug
>     slave {
>        pcm "hw:1,0,0"
>        format S16_LE
>        rate 44100
>     }
> }
> 
> pcm.loop_capture {
>     type hw
>     card 1
>     device 1
>     subdevice 0
> }
> 
> pcm.split {
>     type plug
>     slave.pcm {
>         type multi
>         slaves {
>             a { channels 8 pcm "hdmi:0,0" } # hdmi output
>             b { channels 2 pcm "loop_44100_16" } # loopback record
>         }
>         bindings {
>           0 { slave a channel 0 } # Front Left
>           1 { slave a channel 1 } # Front Right
>           2 { slave a channel 2 } # Rear  Left
>           3 { slave a channel 3 } # Rear right
>           4 { slave a channel 4 } # center
>           5 { slave a channel 5 } # LFE
>           6 { slave a channel 6 } # Side Left
>           7 { slave a channel 7 } # Side right
>           8 { slave b channel 0 } # left
>           9 { slave b channel 1 } # right
>         }
>     }
>     ttable [
> [ 1 0 0 0 0 0 0 0 0.38 0    ] # Front left
> [ 0 1 0 0 0 0 0 0 0    0.38 ] # Front right
> [ 0 0 1 0 0 0 0 0 0.22 0    ] # Rear left
> [ 0 0 0 1 0 0 0 0 0    0.22 ] # Rear right
> [ 0 0 0 0 1 0 0 0 0.18 0.18 ] # center
> [ 0 0 0 0 0 1 0 0 0    0    ] # LFE
> [ 0 0 0 0 0 0 1 0 0.22 0    ] # Side left
> [ 0 0 0 0 0 0 0 1 0    0.22 ] # Side right
> ]
> }
> 
> 
> $ speaker-test -Dsplit -c8 -r192000 -F S32_LE
> 
> speaker-test 1.0.27.2
> 
> Playback device is split
> Stream parameters are 192000Hz, S32_LE, 8 channels
> Using 16 octaves of pink noise
> Rate set to 192000Hz (requested 192000Hz)
> Buffer size range from 296 to 131072
> Period size range from 148 to 65536
> Using max buffer size 131072
> Periods = 4
> was set period_size = 65536
> was set buffer_size = 131072
>  0 - Front Left
> Write error: -32,Broken pipe
> Can't recovery from underrun, prepare failed: Device or resource busy
> Write error: -32,Broken pipe
> Can't recovery from underrun, prepare failed: Device or resource busy
>  4 - Center
> Write error: -32,Broken pipe
> Write error: -32,Broken pipe
> Can't recovery from underrun, prepare failed: Device or resource busy
> Write error: -32,Broken pipe
> Can't recovery from underrun, prepare failed: Device or resource busy
> Write error: -32,Broken pipe
> Can't recovery from underrun, prepare failed: Device or resource busy
>  1 - Front Right
> Write error: -32,Broken pipe
> Write error: -32,Broken pipe
> Can't recovery from underrun, prepare failed: Device or resource busy
> Write error: -32,Broken pipe
> Can't recovery from underrun, prepare failed: Device or resource busy
> Write error: -32,Broken pipe
> Can't recovery from underrun, prepare failed: Device or resource busy
>  7 - Side Right
> Write error: -32,Broken pipe
> Write error: -32,Broken pipe
> Can't recovery from underrun, prepare failed: Device or resource busy
> 
> lano1106@whippet2 ~ $ aplay -l
> **** List of PLAYBACK Hardware Devices ****
> card 0: HDMI [HDA ATI HDMI], device 3: HDMI 0 [HDMI 0]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> card 0: HDMI [HDA ATI HDMI], device 7: HDMI 1 [HDMI 1]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> card 0: HDMI [HDA ATI HDMI], device 8: HDMI 2 [HDMI 2]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> card 0: HDMI [HDA ATI HDMI], device 9: HDMI 3 [HDMI 3]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> card 0: HDMI [HDA ATI HDMI], device 10: HDMI 4 [HDMI 4]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> card 0: HDMI [HDA ATI HDMI], device 11: HDMI 5 [HDMI 5]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> card 1: Loopback [Loopback], device 0: Loopback PCM [Loopback PCM]
>   Subdevices: 8/8
>   Subdevice #0: subdevice #0
>   Subdevice #1: subdevice #1
>   Subdevice #2: subdevice #2
>   Subdevice #3: subdevice #3
>   Subdevice #4: subdevice #4
>   Subdevice #5: subdevice #5
>   Subdevice #6: subdevice #6
>   Subdevice #7: subdevice #7
> card 1: Loopback [Loopback], device 1: Loopback PCM [Loopback PCM]
>   Subdevices: 8/8
>   Subdevice #0: subdevice #0
>   Subdevice #1: subdevice #1
>   Subdevice #2: subdevice #2
>   Subdevice #3: subdevice #3
>   Subdevice #4: subdevice #4
>   Subdevice #5: subdevice #5
>   Subdevice #6: subdevice #6
>   Subdevice #7: subdevice #7
> 
> Thank you,
