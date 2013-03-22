From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 2/2 resend] ASoC: cs4271: preserve "Master
 Playback Switch" setting
Date: Fri, 22 Mar 2013 12:04:54 +0100
Message-ID: <514C3AD6.6080301@gmail.com>
References: <1363895035-20356-1-git-send-email-zonque@gmail.com>
 <1363895035-20356-2-git-send-email-zonque@gmail.com>
 <20130322101820.GC22890@opensource.wolfsonmicro.com>
 <514C3124.8010806@gmail.com>
 <20130322103247.GF22890@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f47.google.com (mail-bk0-f47.google.com
 [209.85.214.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 902012664C2
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 12:05:16 +0100 (CET)
Received: by mail-bk0-f47.google.com with SMTP id jc3so1802985bkc.34
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 04:05:16 -0700 (PDT)
In-Reply-To: <20130322103247.GF22890@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, subaparts@yandex.ru, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 22.03.2013 11:32, Mark Brown wrote:
> On Fri, Mar 22, 2013 at 11:23:32AM +0100, Daniel Mack wrote:
>> On 22.03.2013 11:18, Mark Brown wrote:
> 
>>> The usual fix for this is to just not have the mute operation if it's
>>> important.  Otherwise this seems like something we ought to implement in
>>> the core, it's not a silly feature by any stretch of the imagination but
>>> it applies to any device with a DAI mute unless there's some device
>>> specific thing I'm missing here.
> 
>> So I'd say having a simple OR logic in this case is reasonable and
>> serves all the needs I can think of, no?
> 
> You're not really responding to what I'm saying here.  What I'm saying
> is that if this is useful it should be implemented in the core unless
> there's some reason I'm missing why this is specific to this driver.

Ok, point taken. It's just not really a drop-in equivalent, given that
both the numid and the name string will change then.

I'll see when I'll find some time to do that. Your idea is to have a
"Master Playback Switch" for both the CPU and the Codec on each link, if
the driver implements either ->mute_stream or ->digital_mute, right? And
the control would default to "on"?


Thanks,
Daniel
