From: maarten van es <maarten.h.van.es@gmail.com>
Subject: Re: set_params:1073: not enough memory
Date: Fri, 20 Feb 2009 22:18:00 +0000
Message-ID: <bca65b460902201418g146e66e7xefd0ad96e308d471@mail.gmail.com>
References: <bca65b460901291443h4bbcbd36p683614a7d9770f45@mail.gmail.com>
	<s5h8wopdlr9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f162.google.com (mail-fx0-f162.google.com
	[209.85.220.162])
	by alsa0.perex.cz (Postfix) with ESMTP id 96D9E103814
	for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2009 23:18:01 +0100 (CET)
Received: by fxm6 with SMTP id 6so475859fxm.8
	for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2009 14:18:00 -0800 (PST)
In-Reply-To: <s5h8wopdlr9.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

This is a hobby project, so I am not so quick with building and
testing things. Anyway, it seems to me now this error is related to a
driver (or perhaps my 'hardware'). I tested the environment built by
buildroot by chrooting into it, from 2 host systems. Aplay then works
fine on my laptop, with an intel HDA card running OpenSuse 11.0
x86-64, kernel 2.6.25.20. The exact same build gives the error in
set_params in aplay running in qemu, with an (emulated) es1370 and
running OpenSuse 11.0 x86-64, kernel 2.6.25.5. The error also occurs
when booting qemu with the buildroot environment with kernel 2.6.28.4.
The qemu system is not my final target, but if there are things I can
try / test with the driver I am willing to spend some time on that.

Regards
Maarten


On Mon, Feb 2, 2009 at 1:14 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 29 Jan 2009 22:43:05 +0000,
> maarten van es wrote:
>>
>> Hello all,
>>
>> I am trying to get alsa to work using buildroot to crosscompile to
>> i686-linux-uclibc. I am using the latest git version of alsa-lib and a
>> recent git version of alsa-util. I am stuck with the same error as in
>> the message included below when using aplay. So far I have been able
>> to narrow this down to the function set_params in aplay.c, lines 1070,
>> 1071:
>>
>> chunk_bytes = chunk_size * bits_per_frame / 8;
>> audiobuf = realloc(audiobuf, chunk_bytes);
>>
>> chunk_size is 0 here and obviously the realloc fails.
>>
>> Any ideas on what's going on here?
>
> No idea yet.  But can you reproduce the same problem with glibc?
>
>
> Takashi
>
>> For the record, "aplay -L" lists the correct devices, "aplay -D null
>> test.wav" works ok and the card works correctly using alsa version
>> 1.0.16 on standard suse 11.0.
>>
>> Best regards
>> Maarten van Es
>>
>>
>>
>>
>> Hello all,
>>
>> I'm trying to get alsa 1.0.18 working on a ARM PXA processor and I'm
>> stuck with the following error message:
>>
>> aplay /Sinus.raw -fcd
>> Playing raw data '/Sinus.raw' : Signed 16 bit Little Endian, Rate 44100
>> Hz, Stereo
>> aplay: set_params:1073: not enough memory
>>
>> alsa kernel was compiled with alsa 1.0.16, alsa.conf, located in
>> /usr/share/alsa is the basic:
>>
>> pcm.!default {
>>       type hw
>>       card 0
>>       }
>>
>>       ctl.!default {
>>       type hw
>>       card 0
>>          }
>>
>> also aplay -l and alsaconf store show the message:
>>
>> ALSA lib control.c:909:(snd_ctl_open_noupdate) Invalid CTL hw:0
>>
>> However the card shows up /proc/asound/cards and alsamixer is able to
>> access it.
>>
>> Any ideas?
>>
>> Best regards
>>
>> Michael
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>
