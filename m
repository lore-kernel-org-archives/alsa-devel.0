From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: Intel8x0 problems with rc1
Date: Wed, 03 Dec 2003 18:17:14 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FCE1A9A.9070501@undata.org>
References: <3FCB855F.7080505@undata.org>	<s5hd6b8fl1s.wl@alsa2.suse.de>	<s5h8ylwfk40.wl@alsa2.suse.de>	<3FCC7EC4.6050200@undata.org>	<s5hn0abe7vm.wl@alsa2.suse.de>	<3FCC9A49.3070300@undata.org>	<s5h3cc3dxrb.wl@alsa2.suse.de>	<3FCD163E.7040702@undata.org>	<s5h65gyc8ri.wl@alsa2.suse.de>	<3FCDF77B.7070702@undata.org> <s5hr7zlc2n3.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hr7zlc2n3.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai a écrit :
> At Wed, 03 Dec 2003 15:47:23 +0100,
> Thomas Charbonnel wrote:
> 
>>Takashi Iwai wrote :
>>
>>
>>>>Takashi, I applied your patch but nothings shows up in my logs.
>>>>I even replaced all the KERN_DEBUG by KERN_EMERG, and still nothing.
>>>>The only thing I get is this :
>>>>ALSA intel8x0.c:568: codec_semaphore: semaphore is not ready [0x1][0x300100]
>>>>ALSA intel8x0.c:599: codec_read 0: semaphore is not ready for register 0x56
>>>
>>>
>>>and the driver still works somehow?
>>>
>>>
>>>
>>>>Is it possible that your code never gets called ?
>>>
>>>
>>>if the driver works, it must not happen.
>>>
>>>
>>>Takashi
>>
>>Ok, my fault, sorry Takashi, I stupidly reloaded only the snd-intel8x0 
>>module and forgot snd-ac97-codec, here's the log :
>>
>>ac97_pcm_open: rate = 48000, cfg = 2, slots = 0x198
>>setting ac97 reg 0x2c to rate 48000
>>setting ac97 reg 0x2e to rate 48000
>>ALSA ../../alsa-kernel/pci/ac97/ac97_pcm.c:561: error in 
>>snd_ac97_set_rate: cidx=0, reg=0x2e, rate=48000
>>, err=-22<0>ac97_pcm_open: rate = 48000, cfg = 2, slots = 0x198
>>
>>(The file's rate was 44100 kHz)
> 
> 
> didn't you get any messages before this?
> it should be something like
> 
> checking codec 0, slot = 0xxx / 0xxx
> probing pcm 0
>   ....
> 
> 

Here it is :

PCI: Setting latency timer of device 00:1f.5 to 64
checking codec 0, slots = 0x198 / 0x58
-> capture slots = 0x58
probing pcm 0
.. probing codec 0, slots = 0x3d8
.. tmp = 0x198
.. tmp = 0x198
.. rslots = 0x198, rate_table = 0, rates = 0x0
--> slots = 0x198, rates = 0x0
probing pcm 1
.. probing codec 0, slots = 0x18
.. tmp = 0x18
.. tmp = 0x18
.. rslots = 0x18, rate_table = 0, rates = 0xfe
--> slots = 0x18, rates = 0xfe
probing pcm 2
.. probing codec 0, slots = 0x40
.. tmp = 0x40
.. tmp = 0x40
.. rslots = 0x40, rate_table = 0, rates = 0x80
--> slots = 0x40, rates = 0x80
intel8x0: clocking to 48000

Thomas





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
