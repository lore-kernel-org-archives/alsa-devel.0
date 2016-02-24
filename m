From: Petr Kulhavy <petr@barix.com>
Subject: Re: Codec "virtual multiplexer" representation
Date: Wed, 24 Feb 2016 17:57:30 +0100
Message-ID: <56CDE0FA.8000905@barix.com>
References: <56C499A7.2040202@barix.com>
 <20160218053021.GE6263@borg.dal.design.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FB5A26153C
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2016 17:57:32 +0100 (CET)
Received: by mail-wm0-f52.google.com with SMTP id b205so42701936wmb.1
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2016 08:57:32 -0800 (PST)
In-Reply-To: <20160218053021.GE6263@borg.dal.design.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andreas Dannenberg <dannenberg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 18.02.2016 06:30, Andreas Dannenberg wrote:
>
> Petr,
> on a related note, I'm currently working on a combined driver (85%
> complete) for TAS5720/TAS5722 which are nice but relatively simple
> Class-D mono amplifiers. Despite almost having the same P/N there is
> little to no similarity with TAS5721 (which gives a another example why
> one should be careful with wildcard 'x' in driver names) so there is no
> case for a combined driver here but let's make sure we align our
> namespace to avoid collision:
>
> tas5720.[c|h] - Driver for TAS5720/TAS5722 (WIP by Andreas)
> tas5721.[c|h] - Driver for TAS5721 (WIP by Petr)
>
> Regards,
>
> --
> Andreas Dannenberg
> Texas Instruments Inc
>
Hi Andreas,

thanks for letting me know! In the meantime I have found there is a 
driver for TAS5711, TAS5717 and TAS5719.
The TAS5721 is very similar to the 5711, so I will just update that 
driver rather than creating a new one.

One question came to my mind, which you can perhaps help me to answer as 
you are more familiar with these amplifiers:
what is the usual representation of a 2.1 system in controls? I'm 
wondering that the TAS5711 has just master volume and a double slider 
for Ch1/Ch2, but there is no Ch3 control.
Surely that is needed as well, isn't it?

Regards
Petr
