From: Andreas Bulling <uek32z@phoenix.hadiko.de>
Subject: Re: problems with Terratec Aureon Sky 5.1
Date: Sun, 14 Mar 2004 18:33:49 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040314173349.GA25009@phoenix.hadiko.de>
References: <20040314164136.GA24447@phoenix.hadiko.de> <Pine.LNX.4.58.0403141751370.3332@pnote.perex-int.cz> <20040314171747.GA24849@phoenix.hadiko.de> <Pine.LNX.4.58.0403141819350.3332@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403141819350.3332@pnote.perex-int.cz>
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

On Sun, Mar 14, 2004 at 06:21:32PM +0100, Jaroslav Kysela wrote:
| > Hm... I tried that but it doesn't work - still sound only out of the front speakers with
| > xmms and the duplicate output device. Do I need anything else?
| 
| If you have volumes up, then it should work.
| 
| What does say command 'aplay -v -Dduplicate <somefile>'?

------------------------------
andreas@phoenix andreas $ aplay -v -Dduplicate /usr/kde/3.2/share/sounds/KDE_Startup_new.wav
Playing WAVE '/usr/kde/3.2/share/sounds/KDE_Startup_new.wav' : Signed 16 bit Little Endian, Rate 22050 Hz, Stereo
Plug PCM: Linear conversion PCM (S32_LE)
Its setup is:
stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 22050
exact rate   : 22050 (22050/1)
msbits       : 16
buffer_size  : 11024
period_size  : 2756
period_time  : 124988
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 2756
xfer_align   : 2756
start_threshold  : 11024
stop_threshold   : 11024
silence_threshold: 0
silence_size : 0
boundary     : 1444937728
Slave: Route conversion PCM
Transformation table:
0 <- 0
1 <- 1
2 <- 4
3 <- 5
4 <- 2
5 <- 3
Its setup is:
stream       : PLAYBACK
access       : MMAP_INTERLEAVED
format       : S32_LE
subformat    : STD
channels     : 2
rate         : 22050
exact rate   : 22050 (22050/1)
msbits       : 32
buffer_size  : 11024
period_size  : 2756
period_time  : 124988
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 2756
xfer_align   : 2756
start_threshold  : 11024
stop_threshold   : 11024
silence_threshold: 0
silence_size : 0
boundary     : 1444937728
Slave: Hardware PCM card 0 'Terratec Aureon 5.1-Sky' device 0 subdevice 0

Its setup is:
stream       : PLAYBACK
access       : MMAP_INTERLEAVED
format       : S32_LE
subformat    : STD
channels     : 2
rate         : 22050
exact rate   : 22050 (22050/1)
msbits       : 24
buffer_size  : 11024
period_size  : 2756
period_time  : 124988
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 2756
xfer_align   : 2756
start_threshold  : 11024
stop_threshold   : 11024
silence_threshold: 0
silence_size : 0
boundary     : 1444937728

-----------------------------------------

To tell the truth, I'm totally confused by all the
different postings and answers, now...
*headshaking*

To summarize (please correct me if I'm wrong):
If I have a stereo source I have to mix up or
route the two channels to all of the six channels. 
This is done with the route and ttable config I
posted and should also be possible with your
duplicate setup.

If I have a real surround source I have to
use the surround51 device, perhaps also with
your duplicate config

???

Thanks a lot for your patience!
Andreas


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
