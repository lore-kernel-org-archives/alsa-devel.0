From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: dmix vs alsaplayer [was jackd, zynaddsubfx and iiwusynth]
Date: Tue, 04 Mar 2003 03:27:12 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E639E80.3070506@boosthardware.com>
References: <NDBBLGIKBJENLAMOLFHGAEIABJAB.mknecht@controlnet.com> <200303031203.36434.donburton@sbcglobal.net>
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
To: linux-audio-user@music.columbia.edu, alsaplayer-devel@lists.tartarus.org, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Levi Burton wrote:

> Has anyone tried the dmix plugin thats part of alsa rc8?  This looks 
> interesting, but im scared if I install rc8, I will be bitten by that 
> alsa-lib bug again.
> 

I was fscking around with it on Saturday. So far I have managed to use 
multiple instances of aplay but other apps like alsaplayer bork at it. I 
have yet to figure out why but I think I should probably submit a bug 
report somewhere.

I had to remove /dev/dsp otherwise alsaplayer will use the oss drivers.

Both of these commands give the same error.

$ alsaplayer -o alsa -d "plug:'dmix:RATE=44100'" track_8.wav
$ alsaplayer -o alsa -d plug:\'dmix:SLAVE=\"hw:2,1\",RATE=44100\' 
track_8.wav

--------
error on set_period_size (512)
Unavailable hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: (125011 125012)
PERIOD_SIZE: 5513
PERIOD_BYTES: 22052
PERIODS: (2 3)
BUFFER_TIME: (371519 371520)
BUFFER_SIZE: 16384
BUFFER_BYTES: 65536
TICK_TIME: ALL
error on set_period_size (1024)
Unavailable hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: (125011 125012)
PERIOD_SIZE: 5513
PERIOD_BYTES: 22052
PERIODS: (2 3)
BUFFER_TIME: (371519 371520)
BUFFER_SIZE: 16384
BUFFER_BYTES: 65536
TICK_TIME: ALL
failed to configure output device...trying OSS
error opening /dev/dsp

I could not find a suitable output module on your
system. Make sure they're in "/usr/local/lib/alsaplayer/output/".
Use the -o parameter to select one.

failed to load output plugin (alsa). exitting...
--------

-- 
Patrick Shirkey - Boost Hardware Ltd.
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

Being on stage with the band in front of crowds shouting, "Get off! No! 
We want normal music!", I think that was more like acting than anything 
I've ever done.

Goldie, 8 Nov, 2002
The Scotsman



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
