From: maruthi srinivas <maruthi.srinivas.b@gmail.com>
Subject: Re: pulseaudio external mic jack detection - ASoC
	based card
Date: Wed, 22 Jul 2015 20:43:50 +0530
Message-ID: <CANv6ZMb5oJCF2s3Yu-s2rZKqQXLnzrQxHucZfgFXKgErUaDS9Q@mail.gmail.com>
References: <CANv6ZMYHA7V9Dt0xfxS6jdy5WTbho28p=7p9ZLZNw_tsSQbmfQ@mail.gmail.com>
 <55AF8C86.4070106@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f173.google.com (mail-qk0-f173.google.com
 [209.85.220.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E621260710
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2015 17:13:51 +0200 (CEST)
Received: by qkdv3 with SMTP id v3so155092985qkd.3
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2015 08:13:50 -0700 (PDT)
In-Reply-To: <55AF8C86.4070106@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is for  upcoming AMD ASoC driver.

On Wed, Jul 22, 2015 at 5:58 PM, David Henningsson <
david.henningsson@canonical.com> wrote:

>
>
> On 2015-07-08 13:03, maruthi srinivas wrote:
>
>> Hi,
>>
>> I have a issue with mic jack status in Ubuntu "sound settings"  UI.  When
>> external mic is removed, UI still shows Mic.
>> When compared to HD Azalia driver, UI shouldn't show any external Mic jack
>> information, if it is removed.
>>
>> Codec driver I use reports jack status properly and uses
>> snd_soc_jack_report().
>> /proc/interrupts, /dev/input/eventX  reflects jack activity. But the same
>> is not reflected in UI.
>>
>> I want to know how pulseaudio detect jack status for drivers which follow
>> ALSA SoC architecture.
>> Does it read from any event from /dev/input/eventX ?
>>
>> Please help in understanding.
>>
>
> Has this not been unified in (very) recent kernels, so that ASoC also
> creates kcontrols, or at least has the possibility to do so?
>
> Also, out of curiousity, what machine is this?
>
> --
> David Henningsson, Canonical Ltd.
> https://launchpad.net/~diwic
>
