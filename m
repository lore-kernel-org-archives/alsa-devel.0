From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l52: Report correct chip id and
	revision
Date: Fri, 4 Apr 2014 16:50:19 -0500
Message-ID: <alpine.DEB.2.02.1404041646460.3451@heelrod>
References: <1396616889.13903.2.camel@phoenix>
 <alpine.DEB.2.02.1404041128380.3451@heelrod>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0065.outbound.protection.outlook.com [65.55.169.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 93A0F265851
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 23:50:27 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1404041128380.3451@heelrod>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Axel Lin <axel.lin@ingics.com>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org


> On Fri, 4 Apr 2014, Axel Lin wrote:
>
>>
>> 	dev_info(&i2c_client->dev, "Cirrus Logic CS42L52, Revision: %02X\n",
>> -			reg & 0xFF);
>> +			reg & CS42L52_CHIP_REV_MASK);

>> #define CS42L52_CHIP_REV_B0			0x02
>> -#define CS42L52_CHIP_REV_MASK			0x03
>> +#define CS42L52_CHIP_REV_B1			0x03

Correct me if I'm wrong, but it looks like you added CS42L52_CHIP_REV_MASK 
and then replaced that define with CS42L52_CHIP_REV_B1?

I think some changes to actually display the correct rev_id based on the 
return value of the reg_read would be cool but this isn't it IMO. I don't 
think it will be either.

Thanks,
Brian
