From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH] ASoC: max98090: Simplify
	max98090_readable_register implementation
Date: Mon, 27 Jul 2015 18:39:43 +0800
Message-ID: <CAFRkauBJB3DjKgb+z8ngJ=rUhegj589xdnT26PMrkOnreG1wXA@mail.gmail.com>
References: <1437961183.10891.1.camel@ingics.com>
 <55B6031F.6080305@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f181.google.com (mail-lb0-f181.google.com
 [209.85.217.181])
 by alsa0.perex.cz (Postfix) with ESMTP id A9F822607F7
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2015 12:39:43 +0200 (CEST)
Received: by lblf12 with SMTP id f12so50465251lbl.2
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2015 03:39:43 -0700 (PDT)
In-Reply-To: <55B6031F.6080305@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: "Fang, Yang A" <yang.a.fang@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Jerry Wong <jerry.wong@maximintegrated.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

2015-07-27 18:08 GMT+08:00 Jarkko Nikula <jarkko.nikula@linux.intel.com>:
> On 07/27/2015 04:39 AM, Axel Lin wrote:
>>
>> The readable registers are in consecutive ranges:
>>         0x01 ~ 0x03, 0x0D ~ 0xD1, 0xFF
>> So simplify the implementation by specifying a range of consecutive values
>> in a single case label.
>>
>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>> ---
>>   sound/soc/codecs/max98090.c | 71
>> ++-------------------------------------------
>>   1 file changed, 2 insertions(+), 69 deletions(-)
>>
> Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Thanks.

>
> One minor comment below.
>
>> -       case M98090_REG_DMIC34_BIQUAD_BASE ...
>> M98090_REG_DMIC34_BIQUAD_BASE + 0x0E:
>> +       case M98090_REG_DEVICE_STATUS ... M98090_REG_INTERRUPT_S:
>> +       case M98090_REG_LINE_INPUT_CONFIG ... 0xD1:
>>         case M98090_REG_REVISION_ID:
>>                 return true;
>
>
> I'd have preserved that magic M98090_REG_DMIC34_BIQUAD_BASE + 0x0E here.
> Last register before 0xff is 0xbd in the specification,
> M98090_REG_DMIC34_BIQUAD_BASE is 0xc3 in the max98090.h so it seems to me
> that 0xc3 ~ 0xd1 are undocumented registers.

0xc3 ~ 0xd1 are undocumented registers for MAX98090, but it is documented
in MAX98091 datasheet (SECONDARY RECORD PATH BIQUAD COEFFICIENT REGISTERS).

Regards,
Axel
