From: Antti Boman <antti.boman@mindcom.fi>
Subject: Re: snd-cmipci with Jack not working
Date: Thu, 30 Jan 2003 01:48:18 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E386842.5000908@mindcom.fi>
References: <3E379E8A.10502@mindcom.fi> <s5hsmvblw0e.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hsmvblw0e.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thanks, Takashi! I'll get back to these Friday night, as I'm way too 
busy before that. There are some things included below:

Takashi Iwai wrote:
> at first, please check which chip model you are using and get the
> register dump from /proc/asound/card0/cmipci.

I thought I sent the chip model to the mailing list, but that was 
actually one of the off-list messages. The model seems to be "C-Media 
PCI CMI8738-MC6 (model 55)", as the dump of /proc/asound/card0/cmipci 
here tells:

C-Media PCI CMI8738-MC6 (model 55) at 0xd800, irq 10

00: 00 00 00 00
04: 04 00 00 00
08: 00 00 09 00
0c: 00 00 00 0a
10: 80 00 00 00
14: 00 00 00 00
18: 00 00 89 00
1c: ff ff ff ff
20: 10 40 80 00
24: 00 31 ff 00
28: ff ff ff ff
2c: ff ff ff ff
30: 00 00 00 00
34: 00 00 00 00
38: 00 00 00 00
3c: 00 00 00 00

>>I've gathered the key information here:
>>
>>- The sound when playing back is totally garbled, the pitch is lower
>>  than the original, and I get lots of clicking alongside. If I'm not
>>  using jack but alsa output, everything (playing and recording) is ok.
>>
>>- I have the lowlat patch installed in kernel, but using or not using it
>>  doesn't seem to change anything.
>  
> most likely the kernel scheduler is irrelevant.

The only effect it had was locking the whole machine when using 
playback/capture only.

>>- Using jackd with playback/capture only, it produces the following
>>  message:
>>   jackd: pcm.c:5851: snd_pcm_mmap_commit: Assertion 'pcm' failed
>  
> that's weird.

Yes, and as you most probably know, it refers to alsa-lib/src/pcm/pcm.c

Oh, btw, I'm using alsa 0.9.0rc6, and as root (which you obviously 
already gathered from me using lowlatency patches).

Kernel 2.4.19 with AMD Athlon.

>>- If using kernel real-time patches with playback/capture only, the
>>  system locks up. This doesn't happen with both capture and playback
>>  enabled.
>  
> i can't produce this on my machine...

Here it does the same thing every time.

> anyway, i updated the driver a bit.
> please update the cvs version and report whether it works or not.

I'll do this on Friday, as I told. I'll let you (and the list) know 
immediately.

Thanks again for your help!

-Antti



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
