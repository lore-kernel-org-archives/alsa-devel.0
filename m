From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 1/2] ASoC: rt5645: change gpio to gpiod
 APIs
Date: Wed, 03 Jun 2015 14:08:01 +0200
Message-ID: <556EEE21.9040507@metafoo.de>
References: <1432894607-28489-1-git-send-email-bardliao@realtek.com>
 <5568944C.2060509@metafoo.de> <20150602171655.GX14071@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D70107135C@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-080.synserver.de (smtp-out-080.synserver.de
 [212.40.185.80])
 by alsa0.perex.cz (Postfix) with ESMTP id C8C0926593D
 for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2015 14:08:03 +0200 (CEST)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D70107135C@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, John Lin <john.lin@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "zhengxing@rock-chips.com" <zhengxing@rock-chips.com>, "yang.a.fang@intel.com" <yang.a.fang@intel.com>, "koro.chen@mediatek.com" <koro.chen@mediatek.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "Leilk.Liu@mediatek.com" <Leilk.Liu@mediatek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

On 06/03/2015 02:03 PM, Bard Liao wrote:
>> -----Original Message-----
>> From: Mark Brown [mailto:broonie@kernel.org]
>> Sent: Wednesday, June 03, 2015 1:17 AM
>> To: Lars-Peter Clausen
>> Cc: Bard Liao; lgirdwood@gmail.com; Oder Chiou;
>> alsa-devel@alsa-project.org; zhengxing@rock-chips.com;
>> yang.a.fang@intel.com; koro.chen@mediatek.com; John Lin;
>> Leilk.Liu@mediatek.com; Flove
>> Subject: Re: [alsa-devel] [PATCH v2 1/2] ASoC: rt5645: change gpio to
>> gpiod APIs
>>
>> On Fri, May 29, 2015 at 06:31:08PM +0200, Lars-Peter Clausen wrote:
>>
>>> Three things, don't use the _index API if there is only a single gpio
>>> for the property, either don't use a name at all or use a descriptive
>>> name something like "hp-detect" and use the new version of the API
>>> which has the flags parameter.
>>
>>> So this should be: devm_gpiod_get(&i2c->dev, NULL, GPIOD_IN);
>>
>>> and then drop the gpiod_direction_input()...
>>
>> It seems better if people use names where possible if there's any chance
>> that we could add support for other GPIOs in the future, that avoids
>> confusion further down the line with extension.
>
> Do you mean use a well-described gpio name such as "hp-detect" so that
> we can use another name if we need to add other gpios in the future?

Yes, kind of. The name of the GPIO should be its function. Having a GPIO 
with the name rt5645 on a rt5645 does not really describe anything since we 
already know that it is a rt5645.
