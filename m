From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: Add FSI-DA7210 sound support for
	SuperH
Date: Thu, 10 Dec 2009 09:44:23 +0000
Message-ID: <C86E9D7D-3C28-4B4F-B5F2-9F513D8EDE88@opensource.wolfsonmicro.com>
References: <u3a3kx3gu.wl%morimoto.kuninori@renesas.com>
	<20091209113205.GI19851@opensource.wolfsonmicro.com>
	<uljhb7et1.wl%morimoto.kuninori@renesas.com>
	(sfid-20091210_021817_200062_230D3B3F)
Mime-Version: 1.0 (iPhone Mail 7D11)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A627B24363
	for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2009 10:44:08 +0100 (CET)
In-Reply-To: <uljhb7et1.wl%morimoto.kuninori@renesas.com>
	(sfid-20091210_021817_200062_230D3B3F)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 10 Dec 2009, at 02:17, Kuninori Morimoto <morimoto.kuninori@renesas.com 
 > wrote:

>
> Dear Mark
>
>>> +#define DA7210_BUS 0
>>> +#define DA7210_ADR (0x34 >> 1)
>>> +static int da7210_add_i2c_device(void)
>>> +{
>>
>> This should be being done by the arch code rather than here, and  
>> there's
>> no code to remove the device on shutdown.  This idiom has been used  
>> by
>> some drivers as part of a transition from the old style ASoC stuff  
>> where
>> the I2C device was registered in the CODEC to reduce cross tree  
>> issues
>> but it's best to avoid it for new code.
>
> Wow...
> I should modify ak4642 / fsi-ak4642 too

Yes, please. It's not super urgent but it'd be a nice cleanup.
