From: Laurent Georget <lgeorget2@club-internet.fr>
Subject: level plugin problem with cvs
Date: Sun, 02 Mar 2003 22:50:07 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E627C8F.2010901@club-internet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi!
	It seems  the Alsa level scope plugins fails with recent alsa cvs .
(2 level plugins have the same problem:  the one from Abramo Bagnara , 
and ameter :
http://perso.club-internet.fr/lgeorget/ameter.html
)

	There is no problem with 0.9rc7 (and installing alsa-lib-0.9rc7 while 
keeping
alsa-driver from cvs, solves the problem ) .

	It fails when using low buffer size, necessary for multitrack recording .
I first saw the problem with Glame but it exists also with aplay
( see below for the error messsage ) .

	The error occures often but randomely , except when clicking somewhere in
another window : this always produces the error.

	It is not related to xruns, as sometimes aplay reports xrun but does 
not fail .

	There is no error when using default  plugin , or default buffer size.

	Looking at  pcm_meter.c , the following line is added in cvs:
pcm->poll_events = slave->poll_events;
So I tried  in non blocking mode (aplay -N ... ) : then it works
It would be of course much better if it could work in standard mode .

	(This is with Mandrake 9.)

Any advice highly appreciated . ( Including that this problem cannot be 
solved !)


Laurent


aplay -D level -B 10000 -v  sound.wav

Playing WAVE 'sound.wav' : Signed 16 bit Little Endian, Rate 44100
Hz, Stereo
Meter PCM
Its setup is:
stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 441
period_size  : 110
period_time  : 2494
tick_time    : 10000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 110
xfer_align   : 110
start_threshold  : 440
stop_threshold   : 441
silence_threshold: 0
silence_size : 0
boundary     : 1849688064
Slave: Plug PCM: Hardware PCM card 0 'Ensoniq AudioPCI' device 0 subdevice 0

aplay: pcm_write:1014: write error: Input/output error





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
