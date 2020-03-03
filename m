Return-Path: <SRS0=CIz3=4U=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F40FC3F2D1
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Mar 2020 01:42:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCC5821D56
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Mar 2020 01:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nu6YSHAx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC5821D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 30D0C1673;
	Tue,  3 Mar 2020 02:41:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 30D0C1673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583199758;
	bh=FCRHZFY4XwBLlkUSJjiRDLp68eLVuwbkrGsACThosxM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nu6YSHAxSob8MRg3aCe5aUXlrVgjOBIyAPp5uIgozvYVYTJUpTNkee/uzdROZaqqL
	 VQ828w13zDIHw8VcYSrdRfLrYYlDdRaAOfMWlqSu8bpXEoEqhh0DoG5HpnKvY2j6ob
	 sOlocE1LA5xgezVuvPmHmP0IRrfzwlNPa1G1ZYko=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7EA05F800E5;
	Tue,  3 Mar 2020 02:41:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9D131F801ED; Tue,  3 Mar 2020 02:41:45 +0100 (CET)
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 58F23F800E5
 for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2020 02:41:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 58F23F800E5
Received: by mail-ot1-f65.google.com with SMTP id x19so1412999otp.7
 for <alsa-devel@alsa-project.org>; Mon, 02 Mar 2020 17:41:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=wTmd93QvHJKnRP/iE9AlgpSex86ml4dgAiKBLvXi4d8=;
 b=ilmGvLfZgg0VzBuDD7GNjBR0KvXYcCo6IitxMMkWEacitG3/xtutob3PwEMFQPUvj7
 PLfz/nBjo9lSU+fjetOIN5TdBVQ+rJIHR0STkjlVrEsscX9oiL4cYmr6/cwSBaOtgV9z
 tFBsBez9xv4txtyzw6gKFhchstRfOIL61l0nJ0j45XBkkOVr3VUOE1r2K4ZsyfsSTzMO
 V+GGwUocDVgvHku3fHcwRAT/Jc225zISvBgsPbnAP6GhV/oOEdUXJllbSLGZPJXr5HWs
 ZWndoCD7lI/XkFY+aS3mRQ4VCrFhwLDarGeGm6iyp6lb6RBEih1Y0cED/IDTyAWdhqI6
 5cFQ==
X-Gm-Message-State: ANhLgQ315UNi83sTO2SFJWTGMrTaFO6TiCWVfBBq+ug702Fk+Zt96QhW
 8vaKIfW90kHa1xcXJ3tKsQ==
X-Google-Smtp-Source: ADFU+vsdNg78DFlU+1lj7jVL9V1hy4eNjciajaJxnlZGh0to9M1K+WoyXSAT3r6zp73f0HaM+PIrow==
X-Received: by 2002:a9d:836:: with SMTP id 51mr1698659oty.318.1583199694975;
 Mon, 02 Mar 2020 17:41:34 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id 16sm6365123otc.33.2020.03.02.17.41.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 17:41:34 -0800 (PST)
Received: (nullmailer pid 25998 invoked by uid 1000);
 Tue, 03 Mar 2020 01:41:33 -0000
Date: Mon, 2 Mar 2020 19:41:33 -0600
From: Rob Herring <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v4 1/8] ASoC: dt-bindings: fsl_asrc: Change asrc-width to
 asrc-format
Message-ID: <20200303014133.GA24596@bogus>
References: <cover.1583039752.git.shengjiu.wang@nxp.com>
 <872c2e1082de6348318e14ccd31884d62355c282.1583039752.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <872c2e1082de6348318e14ccd31884d62355c282.1583039752.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 shawnguo@kernel.org, s.hauer@pengutronix.de, tiwai@suse.com,
 lgirdwood@gmail.com, nicoleotsuka@gmail.com, broonie@kernel.org,
 linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
 linux-arm-kernel@lists.infradead.org
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

On Sun, Mar 01, 2020 at 01:24:12PM +0800, Shengjiu Wang wrote:
> asrc_format is more inteligent, which is align with the alsa
> definition snd_pcm_format_t, we don't need to convert it to
> format in driver, and it can distinguish S24_LE & S24_3LE.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,asrc.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> index cb9a25165503..0cbb86c026d5 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> @@ -38,7 +38,9 @@ Required properties:
>  
>     - fsl,asrc-rate	: Defines a mutual sample rate used by DPCM Back Ends.
>  
> -   - fsl,asrc-width	: Defines a mutual sample width used by DPCM Back Ends.
> +   - fsl,asrc-format	: Defines a mutual sample format used by DPCM Back
> +			  Ends. The value is one of SNDRV_PCM_FORMAT_XX in
> +			  "include/uapi/sound/asound.h"

You can't just change properties. They are an ABI.

>  
>     - fsl,asrc-clk-map   : Defines clock map used in driver. which is required
>  			  by imx8qm/imx8qxp platform
> -- 
> 2.21.0
> 
