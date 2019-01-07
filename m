From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Subject: Re: [PATCH] ASoC: AMD: Add delay before starting to
	capture
Date: Mon, 7 Jan 2019 06:00:35 +0000
Message-ID: <eac20959-2904-aef1-eca4-0f85c45b1207@amd.com>
References: <1546510559-17798-1-git-send-email-akshu.agrawal@amd.com>
 <20190104122741.GA4140@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820082.outbound.protection.outlook.com [40.107.82.82])
 by alsa0.perex.cz (Postfix) with ESMTP id B9EF2267A86
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 07:00:40 +0100 (CET)
In-Reply-To: <20190104122741.GA4140@sirena.org.uk>
Content-Language: en-US
Content-ID: <A2D91547C976C6419B0694D4400AC5E4@namprd12.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, "djkurtz@chromium.org" <djkurtz@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, Wei Yongjun <weiyongjun1@huawei.com>, "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
List-Id: alsa-devel@alsa-project.org



On 1/4/2019 5:57 PM, Mark Brown wrote:
> On Thu, Jan 03, 2019 at 10:18:13AM +0000, Agrawal, Akshu wrote:
>> On capture through dmic we observe a glitch at the start of record.
>> This is because we start capturing even before dmic is ready to send
>> out data. The glitch seen last for ~20msec.
>>
> 
>> +	/*
>> +	 * On some platforms, it takes ~20 msec for PDM DMICs and ADAU7002
>> +	 * to settle and start producing proper audio data.
>> +	 */
>> +	msleep(ADAU7002_DELAY_MS);
> 
> If the delay is required for external components to start up the delay
> should be going in the drivers for those components rather than in the
> driver for the CPU side, that way other systems using those components
> get the benefit and non-affected boards don't pay the cost.  There's
> already some support for this in the DMIC driver at least.
> 

Agreed, we can use the similar to wakeup_delay in dmic driver in our
codec driver. Will post the patch on same lines.

Thanks,
Akshu
