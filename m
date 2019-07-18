From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH 3/3] ASoC: fsl_sai: add i.MX8M support
Date: Thu, 18 Jul 2019 22:19:08 +0200
Message-ID: <a7eabb9d-6600-6b50-3f12-71fe19d971ae@intel.com>
References: <20190717105635.18514-1-l.stach@pengutronix.de>
 <20190717105635.18514-4-l.stach@pengutronix.de>
 <9ebe242b-ceac-6064-5b8b-698068fa11f0@intel.com>
 <CAEnQRZDk-O9B2iyjO=cnmqff6praf-SqNFsR=SM2Et-5Xxui5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8057CF8015B
 for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2019 22:19:16 +0200 (CEST)
In-Reply-To: <CAEnQRZDk-O9B2iyjO=cnmqff6praf-SqNFsR=SM2Et-5Xxui5Q@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Angus Ainslie <angus@akkea.ca>, Liam Girdwood <lgirdwood@gmail.com>, patchwork-lst@pengutronix.de, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On 2019-07-18 21:22, Daniel Baluta wrote:
> On Thu, Jul 18, 2019 at 10:12 PM Cezary Rojewski
> <cezary.rojewski@intel.com> wrote:
>>
>> On 2019-07-17 12:56, Lucas Stach wrote:
>>>    static const struct fsl_sai_soc_data fsl_sai_vf610_data = {
>>>        .use_imx_pcm = false,
>>> +     .has_version_registers = false,
>>>        .fifo_depth = 32,
>>>    };
>>>
>>>    static const struct fsl_sai_soc_data fsl_sai_imx6sx_data = {
>>>        .use_imx_pcm = true,
>>> +     .has_version_registers = false,
>>>        .fifo_depth = 32,
>>>    };
>>>
>>> +static const struct fsl_sai_soc_data fsl_sai_imx8m_data = {
>>> +     .use_imx_pcm = true,
>>> +     .has_version_registers = true,
>>> +     .fifo_depth = 128,
>>> +};
>>> +
>>>    static const struct of_device_id fsl_sai_ids[] = {
>>>        { .compatible = "fsl,vf610-sai", .data = &fsl_sai_vf610_data },
>>>        { .compatible = "fsl,imx6sx-sai", .data = &fsl_sai_imx6sx_data },
>>>        { .compatible = "fsl,imx6ul-sai", .data = &fsl_sai_imx6sx_data },
>>> +     { .compatible = "fsl,imx8mq-sai", .data = &fsl_sai_imx8m_data },
>>>        { /* sentinel */ }
>>>    };
>>
> 
> Hi Czarek,
> 
>> These datas are populating quite rapidly. If you're planning for adding
>> more (and/ or appending additional fields), declaring helper macro could
>> prove useful.
> 
> There would be definitely more fields inside *_data structures. Anyhow,
> not sure what do you mean by declaring a helper macro.
> 
> Can you provide an example and how would that be helpful?
> 
> thanks,
> Daniel.
> 

Hello Daniel,

My suggestion was rather straight-forward - examples of such can be 
found in soc-dapm.h header file. Instead of stating everything 
explicitly, there are e.g.: SND_SOC_DAPM_SPK or SND_SOC_DAPM_PGA 
declared to help me out.

Nothing fancy, just space savers if your structs populate like rabbits.

Czarek
