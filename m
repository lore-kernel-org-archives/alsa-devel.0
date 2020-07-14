Return-Path: <SRS0=Ss6N=AZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907D4C433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 07:16:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17E0F221E8
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 07:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rpi0i5BI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E0F221E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=katsuster.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 813DC82E;
	Tue, 14 Jul 2020 09:16:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 813DC82E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594711016;
	bh=Bj4RzbJQwueH905w2vlrljkexPukFPAYPTBMhF25UdU=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rpi0i5BIrhqsnGQ9XoqZ7pWF3B/3FHdNp0yOgevMObHQH2Q3yOb4H0uu3OX1nZnDt
	 3cypGF5DvnzRmvS8+trPYpTWpl69W/+GFnw6LH2Lnr6An/LtCcLuJCKmD2bNNtVwBC
	 9vfg20f3by6rO6gB/j2wFKhG+3XVJIQns6/RzLlo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0F45CF800E5;
	Tue, 14 Jul 2020 09:16:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D394FF8019B; Tue, 14 Jul 2020 09:16:03 +0200 (CEST)
Received: from www1102.sakura.ne.jp (www1102.sakura.ne.jp [219.94.129.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8F9F1F800E5
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2020 09:15:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8F9F1F800E5
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 06E7FbT3024510;
 Tue, 14 Jul 2020 16:15:37 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp);
 Tue, 14 Jul 2020 16:15:37 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp)
Received: from [192.168.1.2] (121.252.232.153.ap.dti.ne.jp [153.232.252.121])
 (authenticated bits=0)
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 06E7FaEQ024506
 (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
 Tue, 14 Jul 2020 16:15:37 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH v2] dt-bindings: sound: convert rk3328 codec binding to
 yaml
To: Rob Herring <robh@kernel.org>
References: <20200630135412.718447-1-katsuhiro@katsuster.net>
 <20200714024307.GA1175068@bogus>
From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <8ab6b52a-1084-c63a-51f9-1aa5bd150682@katsuster.net>
Date: Tue, 14 Jul 2020 16:15:36 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200714024307.GA1175068@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Heiko Stuebner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hello Rob,

Thank you for your comment.

On 2020/07/14 11:43, Rob Herring wrote:
> On Tue, Jun 30, 2020 at 10:54:12PM +0900, Katsuhiro Suzuki wrote:
>> This patch converts Rockchip rk3328 audio codec binding to DT schema.
>> And adds description about "mclk" clock and fixes some errors in
>> original example.
>>
>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
>> ---
>>   .../bindings/sound/rockchip,rk3328-codec.txt  | 28 --------
>>   .../bindings/sound/rockchip,rk3328-codec.yaml | 70 +++++++++++++++++++
>>   2 files changed, 70 insertions(+), 28 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/sound/rockchip,rk3328-codec.txt
>>   create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rk3328-codec.yaml
> 
> Need to Cc Mark Brown...
> 

Oops... I'll add him in the next time.


>>
>> diff --git a/Documentation/devicetree/bindings/sound/rockchip,rk3328-codec.txt b/Documentation/devicetree/bindings/sound/rockchip,rk3328-codec.txt
>> deleted file mode 100644
>> index 1ecd75d2032a..000000000000
>> --- a/Documentation/devicetree/bindings/sound/rockchip,rk3328-codec.txt
>> +++ /dev/null
>> @@ -1,28 +0,0 @@
>> -* Rockchip Rk3328 internal codec
>> -
>> -Required properties:
>> -
>> -- compatible: "rockchip,rk3328-codec"
>> -- reg: physical base address of the controller and length of memory mapped
>> -  region.
>> -- rockchip,grf: the phandle of the syscon node for GRF register.
>> -- clocks: a list of phandle + clock-specifer pairs, one for each entry in clock-names.
>> -- clock-names: should be "pclk".
>> -- spk-depop-time-ms: speak depop time msec.
>> -
>> -Optional properties:
>> -
>> -- mute-gpios: GPIO specifier for external line driver control (typically the
>> -              dedicated GPIO_MUTE pin)
>> -
>> -Example for rk3328 internal codec:
>> -
>> -codec: codec@ff410000 {
>> -	compatible = "rockchip,rk3328-codec";
>> -	reg = <0x0 0xff410000 0x0 0x1000>;
>> -	rockchip,grf = <&grf>;
>> -	clocks = <&cru PCLK_ACODEC>;
>> -	clock-names = "pclk";
>> -	mute-gpios = <&grf_gpio 0 GPIO_ACTIVE_LOW>;
>> -	spk-depop-time-ms = 100;
>> -};
>> diff --git a/Documentation/devicetree/bindings/sound/rockchip,rk3328-codec.yaml b/Documentation/devicetree/bindings/sound/rockchip,rk3328-codec.yaml
>> new file mode 100644
>> index 000000000000..525b48c2f5de
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/rockchip,rk3328-codec.yaml
>> @@ -0,0 +1,70 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/sound/rockchip,rk3328-codec.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Rockchip rk3328 internal codec
>> +
>> +maintainers:
>> +  - Heiko Stuebner <heiko@sntech.de>
>> +
>> +properties:
>> +  compatible:
>> +    const: rockchip,rk3328-codec
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: clock for audio codec
>> +      - description: clock for I2S master clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: pclk
>> +      - const: mclk
>> +
>> +  rockchip,grf:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      The phandle of the syscon node for the GRF register.
>> +
>> +  spk-depop-time-ms:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> Don't need a type with standard unit suffixes.
> 
>> +    default: 200
> 
> Is there a range of values? Surely 2^32 would be too long.
> 

No there isn't. Unfortunately detail specification of rk3328
internal audio codec is not public. I also think 2^32 is too
long, but no one knows correct range...


> Otherwise,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

Best Regards,
Katsuhiro Suzuki


>> +    description:
>> +      Speaker depop time in msec.
>> +
>> +  mute-gpios:
>> +    maxItems: 1
>> +    description:
>> +      GPIO specifier for external line driver control (typically the
>> +      dedicated GPIO_MUTE pin)
>> +
>> +  "#sound-dai-cells":
>> +    const: 0
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - rockchip,grf
>> +  - "#sound-dai-cells"
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +    #include <dt-bindings/clock/rk3328-cru.h>
>> +    codec: codec@ff410000 {
>> +      compatible = "rockchip,rk3328-codec";
>> +      reg = <0xff410000 0x1000>;
>> +      clocks = <&cru PCLK_ACODECPHY>, <&cru SCLK_I2S1>;
>> +      clock-names = "pclk", "mclk";
>> +      rockchip,grf = <&grf>;
>> +      mute-gpios = <&grf_gpio 0 GPIO_ACTIVE_LOW>;
>> +      spk-depop-time-ms = <100>;
>> +      #sound-dai-cells = <0>;
>> +    };
>> -- 
>> 2.27.0
>>

