From: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH 1/7] ASoC: atmel: Remove redundant
 dev_err() call in probe function
Date: Tue, 27 Feb 2018 18:13:42 +0100
Message-ID: <11b53243-49ef-ce79-921a-9aa4d0f79bab@microchip.com>
References: <20180130110604.GA18123@lenoch> <20180130110654.GB18123@lenoch>
 <20180227165445.GD1479@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from esa5.microchip.iphmx.com (esa5.microchip.iphmx.com
 [216.71.150.166])
 by alsa0.perex.cz (Postfix) with ESMTP id 86D7C2676C7
 for <alsa-devel@alsa-project.org>; Tue, 27 Feb 2018 18:16:29 +0100 (CET)
In-Reply-To: <20180227165445.GD1479@piout.net>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Ladislav Michl <ladis@linux-mips.org>
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 27/02/2018 at 17:54, Alexandre Belloni wrote:
> Hi,
> 
> On 30/01/2018 at 12:06:54 +0100, Ladislav Michl wrote:
>> There is an error message within devm_ioremap_resource already,
>> so remove the redundant dev_err() call.
>>
> 
> That one can be sent as-is, don't forget to send to Mark Brown as he is
> the asoc maintainer.

Good, you can add my:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>


>> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
>> ---
>>   sound/soc/atmel/atmel-classd.c | 7 ++-----
>>   sound/soc/atmel/atmel-pdmic.c  | 7 ++-----
>>   2 files changed, 4 insertions(+), 10 deletions(-)
>>
>> diff --git a/sound/soc/atmel/atmel-classd.c b/sound/soc/atmel/atmel-classd.c
>> index ebabed69f0e6..540f0b6a95aa 100644
>> --- a/sound/soc/atmel/atmel-classd.c
>> +++ b/sound/soc/atmel/atmel-classd.c
>> @@ -580,11 +580,8 @@ static int atmel_classd_probe(struct platform_device *pdev)
>>   
>>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>   	io_base = devm_ioremap_resource(dev, res);
>> -	if (IS_ERR(io_base)) {
>> -		ret =  PTR_ERR(io_base);
>> -		dev_err(dev, "failed to remap register memory: %d\n", ret);
>> -		return ret;
>> -	}
>> +	if (IS_ERR(io_base))
>> +		return PTR_ERR(io_base);
>>   
>>   	dd->phy_base = res->start;
>>   
>> diff --git a/sound/soc/atmel/atmel-pdmic.c b/sound/soc/atmel/atmel-pdmic.c
>> index 8e3d34be9e69..0729f656f7eb 100644
>> --- a/sound/soc/atmel/atmel-pdmic.c
>> +++ b/sound/soc/atmel/atmel-pdmic.c
>> @@ -629,11 +629,8 @@ static int atmel_pdmic_probe(struct platform_device *pdev)
>>   
>>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>   	io_base = devm_ioremap_resource(dev, res);
>> -	if (IS_ERR(io_base)) {
>> -		ret = PTR_ERR(io_base);
>> -		dev_err(dev, "failed to remap register memory: %d\n", ret);
>> -		return ret;
>> -	}
>> +	if (IS_ERR(io_base))
>> +		return PTR_ERR(io_base);
>>   
>>   	dd->phy_base = res->start;
>>   
>> -- 
>> 2.15.1
>>
> 


-- 
Nicolas Ferre
