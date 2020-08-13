Return-Path: <SRS0=qZmY=BX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F96C433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:32:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 556672080C
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iIyc40Vj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 556672080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lucaceresoli.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B3EA084D;
	Thu, 13 Aug 2020 12:31:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B3EA084D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597314754;
	bh=JzOFVGT8iwNq/Li046WBt6BbOpLoSxPtWKEag1YjnAc=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iIyc40VjEuKA/sqvsD22W5E/RetiCZn7zkxvTMBBkhDg7q+tJbIBrjlIPdIdb5m9j
	 TjsZZMSDqMncM3oUu0S93kA9VtgQHw38N0GSuhb95jgZV3HXi5aJGyVC1u4eCSl2VC
	 PLs5UkNaGtn+Iqex8TyHnpdZgihMCsPFMYrnNXcw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3D398F8014C;
	Thu, 13 Aug 2020 12:31:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 26638F8015B; Thu, 13 Aug 2020 12:31:43 +0200 (CEST)
Received: from hostingweb31-40.netsons.net (hostingweb31-40.netsons.net
 [89.40.174.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CDF60F80100
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2020 12:31:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CDF60F80100
Received: from [37.161.87.136] (port=46755 helo=[192.168.42.162])
 by hostingweb31.netsons.net with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <luca@lucaceresoli.net>)
 id 1k6AW9-000FlW-5k; Thu, 13 Aug 2020 12:31:29 +0200
Subject: Re: [PATCH] dt-bindings: Whitespace clean-ups in schema files
To: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
References: <20200812203618.2656699-1-robh@kernel.org>
From: Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <d5808e9c-07fe-1c28-b9a6-a16abe9df458@lucaceresoli.net>
Date: Thu, 13 Aug 2020 12:31:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200812203618.2656699-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - alsa-project.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id:
 luca@lucaceresoli.net
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Cc: linux-hwmon@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-spi@vger.kernel.org, linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-input@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
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

Hi Rob,

On 12/08/20 22:36, Rob Herring wrote:
> Clean-up incorrect indentation, extra spaces, long lines, and missing
> EOF newline in schema files. Most of the clean-ups are for list
> indentation which should always be 2 spaces more than the preceding
> keyword.
>=20
> Found with yamllint (which I plan to integrate into the checks).

[...]

> diff --git a/Documentation/devicetree/bindings/clock/idt,versaclock5.ya=
ml b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
> index 3d4e1685cc55..28c6461b9a9a 100644
> --- a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
> +++ b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
> @@ -95,10 +95,10 @@ allOf:
>        # Devices without builtin crystal
>        properties:
>          clock-names:
> -            minItems: 1
> -            maxItems: 2
> -            items:
> -              enum: [ xin, clkin ]
> +          minItems: 1
> +          maxItems: 2
> +          items:
> +            enum: [ xin, clkin ]
>          clocks:
>            minItems: 1
>            maxItems: 2

Thanks for noticing, LGTM.

[...]

> diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchs=
creen.yaml b/Documentation/devicetree/bindings/input/touchscreen/touchscr=
een.yaml
> index d7dac16a3960..36dc7b56a453 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.y=
aml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.y=
aml
> @@ -33,8 +33,8 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
> =20
>    touchscreen-min-pressure:
> -    description: minimum pressure on the touchscreen to be achieved in=
 order for the
> -                 touchscreen driver to report a touch event.
> +    description: minimum pressure on the touchscreen to be achieved in=
 order
> +      for the touchscreen driver to report a touch event.

Out of personal taste, I find the original layout more pleasant and
readable. This third option is also good, especially for long description=
s:

  description:
    minimum pressure on the touchscreen to be achieved in order for the
    touchscreen driver to report a touch event.

At first glance yamllint seems to support exactly these two by default:

> With indentation: {spaces: 4, check-multi-line-strings: true}
>=20
> the following code snippet would PASS:
>=20
> Blaise Pascal:
>     Je vous =C3=A9cris une longue lettre parce que
>     je n'ai pas le temps d'en =C3=A9crire une courte.
>=20
> the following code snippet would PASS:
>=20
> Blaise Pascal: Je vous =C3=A9cris une longue lettre parce que
>                je n'ai pas le temps d'en =C3=A9crire une courte.
>=20
> the following code snippet would FAIL:
>=20
> Blaise Pascal: Je vous =C3=A9cris une longue lettre parce que
>   je n'ai pas le temps d'en =C3=A9crire une courte.
>=20
(https://yamllint.readthedocs.io/en/stable/rules.html#module-yamllint.rul=
es.indentation)


--=20
Luca

