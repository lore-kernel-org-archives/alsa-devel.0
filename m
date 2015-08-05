From: Valentin Corfu <corfuvalentin@gmail.com>
Subject: Re: Segmentation Fault in snd_pcm_rate_hw_free()
Date: Wed, 05 Aug 2015 09:58:16 +0300
Message-ID: <55C1B408.7010501@gmail.com>
References: <55C0C75E.8090501@gmail.com>	<s5hwpxbnm0e.wl-tiwai@suse.de>	<55C0D402.8030806@gmail.com>
 <s5hmvy7nkyp.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com
 [209.85.212.175])
 by alsa0.perex.cz (Postfix) with ESMTP id EBEED265D6A
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 08:59:49 +0200 (CEST)
Received: by wibcd8 with SMTP id cd8so10053507wib.1
 for <alsa-devel@alsa-project.org>; Tue, 04 Aug 2015 23:59:49 -0700 (PDT)
In-Reply-To: <s5hmvy7nkyp.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Takashi,


On 04.08.2015 18:15, Takashi Iwai wrote:
> On Tue, 04 Aug 2015 17:02:26 +0200,
> Valentin Corfu wrote:
>>
>>
>> On 04.08.2015 17:53, Takashi Iwai wrote:
>>> On Tue, 04 Aug 2015 16:08:30 +0200,
>>> Valentin Corfu wrote:
>>>> Hello ALSA developers,
>>>>
>>>> I observed one segmentation fault in snd_pcm_rate_hw_free() function,
>>>> with the following BT:
>>>>
>>>> (gdb) up
>>>> #1  0xb7554cc1 in raise (sig=6) at
>>>> ../nptl/sysdeps/unix/sysv/linux/raise.c:64
>>>> 64        return INLINE_SYSCALL (tgkill, 3, pid, selftid, sig);
>>>> (gdb)
>>>> #2  0xb75580ee in abort () at abort.c:92
>>>> 92            raise (SIGABRT);
>>>> (gdb)
>>>> #3  0xb758a7dd in __libc_message (do_abort=2,
>>>>        fmt=0xb766053c "*** glibc detected *** %s: %s: 0x%s ***\n")
>>>>        at ../sysdeps/unix/sysv/linux/libc_fatal.c:189
>>>> 189           abort ();
>>>> (gdb)
>>>> #4  0xb7594a71 in malloc_printerr (action=<value optimized out>,
>>>>        str=<value optimized out>, ptr=0x969ae98) at malloc.c:6283
>>>> 6283          __libc_message (action & 2,
>>>> (gdb)
>>>> #5  0xb759636b in _int_free (av=<value optimized out>, p=0x969ae90)
>>>>        at malloc.c:4795
>>>> 4795          malloc_printerr (check_action, errstr, chunk2mem(p));
>>>> (gdb)
>>>> #6  0xb75994bd in __libc_free (mem=0x969ae98) at malloc.c:3738
>>>> 3738      _int_free(ar_ptr, p);
>>>> (gdb)
>>>> #7  0xb76f3a81 in snd_pcm_rate_hw_free (pcm=0x9685d78) at pcm_rate.c:341
>>>> 341                     free(rate->pareas[0].addr);
>>> Could you check the content of rate->pareas[0] via gdb?
>> (gdb) frame 7
>> #7  0xb76f3a81 in snd_pcm_rate_hw_free (pcm=0x9685d78) at pcm_rate.c:341
>> 341                     free(rate->pareas[0].addr);
>> (gdb) print rate->pareas[0]
>> $1 = {addr = 0x969ae98, first = 0, step = 16}
>> (gdb) print rate->pareas[0].addr
>> $2 = (void *) 0x969ae98
> And accessing to pareas[0].addr is OK?  This is a temporary sample
> buffer allocated in alsa-lib rate plugin.
>

Are you referring if the pointer is valid one?
How could I check this?


>>>> (gdb)
>>>> #8  0xb76d045b in snd_pcm_hw_free (pcm=0x9685d78) at pcm.c:858
>>>> 858             err = pcm->ops->hw_free(pcm->op_arg);
>>>> (gdb)
>>>> #9  0xb76f826e in snd_pcm_plug_hw_free (pcm=0x96856b0) at pcm_plug.c:1046
>>>> 1046            int err = snd_pcm_hw_free(slave);
>>>> (gdb)
>>>> #10 0xb76d045b in snd_pcm_hw_free (pcm=0x96856b0) at pcm.c:858
>>>> 858             err = pcm->ops->hw_free(pcm->op_arg);
>>>> (gdb)
>>>> #11 0x080492ad in main ()
>>>>
>>>>
>>>> Could you please give me some hints how to solve this issue?
>>>>
>>>> I can provide you more info or the test application, if needed.
>>>> I can see the issue every time, and I also checked with latest version
>>>> of alsa-lib but I got the same results.
>>> I don't know of such an error, so far.
>>> It smells like some memory corruption to me.
>>>
>>> If a test case is a simple code, tracking the bug would be easy...
>> I have paste it here:
>> http://pastebin.com/WJDTz6cE
> It works fine on my system.  How is your PCM setup?  Does the same
> problem occur for "plughw" PCM, too?  Also, no external PCM rate
> plugin is involved?

In my setup it is involved the alsa jack plugin, so I'm using the pcm 
jack when the segmentation fault is visible.
I can not reproduce the issue when I'm using "default" / "plughw" PCM.

For more info I have pasted the dump() & log at run: 
http://pastebin.com/jyy7pP9e
It is involved here PCM rate conversion at 48000, but not external one.


>
> Takashi


Thank you,
Valentin
