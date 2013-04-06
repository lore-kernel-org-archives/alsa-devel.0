From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 2/2] alsa-lib: bring pcm.h and pcm.c in
 sync with the kernel list
Date: Sat, 06 Apr 2013 13:29:50 +0200
Message-ID: <5160072E.8020500@gmail.com>
References: <1364427144-30036-1-git-send-email-zonque@gmail.com>
 <1364427144-30036-2-git-send-email-zonque@gmail.com>
 <51538493.40309@sonarnerd.net>
 <7.0.0.16.2.20130327213632.13b07718@akdesigninc.com>
 <515E8105.9070607@gmail.com>
 <7.0.0.16.2.20130405092937.144d10d0@akdesigninc.com>
 <515F388D.4060707@sonarnerd.net> <515F39B9.90202@sonarnerd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f42.google.com (mail-bk0-f42.google.com
 [209.85.214.42])
 by alsa0.perex.cz (Postfix) with ESMTP id B311926173C
 for <alsa-devel@alsa-project.org>; Sat,  6 Apr 2013 13:29:44 +0200 (CEST)
Received: by mail-bk0-f42.google.com with SMTP id jc3so2451348bkc.15
 for <alsa-devel@alsa-project.org>; Sat, 06 Apr 2013 04:29:44 -0700 (PDT)
In-Reply-To: <515F39B9.90202@sonarnerd.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jussi Laako <jussi@sonarnerd.net>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, clemens@ladisch.de, demian@auraliti.com, ray@auraliti.com, Andreas Koch <andreas@akdesigninc.com>
List-Id: alsa-devel@alsa-project.org

On 05.04.2013 22:53, Jussi Laako wrote:
>> On 04/05/2013 10:59 PM, Andreas Koch wrote:
>> However, they are interpreting the ASIO spec for DSD differently.  They
>> express buffer size in samples, which means that for DSD it is measured
>> in bits.
> 
> One more thing.. So the logic should go like this:
> 
> DSD sample -> 1-bit -> sample rates in bits per second -> buffer and 
> latency sizes in bits.
> 
> ...or...
> 
> DSD sample -> 8-bit -> sample rates in bytes per second -> buffer and 
> latency sizes in bytes.
> 
> But please, please, don't mix bits and bytes in the API, always use only 
> either of these.

Well, we don't care for the ASIO spec of course, as we do not share any
compatibility layer with them. So we can define whatever we think is
useful and consistent.

All audio formats are specified in *bytes* for sample and buffer sizes,
so we will also keep it that way for DSD. Plus, that way we do not have
to fiddle with sample rate translations but always keep the hardware
state in sync to the user space API. Everything will end in utter
confusion at some point.

I will, however, add 'DOP' to the data type names, so it's clear that
the application stack has to deal with the padding bytes.

I'll send out new patches in a minute.


Thanks,
Daniel
