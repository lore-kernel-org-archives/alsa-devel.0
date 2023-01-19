Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC16FC00A5A
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Jan 2023 12:14:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 38692707E;
	Thu, 19 Jan 2023 13:14:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 38692707E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1674130494;
	bh=kvNujVetUBnBdfFPtEOg0jtnfsme9rQYGsNTHFLbznY=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G8gCNJddrDAJa6UgHxlnT/3ENUqOcKtKbqyxOt6BmZYZl0MQijvIB2VOUYhTfkjNU
	 5/ZlAZ4W/W52zdZR7AxAykc/lzBeefRJ/qRKubcJpuJSvtunZ4P92gP9CYk0L+HLaz
	 EIbcBw5Abw5RJNqzXoOhVAxBT0di1VXWcZqSK6f0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D6F9CF80083;
	Thu, 19 Jan 2023 13:14:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ABF4EF8047B; Thu, 19 Jan 2023 13:14:01 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 43DC1F8024D
 for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2023 13:13:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 43DC1F8024D
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=TWemGikn
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 23AFDB82268;
 Thu, 19 Jan 2023 12:13:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFBEC433D2;
 Thu, 19 Jan 2023 12:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1674130436;
 bh=kvNujVetUBnBdfFPtEOg0jtnfsme9rQYGsNTHFLbznY=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=TWemGiknLSA1++g+P9cbbapukHT6XTqf0dvDktE8ZcG9t+9XuB8sSZwd7psDiMrwZ
 1Si1Kua989poNMTXIIgyi0aEu2///hJzjTTc3aGCxAJzZTb3CwUwrDsQifQ0/t9q2e
 kBUOP3bdoAxBjs2sL9CJJRJUAPOLYL80KPBgiqpclNU9k+VbbeC/hccmboMLms6P4J
 PkLoqqRdprhjqPLeYqxhlQDCT6SoZtYR5Qp/IPiPj0LrVA8Zfd/m9TgL1WuDFGtStO
 0QWhNZ1wYMSVaLsKarUAPKTAVnGuEHdcFfWJiwFSyTYDToz8Yi06PzOxqhU5YHQ2NT
 zGuNOEKl5FKtg==
Message-ID: <f0c5e40e-e59d-152d-31f1-1ad3da0a6d34@kernel.org>
Date: Thu, 19 Jan 2023 13:13:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/3] ASoC: google: dt-bindings: sc7280: Add platform
 property
Content-Language: en-US
To: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>, agross@kernel.org,
 andersson@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
 robh+dt@kernel.org, quic_plai@quicinc.com, bgoswami@quicinc.com,
 perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
 quic_rohkumar@quicinc.com, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 swboyd@chromium.org, judyhsiao@chromium.org, devicetree@vger.kernel.org
References: <1674108674-8392-1-git-send-email-quic_srivasam@quicinc.com>
 <1674108674-8392-3-git-send-email-quic_srivasam@quicinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <1674108674-8392-3-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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

On 19/01/2023 07:11, Srinivasa Rao Mandadapu wrote:
> Update sc7280 machine driver bindings with platform property for
> supporting ADSP based platform's DAI links.

Subject:
ASoC: dt-bindings: google,sc7280-herobrine:

> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Tested-by: Ratna Deepthi Kudaravalli <quic_rkudarv@quicinc.com>

This tested tag is a bit unusual. How were they tested? If
dt_bindings_check why this is not the same person as you (submitter)?

> ---
>  .../devicetree/bindings/sound/google,sc7280-herobrine.yaml    | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml b/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
> index 869b403..ccf1b1d 100644
> --- a/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
> +++ b/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
> @@ -75,6 +75,17 @@ patternProperties:
>  
>          additionalProperties: false
>  
> +      platform:
> +        description: Holds subnode which indicates platform dai.

Neither commit msg nor this here explains why do you need it and what it
really represents. Basically description repeats "platform" name of
property - there is no single new information.

> +        type: object
> +        properties:
> +          sound-dai: true

maxItems

> +
> +        required:
> +          - sound-dai
> +
> +        additionalProperties: false
> +
>      required:
>        - link-name
>        - cpu

Best regards,
Krzysztof

