From: "Tom Browne" <tbrowne@tbrowne.demon.co.uk>
Subject: Re: snd_pcm_writei not returning (?!?)
Date: Tue, 6 Apr 2004 11:44:00 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <024801c41bc4$12bc3240$0100a8c0@burpxp>
References: <Pine.HPX.4.33n.0404060944170.17488-100000@studcom.urz.uni-halle.de> <01d901c41bb6$988aaf40$0100a8c0@burpxp> <Pine.LNX.4.58.0404061114560.3153@pnote.perex-int.cz> <021d01c41bbd$b0a8fc10$0100a8c0@burpxp> <Pine.LNX.4.58.0404061213230.3153@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: Jaroslav Kysela <perex@suse.cz>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
>> Which gives threshold = 6552 from buffer=6553, period=3276...
>> exactly the same value as the code I was already using gives!  What
>> else am I missing from the garish red and yellow blocks of WinDiff?
> Then it really appears like a bug. Could you add snd_pcm_dump() call
> just before the block occurs?

Sure... but it doesn't seem to show any anomalies... I've also included the
matching status report from /proc...


state: PREPARED
trigger_time: 1081246741.324684000
tstamp      : 1081246792.298694000
delay       : 0
avail       : 8
avail_max   : 7229
-----
hw_ptr      : 0
appl_ptr    : 6545

--------------

Hardware PCM card 0 'Hoontech SoundTrack Audio DSP24' device 0 subdevice 0

Its setup is:
stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : S32_LE
subformat    : STD
channels     : 10
rate         : 88200
exact rate   : 88200 (88200/1)
msbits       : 24
buffer_size  : 6553
period_size  : 3276
period_time  : 37142
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 3276
xfer_align   : 1
start_threshold  : 6552
stop_threshold   : 6553
silence_threshold: 0
silence_size : 0
boundary     : 1717829632


>> Why does changing to mmap writes make the blocking problem go away?
>> And as I said, the problem only has been made to occur at 88.2 and
>> 96K sampling rates...
> mmap does never block

That'd explain why it doesn't halt like snd_pcm_writei, then... :)

... but if it was having to throw away data, surely wouldn't it drop out
when I swap in mmap?  Because it doesn't... snd_pcm_mmap_writei *seems* to
work perfectly...

I'm suspecting an "off by one" calculation error somewhere.

- Tom.



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
