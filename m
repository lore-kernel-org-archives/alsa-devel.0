From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: rt5640: add ASRC support
Date: Mon, 30 Jun 2014 12:45:06 +0200
Message-ID: <53B13FB2.1090304@metafoo.de>
References: <1403866691-5031-1-git-send-email-bardliao@realtek.com>
 <53AD7A1A.2090501@metafoo.de>
 <ABFD875FF5FB574BA706497D987D48D75C87F7@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-006.synserver.de (smtp-out-006.synserver.de
 [212.40.185.6]) by alsa0.perex.cz (Postfix) with ESMTP id 336AB2619E7
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 12:45:05 +0200 (CEST)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D75C87F7@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

On 06/30/2014 08:09 AM, Bard Liao wrote:
>> -----Original Message-----
>> From: Lars-Peter Clausen [mailto:lars@metafoo.de]
>> Sent: Friday, June 27, 2014 10:05 PM
>> To: Bard Liao; broonie@kernel.org; lgirdwood@gmail.com
>> Cc: Oder Chiou; alsa-devel@alsa-project.org; Flove
>> Subject: Re: [alsa-devel] [PATCH] ASoC: rt5640: add ASRC support
>>
>>
>> I wonder if that shouldn't be something that is automatically
>> enabled/disabled based on the samplerates involved. Also for
>> enable/disable controls use a switch control rather than a enum.
>
> To turn on/off rt5640's ASRC function is not decided by only one
> condition. To make it flexible, I prefer to use a control to enable/
> disable ASRC function.

But the driver should be able to autodetect those conditions, shouldn't it?

> Do you mean SOC_SINGLE_EXT? I didn't find a _SWITCH control
> in soc.h


Yes SOC_SINGLE_EXT() will create a boolean switch if xmax == 1 (otherwise it 
will create a integer control).

- Lars
