From: Nikolay Dimitrov <picmaster@mail.bg>
Subject: Re: [PATCH V2] ASoC: sgtl5000: add delay before first
 I2C access
Date: Sat, 31 Jan 2015 00:24:23 +0200
Message-ID: <54CC0497.2030505@mail.bg>
References: <1422651131-13261-1-git-send-email-eric.nelson@boundarydevices.com>
 <1422652075-13604-1-git-send-email-eric.nelson@boundarydevices.com>
 <CAOMZO5BwM1CEAtFnqxS9xwSy2OamHCuEw=YBT8vf5FNa_4GA7A@mail.gmail.com>
 <54CBFC9C.5060906@mail.bg> <54CBFF5A.4050008@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.mail.bg (mx2.mail.bg [193.201.172.118])
 by alsa0.perex.cz (Postfix) with ESMTP id 0013D260687
 for <alsa-devel@alsa-project.org>; Fri, 30 Jan 2015 23:24:23 +0100 (CET)
In-Reply-To: <54CBFF5A.4050008@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eric Nelson <eric.nelson@boundarydevices.com>
Cc: Takashi Iwai <tiwai@suse.de>, Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Eric,

On 01/31/2015 12:02 AM, Eric Nelson wrote:
> Hi Nikolay,
>
> On 01/30/2015 02:50 PM, Nikolay Dimitrov wrote:
>> Hi Eric,
>>
>> On 01/30/2015 11:31 PM, Fabio Estevam wrote:
>>> Hi Eric,
>>>
>>> On Fri, Jan 30, 2015 at 7:07 PM, Eric Nelson
>>> <eric.nelson@boundarydevices.com> wrote:
>>>> To quote from section 1.3.1 of the data sheet:
>>>>           The SGTL5000 has an internal reset that is deasserted
>>>>           8 SYS_MCLK cycles after all power rails have been brought
>>>>           up. After this time, communication can start
>>>>
>>>>           ...
>>>>           1.0uS represents 8 SYS_MCLK cycles at the minimum 8.0 MHz
>>>> SYS_MCLK.
>>>
>>> Small detail: Should be us instead of uS.
>>
>> FYI - If you're observing issues with communicating with SGTL5000 I2C,
>> please make sure also that the chip has a valid clock signal on
>> SYS_MCLK, otherwise it won't respond on I2C transactions (I2C will work
>> with any SYS_MCLK in the range 8-27MHz).
>>
>
> Thanks for that, but the issue we're seeing and that made me spot this
> was a very intermittent problem (1 in many 1000's of boots) reported by
> a customer on our 3.10.17 code base.
>
> We haven't been able to repeat the issue, but the failure is in the
> initial read of the CHIP_ID register (i.e. the first I2C access) and
> the docs clearly state that a 1us delay is needed.
>
> I haven't found the commit that removed it, but earlier versions
> of sgtl5000.c had a udelay(10) before the first I2C access.

I see. Had similar issue with 3.10.17 (fsl), when sometimes on
hot-reset the (imx6) I2C controller was somehow locked-up on boot and
prevented the driver from reading CHIP_ID, and thus no sound at all.
But on 3.17x/3.18x mainline kernels + riotboard, this initial SGTL5000
configuration is much much better, haven't seen cases when it doesn't
detect the codec.

If you can reproduce the defect, you can try to exercise the I2C
channel and see whether it still works at all.

I'm mentioning this because it's a different root-cause that has quite
similar observable effect. Otherwise I truly agree that reset timings
as per datasheet are very good to be followed.

Kind regards,
Nikolay
