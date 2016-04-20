From: Petr Kulhavy <petr@barix.com>
Subject: Re: GPIO control from ALSA
Date: Wed, 20 Apr 2016 10:51:23 +0200
Message-ID: <5717430B.1030109@barix.com>
References: <571737E4.5030908@barix.com> <57173EEB.5040403@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 54A4D261B0A
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2016 10:51:25 +0200 (CEST)
Received: by mail-wm0-f52.google.com with SMTP id n3so69671791wmn.0
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2016 01:51:25 -0700 (PDT)
In-Reply-To: <57173EEB.5040403@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 20.04.2016 10:33, Lars-Peter Clausen wrote:
> On 04/20/2016 10:03 AM, Petr Kulhavy wrote:
>> Hello,
>>
>> I'm writing a driver for ASoC "sound card" hardware which uses CPU GPIO to
>> mute/unmute an analogue amplifier and another GPIO to control an analogue
>> switch for line/mic switching. Is there an abstraction in ALSA to model this
>> kind of hardware?
> There is no abstraction. Use controls and/or DAPM and the standard GPIO API,
> if you grep the sources you'll find a few examples of drivers using GPIOs to
> mute amplifiers and similar (e.g. qi_lb60).
>
> - Lars

Thanks, Lars, for the good pointers! I will check that out.

Is there also a way to map GPIO to a control which then appears e.g. in 
alsamixer? That would be useful for the mic/line selection.

Regards
Petr
