From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: usbaudio won't do 24-bit or 32-bit i/o, and won't
 do 96000 frames per second
Date: Fri, 06 Dec 2002 15:48:14 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DF0482E.8010109@boosthardware.com>
References: <Pine.HPX.4.33n.0212051549290.19058-100000@studcom.urz.uni-halle.de>
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
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "John S. Denker" <jsd@monmouth.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> John S. Denker wrote:
> 
>>Request #1: USB driver supporting 24-bit i/o.
>>Request #2: USB driver supporting 96000 frames per second.
> 
> 
> What you want is already supported by the snd-usb-audio driver. IIRC
> Patrick Shirkey reported that 24bit@96kHz works with the M-Audio Quattro.
> 

Actually I have just yesterday noticed a specific problem with the 24 
bit support.

Also you should know that the quattro only supports 24_3le which is 24 
bits, three bytes. This is contrary to possibly all other pro devices 
which support 24bits, four bytes or something like that. Meaning that 
you have to use a special bit depth just for the quattro. This could be 
the problem you are seeing.

Currently I am using the cvs from the 18 November. I will update and 
check again. I have initialised both pcms and I cannot record a signal 
through the first pcm hw:1,0 although arecord doesn't complain.

Using 24_3le,2,44100 I get a normal signal on the left (input 3) but 
maxed signal on the right (input 4). If I press in the input level 
button on the device input 3 is boosted (again normal operation) but 
input 4 is still maxed.

I have verified it is the same for 88200 and 96000hz too.

arecord will not work for 88200 or 96000 at 16 bit eg.

arecord -D hw:1,1 -c 2 -f s16_le -r 88200 -d 10 
/art/1music/rec/test-10sec-88-16.wav
Recording WAVE '/art/1music/rec/test-10sec-88-16.wav' : Signed 16 bit 
Little Endian, Rate 88200 Hz, Stereo
ALSA lib pcm_hw.c:428:(snd_pcm_hw_prepare) SNDRV_PCM_IOCTL_PREPARE 
failed: Invalid argument
arecord: set_params:814: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 88200
PERIOD_TIME: (46439 46440)
PERIOD_SIZE: 4096
PERIOD_BYTES: 16384
PERIODS: 4
BUFFER_TIME: (185759 185760)
BUFFER_SIZE: 16384
BUFFER_BYTES: 65536
TICK_TIME: 10000




-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
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
