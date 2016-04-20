From: Petr Kulhavy <petr@barix.com>
Subject: Re: GPIO control from ALSA
Date: Wed, 20 Apr 2016 11:47:38 +0200
Message-ID: <5717503A.9050000@barix.com>
References: <571737E4.5030908@barix.com> <57173EEB.5040403@metafoo.de>
 <5717430B.1030109@barix.com> <57174681.2050908@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
 by alsa0.perex.cz (Postfix) with ESMTP id D754C261B0A
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2016 11:47:40 +0200 (CEST)
Received: by mail-wm0-f50.google.com with SMTP id v188so195793235wme.1
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2016 02:47:40 -0700 (PDT)
In-Reply-To: <57174681.2050908@metafoo.de>
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



On 20.04.2016 11:06, Lars-Peter Clausen wrote:
> On 04/20/2016 10:51 AM, Petr Kulhavy wrote:
>>
>> Thanks, Lars, for the good pointers! I will check that out.
>>
>> Is there also a way to map GPIO to a control which then appears e.g. in
>> alsamixer? That would be useful for the mic/line selection.
> Rather than exposing the GPIO itself you'd expose the logical function of
> the GPIO. E.g. in your case a ENUM control that allows to switch between
> microphone and capture and in the background this sets the GPIO according to
> the selection.

I understand that, my question was more how to hook the enum to a 
function rather to a codec register?

Thanks
Petr
