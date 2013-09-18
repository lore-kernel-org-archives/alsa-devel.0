From: Sander Jansen <s.jansen@gmail.com>
Subject: Re: snd_pcm_delay issue - How to debug?
Date: Wed, 18 Sep 2013 10:33:41 -0500
Message-ID: <CACj81kHkTj1OY4od2uq_uUDYc72Vt+UH2j3moSEx1s_1RZh2Qw@mail.gmail.com>
References: <CACj81kE7OVvwPbgNnSOMaU0u0JKdkSFf0ofz40VFoCi4e6ntxA@mail.gmail.com>
 <CACj81kEBBLj503jebw2MFAuKftBvQE=_wtU4smKPWKidOy=rLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f181.google.com (mail-ve0-f181.google.com
 [209.85.128.181])
 by alsa0.perex.cz (Postfix) with ESMTP id D42D22610B7
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2013 17:33:42 +0200 (CEST)
Received: by mail-ve0-f181.google.com with SMTP id oy12so5793214veb.12
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2013 08:33:42 -0700 (PDT)
In-Reply-To: <CACj81kEBBLj503jebw2MFAuKftBvQE=_wtU4smKPWKidOy=rLA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Never mind. Issue not related to alsa.


On Tue, Jul 16, 2013 at 6:27 PM, Sander Jansen <s.jansen@gmail.com> wrote:

> Here the two alsa-info dumps for the hardware I'm having the problem with.
> Also a log of my music player. It reports:
>
> The 'position' the  number of frames it has written to the device (also
> reported in seconds) and the delay at that time (after writing).
> Also the 'timestamp' which is the reported playback progress in seconds
>  reported to the UI. When the second track is played (line 590), the
> problems start to become noticeable eg. playback progress is a couple of
> seconds out of sync.
>
> Any ideas?
>
> Thanks,
>
> Sander
>
>
>
> On Tue, Jul 16, 2013 at 9:28 AM, Sander Jansen <s.jansen@gmail.com> wrote:
>
>> Hi,
>>
>> I'm seeing an issue where snd_pcm_delay is returning bogus values
>> (usually a lot larger than in actuality)  in that it ultimately affects the
>> progress timer in my audio player. Both are HDA based audio cards, though
>> one connects to the HDMI output and while the other connects to analog out.
>>
>> I'm suspecting I'm seeing a driver bug since I only start noticing the
>> issue since a few kernel releases ago (though not sure which one started
>> it).
>>
>> How can i best debug this issue and find out the cause.
>>
>> Thanks,
>>
>> Sander
>>
>
>
