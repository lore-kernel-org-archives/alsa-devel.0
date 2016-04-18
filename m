From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 2/6] ASoC: Davinci: McBSP: add device
 tree support for McBSP
Date: Mon, 18 Apr 2016 13:18:17 +0300
Message-ID: <5714B469.1040408@ti.com>
References: <1460375117-4311-1-git-send-email-petr@barix.com>
 <1460375117-4311-3-git-send-email-petr@barix.com> <5710B516.2000006@ti.com>
 <5714A864.5050505@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 380A72650B0
 for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2016 12:18:25 +0200 (CEST)
In-Reply-To: <5714A864.5050505@barix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <petr@barix.com>, nsekhar@ti.com, khilman@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, devicetree@vger.kernel.org
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, robh+dt@kernel.org, galak@codeaurora.org
List-Id: alsa-devel@alsa-project.org

On 04/18/16 12:27, Petr Kulhavy wrote:
>>   static int davinci_i2s_probe(struct platform_device *pdev)
>>   {
>> +    struct snd_dmaengine_dai_dma_data *dma_data;
>> +    struct snd_platform_data *pdata;
>>       struct davinci_mcbsp_dev *dev;
>>       struct resource *mem, *res;
>>       void __iomem *io_base;
>>       int *dma;
>>       int ret;
>>   -    mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +    pdata =3D davinci_i2s_set_pdata_from_of(pdev);
>> +    if (IS_ERR(pdata)) {
>> +        dev_err(&pdev->dev, "Error populating platform data, err %ld\n",
>> +            PTR_ERR(pdata));
>> +        return PTR_ERR(pdata);
>> +    }
>> The current driver does not use the pdata as far as I can see. Kind of
>> strange. So now in DT boot you will allocate memory for the pdata, which=
 is
>> not used by the driver at all.
>> I think we should implement the pdata handling in the driver first for t=
he
>> legacy mode, then probably having pdata allocated for DT case might make=
 sense.
> Indeed the current driver does not use pdata. Neither the legacy board dr=
ivers
> in arch/mach-davinci do.
> Well, except for the dm365_evm which sets the asp_chan_q which is later n=
ot used:
> =

> static struct snd_platform_data dm365_evm_snd_data __maybe_unused =3D {
>         .asp_chan_q =3D EVENTQ_3,
> };
> =

> =

> If the pdata is not used at all I would completely drop it.

the asp_chan_q was used with the old davinci_pcm which has been removed a
while ago.

> Or what do you think the pdata should carry?

Good question. Since the driver itself does not care about pdata I would
remove it. On the other hand if you implement the FIFO handling you will ne=
ed
pdata for legacy mode to select the FIFO threshold.
Currently there is one pdata structure for legacy mode used by the McASP,
McBSP and the Voice Codec. It contains mixed options applicable for all and
some which applicable only for one of the drivers...
I think if we want to make things clean and neat we would aim to have separ=
ate
pdata for each of the drivers.

I would probably drop the current pdata for McBSP and when I see what data I
need for the driver later I would create one for the McBSP only.

-- =

P=E9ter
