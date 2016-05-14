From: Trent Reed <treed0803@gmail.com>
Subject: Re: Errors iterating over PCM stream hints and opening
 based on NAME/IOID
Date: Fri, 13 May 2016 22:09:47 -0700
Message-ID: <CAL6pMWqxayL=hOq=EezPJuF1AZ-1_mg0zEBtwtOjV+Zn59+5Xw@mail.gmail.com>
References: <CAL6pMWrVwYd7nw46006LeRs=qyBAgeZYTV2K_0pLoMtZYfcfsQ@mail.gmail.com>
 <s5hposrbatz.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
 [209.85.218.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FBA9261AD0
 for <alsa-devel@alsa-project.org>; Sat, 14 May 2016 07:09:48 +0200 (CEST)
Received: by mail-oi0-f68.google.com with SMTP id t140so7658487oie.0
 for <alsa-devel@alsa-project.org>; Fri, 13 May 2016 22:09:48 -0700 (PDT)
In-Reply-To: <s5hposrbatz.wl-tiwai@suse.de>
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

Hey Takashi,

Glad that this issue with bidirectional PCM hints was patched. :)
I appreciate your help and input!

Thanks,
- Trent Reed

On Thu, May 12, 2016 at 7:38 AM, Takashi Iwai <tiwai@suse.de> wrote:
> On Sat, 07 May 2016 05:19:45 +0200,
> Trent Reed wrote:
>>
>> Hey All,
>>
>> (Tried to send an email earlier, it didn't seem to send?)
>>
>> I'm trying to understand ALSA, having a little trouble with some
>> errors that I can't ration over.
>> Gist Repro: https://gist.github.com/TReed0803/353ce27d37bc1ebe965854ea88c8b97b
>>
>> Whenever I run the above simple code (iterate over PCM stream hints,
>> open for Playback/Capture depending on IOID; output also provided at
>> link above) I notice that I sometimes hit errors. I'm having trouble
>> understanding these errors, because as I understand I'm using the ALSA
>> library correctly. For example, dmix is telling me that it "Only
>> supports playback streams", well then, why does the hint IOID return
>> that it supports capture as well? (same for dsnoop).
>
> Oh, these are real bugs.  They shouldn't have been listed as
> bidirectional, indeed.  The fix patches are below.
>
>> More confusing
>> are the "ALSA lib pcm_route.c:867:(find_matching_chmap) Found no
>> matching channel map" errors.
>
> This is a bit more complicated.  I suppose you're testing with
> HD-audio, right?  HD-audio has a restriction that it accepts only even
> numbered streams (2, 4, 6, 8).  The error comes from the definition of
> surround21, i.e. the odd numbers.  But, you can still use this
> definition by wrapping with plug, so that the missing one channel is
> filled automatically while using the given channel allocation.
>
> thanks,
>
> Takashi
>
