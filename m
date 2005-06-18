From: Raymond <rayau@netvigator.com>
Subject: Re: [ALSA - driver 0001047]: module hangs at seemingly random times
Date: Sat, 18 Jun 2005 21:51:14 +0800
Message-ID: <42B426D2.806@netvigator.com>
References: <50ce26d334ea87a34d7e9e58d1d69a87@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <50ce26d334ea87a34d7e9e58d1d69a87@bugtrack.alsa-project.org>
Sender: alsa-devel-admin@lists.sourceforge.net
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

Alien wrote:
> Op dinsdag 7 juni 2005 15:44, schreef Raymond:
>>
>>After eight instances of "mplayer" playing stereo music concurrently in
>>my 32-bits machine and start an instance of aplay.
>>
>>aplay outls.wav
>>Playing WAVE 'outls.wav' : Signed 16 bit Little Endian, Rate 22050 Hz,
>>Stereo
>>aplay: set_params:935: Unable to install hw params:
>>ACCESS:  RW_INTERLEAVED
>>FORMAT:  S16_LE
>>SUBFORMAT:  STD
>>SAMPLE_BITS: 16
>>FRAME_BITS: 32
>>CHANNELS: 2
>>RATE: 22050
>>PERIOD_TIME: (46439 46440)
>>PERIOD_SIZE: 1024
>>PERIOD_BYTES: 4096
>>PERIODS: 11
>>BUFFER_TIME: (510839 510840)
>>BUFFER_SIZE: 11264
>>BUFFER_BYTES: 45056
>>TICK_TIME: 10000
>>
>>
>>aplay abort as there is no more SampleRateConvertors available.
>>
>>There is no deadlock or hang. After the "mplayer" finish playing and
>>release the SRCs, I can start another instance of ALSA application to
>>play music.
>
>
>
> I'm going to try to do the same thing with xine and CVS aplay, see
> what happens...


I have use the following script to test, I can hear the sound and my
32-bits machine does not hang/freeze.

aplay mono1.wav &
aplay mono2.wav &
aplay mono3.wav &
aplay mono4.wav &
aplay mono5.wav &
aplay mono6.wav &
aplay mono7.wav &
aplay mono8.wav &
aplay mono9.wav &
aplay mono10.wav &
aplay mono11.wav &
aplay mono12.wav &
aplay mono13.wav &
aplay mono14.wav &
aplay mono15.wav &
aplay mono16.wav &
aplay mono17.wav

> and the logs didn't detect anything specific at the time.

#dmesg

vortex: FATAL: ResManager: resource type 1 exhausted.

The above message is correct since 16 SRC (Type 1 resource) have been
used up

> snd-pcm-oss            59752  11
> snd-mixer-oss          20480  1 snd-pcm-oss


Which oss applications are you rnning ?

Since you are using VIA chipset, have you try the pcifix switch ?

bugtrack@alsa-project.org wrote:
> A NOTE has been added to this issue.
> ======================================================================
> <https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1047> 
> ======================================================================
> Reported By:                alien999999999
> Assigned To:                mjander
> ======================================================================
> Project:                    ALSA - driver
> Issue ID:                   1047
> Category:                   PCI - au88x0
> Reproducibility:            sometimes
> Severity:                   block
> Priority:                   normal
> Status:                     assigned
> Distribution:               Mandrake
> Kernel Version:             2.6.7
> ======================================================================
> Date Submitted:             04-12-2005 20:43 CEST
> Last Modified:              04-12-2005 20:51 CEST
> ======================================================================
> Summary:                    module hangs at seemingly random times
> Description: 
> sometimes i start playing a song, and it starts playing a few second or so
> and hangs, then i kill the application and modprobe -r all sound modules
> and modprobe them again to make it work again.
> 
> BUT: sometimes not only that happens, but also when i try to kill the apps
> it will not kill. when that happens, all kill, killall, top, ps aux
> commands hang at the command line and cannot be killed by CTRL-C or
> otherwise, i have been able to see that when i stopped my display
> managener I did an lsmod and it gave something like this:
> 
> snd-pcm-oss            59752  11
> snd-mixer-oss          20480  1 snd-pcm-oss
> snd-au8810             43760  220
> snd-ac97-codec         83408  1 snd-au8810
> snd-pcm               108172  112 snd-pcm-oss,snd-au8810,snd-ac97-codec
> snd-page-alloc         10384  1 snd-pcm
> gameport                3840  1 snd-au8810
> snd-mpu401-uart        11904  1 snd-au8810
> 
> 
> as you can see the snd-au8810 module seem to have an impossible number of
> "dependencies" (i think has to do with the number of unclosed sound-apps
> trying to be played; this could be since gaim is programmed to execute an
> 'aplay %s')
> 
> i've had this major crash below only 3 times; and the logs didn't detect
> anything specific at the time. the only thing the logs mentioned at that
> time was an ntpd sync going on; so the only thing i can think of is that
> at a certain moment when a sync is going on, some kind of lock is holding
> cause this to happen... the only thing that i can do to fix this is
> reset...
> 
> it is interesting to note that i also have an snd-emu10k1 as second card,
> which never gave problems like this, and i am always able to "modprobe -r
> snd-emu10k1" ...



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
