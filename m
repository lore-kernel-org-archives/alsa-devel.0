Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFEFC001DF
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Aug 2023 15:51:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 880B1832;
	Tue,  1 Aug 2023 17:50:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 880B1832
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690905065;
	bh=Ao9jKG02zCn9mT46E7t4bpXrC0zyjDPbbvJx/0zuRN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=FMMchQHQ0SyxOMQPZu7XmTh+jVWd4FtdLBrvs9PNO97wmm67m0nBZdJLeV1WSpY0r
	 IKZEYQq/t4UaKdF+PEIkiAmsXClhqsM4bV3K54yJrZWMT/C1g3CFi4ZkrxCp/lmyUN
	 CDHCyxJNsMnb8f44Aasgxdh6Sjkuhk9/NemJ74+U=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 77F68F80549; Tue,  1 Aug 2023 17:49:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 80624F80520;
	Tue,  1 Aug 2023 17:49:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5E083F8016D; Mon, 31 Jul 2023 14:11:34 +0200 (CEST)
Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 453EDF8015B
	for <alsa-devel@alsa-project.org>; Mon, 31 Jul 2023 14:11:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 453EDF8015B
Received: from localhost (localhost [127.0.0.1])
	by honk.sigxcpu.org (Postfix) with ESMTP id A7A9CFB03;
	Mon, 31 Jul 2023 14:11:16 +0200 (CEST)
Received: from honk.sigxcpu.org ([127.0.0.1])
	by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s8Fn4PzHcjuu; Mon, 31 Jul 2023 14:11:15 +0200 (CEST)
Date: Mon, 31 Jul 2023 14:11:13 +0200
From: Guido =?iso-8859-1?Q?G=FCnther?= <guido.gunther@puri.sm>
To: David Heidelberg <david@ixit.cz>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, - <kernel@puri.sm>,
	alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: sound: gtm601: convert to YAML
Message-ID: <ZMek4XHZQ/HVahKV@qwark.sigxcpu.org>
References: <20230730191742.117013-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230730191742.117013-1-david@ixit.cz>
X-MailFrom: guido.gunther@puri.sm
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: NHP6KB7SCFC5DCK7SIMPU5YPGYOROTHC
X-Message-ID-Hash: NHP6KB7SCFC5DCK7SIMPU5YPGYOROTHC
X-Mailman-Approved-At: Tue, 01 Aug 2023 15:47:38 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NHP6KB7SCFC5DCK7SIMPU5YPGYOROTHC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

On Sun, Jul 30, 2023 at 10:17:42PM +0300, David Heidelberg wrote:
> Convert GTM601 binding to the YAML format.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v4:
>  - added missing required property
> v3:
>  - incorporated feedback from Krzysztof
> v2:
>  - add #sound-dai-cells
>  - put kernel@puri.sm into maintainers
> 
>  .../devicetree/bindings/sound/gtm601.txt      | 19 ---------
>  .../bindings/sound/option,gtm601.yaml         | 40 +++++++++++++++++++
>  2 files changed, 40 insertions(+), 19 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/gtm601.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/option,gtm601.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/gtm601.txt b/Documentation/devicetree/bindings/sound/gtm601.txt
> deleted file mode 100644
> index efa32a486c4a..000000000000
> --- a/Documentation/devicetree/bindings/sound/gtm601.txt
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -GTM601 UMTS modem audio interface CODEC
> -
> -This device has no configuration interface. The sample rate and channels are
> -based on the compatible string
> -	"option,gtm601" = 8kHz mono
> -	"broadmobi,bm818" = 48KHz stereo
> -
> -Required properties:
> -
> -  - compatible : one of
> -	"option,gtm601"
> -	"broadmobi,bm818"
> -
> -
> -Example:
> -
> -codec: gtm601_codec {
> -	compatible = "option,gtm601";
> -};
> diff --git a/Documentation/devicetree/bindings/sound/option,gtm601.yaml b/Documentation/devicetree/bindings/sound/option,gtm601.yaml
> new file mode 100644
> index 000000000000..69c2ccc79dc5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/option,gtm601.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/option,gtm601.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: GTM601 UMTS modem audio interface CODEC
> +
> +maintainers:
> +  - kernel@puri.sm
> +
> +description: >
> +  This device has no configuration interface. The sample rate and channels are
> +  based on the compatible string
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:  # 48 kHz stereo
> +          - const: broadmobi,bm818
> +          - const: option,gtm601
> +      - const: option,gtm601  # 8 kHz mono

This looks good to me. I just wonder if it makes sense to use a description
instead of comments to make the sampling rate/channel requirements a bit
more obvious:

      - description: Broadmobi BM818 (48kHz stereo)
        items:
           - const: broadmobi,bm818
           - const: option,gtm601
      - description:  Option GTM601 audio code (8kHz mono) 
        const: option,gtm601

Cheers,
 -- Guido

> +
> +  '#sound-dai-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    codec {
> +        compatible = "option,gtm601";
> +        #sound-dai-cells = <0>;
> +    };
> -- 
> 2.40.1
> 
