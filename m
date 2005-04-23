From: Raymond <rayau@netvigator.com>
Subject: Re: au88x0_synth
Date: Sat, 23 Apr 2005 12:04:35 +0800
Message-ID: <4269C953.4050504@netvigator.com>
References: <423CCDAC.80401@netvigator.com> <s5h4qf44vna.wl@alsa2.suse.de> <424A5D7D.2070400@netvigator.com> <200503301013.30400.alien999999999@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200503301013.30400.alien999999999@users.sourceforge.net>
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
> while you guys are working on that driver, is there anyone that has a 64bit 
> setup? if not, i'd like to test out your driver in 64bit. i still have a 
> number of issues with it (my card is an au8810).
> 

I do not have any 64bit setup, are you sure that your 64bit patch is
correct ?

http://kerneltrap.org/node/3848

snd-au88x0 use the following macros to perform read/write of 32bit data
from/to Memory Mapped I/O

#define	hwread(x,y) readl((x)+((y)>>2))
#define	hwwrite(x,y,z) writel((z),(x)+((y)>>2))

Would you provide the result of "lspci -vvvn" to find out the content of
PCI BAR0 of your au8810 card ?

What is the model of your au8810 card (e.g. Vortex Advantage, SQ1500,
SoundCom V90) ?

Do your 64bit machine has more than 4Gb memory ?

> sometimes i start playing a song, and it starts playing a few second
> or so and hangs, then i kill the application and modprobe -r all sound
> modules and modprobe them again to make it work again.

Do your configure all the sound-apps to use ALSA instead of OSS ?

>
> BUT: sometimes not only that happens, but also when i try to kill the
> apps it will not kill. when that happens, all kill, killall, top, ps
> aux commands hang at the command line and cannot be killed by CTRL-C
> or otherwise, i have been able to see that when i stopped my display
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
> as you can see the snd-au8810 module seem to have an impossible number
> of "dependencies" (i think has to do with the number of unclosed
> sound-apps trying to be played; this could be since gaim is programmed
> to execute an 'aplay %s')


This is abnormal, au8810 has 16 SRC and snd-au8810 can play either 16
mono streams or 8 stereo streams concurrently.

Use alsamixer to find out which ac97 codec on your au8810.

Do you have any application using gameport, mpu401 or OSS  ?


>
> i've had this major crash below only 3 times; and the logs didn't
> detect anything specific at the time. the only thing the logs
> mentioned at that time was an ntpd sync going on; so the only thing i
> can think of is that at a certain moment when a sync is going on, some
> kind of lock is holding cause this to happen... the only thing that i
> can do to fix this is reset...

Do the log indicate the snd-au8810 is loaded properly ?


>
> it is interesting to note that i also have an snd-emu10k1 as second
> card, which never gave problems like this, and i am always able to
> "modprobe -r snd-emu10k1" ...

snd-emu10k1 use PIO.

Would you post the content of /etc/modprobe.conf ?









-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
