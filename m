From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: Re: USB recording - repetitive peaks
Date: Fri, 05 Jul 2002 02:15:39 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D2482BB.5020506@boosthardware.com>
References: <3D208C5C.36649172@ladisch.de>	<s5hhejibem0.wl@alsa2.suse.de>	<3D21B878.8090902@boosthardware.com>	<s5hy9curxdr.wl@alsa2.suse.de>	<3D21C827.2060602@boosthardware.com>	<s5hwuseruac.wl@alsa2.suse.de>	<3D21D6CA.7000308@boosthardware.com>	<s5hu1nirsni.wl@alsa2.suse.de>	<3D21DDFD.6000206@boosthardware.com>	<3D21EB37.7070008@boosthardware.com>	<s5hpty5ry0y.wl@alsa2.suse.de>	<3D247676.8090309@boosthardware.com> <s5hu1nfqx22.wl@alsa2.suse.de>
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
> At Fri, 05 Jul 2002 01:23:18 +0900,
> Patrick Shirkey wrote:
> 
>>Takashi Iwai wrote:
>>
>> >the hang-up at capture close was at least fixed on cvs.
>> >it was due to the combination of ASYNC_UNLINK and complete callbacks.
>> >
>> >not sure whether the bug with jack is fixed, too, but i think it was 
>> >caused by the same reason.  please update the cvs tree.
>>
>>I can now record successfully using arecord without hanging the system
>>but now I get an instant lock up while starting ardour. :( I have a 
>>suspicion that it happens when ardour registers with jackd and asks for 
>>the available input devices.  (I'm not sure about the sound quality. I 
>>will see if I can generate a test tone to use instead of actual music).
> 
> 
> then could you remove the mask USB_ASYNC_UNLINK from line 826 of
> usbaudio.c? 
> this might also leads to a lock-up when usb_submit_urb() fails, but
> this must happen rarely.
> 

First I tried

		u->urb->transfer_flags = USB_ISO_ASAP; /*  |  USB_ASYNC_UNLINK; */

but that made almost no difference. I was able to load ardour for about 
10 seconds before the machine hung.

Now I have commented out the line and I get this from jackd

----
$ jackd -v -d alsa -d quattro2
jackd 0.37.1
Copyright 2001-2002 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details

2616 waiting for signals
creating alsa driver ... quattro2|1024|2|48000|swmon
new client: alsa_pcm, id = 1 type 1 @ 0x80664b0 fd = 12
port alsa_pcm:in_1 buf shm key 0x30945346 at offset 4096 bi = 0x8065880
registered port alsa_pcm:in_1, offset = 4096
port alsa_pcm:in_2 buf shm key 0x30945346 at offset 8192 bi = 0x8065890
registered port alsa_pcm:in_2, offset = 8192
registered port alsa_pcm:out_1, offset = 0
registered port alsa_pcm:out_2, offset = 0
-- jack_rechain_graph():
client alsa_pcm: inprocess client, execution_order=0.
ALSA: poll time out polled for 44800.813378
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



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Caffeinated soap. No kidding.
http://thinkgeek.com/sf
