From: Torrey Hoffman <thoffman@arnor.net>
Subject: Re: ALSA doesn't work with XMMS - or alsaplayer either
Date: Mon, 19 Jan 2004 16:33:28 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1074558808.22882.87.camel@moria.arnor.net>
References: <1074549141.22882.71.camel@moria.arnor.net>
	 <1074555723.22882.75.camel@moria.arnor.net>
	 <20040119161817.5ceac577.rpav@mephle.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040119161817.5ceac577.rpav@mephle.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ryan Pavlik <rpav@mephle.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Thanks for the tip... before this I didn't know about .asoundrc files --
I just read through the on-line documentation on them, looks cool! 

This sort of flexibility is the good thing about ALSA.  The bad thing is
it still doesn't work, but OSS does :-/

I created a .asoundrc following your model, and configured the xmms alsa
plugin to use the virtual "cdaudio" device as suggested.

It does the same things as configuring the xmms alsa plugin to use
plughw:1,0 -- just repetitive noise, like a stuck CD.

(My card 0 is the motherboard onboard chip, which I'm not using, and
card 1 is the M-Audio)

The messages on the console are:


[thoffman@moria thoffman]$ xmms &
[1] 25442
[thoffman@moria thoffman]$ Message: alsa_setup_mixer
Message: alsa_setup_mixer: end
Message: Opening device
Message: alsa_setup
Message: output format: 7, rate: 44100, channels: 2
Message: Opening device: cdaudio
 
Opened ALSA card 1, Device 0, Subdevice 0
Message: Configuring device: cdaudio
 
Message: Attempting to set hardware format S16_LE
 
start_mode: DATA
xrun_mode: STOP
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 2205
xfer_align: 2205
silence_threshold: 0
silence_size: 0
boundary: 1717829632
Plug PCM: Route conversion PCM (sformat=S32_LE)
Transformation table:
0 <- 0
1 <- 1
2 <- none
3 <- none
4 <- none
5 <- none
6 <- none
7 <- none
8 <- none
9 <- none
Its setup is:
stream       : PLAYBACK
access       : MMAP_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 6553
period_size  : 2205
period_time  : 50000
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 2205
xfer_align   : 2205
start_threshold  : 1
stop_threshold   : 6553
silence_threshold: 0
silence_size : 0
boundary     : 1717829632
Slave: Hardware PCM card 1 'M Audio Audiophile 24/96' device 0 subdevice
0
 
Its setup is:
stream       : PLAYBACK
access       : MMAP_INTERLEAVED
format       : S32_LE
subformat    : STD
channels     : 10
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 24
buffer_size  : 6553
period_size  : 2205
period_time  : 50000
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 2205
xfer_align   : 2205
start_threshold  : 1
stop_threshold   : 6553
silence_threshold: 0
silence_size : 0
boundary     : 1717829632
Message: Device setup: buffer time: 148594, size: 26212 frames.
Message: bits per sample: 16; frame size: 4; Bps: 176
Message: alsa_setup_mixer
Message: alsa_setup_mixer: end
Message: Stream started
 
Message: Closing device
Message: Device closed
Label: Intel ICH5 Card: 0 Device: 0
Label: Intel ICH5 - IEC958 Card: 0 Device: 4
Label: ICE1712 multi Card: 1 Device: 0
Message: Opening device
Message: alsa_setup
Message: output format: 7, rate: 44100, channels: 2
Message: Opening device: cdaudio
 
Opened ALSA card 1, Device 0, Subdevice 0
Message: Configuring device: cdaudio
 
Message: Attempting to set hardware format S16_LE
 
start_mode: DATA
xrun_mode: STOP
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 2205
xfer_align: 2205
silence_threshold: 0
silence_size: 0
boundary: 1717829632
Plug PCM: Route conversion PCM (sformat=S32_LE)
Transformation table:
0 <- 0
1 <- 1
2 <- none
3 <- none
4 <- none
5 <- none
6 <- none
7 <- none
8 <- none
9 <- none
Its setup is:
stream       : PLAYBACK
access       : MMAP_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 6553
period_size  : 2205
period_time  : 50000
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 2205
xfer_align   : 2205
start_threshold  : 1
stop_threshold   : 6553
silence_threshold: 0
silence_size : 0
boundary     : 1717829632
Slave: Hardware PCM card 1 'M Audio Audiophile 24/96' device 0 subdevice
0
 
Its setup is:
stream       : PLAYBACK
access       : MMAP_INTERLEAVED
format       : S32_LE
subformat    : STD
channels     : 10
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 24
buffer_size  : 6553
period_size  : 2205
period_time  : 50000
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 2205
xfer_align   : 2205
start_threshold  : 1
stop_threshold   : 6553
silence_threshold: 0
silence_size : 0
boundary     : 1717829632
Message: Device setup: buffer time: 148594, size: 26212 frames.
Message: bits per sample: 16; frame size: 4; Bps: 176
Message: alsa_setup_mixer
Message: alsa_setup_mixer: end
Message: Stream started
 
Message: alsa_pause
Message: Stream started
 
Message: alsa_pause
Message: Stream started
 
Message: Closing device
Message: Device closed
 


On Mon, 2004-01-19 at 16:18, Ryan Pavlik wrote:
> On Mon, 19 Jan 2004 15:42:03 -0800
> Torrey Hoffman <thoffman@arnor.net> wrote:
> 
> > I can now confirm this is an ALSA problem, not just an XMMS problem:
> > alsaplayer doesn't work with this driver either.
> > 
> > [thoffman@moria thoffman]$ alsaplayer -d hw:1:0 12.mp3
> > ALSA lib pcm_hw.c:1142:(_snd_pcm_hw_open) Invalid value for card
> > snd_pcm_open: No such device (hw:1:0)
> > Failed to initialize plugin!
> > Failed to register plugin: /usr/lib/alsaplayer/output/libalsa_out.so
> > Failed to load output plugin "alsa". Trying defaults.
> > 
> > So... I haven't found any way to play an MP3 file on my M-Audio card
> > without using OSS...
> 
> I've got an m-audio delta 44, you probably just need to use the xmms
> ALSA plugin and tell it to use an ALSA plugin or whatever:
> 
> My .asoundrc:
> 
>     pcm.ice1712 {
>         type hw
>         card 0
>         device 0
>     }
>     
>     ctl.ice1712 {
>         type hw
>         card 0
>     }
>     
>     pcm.cdaudio {
>         type plug
>         slave {
>             pcm ice1712
>         }
>     }
> 
> Now in the xmms plugin where it says 'Audio device:' followed by
> '[ ] User defined:', check that, and enter 'cdaudio' in the box.
> After that it works fine for me.
> 
> Most other ALSA stuff should follow similarly; try -d cdaudio with
> alsaplayer; with mplayer I use '-ao alsa9:cdaudio', etc.
> 
> hth,
-- 
Torrey Hoffman <thoffman@arnor.net>



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
