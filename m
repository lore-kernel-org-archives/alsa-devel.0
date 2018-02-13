From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Fix master mode clock
	I2S bus clocks
Date: Tue, 13 Feb 2018 11:22:47 +0200
Message-ID: <f83337ef-a2d7-5780-f6ad-34487b3ac29a@ti.com>
References: <20180212140646.3268-1-peter.ujfalusi@ti.com>
 <b582d1d1-a027-f7cf-1f2e-a09a411f1354@ti.com>
 <cdf06301-8166-3035-97db-0e87d3888192@ti.com>
 <fe5d4632-7b31-8001-f2b9-98a6ee3ed317@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx194.ext.ti.com (lelnx194.ext.ti.com [198.47.27.80])
 by alsa0.perex.cz (Postfix) with ESMTP id 574A726785C
 for <alsa-devel@alsa-project.org>; Tue, 13 Feb 2018 10:22:51 +0100 (CET)
In-Reply-To: <fe5d4632-7b31-8001-f2b9-98a6ee3ed317@ti.com>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Andrew F. Davis" <afd@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 12/02/18 19:27, Andrew F. Davis wrote:
>>> If all output/input is disconnected why do we need the I2C clocks?
>> we need I2S clocks when user is running audio, otherwise it will time
>> out with error.
>>
> You mean in the case were they have the device set to route the I2S
> stream to a dead end inside the CODEC (DAC IN -> OFF), but still want to
> push data down the I2S line?
> 
> Is there no way to communicate the device is muted back to the I2S data
> master to not try to push data

The audio device should still keep the stream flowing and continue
draining (or pushing) the samples even if the path is muted. Doing that
properly in any other way than keeping the I2S clocked is quite complicated.

Best regards,
Jyri

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
