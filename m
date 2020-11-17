Return-Path: <SRS0=TkwG=EX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE600C2D0E4
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 15:10:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABBDD24199
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 15:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="n26UX3Cs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABBDD24199
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D8ECE1732;
	Tue, 17 Nov 2020 16:09:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D8ECE1732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605625805;
	bh=JygdgZukTxECYYHDTqgW9sWRMjPieNIgHl60sXBRv+4=;
	h=From:To:Subject:Date:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n26UX3CsEiPjOl60c7gWp8yTn89CeZSVrPlklzeDX5EeywmKivezy8kDvKYFn4F3u
	 sB/ETGwNckLvhwZCkrDP3l0K5IjdqJzIcXOhh2HdgdRz472cNqmLVnn2ojYW6/Lfmh
	 EEP94CdDKdpfQKJGMrhU/KZHgp/zR/euOako0ErI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5AF66F800FE;
	Tue, 17 Nov 2020 16:09:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8DA45F801F5; Tue, 17 Nov 2020 16:09:12 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7599CF800FE;
 Tue, 17 Nov 2020 16:08:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7599CF800FE
IronPort-SDR: LxXmK6B/hxfNFDbQJXAmsTgWTOC9MU5MBIZr4N3Wav31SEibdWYMiOlLY5IDCWtoMVvYa07Dbx
 +JgIUgxzjUgA==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="170156027"
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; d="scan'208";a="170156027"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2020 07:08:44 -0800
IronPort-SDR: otD5Lqb1Gl0rh2+AYmow3TKjnNQJ45IZIgJGW3bGi5E9hgX7lJqR8PG0sMqjRLjcZBMHF276hV
 4nkBfez/Jzmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; d="scan'208";a="310239693"
Received: from irsmsx603.ger.corp.intel.com ([163.33.146.9])
 by fmsmga008.fm.intel.com with ESMTP; 17 Nov 2020 07:08:43 -0800
Received: from irsmsx601.ger.corp.intel.com (163.33.146.7) by
 irsmsx603.ger.corp.intel.com (163.33.146.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Nov 2020 15:08:42 +0000
Received: from irsmsx601.ger.corp.intel.com ([163.33.146.7]) by
 irsmsx601.ger.corp.intel.com ([163.33.146.7]) with mapi id 15.01.1713.004;
 Tue, 17 Nov 2020 15:08:42 +0000
From: "Rojewski, Cezary" <cezary.rojewski@intel.com>
To: Gustaw Lewandowski <gustaw.lewandowski@linux.intel.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: RE: [PATCH v2] ASoC: Intel: catpt: select WANT_DEV_COREDUMP
Thread-Topic: [PATCH v2] ASoC: Intel: catpt: select WANT_DEV_COREDUMP
Thread-Index: AQHWvPKtaHU9bHZ2V0aVxp0N96mzhanMbLqg
Date: Tue, 17 Nov 2020 15:08:42 +0000
Message-ID: <50823438bf95492d97fbf1d46471e2c4@intel.com>
References: <20201117145223.21222-1-gustaw.lewandowski@linux.intel.com>
In-Reply-To: <20201117145223.21222-1-gustaw.lewandowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [163.33.253.164]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Cc: "pierre-louis.bossart@linux.intel.com"
 <pierre-louis.bossart@linux.intel.com>,
 "patch@alsa-project.org" <patch@alsa-project.org>,
 "tiwai@suse.de" <tiwai@suse.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 Piotr Maziarz <piotrx.maziarz@linux.intel.com>,
 "broonie@kernel.org" <broonie@kernel.org>
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


On 2020-11-17 3:52 PM, Gustaw Lewandowski wrote:
> From: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
>=20
> Select WANT_DEV_COREDUMP for catpt driver.
>=20
> Signed-off-by: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
> Signed-off-by: Gustaw Lewandowski <gustaw.lewandowski@linux.intel.com>
>=20

Thanks for this update, Gustaw.

Acked-by: Cezary Rojewski <cezary.rojewski@intel.com>

> --
> Changes in v2:
>   - change should be added to catpt only
> ---
>   sound/soc/intel/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> index a5b446d5af19..52ae7c981f56 100644
> --- a/sound/soc/intel/Kconfig
> +++ b/sound/soc/intel/Kconfig
> @@ -24,6 +24,7 @@ config SND_SOC_INTEL_CATPT
>   	depends on DMADEVICES && SND_DMA_SGBUF
>   	select DW_DMAC_CORE
>   	select SND_SOC_ACPI_INTEL_MATCH
> +	select WANT_DEV_COREDUMP
>   	help
>   	  Enable support for Intel(R) Haswell and Broadwell platforms
>   	  with I2S codec present. This is a recommended option.
>
