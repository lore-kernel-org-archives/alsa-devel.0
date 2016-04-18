From: Petr Kulhavy <petr@barix.com>
Subject: Re: [PATCH v2 2/6] ASoC: Davinci: McBSP: add device
 tree support for McBSP
Date: Mon, 18 Apr 2016 12:24:54 +0200
Message-ID: <5714B5F6.9@barix.com>
References: <1460375117-4311-1-git-send-email-petr@barix.com>
 <1460375117-4311-3-git-send-email-petr@barix.com> <5710B516.2000006@ti.com>
 <5714A864.5050505@barix.com> <5714B469.1040408@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
 by alsa0.perex.cz (Postfix) with ESMTP id A12F52650B0
 for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2016 12:24:57 +0200 (CEST)
Received: by mail-wm0-f42.google.com with SMTP id u206so116716329wme.1
 for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2016 03:24:57 -0700 (PDT)
In-Reply-To: <5714B469.1040408@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, nsekhar@ti.com, khilman@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, devicetree@vger.kernel.org
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, robh+dt@kernel.org, galak@codeaurora.org
List-Id: alsa-devel@alsa-project.org



On 18.04.2016 12:18, Peter Ujfalusi wrote:
> On 04/18/16 12:27, Petr Kulhavy wrote:
>
>> Or what do you think the pdata should carry?
> Good question. Since the driver itself does not care about pdata I would
> remove it. On the other hand if you implement the FIFO handling you will need
> pdata for legacy mode to select the FIFO threshold.
> Currently there is one pdata structure for legacy mode used by the McASP,
> McBSP and the Voice Codec. It contains mixed options applicable for all and
> some which applicable only for one of the drivers...
> I think if we want to make things clean and neat we would aim to have separate
> pdata for each of the drivers.
>
> I would probably drop the current pdata for McBSP and when I see what data I
> need for the driver later I would create one for the McBSP only.
>

Thanks, Peter. I agree with you.
I don't have the time to implement the FIFO now, so it makes sense to 
drop the pdata for now and add a dedicated one if needed later.
Shall I remove the pdata also from the EVK legacy board drivers?

I'm going to prepare another patch set.

Cheers
Petr
