From: Giuliano Pochini <pochini@shiny.it>
Subject: How to debug ?
Date: 01 Apr 2003 22:48:51 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1049237332.26708.30.camel@Jay>
Mime-Version: 1.0
Content-Type: text/plain
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


My driver do not work anymore with xmms (alsa-xmms plugin) and
alsaplayer. I have no idea when that happened because I always use
alsa-utils to make tests and I made a lot of changes since the last time
I tested xmms and ap. Alsaplayer writes this:

[Giu@Jay Giu]$ alsaplayer 
ALSA lib pcm_mmap.c:351:(snd_pcm_mmap) mmap failed: Invalid argument
Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_BE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: (23219 23220)
PERIOD_SIZE: 1024
PERIOD_BYTES: 4096
PERIODS: 8
BUFFER_TIME: (185759 185760)
BUFFER_SIZE: 8192
BUFFER_BYTES: 32768
TICK_TIME: 10000

But the ll driver writelogs:

pcm_hw_params (bufsize=32768B periods=16 persize=2048B)
pcm_hw_params ok
Prepare rate=44100 format=2 channels=2
Prepare ok
(Format 2 is S16_LE).

Xmms says "sample format not available:invalid argument". My driver do
not report any failure, so the error comes from the middle layer or from
alsa-lib. How can I debug it ? I'm using 0.9.2 release.


Bye.




-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
