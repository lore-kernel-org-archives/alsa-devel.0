From: John Simpson <john@swajime.com>
Subject: Re: Compiler errors in alsa-lib-1.0.22/test/*.c
Date: Mon, 19 Jul 2010 17:54:26 -0500
Message-ID: <AANLkTil-ZQzde-PfVMZhxb-yE0Lkkz6QoEpkqiDmDbTy@mail.gmail.com>
References: <AANLkTin75qlRIEXwE8_12m3GcGXagKY0lQhQ4hN9h_co@mail.gmail.com>
	<4C3C0540.6020506@ladisch.de>
	<AANLkTinsZlWl0VtR8F1mHHYUNUd6jHvTjGhd_J2sdsoM@mail.gmail.com>
	<AANLkTinuYzw-4iuEyemaL4Jlh0NC0byhPBNJ5nu5tscX@mail.gmail.com>
	<AANLkTilDAsnNVSs17ochWuMfBlU_PIbL4OzH67CtPcLD@mail.gmail.com>
	<alpine.LNX.2.00.1007191052020.9258@eeebox2.perex-int.cz>
	<AANLkTinomEJIjm4DOkZPUcL0d_I6PwzHIGNiT5sUd1FZ@mail.gmail.com>
Reply-To: john@swajime.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 60BA124434
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jul 2010 00:54:27 +0200 (CEST)
Received: by iwn39 with SMTP id 39so5284200iwn.38
	for <alsa-devel@alsa-project.org>; Mon, 19 Jul 2010 15:54:26 -0700 (PDT)
In-Reply-To: <AANLkTinomEJIjm4DOkZPUcL0d_I6PwzHIGNiT5sUd1FZ@mail.gmail.com>
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

On 7/19/10, John Simpson <john@swajime.com> wrote:
> On 7/19/10, Jaroslav Kysela <perex@perex.cz> wrote:
>
>> You must force compilation in test directory, for example:
>>
>> cd alsa-lib/test
>> make pcm
>>
>>  					Jaroslav
>>
>
> Ok ... I'm learning :o) (i think)
>
> On my n810 that gives me this:
> [user@nokia ~/src/dsp-alsa/trunk/alsa-lib/test]$ make pcm
> cc     pcm.c   -o pcm
> pcm.c: In function `help':
> pcm.c:719: warning: use of cast expressions as lvalues is deprecated
> /var/tmp/ccQOAYhr.o: In function `generate_sine':pcm.c:(.text+0x140):
> undefined reference to `snd_pcm_format_width'
> :pcm.c:(.text+0x160): undefined reference to `snd_pcm_format_width'
> :pcm.c:(.text+0x378): undefined reference to `sin'
> /var/tmp/ccQOAYhr.o: In function `set_hwparams':pcm.c:(.text+0x5ac):
> undefined reference to `snd_pcm_hw_params_any'
> :pcm.c:(.text+0x5c4): undefined reference to `snd_strerror'
>
> On my ubuntu system:
> john@system76-pc:~/alsa-lib-1.0.23/test$ make pcm
> if gcc -DHAVE_CONFIG_H -I. -I. -I../include -I../include   -Wall -pipe
> -g -D_GNU_SOURCE -MT pcm.o -MD -MP -MF ".deps/pcm.Tpo" -c -o pcm.o
> pcm.c; \
> 	then mv -f ".deps/pcm.Tpo" ".deps/pcm.Po"; else rm -f
> ".deps/pcm.Tpo"; exit 1; fi
> make: *** No rule to make target `../src/libasound.la', needed by `pcm'.
> Stop.
>
> It works on the ubuntu system only if I run 'make check' first, as
> mentioned by Clemens Ladisch in another post.
>
> I copied the file .deps/pcm.Tpo from the ubunutu system to the n810,
> and pasted the output from the ubuntu command "make pcm" in directly:
> [user@nokia ~/src/dsp-alsa/trunk/alsa-lib/test]$ if gcc
> -DHAVE_CONFIG_H -I. -I. -I../include -I../include   -Wall -pipe -g
> -D_GNU_SOURCE -MT pcm.o -MD -MP -MF ".deps/pcm.Tpo" -c -o pcm.o pcm.c;
> then mv -f ".deps/pcm.Tpo" ".deps/pcm.Po"; else rm -f ".deps/pcm.Tpo";
> exit 1; fi
> pcm.c: In function `help':
> pcm.c:719: warning: use of cast expressions as lvalues is deprecated
>
> Now it looks to me like that generated pcm.o on both machines.  What
> do I do with pcm.o now?
>

I'm going to try 1.0.23 on the n810 again, now that I see it works on
the ubuntu system.

[user@nokia ~/src/dsp-alsa/trunk/alsa-lib]$ cat version
1.0.10
