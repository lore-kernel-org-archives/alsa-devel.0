From: Kirill Marinushkin <k.marinushkin@gmail.com>
Subject: Re: [RFC,
 alsa-utils] RFC: alsamixer: Improve description of playback switches
Date: Tue, 27 Mar 2018 21:12:01 +0200
Message-ID: <b0b861a6-b466-1ecd-4f81-328883c64c47@gmail.com>
References: <20180326051144.16672-1-k.marinushkin@gmail.com>
 <s5ho9jb70ce.wl-tiwai@suse.de>
 <58f2b5d7-35ce-7233-2dbf-d4e1f0b1f617@gmail.com>
 <CANVWZtF6B_Bnv+tGfUVVkjE8PhBQXSMqTdUBa-n1D+uMeVh4=Q@mail.gmail.com>
 <bb64a7f3-1664-65cc-871d-da7d5952a864@gmail.com>
 <e1cb0e74-8372-f342-b38c-9ad4f80c0ffd@sakamocchi.jp>
 <185d4bb1-8af6-23a4-5abd-86d91ace83f2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 by alsa0.perex.cz (Postfix) with ESMTP id B7FF8267063
 for <alsa-devel@alsa-project.org>; Tue, 27 Mar 2018 21:11:29 +0200 (CEST)
Received: by mail-wm0-f65.google.com with SMTP id x82so850130wmg.1
 for <alsa-devel@alsa-project.org>; Tue, 27 Mar 2018 12:11:29 -0700 (PDT)
In-Reply-To: <185d4bb1-8af6-23a4-5abd-86d91ace83f2@gmail.com>
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
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, Andrew Chant <achant@google.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Takashi Sakamoto, Takashi Iwai, Andrew Chant,

Thank you for the discussion. I saw the drawbacks of my proposal, and it was nice to clarify them with you.

Also, during our discussion I found, that the "description of playback switches" has a different solution.
I will check my new idea. If it will work good enough, I will send a patch later.

>From my perspective, we can consider this RFC to be closed.

Thanks for your attention.

Best Regards,
Kirill

On 03/26/18 23:53, Kirill Marinushkin wrote:
> On 03/26/18 23:44, Takashi Sakamoto wrote:
>> Hi,
>>
>> On Mar 27 2018 06:13, Kirill Marinushkin wrote:
>>> On 03/26/18 22:41, Andrew Chant wrote:
>>>> On Mon, Mar 26, 2018 at 11:32 AM, Kirill Marinushkin
>>>> <k.marinushkin@gmail.com> wrote:
>>>>> I faced 2 problems:
>>>>>
>>>>> * the clock source validity was displayed as [O]. I thought it is a zero, which is the opposite from the real state
>>>>> * I couldn't find how to turn the processing feature on. The help doesn't say anything about it
>>>> A recent patch of mine changed clock source validity from a mixer to a
>>>> global control, so it should no longer show up in alsamixer.
>>> Hello Andrew,
>>>
>>> Nice! One of the problems is solved. However, the second problem is still actual.
>>> As you had a recent experience with alsamixer, what is your opinion?
>> I think Kirill mentions a patch to change the type of 'iface' for such control elements to 'SNDRV_CTL_ELEM_IFACE_CARD' or 'SNDRV_CTL_ELEM_IFACE_PCM', but I cannot find such patches in Iwai-san's tree[1]. I guess they're not merged yet.
> Andrew mentioned the patch [2]
>
>> In my humble opinion, if so, Kirill's patch is not better in a view of compatibility, because such smixer controls suddenly disappear via alsa-lib's mixer APIs when the patched kernel is released. In a point of backward compatibility, this kind of change should be avoided, as possible (of cource, depending on the cases).
> The patch of Andrew and my RFC serve different purposes. They do not replace each other.
> Patch of Andrew made the "clock valid" global.
> My RFC is to add the string in the help, to clarify how to toggle the switches in alsamixer.
>
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/log/?h=for-next
>>
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/?h=for-next&id=568fa7e087ef98bc85b5aa31ea7c9252c1305c1f
>
>> Regards
>>
>> Takashi Sakamoto
