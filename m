From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: USB Audio/Midiman - partial success
Date: Fri, 13 Sep 2002 14:59:40 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D817ECC.5030904@boosthardware.com>
References: <s5hn0qryq08.wl@alsa2.suse.de>	<Pine.HPX.4.33n.0209100853400.12586-100000@studcom.urz.uni-halle.de> <s5h65xbp6n2.wl@alsa2.suse.de>
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
List-Archive: <http://sourceforge.net/mailarchive/forum.php=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Tue, 10 Sep 2002 10:58:34 +0200 (METDST),
> Clemens Ladisch wrote:
> 
>>>>The two PCM devices cannot be used at the same time anyway, so I think
>>>>creating a quirk for interface 0 which says "ignore this" could work.
>>>>Takashi, any comments?
>>>
>>>i think implementing a semaphore (or flag) for each endpoint would be
>>>better, so that the driver can find generally double-endpoints
>>>problem.
>>
>>I cannot imagine anybody else would be stupid enough to design a device
>>with double endpoints. But then I didn't imagine Midiman would, either.
>>Oh well, Murphy's Law ...  :-(
> 
> 
> since many (at least plural :) devices have this problem, i changed
> the usbaudio code slightly.  now a pcm stream is created per endpoint
> instead of interface.
> 
> on this version, m-audio's device should have one (for duo) or two
> (for quattro) pcm devices.
> 
> please let me know if any problems arise with this change.
> 

FYI: I have found that using the quattro with jack is rock solid when 
only accessing one of the pcms at a time at 48khz even as normal user.

But switch to a higher sample rate and/or 4 channels(with root 
priveledges and lowlatency scheduling on) and different things happen:

----
  jackd -v -d alsa -d quattro1 -r 96000 -p 192
jackd 0.37.2
Copyright 2001-2002 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details

10691 waiting for signals
creating alsa driver ... quattro1|192|2|96000|swmon
ALSA lib pcm_hw.c:398:(snd_pcm_hw_prepare) SNDRV_PCM_IOCTL_PREPARE 
failed: Invalid argument
ALSA: cannot set hardware parameters for capture
ALSA: cannot configure capture channel
cannot load driver module alsa
jack main caught signal 15
----
jackd -v -d alsa -d q4b -r 48000 -p 3072
jackd 0.37.2
Copyright 2001-2002 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details

10728 waiting for signals
creating alsa driver ... q4b|3072|2|48000|swmon
new client: alsa_pcm, id = 1 type 1 @ 0x8068078 fd = 14
port alsa_pcm:in_1 buf shm key 0x53ff306d at offset 12288 bi = 0x8067448
registered port alsa_pcm:in_1, offset = 12288
port alsa_pcm:in_2 buf shm key 0x53ff306d at offset 24576 bi = 0x8067458
registered port alsa_pcm:in_2, offset = 24576
port alsa_pcm:in_3 buf shm key 0x53ff306d at offset 36864 bi = 0x8067468
registered port alsa_pcm:in_3, offset = 36864
port alsa_pcm:in_4 buf shm key 0x53ff306d at offset 49152 bi = 0x8067478
registered port alsa_pcm:in_4, offset = 49152
registered port alsa_pcm:out_1, offset = 0
registered port alsa_pcm:out_2, offset = 0
registered port alsa_pcm:out_3, offset = 0
registered port alsa_pcm:out_4, offset = 0
-- jack_rechain_graph():
client alsa_pcm: inprocess client, execution_order=0.


**** alsa_pcm: xrun of at least 0.046 msecs



**** alsa_pcm: xrun of at least 0.045 msecs

load = 11.1325 max usecs: 14249.315, spare = 49749.684


**** alsa_pcm: xrun of at least 0.044 msecs

load = 16.6987 max usecs: 14249.315, spare = 49749.684


**** alsa_pcm: xrun of at least 0.043 msecs

load = 19.4754 max usecs: 14241.095, spare = 49757.906
load = 20.8637 max usecs: 14241.095, spare = 49757.906
load = 10.5940 max usecs: 207.489, spare = 63791.512


**** alsa_pcm: xrun of at least 0.045 msecs


load = 16.4347 max usecs: 14256.115, spare = 49742.883
load = 19.3551 max usecs: 14256.115, spare = 49742.883
load = 9.8830 max usecs: 262.911, spare = 63736.090


**** alsa_pcm: xrun of at least 0.043 msecs

load = 16.0698 max usecs: 14243.989, spare = 49755.012
jackd: signal 2 received
jack main caught signal 15

# jackd -v -d alsa -d q4b -r 48000 -p 6144
jackd 0.37.2
Copyright 2001-2002 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details

10734 waiting for signals
creating alsa driver ... q4b|6144|2|48000|swmon
new client: alsa_pcm, id = 1 type 1 @ 0x8068078 fd = 14
port alsa_pcm:in_1 buf shm key 0x74529998 at offset 24576 bi = 0x8067448
registered port alsa_pcm:in_1, offset = 24576
port alsa_pcm:in_2 buf shm key 0x74529998 at offset 49152 bi = 0x8067458
registered port alsa_pcm:in_2, offset = 49152
port alsa_pcm:in_3 buf shm key 0x74529998 at offset 73728 bi = 0x8067468
registered port alsa_pcm:in_3, offset = 73728
port alsa_pcm:in_4 buf shm key 0x74529998 at offset 98304 bi = 0x8067478
registered port alsa_pcm:in_4, offset = 98304
registered port alsa_pcm:out_1, offset = 0
registered port alsa_pcm:out_2, offset = 0
registered port alsa_pcm:out_3, offset = 0
registered port alsa_pcm:out_4, offset = 0
-- jack_rechain_graph():
client alsa_pcm: inprocess client, execution_order=0.


**** alsa_pcm: xrun of at least 1.435 msecs



**** alsa_pcm: xrun of at least 0.046 msecs

load = 5.2546 max usecs: 13451.668, spare = 114547.328


**** alsa_pcm: xrun of at least 0.043 msecs

load = 8.6591 max usecs: 15441.339, spare = 112557.664


**** alsa_pcm: xrun of at least 0.042 msecs

load = 10.3614 max usecs: 15441.339, spare = 112557.664


**** alsa_pcm: xrun of at least 0.045 msecs

load = 11.2125 max usecs: 15441.339, spare = 112557.664


**** alsa_pcm: xrun of at least 0.046 msecs

load = 11.6381 max usecs: 15441.339, spare = 112557.664
jackd: signal 2 received
jack main caught signal 15



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
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
