From: Torrey Hoffman <thoffman@arnor.net>
Subject: Re: Problem with supported PCM formats in ice1712
	driver
Date: Mon, 19 Jan 2004 10:42:26 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1074537746.22882.12.camel@moria.arnor.net>
References: <1074305741.6251.7.camel@moria.arnor.net>
	 <1074341307.3405.9.camel@terminal124.gozu.lan>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from devil.servak.biz (devil.servak.biz [209.124.81.2])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id TAA00308
	for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2004 19:46:59 +0100
In-Reply-To: <1074341307.3405.9.camel@terminal124.gozu.lan>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Ronny V. Vindenes" <s864@ii.uib.no>
Cc: ALSA Development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 2004-01-17 at 04:08, Ronny V. Vindenes wrote:
> On Sat, 2004-01-17 at 03:15, Torrey Hoffman wrote:
> > I've got an M-Audio Audiophile 2496 and am running linux 2.6.1-mm3
> > (which includes ALSA 1.0.1).
...
 
> > Message: alsa_setup_mixer
> > Message: alsa_setup_mixer: end
> > Message: Opening device
> > Message: alsa_setup
> > Message: output format: 7, rate: 44100, channels: 2
> > Message: Opening device: hw:0,0
> > Opened ALSA card 0, Device 0, Subdevice 0
> > Message: Configuring device: hw:0,0
> > Message: Attempting to set hardware format S16_LE
> > Message: Attempting to set next hardware format S16_LE
> > Message: Attempting to set next hardware format S16_BE
> > Message: Attempting to set next hardware format U8
> > ** WARNING **: alsa_setup(): Sample format not available for playback:
> > Invalid argument
> > Message: Closing device
> > Message: Device closed
> > --
> 
> > This seems to explain why the XMMS Alsa plugin fails... apparently only
> > "Signed 32 bit Little Endian" is supported by this driver???
> > 
> 
> The Envy24 hardware only supports 24bit in 32bit little-endian format,
> if you want other formats you have to use the plughw: device.

Thanks for the information.  I tried specifying "plughw:1,0" as the
playback device in the XMMS ALSA plugin, and now I do get sound from my
Audiophile 2496... but it's just noise.  Specifically, when I start XMMS
playing, I get a repetitive burst of noise which repeats without
changing until I stop playback.

Here are the messages from XMMS while this happens:
Message: alsa_setup_mixer: end
Message: Opening device
Message: alsa_setup
Message: output format: 7, rate: 44100, channels: 2
Message: Opening device: plughw:1,0
 
Opened ALSA card 1, Device 0, Subdevice 0
Message: Configuring device: plughw:1,0
 
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

	
-- 
Torrey Hoffman <thoffman@arnor.net>



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
