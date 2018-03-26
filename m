From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC,
 alsa-utils] RFC: alsamixer: Improve description of playback switches
Date: Tue, 27 Mar 2018 06:44:00 +0900
Message-ID: <e1cb0e74-8372-f342-b38c-9ad4f80c0ffd@sakamocchi.jp>
References: <20180326051144.16672-1-k.marinushkin@gmail.com>
 <s5ho9jb70ce.wl-tiwai@suse.de>
 <58f2b5d7-35ce-7233-2dbf-d4e1f0b1f617@gmail.com>
 <CANVWZtF6B_Bnv+tGfUVVkjE8PhBQXSMqTdUBa-n1D+uMeVh4=Q@mail.gmail.com>
 <bb64a7f3-1664-65cc-871d-da7d5952a864@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id D23E8266FA1
 for <alsa-devel@alsa-project.org>; Mon, 26 Mar 2018 23:44:05 +0200 (CEST)
In-Reply-To: <bb64a7f3-1664-65cc-871d-da7d5952a864@gmail.com>
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
To: Kirill Marinushkin <k.marinushkin@gmail.com>, Andrew Chant <achant@google.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Mar 27 2018 06:13, Kirill Marinushkin wrote:
> On 03/26/18 22:41, Andrew Chant wrote:
>> On Mon, Mar 26, 2018 at 11:32 AM, Kirill Marinushkin
>> <k.marinushkin@gmail.com> wrote:
>>> I faced 2 problems:
>>>
>>> * the clock source validity was displayed as [O]. I thought it is a zero, which is the opposite from the real state
>>> * I couldn't find how to turn the processing feature on. The help doesn't say anything about it
>> A recent patch of mine changed clock source validity from a mixer to a
>> global control, so it should no longer show up in alsamixer.
> 
> Hello Andrew,
> 
> Nice! One of the problems is solved. However, the second problem is still actual.
> As you had a recent experience with alsamixer, what is your opinion?

I think Kirill mentions a patch to change the type of 'iface' for such 
control elements to 'SNDRV_CTL_ELEM_IFACE_CARD' or 
'SNDRV_CTL_ELEM_IFACE_PCM', but I cannot find such patches in Iwai-san's 
tree[1]. I guess they're not merged yet.

In my humble opinion, if so, Kirill's patch is not better in a view of 
compatibility, because such smixer controls suddenly disappear via 
alsa-lib's mixer APIs when the patched kernel is released. In a point of 
backward compatibility, this kind of change should be avoided, as 
possible (of cource, depending on the cases).


[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/log/?h=for-next


Regards

Takashi Sakamoto
