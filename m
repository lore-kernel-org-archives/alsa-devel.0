From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Memory problems are back with SB Live!
Date: Tue, 19 Nov 2002 21:55:16 +0000 (GMT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021119215516.8350.qmail@web40606.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

Hi,

My box has now accumulated almost 3 weeks of uptime,
and so the ALSA memory problem is back again:

$ aplay /usr/lib/sounds/jungle_exit.wav 
Playing WAVE '/usr/lib/sounds/jungle_exit.wav' :
Signed 16 bit Little Endian, Rate 22050 Hz, Stereo
ALSA lib pcm_hw.c:297:(snd_pcm_hw_hw_params)
SNDRV_PCM_IOCTL_HW_PARAMS failed: Cannot allocate
memory
aplay: set_params:814: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 22050
PERIOD_TIME: 100000
PERIOD_SIZE: 2205
PERIOD_BYTES: 8820
PERIODS: 5
BUFFER_TIME: 500000
BUFFER_SIZE: 11025
BUFFER_BYTES: 44100
TICK_TIME: 10000

Is that patch you sent me to hack^Wfix this still
relevant, or will it make things worse? I've noticed a
few changes to these parts of the kernel drivers.

As an aside, my memory looks like this:
$ free -t
             total       used       free     shared   
buffers     cached
Mem:       1033544    1011004      22540          0   
  53776     728244
-/+ buffers/cache:     228984     804560
Swap:       498004       8168     489836
Total:     1531548    1019172     512376

Isn't Linux supposed to surrender disk-cache memory if
another process requests it? Surely *some* of that
1011004 KB cache must be usable!?

Chris

__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
