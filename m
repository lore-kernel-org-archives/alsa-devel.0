From: Kirill Marinushkin <k.marinushkin@gmail.com>
Subject: Re: [RFC,
 alsa-utils] RFC: alsamixer: Improve description of playback switches
Date: Mon, 26 Mar 2018 23:13:49 +0200
Message-ID: <bb64a7f3-1664-65cc-871d-da7d5952a864@gmail.com>
References: <20180326051144.16672-1-k.marinushkin@gmail.com>
 <s5ho9jb70ce.wl-tiwai@suse.de>
 <58f2b5d7-35ce-7233-2dbf-d4e1f0b1f617@gmail.com>
 <CANVWZtF6B_Bnv+tGfUVVkjE8PhBQXSMqTdUBa-n1D+uMeVh4=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 26DD9266FA1
 for <alsa-devel@alsa-project.org>; Mon, 26 Mar 2018 23:13:17 +0200 (CEST)
Received: by mail-wm0-f67.google.com with SMTP id i75so17932970wmf.0
 for <alsa-devel@alsa-project.org>; Mon, 26 Mar 2018 14:13:17 -0700 (PDT)
In-Reply-To: <CANVWZtF6B_Bnv+tGfUVVkjE8PhBQXSMqTdUBa-n1D+uMeVh4=Q@mail.gmail.com>
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
To: Andrew Chant <achant@google.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

On 03/26/18 22:41, Andrew Chant wrote:
> On Mon, Mar 26, 2018 at 11:32 AM, Kirill Marinushkin
> <k.marinushkin@gmail.com> wrote:
>> I faced 2 problems:
>>
>> * the clock source validity was displayed as [O]. I thought it is a zero, which is the opposite from the real state
>> * I couldn't find how to turn the processing feature on. The help doesn't say anything about it
> A recent patch of mine changed clock source validity from a mixer to a
> global control, so it should no longer show up in alsamixer.

Hello Andrew,

Nice! One of the problems is solved. However, the second problem is still actual.
As you had a recent experience with alsamixer, what is your opinion?

Best Regards,
Kirill
