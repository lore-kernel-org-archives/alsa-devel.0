From: Giuliano Pochini <pochini@shiny.it>
Subject: weird xrun problem
Date: Sat, 22 May 2004 12:38:55 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040522123855.12837e8d.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org



I'm getting a lot of xruns with some buffer/period sizes and it's perfectly
reproducible. It happens when the buffer is divided in two periods and the
second period is a bit smaller of the first one. For example:


[Giu@Jay Giu]$ aplay -v -B300000 -F150000 something.wav
Playing WAVE 'something.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
Plug PCM: Hardware PCM card 0 'Gina24' device 0 subdevice 0

Its setup is:
stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 13216
period_size  : 6624
period_time  : 150204
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 6624
xfer_align   : 6624
start_threshold  : 6624
stop_threshold   : 13216
silence_threshold: 0
silence_size : 0
boundary     : 1732247552
xrun!!! (at least 0.000 ms long)
Status:
state       : XRUN
trigger_time: 1085219431.336894000
tstamp      : 1085219431.336894000
delay       : 0
avail       : 13248
avail_max   : 13248


Period 0 is 6624 frames and Period 1 is 6592 frames long (32 frames
shorter). I put some debug code and this is the output for a the playback
test above:

May 22 11:54:22 localhost kernel: pcm_trigger start
May 22 11:54:22 localhost kernel: pointer=6656  period=1
May 22 11:54:22 localhost kernel: pcm_trigger stop
May 22 11:54:22 localhost kernel: Prepare
May 22 11:54:22 localhost kernel: pcm_trigger start
May 22 11:54:22 localhost kernel: pointer=6656  period=1
May 22 11:54:22 localhost kernel: pcm_trigger stop
May 22 11:54:22 localhost kernel: Prepare
May 22 11:54:22 localhost kernel: pcm_trigger start
May 22 11:54:22 localhost kernel: pointer=6656  period=1
May 22 11:54:23 localhost kernel: pcm_trigger stop
May 22 11:54:23 localhost kernel: Prepare
May 22 11:54:23 localhost kernel: pcm_trigger start

Note that I get an xrun after every period. Most xruns are 0ms long,
sometimes they are 1ms and there are no other values. Only 1 or 0.


If the periods have the same size or there are three or more periods it
works fine:

[Giu@Jay Giu]$ aplay -v -B200000 -F100000 something.wav

May 22 11:59:38 localhost kernel: pcm_hw_params ok
May 22 11:59:38 localhost kernel: Prepare
May 22 11:59:38 localhost kernel: pcm_trigger start
May 22 11:59:38 localhost kernel: pointer=4448  period=1
May 22 11:59:38 localhost kernel: pointer=32  period=0
May 22 11:59:38 localhost kernel: pointer=4448  period=1
May 22 11:59:38 localhost kernel: pointer=32  period=0
May 22 11:59:38 localhost kernel: pointer=4448  period=1
May 22 11:59:38 localhost kernel: pointer=32  period=0


(alsa-driver 1.0.4)

--
Giuliano.



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
