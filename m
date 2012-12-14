From: Devin Anderson <surfacepatterns@gmail.com>
Subject: Re: Polling issues with the PCM multi plugin
Date: Thu, 13 Dec 2012 19:43:25 -0800
Message-ID: <CAG7zqTpWkGD5XFKEfJNYXh0bAjTNOmL-KcXBQJPj96exEYbukg@mail.gmail.com>
References: <CAG7zqTqPaLWy-1kN_4pbpbNTL4jAaEnDn6p-OT+-xsrFffpvjA@mail.gmail.com>
 <s5hd2yesbo8.wl%tiwai@suse.de>
 <CAG7zqTroztZHymJmBASNcvZ9odfEBfXpowOi=bKAxGgHAT20rA@mail.gmail.com>
 <s5h38zas9b5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f53.google.com (mail-wg0-f53.google.com [74.125.82.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EA602616DC
 for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2012 04:43:25 +0100 (CET)
Received: by mail-wg0-f53.google.com with SMTP id ei8so1184554wgb.20
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2012 19:43:25 -0800 (PST)
In-Reply-To: <s5h38zas9b5.wl%tiwai@suse.de>
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

On Wed, Dec 12, 2012 at 11:25 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Wed, 12 Dec 2012 23:04:16 -0800,
> Devin Anderson wrote:
>> Are the apps really doing the wrong thing?  It seems like
>> `snd_pcm_poll_descriptors()` and `snd_pcm_poll_descriptor_revents()`
>> are meant to operate on a single group of file descriptors, without
>> interpreting what the availability of events on each particular file
>> descriptor might mean.  This leads to some problems.
>
> Yes, grouping multiple descriptors gives ambiguity.  It must be a part
> of the problems.
>
>> As an example, let's consider what the multi plugin should do when
>> `snd_pcm_poll_descriptors_revents()` is called.  It basically has two
>> options:
>>
>> 1.) Return I/O events when one or more file descriptors have I/O events
>>
>> This is obviously problematic, as there may only be partial data
>> available.  This is also how the multi plugin works today.
>
> Right, and this behavior hasn't been changed, AFAIK.
>
>> 2.) Return I/O events when all file descriptors have I/O events.
>>
>> In this scenario, `poll()` will return when events are available on at
>> least one poll descriptor, leading to busy waiting via `poll()` until
>> I/O events are available on all file descriptors.
>
> Never implemented in such a way, so far, because this can very easily
> lead to XRUN.

So, how can this problem be solved?

I have an idea that I'd like to explore, but it's dependent on the
idea that `snd_pcm_poll_descriptors()` needs to be called before every
`poll()` call, and I'm not sure if that's a reasonable expectation.
Is `snd_pcm_poll_descriptors()` a function you can call once, and then
depend on working through multiple `poll()` calls, or is it required
that `snd_pcm_poll_descriptors()` be called for every call to refresh
the descriptors and the events they should be polled for?

Thanks,

-- 
Devin Anderson
surfacepatterns (at) gmail (dot) com

blog - http://surfacepatterns.blogspot.com/
psinsights - http://psinsights.googlecode.com/
synthclone - http://synthclone.googlecode.com/
