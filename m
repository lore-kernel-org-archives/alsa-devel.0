From: Dmitry <dbaryshkov@gmail.com>
Subject: Re: [PATCH 1/4] Separate common pxa2xx-ac97 code
Date: Thu, 11 Sep 2008 18:51:26 +0400
Message-ID: <bc64b4640809110751y4faf2c67o3974f28c69b6bced@mail.gmail.com>
References: <1221008480-13377-1-git-send-email-dbaryshkov@gmail.com>
	<20080911143005.GA12311@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.154])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C03024151
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Sep 2008 16:51:27 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 36so146023yxh.2
	for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2008 07:51:26 -0700 (PDT)
In-Reply-To: <20080911143005.GA12311@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry Baryshkov <dbaryshkov@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2008/9/11 Mark Brown <broonie@sirena.org.uk>:
> On Wed, Sep 10, 2008 at 05:01:17AM +0400, Dmitry Baryshkov wrote:
>
>> +config SND_PXA2XX_LIB
>> +     tristate
>> +     select SND_AC97_CODEC
>> +
>>  config SND_PXA2XX_AC97
>>       tristate "AC97 driver for the Intel PXA2xx chip"
>>       depends on ARCH_PXA
>>       select SND_PXA2XX_PCM
>> -     select SND_AC97_CODEC
>> +     select SND_PXA2XX_LIB
>>       help
>
> Since select ignores dependency information in the selected thing the
> select for SND_AC97_CODEC needs to stay in SND_PXA2XX_AC97.  I'll fix
> this up locally.
>


Fine with me, thanks!


-- 
With best wishes
Dmitry
