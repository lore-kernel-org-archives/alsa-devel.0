From: Francisco Moraes <fmoraes@nc.rr.com>
Subject: Rate or Plug plugin problem when converting rate down
Date: Thu, 08 Jul 2004 19:58:36 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40EDDFAC.9000201@nc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Whenever I use plug, plughw or rate plugins to convert a stream into a 
lower frequency, I get cracks in the sound output.

I am attaching a dump of aplay -v with the rate plugin being used.

Any ideas of what can be wrong? I've tried even 24000 which is half of 
the default frequency of the emu10k1x card, but it still causes the problem.

Francisco

Plug PCM: Rate conversion PCM (48000, sformat=S16_LE)
Its setup is:
stream       : CAPTURE
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 3763
period_size  : 1881
period_time  : 42666
tick_time    : 10000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 1881
xfer_align   : 1881
start_threshold  : 1
stop_threshold   : 3763
silence_threshold: 0
silence_size : 0
boundary     : 986447872
Slave: Hardware PCM card 0 'Dell Sound Blaster Live!' device 0 subdevice 0
 
Its setup is:
stream       : CAPTURE
access       : MMAP_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 48000
exact rate   : 48000 (48000/1)
msbits       : 16
buffer_size  : 4096
period_size  : 2048
period_time  : 42666
tick_time    : 10000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 2048
xfer_align   : 2048
start_threshold  : 1
stop_threshold   : 4096
silence_threshold: 0
silence_size : 0
boundary     : 1073741824




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
