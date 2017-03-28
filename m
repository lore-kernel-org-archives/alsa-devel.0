From: Ryans Lee <RyanS.Lee@maximintegrated.com>
Subject: Re: [PATCH] ASoC: Add support for Maxim Integrated
	MAX98927 Amplifier
Date: Tue, 28 Mar 2017 15:36:02 +0000
Message-ID: <BY2PR11MB0837EED36FBC3BAF061272FAE7320@BY2PR11MB0837.namprd11.prod.outlook.com>
References: <1489970423-29353-1-git-send-email-ryans.lee@maximintegrated.com>
 <20170324152613.qzvsviznhiz5f3sj@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0116.outbound.protection.outlook.com [104.47.37.116])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E35426583C
 for <alsa-devel@alsa-project.org>; Tue, 28 Mar 2017 17:36:09 +0200 (CEST)
In-Reply-To: <20170324152613.qzvsviznhiz5f3sj@rob-hp-laptop>
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
To: Rob Herring <robh@kernel.org>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "tiwai@suse.com" <tiwai@suse.com>, "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>, "romain.perier@collabora.com" <romain.perier@collabora.com>, "bardliao@realtek.com" <bardliao@realtek.com>, "lars@metafoo.de" <lars@metafoo.de>, "axel.lin@ingics.com" <axel.lin@ingics.com>, "Paul.Handrigan@cirrus.com" <Paul.Handrigan@cirrus.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "nh6z@nh6z.net" <nh6z@nh6z.net>, "broonie@kernel.org" <broonie@kernel.org>, "ckeepax@opensource.wolfsonmicro.com" <ckeepax@opensource.wolfsonmicro.com>, "dgreid@google.com" <dgreid@google.com>, oder_chiou@realtek.co
List-Id: alsa-devel@alsa-project.org


> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Friday, March 24, 2017 8:26 AM
> To: Ryans Lee <RyanS.Lee@maximintegrated.com>
> Cc: lgirdwood@gmail.com; broonie@kernel.org; mark.rutland@arm.com; 
> perex@perex.cz; tiwai@suse.com; kuninori.morimoto.gx@renesas.com; 
> arnd@arndb.de; ckeepax@opensource.wolfsonmicro.com; lars@metafoo.de; 
> bardliao@realtek.com; nh6z@nh6z.net; KCHSU0@nuvoton.com; 
> axel.lin@ingics.com; romain.perier@collabora.com; petr@barix.com; 
> srinivas.kandagatla@linaro.org; oder_chiou@realtek.com; 
> Paul.Handrigan@cirrus.com; alsa-devel@alsa-project.org; 
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; 
> dgreid@google.com
> Subject: Re: [PATCH] ASoC: Add support for Maxim Integrated MAX98927 
> Amplifier
>
> EXTERNAL EMAIL
>
>
>
> On Mon, Mar 20, 2017 at 09:40:23AM +0900, Ryan Lee wrote:
>> Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
>> ---
>> Resubmit the intial version of MAX98927 driver. Added all fixes into the initial patch.
>>
>>  .../devicetree/bindings/sound/max98927.txt         |   39 +
>>  sound/soc/codecs/Kconfig                           |    5 +
>>  sound/soc/codecs/Makefile                          |    2 +
>>  sound/soc/codecs/max98927.c                        | 1040 ++++++++++++++++++++
>>  sound/soc/codecs/max98927.h                        |  267 +++++
>>  5 files changed, 1353 insertions(+)
>>  create mode 100755
>> Documentation/devicetree/bindings/sound/max98927.txt
>>  mode change 100644 => 100755 sound/soc/codecs/Kconfig  mode change
>> 100644 => 100755 sound/soc/codecs/Makefile  create mode 100755 
>> sound/soc/codecs/max98927.c  create mode 100755 
>> sound/soc/codecs/max98927.h
>>
>> diff --git a/Documentation/devicetree/bindings/sound/max98927.txt
>> b/Documentation/devicetree/bindings/sound/max98927.txt
>> new file mode 100755
>> index 0000000..d610879
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/max98927.txt
>> @@ -0,0 +1,39 @@
>> +max98927 audio CODEC
>> +
>> +This device supports I2C.
>
> Can we combine this and the other max9892x bindings. They all look similar.
They are not same but almost similar. I combined MAX98925, MAX98926 and MAX98927 bindings into MAX9892x.txt
Thank you for your feedback.
>
>> +
>> +Required properties:
>> +
>> +  - compatible : "maxim,max98927"
>> +
>> +  - maxim,vmon-slot-no : slot number used to send voltage 
>> + information
>
> While vendor prefix is preferred, so is using the same property names.
> Either use the existing names or deprecate the old ones in favor of these.
To use same property names, I kept existing names. Thanks.

>
>> +                   or in inteleave mode this will be used as
>> +                   interleave slot.
>> +                   This property can be set to values from 0 to 15 for slot 0 to 15.
>> +                   Default value is 0.
>> +
>> +  - maxim,imon-slot-no : slot number used to send current information
>> +                   This property can be set to values from 0 to 15 for slot 0 to 15.
>> +                   Default value is 0.
>> +
>> +  - maxim,interleave-mode : When using two MAX98927 in a system it is
>> +                   possible to create ADC data that that will
>> +                   overflow the frame size. Digital Audio Interleave
>> +                   mode provides a means to output VMON and IMON data
>> +                   from two devices on a single DOUT line when running
>> +                   smaller frames sizes such as 32 BCLKS per LRCLK or
>> +                   48 BCLKS per LRCLK.
>> +                   This property can be set to values from 0 to 1 for off and on.
>> +                   Default value is 0.
>> +
>> +  - reg : the I2C address of the device for I2C
>> +
>> +Example:
>> +
>> +codec: max98927@3a {
>> +   compatible = "maxim,max98927";
>> +   maxim,vmon-slot-no = <0>;
>> +   maxim,imon-slot-no = <1>;
>> +   maxim,interleave-mode = <0>;
>> +   reg = <0x3a>;
>> +};
