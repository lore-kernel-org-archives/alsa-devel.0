Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F07D4C3DA61
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Jul 2024 17:17:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8D7571FF;
	Mon, 29 Jul 2024 19:16:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8D7571FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1722273427;
	bh=k6ksBZ8+yz65X/L4HiwrGsPSjDnf1yKvvTsD+2UxvV4=;
	h=From:To:CC:References:In-Reply-To:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=AfbZ/L7cQrXSOTLcUH759H5aUHxWNFYac4l1t2X1sKrq9ZZT+F1I3zBeR24IZbKeF
	 YwJldoHlFkgO2YcH02WbhxSm1Sq/2DyTqidJyWE4cIWz17+AG/jXo6h27I78lKVgFh
	 CZJSB3AotYuUMpkFYYSDeoDsdipma5GWFuLiWQFg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D619DF805B3; Mon, 29 Jul 2024 19:16:29 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CFB65F805B6;
	Mon, 29 Jul 2024 19:16:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BC82CF802DB; Mon, 29 Jul 2024 19:15:16 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CBAAAF8007E
	for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2024 19:14:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CBAAAF8007E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=dIfKZgdj
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id
 46TFFcrO019068;
	Mon, 29 Jul 2024 12:14:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=1FFP2i5VBb8mE8rlotGa2erv9oQ/ADnp9DnG2pdUJnU=; b=
	dIfKZgdjTS1we5G6s81FhKX1NYb7si5jsGyV3LquTxTC4pafTzTajGcJFUV7CzZU
	Q8/pgBoqdmwzHWNzY0TEBgVcaKWWVSEd9BpvLUvka68XKheiBJkoT8AnkgsgkOxN
	KP0C264GXLwbab04h1kt5IU/q7RGJ7gEG8ExtJZ944uof2Acw77FK3E6tNshscl6
	6M9YN39hQkqrONEIZg6ZHloXyZPlQ7oYZlKIRgWVpec1A93mlrIDNKd1dhIjmNK8
	borMM4ZJCvLOv0nPiPIHBOZKoWFIJ8Iory299asfbq7gUqHO5bGmxJ3u+WrdxbiX
	mD+JqgaCljzUfRISKY2Duw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 40mwajtd9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 12:14:15 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 29 Jul
 2024 18:14:13 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 29 Jul 2024 18:14:13 +0100
Received: from EDIN6ZZ2FY3 (EDIN6ZZ2FY3.ad.cirrus.com [198.90.188.28])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 8D108820244;
	Mon, 29 Jul 2024 17:14:13 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20240729161532.147893-1-simont@opensource.cirrus.com>
In-Reply-To: <20240729161532.147893-1-simont@opensource.cirrus.com>
Subject: RE: [PATCH] ALSA: hda: cs35l56: Stop creating ALSA controls for
 firmware coefficients
Date: Mon, 29 Jul 2024 18:14:13 +0100
Message-ID: <019d01dae1da$bc32b1d0$34981570$@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQEcFAlpKboO1qvXEI+3RGtpBQpfeLOLjSvw
X-Proofpoint-GUID: BNXFBh-k94F6vNGNUKZDZtnSWk1xHSIu
X-Proofpoint-ORIG-GUID: BNXFBh-k94F6vNGNUKZDZtnSWk1xHSIu
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: AWUUEVD65FNNJGSXDQY3T5LGUGLP6E6L
X-Message-ID-Hash: AWUUEVD65FNNJGSXDQY3T5LGUGLP6E6L
X-MailFrom: prvs=5940d8ee55=simont@opensource.cirrus.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AWUUEVD65FNNJGSXDQY3T5LGUGLP6E6L/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Apologies Takashi - can you ignore this one please? It will need a V2

> -----Original Message-----
> From: Simon Trimmer <simont@opensource.cirrus.com>
> Sent: Monday, July 29, 2024 5:16 PM
> To: tiwai@suse.com
> Cc: linux-sound@vger.kernel.org; alsa-devel@alsa-project.org; linux-
> kernel@vger.kernel.org; patches@opensource.cirrus.com; Simon Trimmer
> <simont@opensource.cirrus.com>
> Subject: [PATCH] ALSA: hda: cs35l56: Stop creating ALSA controls for
firmware
> coefficients
> 
> A number of laptops have gone to market with old firmware versions that
> export controls that have since been hidden, but we can't just install a
> newer firmware because the firmware for each product is customized and
> qualified by the OEM. The issue is that alsactl save and restore has no
> idea what controls are good to persist which can lead to
> misconfiguration.
> 
> As the ALSA controls for the firmware coefficients are not used in
> normal operation they can all be hidden, but add a kernel parameter so
> that they can be re-enabled for debugging.
> 
> Fixes: 73cfbfa9caea ("ALSA: hda/cs35l56: Add driver for Cirrus Logic
CS35L56
> amplifier")
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
> ---
>  sound/pci/hda/cs35l56_hda.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
> index 96d3f13c5abf..1494383b22c9 100644
> --- a/sound/pci/hda/cs35l56_hda.c
> +++ b/sound/pci/hda/cs35l56_hda.c
> @@ -23,6 +23,10 @@
>  #include "hda_cs_dsp_ctl.h"
>  #include "hda_generic.h"
> 
> +static bool expose_dsp_controls;
> +module_param(expose_dsp_controls, bool, 0444);
> +MODULE_PARM_DESC(expose_dsp_controls, "Expose firmware controls as
> ALSA controls 0=no (default), 1=yes");
> +
>   /*
>    * The cs35l56_hda_dai_config[] reg sequence configures the device as
>    *  ASP1_BCLK_FREQ = 3.072 MHz
> @@ -758,6 +762,9 @@ static int cs35l56_hda_bind(struct device *dev, struct
> device *master, void *mas
> 
>  	cs35l56_hda_create_controls(cs35l56);
> 
> +	if (expose_dsp_controls)
> +		cs35l56_hda_add_dsp_controls(cs35l56);
> +
>  #if IS_ENABLED(CONFIG_SND_DEBUG)
>  	cs35l56->debugfs_root = debugfs_create_dir(dev_name(cs35l56-
> >base.dev), sound_debugfs_root);
>  	cs_dsp_init_debugfs(&cs35l56->cs_dsp, cs35l56->debugfs_root);
> --
> 2.43.0


