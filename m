From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: "Cannot allocate memory" problem with latest CVS
Date: Sun, 27 Oct 2002 18:05:41 +0000 (GMT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021027180541.43540.qmail@web40608.mail.yahoo.com>
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

The 'cannot allocate memory' problem has returned on
my machine:

$ aplay /usr/lib/sounds/ring.wav 
Playing WAVE '/usr/lib/sounds/ring.wav' : Unsigned 8
bit, Rate 22050 Hz, Mono
ALSA lib pcm_hw.c:297:(snd_pcm_hw_hw_params)
SNDRV_PCM_IOCTL_HW_PARAMS failed: Cannot allocate
memory
aplay: set_params:814: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  U8
SUBFORMAT:  STD
SAMPLE_BITS: 8
FRAME_BITS: 8
CHANNELS: 1
RATE: 22050
PERIOD_TIME: 100000
PERIOD_SIZE: 2205
PERIOD_BYTES: 2205
PERIODS: 5
BUFFER_TIME: 500000
BUFFER_SIZE: 11025
BUFFER_BYTES: 11025
TICK_TIME: 10000


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


$ aplay /usr/lib/sounds/star_trek_6_overture.au
Playing Sparc Audio
'/usr/lib/sounds/star_trek_6_overture.au' : Mu-Law,
Rate 8000 Hz, Mono
ALSA lib pcm_hw.c:297:(snd_pcm_hw_hw_params)
SNDRV_PCM_IOCTL_HW_PARAMS failed: Cannot allocate
memory
aplay: set_params:814: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  MU_LAW
SUBFORMAT:  STD
SAMPLE_BITS: 8
FRAME_BITS: 8
CHANNELS: 1
RATE: 8000
PERIOD_TIME: 125000
PERIOD_SIZE: 1000
PERIOD_BYTES: 1000
PERIODS: 4
BUFFER_TIME: 500000
BUFFER_SIZE: 4000
BUFFER_BYTES: 4000
TICK_TIME: 10000


$ free -t
             total       used       free     shared   
buffers     cached
Mem:       1033544    1020348      13196          0   
  30228     748684
-/+ buffers/cache:     241436     792108
Swap:       498004      10668     487336
Total:     1531548    1031016     500532


$ vmstat
   procs                      memory      swap        
 io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi  
 bo   in    cs us sy id
 2  0  0  10668  13096  30284 748728    0    0     1  
  3   10    14 97  3  0


I am using the snd-emu10k1 driver with a SB-Live!
card, on a 2.4.19-SMP box with 1 GB memory, so this
out-of-memory error is a bit of a mystery. Are there
any other statistics that would be useful? I expect
(hope!) that this error will disappear soon, so I'd
recommend a swift response, if required.

Cheers,
Chris



__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
