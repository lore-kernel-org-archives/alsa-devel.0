From: Daniel Mack <zonque@gmail.com>
Subject: Re: DT support for Davinci ASoC platform
Date: Wed, 08 Aug 2012 15:36:37 +0200
Message-ID: <50226B65.4090804@gmail.com>
References: <1BAFE6F6C881BF42822005164F1491C33EA35352@DBDE01.ent.ti.com>
 <4FF5733E.6000604@gmail.com> <501AE3C6.8040708@gmail.com>
 <501B954C.3070606@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 33AE4266208
 for <alsa-devel@alsa-project.org>; Wed,  8 Aug 2012 15:06:57 +0200 (CEST)
Received: by bkcjk13 with SMTP id jk13so265043bkc.38
 for <alsa-devel@alsa-project.org>; Wed, 08 Aug 2012 06:36:43 -0700 (PDT)
In-Reply-To: <501B954C.3070606@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: "Porter, Matt" <mporter@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Rajashekhara,
 Sudhakar" <sudhakar.raj@ti.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "Hebbar,
 Gururaja" <gururaja.hebbar@ti.com>, "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>, "Girdwood,
 Liam" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hi Serkar,

On 03.08.2012 11:09, Sekhar Nori wrote:
> On 8/3/2012 2:02 AM, Daniel Mack wrote:
>> On 05.07.2012 12:58, Daniel Mack wrote:
>>> Hi Gururaja,
>>>
>>> On 04.07.2012 14:48, Hebbar, Gururaja wrote:
>>>> All,
>>>>
>>>> Are there any plans or work going on for providing Device Tree Support for Davinci
>>>> ASoC?
>>>>
>>>> I am planning to add DT support for TI AM335x (McASP) and I don't want to do duplicate
>>>> task.
>>>
>>> That's good to know. But isn't there a dependency on the EDMA engine? Is
>>> that part ported yet?
>>
>> May I ask whether you made any progress on that yet?
> 
> Matt Porter from TI is working on DMA engine migration. This would still
> be some time away since there is a bunch of work involved here.
> 
> To make progress on Audio DT conversion Gururaja is doing an up port of
> AM335x EDMA support from TI release to mainline kernel. If you are
> interested in it, he can probably share that with you once he posts his
> DT patches.

As the DMA engine is also a requirement for the MMC controller, I would
be interested in helping, in case help is required. Is there any
repository with code that I can have a look at?

Thanks,
Daniel
