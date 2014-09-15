From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Master Plan on rewinding
Date: Mon, 15 Sep 2014 10:43:53 +0800
Message-ID: <CAN8cciabG3+Raaru0FnLHH3SvB+VoQTd8WbwTjdy+2=2y_SUKA@mail.gmail.com>
References: <540C76E0.9050808@gmail.com> <54148E72.2050903@gmail.com>
 <CAN8cciYj4fo01XZwJ-NhFQDNv6Ua5mqaAEq1zU7PYxHkJyOQ5A@mail.gmail.com>
 <541584FB.2030208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f49.google.com (mail-qa0-f49.google.com
 [209.85.216.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 69DEC2608C9
 for <alsa-devel@alsa-project.org>; Mon, 15 Sep 2014 04:43:54 +0200 (CEST)
Received: by mail-qa0-f49.google.com with SMTP id i13so3132297qae.22
 for <alsa-devel@alsa-project.org>; Sun, 14 Sep 2014 19:43:53 -0700 (PDT)
In-Reply-To: <541584FB.2030208@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, David Henningsson <david.henningsson@canonical.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

>>  >
>>  >> === On the rewind safeguard ===
>>  >
>>  >
>>  > Result 1: it has been decided that the return value of
>> snd_pcm_rewindable() is not changed, and the safeguard is returned by a
>> separate function.
>>
>> It is unlikely to return any value which is safe, it is the
>> responsiability of the application to decide how much can be rewind
>
>
> You are placing a responsibility on an application without giving it any
means to make an informed decision. E.g. 4 ms is OK on snd-hda-intel, but
definitely not OK on ymfpci even on infinitely fast CPU (because of the
fixed 5 ms interrupt interval). The whole question here is: how is an
application supposed to know that?
>

Take a look at patent US 20100131783

System and Method of Dynamically Switching Queue Threshold

HDA may have different fifo threshold in different power states, the
granularity is not fixed

Twice the minimum period size/time is not any over estimate

Glitching still occurs at switch sink / change in power state when  you
allow sound card run with lowest latency ?

I don't think your proposal of having three different class of granularity
is good idea
