From: Raymond <rayau@netvigator.com>
Subject: Re: aplay - How to use device 3 of card 0 ?
Date: Mon, 07 Mar 2005 20:04:06 +0800
Message-ID: <422C4336.3090509@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

 >> What is the correct syntax for "aplay" to use device 3 of card 0 ?

 >AFAIK, it should be
 >aplay -d hw:0,3 file.wav



# aplay --verbose -d hw:0,3 piano.wav
Playing WAVE 'piano.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Mono
Plug PCM: Hardware PCM card 0 'au8830' device 0 subdevice 0

Its setup is:
stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 1
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 22528
period_size  : 2048
period_time  : 46439
tick_time    : 10000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 2048
xfer_align   : 2048
start_threshold  : 22528
stop_threshold   : 22528
silence_threshold: 0
silence_size : 0
boundary     : 1476395008



# aplay --verbose -d hw:0,1 piano.wav
Playing WAVE 'piano.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Mono
Plug PCM: Hardware PCM card 0 'au8830' device 0 subdevice 0

Its setup is:
stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 1
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 22528
period_size  : 2048
period_time  : 46439
tick_time    : 10000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 2048
xfer_align   : 2048
start_threshold  : 22528
stop_threshold   : 22528
silence_threshold: 0
silence_size : 0
boundary     : 1476395008



Is this a bug of "aplay" or au88x0 driver ?




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
