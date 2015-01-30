From: Eric Nelson <eric.nelson@boundarydevices.com>
Subject: Re: [PATCH V2] ASoC: sgtl5000: add delay before first
 I2C access
Date: Fri, 30 Jan 2015 15:02:02 -0700
Message-ID: <54CBFF5A.4050008@boundarydevices.com>
References: <1422651131-13261-1-git-send-email-eric.nelson@boundarydevices.com>
 <1422652075-13604-1-git-send-email-eric.nelson@boundarydevices.com>
 <CAOMZO5BwM1CEAtFnqxS9xwSy2OamHCuEw=YBT8vf5FNa_4GA7A@mail.gmail.com>
 <54CBFC9C.5060906@mail.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 99119260669
 for <alsa-devel@alsa-project.org>; Fri, 30 Jan 2015 23:02:06 +0100 (CET)
Received: by mail-pa0-f46.google.com with SMTP id lj1so57152724pab.5
 for <alsa-devel@alsa-project.org>; Fri, 30 Jan 2015 14:02:05 -0800 (PST)
In-Reply-To: <54CBFC9C.5060906@mail.bg>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nikolay Dimitrov <picmaster@mail.bg>
Cc: Takashi Iwai <tiwai@suse.de>, Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Nikolay,

On 01/30/2015 02:50 PM, Nikolay Dimitrov wrote:
> Hi Eric,
> 
> On 01/30/2015 11:31 PM, Fabio Estevam wrote:
>> Hi Eric,
>>
>> On Fri, Jan 30, 2015 at 7:07 PM, Eric Nelson
>> <eric.nelson@boundarydevices.com> wrote:
>>> To quote from section 1.3.1 of the data sheet:
>>>          The SGTL5000 has an internal reset that is deasserted
>>>          8 SYS_MCLK cycles after all power rails have been brought
>>>          up. After this time, communication can start
>>>
>>>          ...
>>>          1.0uS represents 8 SYS_MCLK cycles at the minimum 8.0 MHz
>>> SYS_MCLK.
>>
>> Small detail: Should be us instead of uS.
> 
> FYI - If you're observing issues with communicating with SGTL5000 I2C,
> please make sure also that the chip has a valid clock signal on
> SYS_MCLK, otherwise it won't respond on I2C transactions (I2C will work
> with any SYS_MCLK in the range 8-27MHz).
> 

Thanks for that, but the issue we're seeing and that made me spot this
was a very intermittent problem (1 in many 1000's of boots) reported by
a customer on our 3.10.17 code base.

We haven't been able to repeat the issue, but the failure is in the
initial read of the CHIP_ID register (i.e. the first I2C access) and
the docs clearly state that a 1us delay is needed.

I haven't found the commit that removed it, but earlier versions
of sgtl5000.c had a udelay(10) before the first I2C access.

Regards,


Eric
