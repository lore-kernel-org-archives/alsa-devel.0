From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: quattro multi plugin.
Date: Sun, 21 Jul 2002 01:22:26 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D398E42.3050104@boosthardware.com>
References: <3D37BBBA.7030308@boosthardware.com>	<3D37D0FD.3090400@boosthardware.com>	<3D381A7F.4090708@boosthardware.com> <s5hd6tjr4g9.wl@alsa2.suse.de> <3D398B26.8080106@boosthardware.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net, jackit-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Patrick Shirkey wrote:
> Nope. I have tried something very similar to this before with no luck. 
> It is extremely annoying that I now cannot reproduce the previous 
> message. I don't understand why it can almost work once but seemingly 
> never again ??? It's very strange.
> 

I guess I spoke too soon. After a hard reeboot and starting the box 
after I had Linux up. I could get similar output to the original message 
except htis time I got an instant hang once kackd had found the i/o ports.

I will of course test some more :)

> 
> 
> Takashi Iwai wrote:
> 
>> At Fri, 19 Jul 2002 22:56:15 +0900,
>> Patrick Shirkey wrote:
>>
>>> This is wierd. Using the exact same commands I cannot get jackd to 
>>> load now. The card still, ahem, works, cough, with a single pcm device.
>>
>>
>>
>> how about the asoundrc attached below?
>> this will map hw:2,1 and hw:2,2 as 4 channels pcm.
>> i thought that these two devices correspond to 96kHz, so you need to
>> specify other frequency for jackd.
>>
>>
>> Takashi
> 
> 
> ----
> # jackd -R -v -a -d alsa -d q4
> jackd 0.37.1
> Copyright 2001-2002 Paul Davis and others.
> jackd comes with ABSOLUTELY NO WARRANTY
> This is free software, and you are welcome to redistribute it
> under certain conditions; see the file COPYING for details
> 
> 507 waiting for signals
> creating alsa driver ... q4|1024|2|48000|swmon
> You appear to be using the ALSA software "plug" layer, probably
> a result of using the "default" ALSA device. This is less
> efficient than it could be. Consider using a ~/.asoundrc file
> to define a hardware audio device rather than using the plug layer
> 
> You appear to be using the ALSA software "plug" layer, probably
> a result of using the "default" ALSA device. This is less
> efficient than it could be. Consider using a ~/.asoundrc file
> to define a hardware audio device rather than using the plug layer
> 
> new client: alsa_pcm, id = 1 type 1 @ 0x8067490 fd = 14
> port alsa_pcm:in_1 buf shm key 0x28441bd5 at offset 4096 bi = 0x8066860
> registered port alsa_pcm:in_1, offset = 4096
> port alsa_pcm:in_2 buf shm key 0x28441bd5 at offset 8192 bi = 0x8066870
> registered port alsa_pcm:in_2, offset = 8192
> registered port alsa_pcm:out_1, offset = 0
> registered port alsa_pcm:out_2, offset = 0
> -- jack_rechain_graph():
> client alsa_pcm: inprocess client, execution_order=0.
> jackd: pcm.c:1925: snd_pcm_area_silence: Assertion `0' failed.
> 
> # jackd watchdog: timeout - killing jackd
> 
> # jackd -R -v -a -d alsa -d quattro
> jackd 0.37.1
> Copyright 2001-2002 Paul Davis and others.
> jackd comes with ABSOLUTELY NO WARRANTY
> This is free software, and you are welcome to redistribute it
> under certain conditions; see the file COPYING for details
> 
> creating alsa driver ... quattro|1024|2|48000|swmon
> ALSA: mmap-based access is not possible for the capture stream of this 
> audio int
> erface514 waiting for signals
> 
> ALSA: cannot configure capture channel
> cannot load driver module alsa
> jack main caught signal 15
> 
> ----
> 



-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
