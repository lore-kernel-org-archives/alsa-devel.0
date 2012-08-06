From: Ezequiel Garcia <elezegarcia@gmail.com>
Subject: Re: [PATCH v8] media: Add stk1160 new driver
Date: Mon, 6 Aug 2012 16:13:51 -0300
Message-ID: <CALF0-+WmqJdEprO+ShJDDVfxvE70hWaW1iXAb=9zxOYajRgStw@mail.gmail.com>
References: <1344260302-28849-1-git-send-email-elezegarcia@gmail.com>
 <CALF0-+Xwa6qNH3pEOgJq9f07C+ArNco6nxQcjGWoy5kwyQeScA@mail.gmail.com>
 <501FCFE1.7010802@redhat.com>
 <201208061618.56479.hverkuil@xs4all.nl>
 <CALF0-+U7DYEgRFMaJx4kRpNb4aeeUaTywBVDkmw99azozG_0nQ@mail.gmail.com>
 <CALF0-+UkH7o=mopJJSjRMBF-+60q+-6L=LdfJsWt17oJ0ij0Lw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gh0-f179.google.com (mail-gh0-f179.google.com
 [209.85.160.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E219265DCD
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2012 20:44:06 +0200 (CEST)
Received: by ghbg2 with SMTP id g2so2112768ghb.38
 for <alsa-devel@alsa-project.org>; Mon, 06 Aug 2012 12:13:52 -0700 (PDT)
In-Reply-To: <CALF0-+UkH7o=mopJJSjRMBF-+60q+-6L=LdfJsWt17oJ0ij0Lw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Takashi Iwai <tiwai@suse.de>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, alsa-devel@alsa-project.org, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hello,

On Mon, Aug 6, 2012 at 12:42 PM, Ezequiel Garcia <elezegarcia@gmail.com> wrote:
> Hi Mauro,
>
> On Mon, Aug 6, 2012 at 12:21 PM, Ezequiel Garcia <elezegarcia@gmail.com> wrote:
>> On Mon, Aug 6, 2012 at 11:18 AM, Hans Verkuil <hverkuil@xs4all.nl> wrote:
>>> On Mon August 6 2012 16:08:33 Mauro Carvalho Chehab wrote:
>>>> Em 06-08-2012 10:58, Ezequiel Garcia escreveu:
>>>> > Hi Mauro,
>>>> >
>>>> > On Mon, Aug 6, 2012 at 10:38 AM, Ezequiel Garcia <elezegarcia@gmail.com> wrote:
>>>> >> This driver adds support for stk1160 usb bridge as used in some
>>>> >> video/audio usb capture devices.
>>>> >> It is a complete rewrite of staging/media/easycap driver and
>>>> >> it's expected as a replacement.
>>>> >> ---
>>>> >>
>>>> >
>>>> > I just sent v8, but it looks it wasn't received by patchwork either.
>>>> >
>>>> > What's going on?
>>>>
>>>> The patch didn't arrive at linux-media ML.
>>>>
>>>> Not sure why it got rejected at vger. I suggest you to ping vger admin
>>>> to see why your patches are being rejected there.
>>>>
>>>> I tested parsing this patch manually and patchwork accepted. So, once
>>>> the issue with vger is solved, other patches should be properly
>>>> handled there.
>>>
>>> Could it be related to the fact that a gmail account is used? Konke Radlow
>>> had a similar issue recently when he posted a patch from a gmail account. It
>>> worked fine when posted from a company account.
>>>
>>
>> FWIW, I've always sent my patches from git-send-email through my gmail account.
>> Don't know if this is an issue, but it never seemed to.
>>
>
> On a second thought, perhaps it makes sense to have a git repo (on linuxtv.org)
> for me to work on stk1160.
> That way I could simply send "git pull" requests instead of patches.
>
> I'm not sure if this is a better workflow and/or would allow for
> easier reviewing.
>

Well, I just got an answer from vger administrator. He told me the
patch was exceeding
the allowed limit. Which I later discovered it was documented here:

http://vger.kernel.org/majordomo-info.html

Apparently, there is a 100, 000 characters limit.

So, how do we proceed?

Regards,
Ezequiel.
