From: Flo Gleixner <flo@bier.homeip.net>
Subject: Problem recording with via 8235
Date: Fri, 23 Jul 2004 16:52:23 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.60.0407231650160.25456@octopus.goldach.test>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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


Sorry for crossposting, but this problem is probably more for the devels.

Thanks for your time.

Flo

---------- Forwarded message ----------
Date: Thu, 22 Jul 2004 00:51:12 +0200 (CEST)
From: Flo Gleixner <flo@bier.homeip.net>
To: alsa-user@lists.sourceforge.net
Subject: [Alsa-user] Problem recording with via 8235


Hi,

does somebody know what i'm doing wrong:

arecord -vv & while true ; do date ; sleep 1 ; done
RIFF$_WAVEfmt @data_Recording WAVE 'stdout' : Unsigned 8 bit, Rate 8000 Hz, 
Mono
Plug PCM: Hardware PCM card 0 'VIA 8235' device 0 subdevice 0

Its setup is:
stream       : CAPTURE
access       : RW_INTERLEAVED
format       : U8
subformat    : STD
channels     : 1
rate         : 8000
exact rate   : 8000 (8000/1)
msbits       : 8
buffer_size  : 4000
period_size  : 1000
period_time  : 125000
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 1000
xfer_align   : 1000
start_threshold  : 1
stop_threshold   : 4000
silence_threshold: 0
silence_size : 0
boundary     : 2097152000
[1] 4146
Tue Jul 20 00:27:17 CEST 2004
Tue Jul 20 00:27:18 CEST 2004
Tue Jul 20 00:27:19 CEST 2004
Tue Jul 20 00:27:20 CEST 2004
Tue Jul 20 00:27:21 CEST 2004
Tue Jul 20 00:27:22 CEST 2004
Tue Jul 20 00:27:23 CEST 2004
Tue Jul 20 00:27:24 CEST 2004
Tue Jul 20 00:27:25 CEST 2004
Tue Jul 20 00:27:26 CEST 2004
arecord: pcm_read:1164: read error: Input/output error
[1]+  Exit 1                  arecord -vv
Tue Jul 20 00:27:27 CEST 2004
Tue Jul 20 00:27:28 CEST 2004


If i strace arecord, i see this:

....
open("/dev/snd/pcmC0D0c", O_RDWR)       = 5
....
ioctl(5, 0xc25c4111, 0xbffff384)        = 0
ioctl(5, 0xc0684113, 0xbfffef10)        = 0
ioctl(5, 0x4140, 0x4002d278)            = 0
--- next one takes 10 secs. ---
ioctl(5, 0x800c4151, 0xbffff5b0)        = -1 EIO (Input/output error)
write(2, "arecord: pcm_read:1164: ", 24arecord: pcm_read:1164: ) = 24
write(2, "read error: Input/output error", 30read error: Input/output error) = 
30


aplay works as far as i see. I use Mandrake 10.0 which uses alsa 1.0.2

Another problem i have: unreal tournament plays sounds in double speed.

Thanks for the help!

Flo




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
