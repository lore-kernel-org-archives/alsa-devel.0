From: Nathan Gray <n8gray@caltech.edu>
Subject: RE: recording issues
Date: Thu, 02 Oct 2003 10:37:51 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <blhnpg$j1s$1@sea.gmane.org>
References: <200310011434.29210.n8gray@caltech.edu> <XFMail.20031002093600.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Giuliano Pochini wrote:

> 
> On 01-Oct-2003 Nathaniel Gray wrote:
>> My sound card uses different devices for capture (device 0) and playback
>> (device 1).  I have two issues with capture right now:
>> 
>> 1.  If I do something like:
>>       arecord -f dat -D hw:0,1 -d 5 foo.wav
>> it seems to record for much longer than 5 seconds.  In fact, "time
>> arecord..." tells me that it goes for 10 seconds.  If I then try to
>> play back the result with aplay:
> 
> Try aplay/arecord -v[vvvvvv] to see what parameters have been actually
> set. You can also put printk()'s in the driver to check what's going
> on. 

Well before going to printk's here's the -v output:

[n8gray@golux alsa]$ arecord -f dat -D hw:0,1 -d 5 -v foo.wav
Recording WAVE 'foo.wav' : Signed 16 bit Little Endian, Rate 48000 Hz,
Stereo
Hardware PCM card 0 'Intel 82801CA-ICH3' device 1 subdevice 0

Its setup is:
stream       : CAPTURE
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 48000
exact rate   : 48000 (48000/1)
msbits       : 16
buffer_size  : 24000
period_size  : 6000
period_time  : 125000
tick_time    : 10000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 6000
xfer_align   : 6000
start_threshold  : 1
stop_threshold   : 24000
silence_threshold: 0
silence_size : 0
boundary     : 1572864000

[n8gray@golux alsa]$ aplay -v foo.wav
Playing WAVE 'foo.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
Plug PCM: Hardware PCM card 0 'Intel 82801CA-ICH3' device 0 subdevice 0

Its setup is:
stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 48000
exact rate   : 48000 (48000/1)
msbits       : 16
buffer_size  : 12000
period_size  : 6000
period_time  : 125000
tick_time    : 10000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 6000
xfer_align   : 6000
start_threshold  : 12000
stop_threshold   : 12000
silence_threshold: 0
silence_size : 0
boundary     : 1572864000

Could it be possible that RW_INTERLEAVED is incorrect since playback and
record are on different devices?

> Why are you using different devices for capture and playback ?

It's the way my card is designed.  Recording from hw:0,0 doesn't work.

> Perhaps it's a typo, but if capture is dev 0, you have to type
> 
> arecord -D hw:0,0

Yes, that was a typo.  Capture is device 1 and playback is device 0.

Thanks,
-Nathan

-- 
>>>-- Nathaniel Gray -- Caltech Computer Science ------>
>>>-- Mojave Project -- http://mojave.cs.caltech.edu -->



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
