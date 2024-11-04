Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5EA7D1BDC3
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Nov 2024 16:18:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AFA21825;
	Mon,  4 Nov 2024 17:18:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AFA21825
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1730737128;
	bh=bfAsiSNijIbn9dA6dCEoAJCNnIpUVnYgwURSK8OS4ug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=KBkvyIf+k7xm5EIZ/cLYAFq+OVgdVpO3RAUAgw6ecyW9Ow6ahgjgX1mYTyKPiyLO8
	 efY20wMxqzRO7XWG66BM+YNJhDGHsLrheaASbtAiOmKVk1jt/taJdJq2ya6OuRnvs0
	 u9R5QlIbFPADCpLfupmeUWv7Br1KuCzjzpvO5Bxc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8157AF805B4; Mon,  4 Nov 2024 17:18:17 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F046FF805A0;
	Mon,  4 Nov 2024 17:18:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EB6C9F8026A; Mon,  4 Nov 2024 17:18:12 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B3223F8013D
	for <alsa-devel@alsa-project.org>; Mon,  4 Nov 2024 17:17:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B3223F8013D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ELeHiV4v
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 437C85C486D;
	Mon,  4 Nov 2024 16:17:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E502C4CECE;
	Mon,  4 Nov 2024 16:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730737073;
	bh=bfAsiSNijIbn9dA6dCEoAJCNnIpUVnYgwURSK8OS4ug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ELeHiV4vJKBVJKglPnNwM4FU9h4OgvTXusWR8lAPnMYQkdfviOs8EYxwcL7BFbdiL
	 2RVJSf42kx/VHzzyjb4XTns0+4vRba32OT2rKvpm8SOwYAx5UdrChcvvsSZ2CEFndf
	 daO4CLeyWE5Lbh8G7KVLF5o9n7K3VsPFRKrVV44BpsC97egsW8iREvcfqojKpnzwj1
	 03GkPzA0xMlNzY9F/Q3KiNX+Iqyda+V0dAPhUZYMyiihT49jsH9JICKfJKpendetVR
	 cx3TENatm5/RUWWRx9XlsjY818EJGeRDOmYYG69p1JW1AKCDsHHhDGMSFgkG2nm4P1
	 lv2vYvcLarrcw==
Date: Mon, 4 Nov 2024 10:17:51 -0600
From: Rob Herring <robh@kernel.org>
To: Ki-Seok Jo <kiseok.jo@irondevice.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] ASoC: dt-bindings: irondevice,sma1307: Add
 initial DT binding
Message-ID: <20241104161751.GA320514-robh@kernel.org>
References: <20241104-irondevice-sma1307-v3-0-4bbe79895f54@irondevice.com>
 <20241104-irondevice-sma1307-v3-1-4bbe79895f54@irondevice.com>
 <SL2P216MB23377A60BEC4396ADFA78A6A8C512@SL2P216MB2337.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: 
 <SL2P216MB23377A60BEC4396ADFA78A6A8C512@SL2P216MB2337.KORP216.PROD.OUTLOOK.COM>
Message-ID-Hash: 4FJ3O7OYFFHMF73SC4EH43JAZSWNWNIZ
X-Message-ID-Hash: 4FJ3O7OYFFHMF73SC4EH43JAZSWNWNIZ
X-MailFrom: robh@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4FJ3O7OYFFHMF73SC4EH43JAZSWNWNIZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, Nov 04, 2024 at 07:33:47AM +0000, Ki-Seok Jo wrote:
> 

I don't see the rest of the series (I fetch from lore). That means your 
threading is broken.

> This adds the schema binding for the Iron Device SMA1307 Amp
> 
> Signed-off-by: Kiseok Jo <kiseok.jo@irondevice.com>
> ---

v3, but where is the revision history?

>  .../bindings/sound/irondevice,sma1307.yaml         | 54 ++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/irondevice,sma1307.yaml b/Documentation/devicetree/bindings/sound/irondevice,sma1307.yaml
> new file mode 100644
> index 000000000..0bb4ee664
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/irondevice,sma1307.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2

"%YAML 1.2" goes on the 2nd line.

> +---
> +$id: http://devicetree.org/schemas/sound/irondevice,sma1307.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Iron Device SMA1307 Audio Amplifier
> +
> +maintainers:
> +  - Kiseok Jo <kiseok.jo@irondevice.com>
> +
> +description:
> +  SMA1307 boosted digital speaker amplifier
> +  with feedback-loop.

Wrap lines at 80 char.

> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - irondevice,sma1307a
> +      - irondevice,sma1307aq
> +    description:
> +      If a 'q' is added, it indicated the product is AEC-Q100
> +      qualified for automotive applications. SMA1307A supports
> +      both WLCSP and QFN packages. However, SMA1307AQ only
> +      supports the QFN package.

Is this difference visible to software? The package is not, so that part 
is irrelevant.

> +
> +  reg:
> +    maxItems: 1
> +
> +  '#sound-dai-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#sound-dai-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        amplifier@1e {
> +            compatible = "irondevice,sma1307a";
> +            reg = <0x1e>;
> +            #sound-dai-cells = <1>;
> +        };
> +    };
> 
> --
> 2.39.2
> 
