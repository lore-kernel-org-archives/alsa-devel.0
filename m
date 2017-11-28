From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: ["PATCH alsa-lib"] Change snd_dlopen() function to
 return the error string
Date: Tue, 28 Nov 2017 08:26:09 +0100
Message-ID: <01da9a05-3e94-2794-74b3-733a95544307@perex.cz>
References: <20171127085016.11339-1-perex@perex.cz>
 <511ce0ed-77e2-b319-e1a1-e461ba1ac1e1@sakamocchi.jp>
 <s5h4lpfmpvs.wl-tiwai@suse.de>
 <00263979-4138-4e63-62a0-c5683a352102@perex.cz>
 <s5hwp2bl8j7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id BB159267277
 for <alsa-devel@alsa-project.org>; Tue, 28 Nov 2017 08:26:12 +0100 (CET)
In-Reply-To: <s5hwp2bl8j7.wl-tiwai@suse.de>
Content-Language: en-US
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
Cc: ALSA development <alsa-devel@alsa-project.org>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

Dne 27.11.2017 v 22:24 Takashi Iwai napsal(a):
> On Mon, 27 Nov 2017 21:49:06 +0100,
> Jaroslav Kysela wrote:
>>
>> Dne 27.11.2017 v 21:24 Takashi Iwai napsal(a):
>>> On Mon, 27 Nov 2017 19:19:51 +0100,
>>> Takashi Sakamoto wrote:
>>>>
>>>> Hi Jaroslav,
>>>>
>>>> On Nov 27 2017 17:50, Jaroslav Kysela wrote:
>>>>> The dlopen() function might fail also for another reason than
>>>>> a missing file, thus return the error string from dlerror().
>>>>>
>>>>> Signed-off-by: Jaroslav Kysela <perex@perex.cz>
>>>>> ---
>>>>>   include/global.h        |  2 +-
>>>>>   src/Versions.in         |  5 +++++
>>>>>   src/conf.c              | 13 ++++++-----
>>>>>   src/dlmisc.c            | 60 +++++++++++++++++++++++++++++++++++++++----------
>>>>>   src/hwdep/hwdep.c       |  6 ++---
>>>>>   src/mixer/simple_abst.c | 10 ++++-----
>>>>>   src/pcm/pcm_hooks.c     |  8 +++----
>>>>>   src/pcm/pcm_meter.c     |  6 ++---
>>>>>   src/rawmidi/rawmidi.c   |  6 ++---
>>>>>   src/seq/seq.c           |  6 ++---
>>>>>   src/timer/timer.c       |  6 ++---
>>>>>   src/timer/timer_query.c |  6 ++---
>>>>>   12 files changed, 88 insertions(+), 46 deletions(-)
>>>>
>>>> Unfortunately, this patch brings build error in my environment (Ubuntu
>>>> 17.10 amd64, gcc7.2.0 from gcc-7 7.2.0-8ubuntu3).
>>>>
>>>> $ ./gitcompile
>>>> $ make
>>>> make[2]: Entering directory '/tmp/alsa-lib/src'
>>>>   CCLD     libasound.la
>>>> /usr/bin/ld: unable to find version dependency `ALSA_1.1.6'
>>>> pcm/.libs/libpcm.a(pcm_generic.o): In function `snd1_pcm_generic_hwsync':
>>>> /tmp/alsa-lib/src/pcm/pcm_generic.c:142: warning:
>>>> collect2: error: ld returned 1 exit status
>>>> Makefile:491: recipe for target 'libasound.la' failed
>>>> make[2]: *** [libasound.la] Error 1
>>>>
>>>> At present, I don't know exactly the reason, but I'll start
>>>> investigating it in next morning (I'd like to have sleep...).
>>>
>>> It's likely a bogus definition in version symbols.
>>> It has to be a form like:
>>>
>>>   ALSA_1.1.6 {
>>>     global:
>>>       @SYMBOL_PREFIX@snd_dlopen;
>>>   } ALSA_1.1.5;
>>>
>>> while the patch put "ALSA_1.1.6" to both places.
>>
>> Yes, I forgot to modify src/Versions.in (I modified only src/Versions
>> for my local build).
>>
>>> Besides that, I'm scared by the versioned symbols, of which I have
>>> only a bad memory.
>>
>> I know, but the major issue that we forgot to apply old symbol versions
>> to some functions in the past, right ? I don't see any drawback.
> 
> IIRC, some apps didn't compile the stuff properly with the versioned
> symbols, thus fall back to bind with the old symbols without error,
> which leads to a crash at runtime.

It's probably a linking issue which should be resolved by the developer.

> Another case is when an app or a library does symbol resolution by
> itself via dlopen and dlsym.  libao does it, for example.

The developers might use dlvsym() or recompile and fix compilation
errors for new library.

> The snd_dlopen() isn't supposed to be used widely in external apps, so
> maybe the influence is limited.  But I still feel bad with the usage
> of versioned symbols unless really needed.  In this case, we can avoid
> the issue just by adding another better function.  And, the purpose is
> only for a better debuggability, so the change in caller side isn't
> mandatory.

Yep, snd_dlopen() is probably not used outside alsa-lib at all.

The glibc is full of versioned symbols and it seems that it plays good
with them.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
