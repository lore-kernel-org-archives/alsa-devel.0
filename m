From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: AW: usb quattro
Date: Sat, 07 Sep 2002 05:40:02 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D7912A2.1000908@boosthardware.com>
References: <3D77A319.3010703@boosthardware.com>	<DAELIEGDPLDDCIJPAICBGEHNCDAA.annabellesgarden@yahoo.de> <s5hvg5jwgvk.wl@alsa2.suse.de>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>>the Tascam US-428 driver (copied / changed from snd-usb-audio ) showed a
>>similar problem.
>>I worked around it by not using ASYNC_UNLINKing of the urbs.
> 
>  
> yes, this could be the problem.
> this happend once and i thought it fixed on the alsa side, but it
> seems that there is something wrong on usb driver itself.
> why it happened on jack is because jack caused xrun - and the driver
> tries to stop the stream and unlinks urbs with ASYNC_UNLINK flag.
> 
> anyway, i changed the code on cvs to use SYNC unlink mode as default.
> this may have a drawback that the urbs still exist even if the driver
> stops the stream after detection of xrun.  but usually this doesn't
> matter so much.
> 
> i've tested normal playbacks and it seems working.
> 
> 

I have actually managed to get a stream from alsaplayer through without 
a hang but the sound is choppy.

I will make a test signal  so you can hear what I am getting. It's 
similar to what was happening before the driver was fixed last time.

I got this output from jackd. this happened after I started jack and 
didn't connect any other apps. Maybe it timed out but I don't think it 
is supposed to.

----
$ jackd -v -d alsa -d q4
jackd 0.37.1
Copyright 2001-2002 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details

512 waiting for signals
creating alsa driver ... q4|1024|2|48000|swmon
You appear to be using the ALSA software "plug" layer, probably
a result of using the "default" ALSA device. This is less
efficient than it could be. Consider using a ~/.asoundrc file
to define a hardware audio device rather than using the plug layer

You appear to be using the ALSA software "plug" layer, probably
a result of using the "default" ALSA device. This is less
efficient than it could be. Consider using a ~/.asoundrc file
to define a hardware audio device rather than using the plug layer

new client: alsa_pcm, id = 1 type 1 @ 0x8067e38 fd = 14
port alsa_pcm:in_1 buf shm key 0x7598eff0 at offset 4096 bi = 0x8067208
registered port alsa_pcm:in_1, offset = 4096
port alsa_pcm:in_2 buf shm key 0x7598eff0 at offset 8192 bi = 0x8067218
registered port alsa_pcm:in_2, offset = 8192
registered port alsa_pcm:out_1, offset = 0
registered port alsa_pcm:out_2, offset = 0
-- jack_rechain_graph():
client alsa_pcm: inprocess client, execution_order=0.


**** alsa_pcm: xrun of at least 0.044 msecs



**** alsa_pcm: xrun of at least 0.024 msecs



**** alsa_pcm: xrun of at least 0.024 msecs



**** alsa_pcm: xrun of at least 0.028 msecs



**** alsa_pcm: xrun of at least 0.027 msecs



**** alsa_pcm: xrun of at least 0.029 msecs



**** alsa_pcm: xrun of at least 0.044 msecs



**** alsa_pcm: xrun of at least 0.035 msecs



**** alsa_pcm: xrun of at least 0.043 msecs



**** alsa_pcm: xrun of at least 0.043 msecs



**** alsa_pcm: xrun of at least 0.024 msecs



**** alsa_pcm: xrun of at least 0.025 msecs



**** alsa_pcm: xrun of at least 0.025 msecs



**** alsa_pcm: xrun of at least 0.026 msecs



**** alsa_pcm: xrun of at least 0.028 msecs



**** alsa_pcm: xrun of at least 0.027 msecs



**** alsa_pcm: xrun of at least 0.035 msecs



**** alsa_pcm: xrun of at least 0.034 msecs



**** alsa_pcm: xrun of at least 0.044 msecs



**** alsa_pcm: xrun of at least 0.292 msecs



**** alsa_pcm: xrun of at least 0.025 msecs



**** alsa_pcm: xrun of at least 0.025 msecs



**** alsa_pcm: xrun of at least 0.026 msecs



**** alsa_pcm: xrun of at least 0.028 msecs

load = 40.1330 max usecs: 17123.160, spare = 4209.840


**** alsa_pcm: xrun of at least 0.028 msecs



**** alsa_pcm: xrun of at least 0.036 msecs



**** alsa_pcm: xrun of at least 0.044 msecs



**** alsa_pcm: xrun of at least 0.044 msecs



**** alsa_pcm: xrun of at least 0.043 msecs



**** alsa_pcm: xrun of at least 0.025 msecs



**** alsa_pcm: xrun of at least 0.025 msecs



**** alsa_pcm: xrun of at least 0.025 msecs



**** alsa_pcm: xrun of at least 0.023 msecs

load = 56.6747 max usecs: 15619.234, spare = 5713.766
load = 28.5257 max usecs: 80.377, spare = 21252.623
load = 14.4081 max usecs: 61.988, spare = 21271.012
load = 7.3838 max usecs: 76.672, spare = 21256.328
load = 3.8441 max usecs: 64.923, spare = 21268.076
load = 2.0735 max usecs: 64.639, spare = 21268.361


**** alsa_pcm: xrun of at least 19.643 msecs

delay of 29276.168 usecs exceeds estimated spare time of 21268.361; 
restart ...
load = 1.1959 max usecs: 67.880, spare = 21265.121
load = 0.7490 max usecs: 64.444, spare = 21268.557
load = 0.5604 max usecs: 79.328, spare = 21253.672


**** alsa_pcm: xrun of at least 25.716 msecs

delay of 39187.176 usecs exceeds estimated spare time of 21253.672; 
restart ...
load = 0.4574 max usecs: 75.620, spare = 21257.381
load = 0.3795 max usecs: 64.340, spare = 21268.660
load = 0.3446 max usecs: 66.060, spare = 21266.939
load = 0.3312 max usecs: 67.805, spare = 21265.195
load = 0.3430 max usecs: 75.690, spare = 21257.311
load = 0.3253 max usecs: 65.600, spare = 21267.400
load = 0.3170 max usecs: 65.860, spare = 21267.141


**** alsa_pcm: xrun of at least 0.348 msecs

ALSA lib pcm_hw.c:398:(snd_pcm_hw_prepare) SNDRV_PCM_IOCTL_PREPARE 
failed: Input/output error
ALSA-HW: prepare error for playback on "q4" (Input/output error)
driver wait function failed, exiting
telling signal thread that the engine is done
jack main caught signal 1


----

-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================

"Um...symbol_get and symbol_put... They're
kindof like does anyone remember like get_symbol
and put_symbol I think we used to have..."
- Rusty Russell in his talk on the module subsystem



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
