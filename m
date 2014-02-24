From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 04/11] ASoC: Add macros for defining
 virtual enums
Date: Mon, 24 Feb 2014 12:50:54 +0100
Message-ID: <530B321E.5050409@metafoo.de>
References: <1393168221-23018-1-git-send-email-lars@metafoo.de>
 <1393168221-23018-5-git-send-email-lars@metafoo.de>
 <s5htxboyi33.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-167.synserver.de (smtp-out-075.synserver.de
 [212.40.185.75])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CBF426530E
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 12:50:37 +0100 (CET)
In-Reply-To: <s5htxboyi33.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, =?ISO-8859-1?Q?Philippe_R=E9tornaz?= <philippe.retornaz@epfl.ch>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Jerry Wong <jerry.wong@maximintegrated.com>
List-Id: alsa-devel@alsa-project.org

On 02/24/2014 10:29 AM, Takashi Iwai wrote:
> At Sun, 23 Feb 2014 16:10:14 +0100,
> Lars-Peter Clausen wrote:
>>
>> With the upcoming consolidation of normal MUXs and virtual MUXs we need to be
>> able to distinguish between enums with and without a backing register at the
>> enum level. Use the same approach as used for virtual mixer controls by setting
>> the reg field of the enum to SND_SOC_NOPM for enums without a backing register.
>> This patch adds a set of helper macros that can be used to define such enums.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> ---
>>   include/sound/soc.h | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/sound/soc.h b/include/sound/soc.h
>> index e005196..a25de13 100644
>> --- a/include/sound/soc.h
>> +++ b/include/sound/soc.h
>> @@ -189,6 +189,8 @@
>>   	.mask = xmask, .items = xitems, .texts = xtexts, .values = xvalues}
>>   #define SOC_VALUE_ENUM_SINGLE(xreg, xshift, xmask, xnitmes, xtexts, xvalues) \
>>   	SOC_VALUE_ENUM_DOUBLE(xreg, xshift, xshift, xmask, xnitmes, xtexts, xvalues)
>> +#define SOC_ENUM_SINGLE_VIRT(xmax, xtexts) \
>> +	SOC_ENUM_SINGLE(SND_SOC_NOPM, 0, xmax, xtexts)
>
> Could you replace "max" with "items"?

Yep, missed that one when I rebased things on top of your changes.

- Lars
