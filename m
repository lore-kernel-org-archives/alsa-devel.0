From: Igor Kovalenko <garrison@mail.ru>
Subject: Re: [Openvortex-dev] Re: Re: [ALSA - driver 0001138]:   errors when
 installing au8820 modules
Date: Wed, 08 Jun 2005 22:03:49 +0400
Message-ID: <42A73305.9000000@mail.ru>
References: <add360993204c8039097fe7085524651@bugtrack.alsa-project.org>	<s5h8y1n7af3.wl@alsa2.suse.de>	<42A5B7D4.50201@netvigator.com>	<200506071716.05194.alien999999999@users.sourceforge.net>	<s5hwtp6w2nw.wl@alsa2.suse.de> <42A5D3C8.1030903@mail.ru> <42A6E5BE.4030003@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42A6E5BE.4030003@netvigator.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Raymond <rayau@netvigator.com>
Cc: alsa-devel@lists.sourceforge.net, openvortex-dev@nongnu.org
List-Id: alsa-devel@alsa-project.org

Raymond wrote:
> Is there any way to remove this warning for the change from "0x%08lx" to
> "0x%08x" in 32-bits compiler ?
> 
>  warning: unsigned int format, long unsigned int arg (arg 2)
> 
> There is no warning before this change.
> 
> 
> alsa-kernel/pci/au88x0/au88x0_core.c
> 
> @@ -1054,7 +1054,7 @@
>                 hwwrite(vortex->mmio, addr, FIFO_U0);
>                 if (hwread(vortex->mmio, addr) != FIFO_U0)
>                         printk(KERN_ERR
> -                              "bad wt fifo reset (0x%08lx, 0x%08x)!\n",
> +                              "bad wt fifo reset (0x%08x, 0x%08x)!\n",
>                                addr, hwread(vortex->mmio, addr));
>                 vortex_fifo_clearwtdata(vortex, x, FIFO_SIZE);
>                 addr -= 4;
> 
> 
>>
>> Well, I've not stated the problem clearly enough.
>> Once set, volume stays as it should. The problem is that
>> PCM volume is:
>> 1% - at lowest audible level
>> 25% - at about 50% audible level
>> 49% - at about max audible level
>> 51% - at lowest audible level
>> 75% - at about 50% audible level
>> 99% - at about max audible level
>> - that is what I described as low-high-low-high.
>> On the other hand, Master volume behaves as expected.
> 
> 
> 
> What is the value of comment.range of 'PCM Playback Volume' in
> /etc/asound.state for your STAC9704 (au8820) ?
> 
> 
> According to 9704SPEC.pdf, it should be '0-31' ( 5 bits ) for STAC9704
> PCM Out volume.
> 

        control.21 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 63'
                iface MIXER
                name 'PCM Playback Volume'
                value.0 21
                value.1 21
        }

Do you mean AC97 is incorrectly reporting 0...63 range?

> or check the values *low_max and *high_max return by
> check_volume_resolution()
> 
> http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-kernel/pci/ac97/ac97_codec.c?r1=1.163&r2=1.164
> 
> 
> 
> Igor Kovalenko wrote:
> 
>> Takashi Iwai wrote:
>>
>>> At Tue, 7 Jun 2005 17:16:02 +0200,
>>> Alien wrote:
>>>
>>>
>>>> [1  <text/plain; iso-8859-1 (quoted-printable)>]
>>>> Op dinsdag 7 juni 2005 17:05, schreef Raymond:
>>>>
>>>>
>>>>> The patch (diff11.diff) cause segmenation fault on my 32bit machine
>>>>> during /etc/init.d/alsasound start
>>>>>
>>>>> http://savannah.nongnu.org/patch/?func=detailitem&item_id=3948
>>>>>
>>>>> Do anyone know why readl() and writel() behave different in i386
>>>>> (32bits) and AMD64 (64bits) ?
>>>>>
>>>>> http://sourceforge.net/mailarchive/message.php?msg_id=10773530
>>>>>
>>>>>
>>>>> #ifndef CONFIG_X86_64
>>>>>
>>>>> #define        hwread(x,y) readl((x)+((y)>>2))
>>>>> #define        hwwrite(x,y,z) writel((z),(x)+((y)>>2))
>>>>>
>>>>> #else
>>>>>
>>>>> #define        hwread(x,y) readl((x)+(y))
>>>>> #define        hwwrite(x,y,z) writel((z),(x)+(y))
>>>>>
>>>>> #endif
>>>>
>>>>
>>>> that doesn't look good, unless the mmio is void* in 32bit and
>>>> unsigned long* in x86_64...
>>>>
>>>> 'unsigned long* mmio' should be preferred and together with
>>>> '#define        hwread(x,y) readl((x)+(y))' , this works for both
>>>> platforms
>>>
>>>
>>>
>>> I guess using "unsigned long" for both architectures is broken, too.
>>> Should be "u32" to be arch-independent.
>>>
>>
>>
>> I strongly believe readl() and writel() on x86_64 does 32 bit
>> reads/writes.
>> (checked linux-2.6.12-rc5). Therefore reads/writes are of correct size
>> with
>> that patch - should be something different.
>>
> 
> 
> 
> 
> 
> _______________________________________________
> Openvortex-dev mailing list
> Openvortex-dev@nongnu.org
> http://lists.nongnu.org/mailman/listinfo/openvortex-dev
> 
> 


-- 
Kind regards,
Igor V. Kovalenko


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
