From: Sol <science@foxinternet.com>
Subject: Another alsa newbie seeks help
Date: 14 Sep 2003 19:02:58 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1063591377.3330.29.camel@localhost>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

I have been using the example "pcm.c" in the alsa-lib/test directory to
learn about alsa and my soundcard(audiophile 2496 ice1712).

I have found something strange that I do not understand. 
async_direct(mmap) method will produce no sound for my card.  However,
if I change the format to S32_LE in pcm.c and first specify 10 channels
using async method- then I get sound when I use the async_direct method
afterwards.

If I haven't confused myself writing this, it looks like this:

./pcm -c 10 -m async_direct
Playback device is plughw:0,0
Stream parameters are 44100Hz, S32_LE, 10 channels
Sine wave rate is 440.0000Hz
Using transfer method: async_direct

(No sound here)

./pcm -c 10 -m async
Playback device is plughw:0,0
Stream parameters are 44100Hz, S32_LE, 10 channels
Sine wave rate is 440.0000Hz
Using transfer method: async

(Sound plays)

./pcm -c 10 -m async_direct
Playback device is plughw:0,0
Stream parameters are 44100Hz, S32_LE, 10 channels
Sine wave rate is 440.0000Hz
Using transfer method: async_direct

(Sound plays)

I see the hw_params change from RW_INTERLEAVED to MMAP_INTERLEAVED.  Do
I need to specify my channels somewhere for the mmap to work correctly
with my card?  Am I smoking crack!?

Thanks,

Sol




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
