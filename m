From: "random.bits" <random.bits@rogers.com>
Subject: Re: Re: alsa driver, repeat playback of buffer contents
Date: Tue, 15 Mar 2005 16:34:28 -0500
Message-ID: <200503151634.28911.random.bits@rogers.com>
References: <200503141530.20339.random.bits@rogers.com> <200503151349.02376.random.bits@rogers.com> <Pine.LNX.4.58.0503151949320.21135@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.58.0503151949320.21135@pnote.perex-int.cz>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Sorry, I replied to your earlier message before seeing 
this message.

I worked my way through the documentation looking at 
no-xrun mode and stop_threshold values. 

When I read the stop_threshold after setting the buffer 
to 471 frames (length of pcm stream I want to repeat 
is 1884 bytes, 11025 sampling, the concept of periods 
is confusing me at the moment, but I used 1), the 
stop_threshold is also set to 471. I then read the 
boundary value and its set to 1975517184. 

If I understand correctly, if I set the stop_threshold 
to this value, the sound should continue to repeat.

It does not repeat the sound. Here is my debug output, 
it shows initial and final settings as the program is 
set up. Then the data is sent to the buffer for 
playback.  Followed by a stream status output. I can 
post the source code if you want, but I figure I made 
a mistake with the setup.

<debug output from alsarepeat.c, for pcm device "hw">
On opening the device, the hw parameters are:
ACCESS:  MMAP_INTERLEAVED RW_INTERLEAVED
FORMAT:  S16_LE S32_LE
SUBFORMAT:  STD
SAMPLE_BITS: [16 32]
FRAME_BITS: [32 64]
CHANNELS: 2
RATE: [8000 48000]
PERIOD_TIME: (83 2048000]
PERIOD_SIZE: [4 16384]
PERIOD_BYTES: [32 131072]
PERIODS: [1 1024]
BUFFER_TIME: (83 2048000]
BUFFER_SIZE: [4 16384]
BUFFER_BYTES: [32 65536]
TICK_TIME: 1000

HW parameters are now:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 11025
PERIOD_TIME: (42721 42722)
PERIOD_SIZE: 471
PERIOD_BYTES: 1884
PERIODS: 1
BUFFER_TIME: (42721 42722)
BUFFER_SIZE: 471
BUFFER_BYTES: 1884
TICK_TIME: 1000

The initial software parameters are:
start_mode: DATA
xrun_mode: STOP
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 471
xfer_align: 471
silence_threshold: 0
silence_size: 0
boundary: 1975517184

SW parameters are now set to:
start_mode: DATA
xrun_mode: NONE
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 471
xfer_align: 471
silence_threshold: 0
silence_size: 0
boundary: 1975517184

Stream status is
state       : RUNNING
trigger_time: 1110922148.974638000
tstamp      : 1110922149.272647000
delay       : 470
avail       : 1
avail_max   : 472



On Tuesday 15 March 2005 13:49, Jaroslav Kysela wrote:
> On Tue, 15 Mar 2005, random.bits wrote:
> > How can I get the hardware to continue to play
> > using the data in the ring buffer?
>
> Use no-xrun mode (set stop_threshold to boundary).
>
> 						Jaroslav
>
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SUSE Labs
>
>
> ----------------------------------------------------
>--- SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT
> Products from real users. Discover which products
> truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=cl
>ick _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-de
>vel


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
