From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: Re: [PATCH v8] media: Add stk1160 new driver
Date: Thu, 09 Aug 2012 09:33:09 -0300
Message-ID: <5023AE05.1040604@redhat.com>
References: <1344260302-28849-1-git-send-email-elezegarcia@gmail.com>
 <CALF0-+Xwa6qNH3pEOgJq9f07C+ArNco6nxQcjGWoy5kwyQeScA@mail.gmail.com>
 <501FCFE1.7010802@redhat.com> <201208061618.56479.hverkuil@xs4all.nl>
 <CALF0-+U7DYEgRFMaJx4kRpNb4aeeUaTywBVDkmw99azozG_0nQ@mail.gmail.com>
 <CALF0-+UkH7o=mopJJSjRMBF-+60q+-6L=LdfJsWt17oJ0ij0Lw@mail.gmail.com>
 <CALF0-+WmqJdEprO+ShJDDVfxvE70hWaW1iXAb=9zxOYajRgStw@mail.gmail.com>
 <CALF0-+UqJUeCCakr73yHFjUvRVm6ZJ371wtTDKPmAXSWUB-57g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 315E72652D3
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2012 14:03:33 +0200 (CEST)
In-Reply-To: <CALF0-+UqJUeCCakr73yHFjUvRVm6ZJ371wtTDKPmAXSWUB-57g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ezequiel Garcia <elezegarcia@gmail.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Takashi Iwai <tiwai@suse.de>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, alsa-devel@alsa-project.org, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Em 09-08-2012 09:24, Ezequiel Garcia escreveu:
> Hi Mauro,
> 
> On Mon, Aug 6, 2012 at 4:13 PM, Ezequiel Garcia <elezegarcia@gmail.com> wrote:
>>>
>>> On a second thought, perhaps it makes sense to have a git repo (on linuxtv.org)
>>> for me to work on stk1160.
>>> That way I could simply send "git pull" requests instead of patches.
>>>
>>> I'm not sure if this is a better workflow and/or would allow for
>>> easier reviewing.
>>>
>>
>> Well, I just got an answer from vger administrator. He told me the
>> patch was exceeding
>> the allowed limit. Which I later discovered it was documented here:
>>
>> http://vger.kernel.org/majordomo-info.html
>>
>> Apparently, there is a 100, 000 characters limit.
>>
>> So, how do we proceed?
>>
> 
> Ping! Could you take a look at this?
> I'd like to solve the pending issues (see previous mails),
> in order to know if the driver will need further work.
> 
> ... or perhaps we can leave this for after the merge window, when
> you (and everyone) are be less busy.
> 
> I *really* hope I'm not spamming. In that case, feel free to say so.

The merge window was closed already. I pushed this patch directly into patchwork,
so I should be handling it sooner or later.

Unfortunately, I had a crash on my home volume group, and I'm busy those
days recovering data from it. It seems I'll be able to recover everything,
but I'll need to move about 800GB of data between two disks (one of them is
a slow one), plus my backup machine. I'll likely break it into several smaller 
logical volumes, in order to help me to keep the backup updated. So, 
that'll keep me busy for a while. In the meantime, I'm working on a slow
notebook. So, I might still be able to review and add some patches upstream,
especially the more trivial ones.

Regards,
Mauro
