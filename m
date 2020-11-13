Return-Path: <SRS0=KFnC=ET=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B58FC388F7
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Nov 2020 11:19:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A94CE207DE
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Nov 2020 11:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nYiv0QE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A94CE207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 28BD3185A;
	Fri, 13 Nov 2020 12:18:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 28BD3185A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605266341;
	bh=TJdtQDxLSdtEtRvudXgSSyAiH8pLXpiAB/nq2rXLwQ8=;
	h=From:To:Subject:Date:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nYiv0QE/qDXSgWvc+9jbxEgirqmy+Q5EdkbSl5L69hW+Rvne1vAnzRwgJj14e9saH
	 p0C/vcMV4bR/e8HESFehaz9zphudtPhABK4yNazCktItwqZ8RrztrK5IGbCFzjxUvt
	 bdU9LXBzPQa2spBBBu+/akhalqSGvGbQLF3uKYMc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 81E78F801F5;
	Fri, 13 Nov 2020 12:18:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8CDB3F8020C; Fri, 13 Nov 2020 12:18:08 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1920EF80086
 for <alsa-devel@alsa-project.org>; Fri, 13 Nov 2020 12:18:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1920EF80086
IronPort-SDR: +idpZD4SUQQgj2ONeOREk+pm/KT3C0DR4crSGQOpmQnBuS2WMjsuPYHvd1Og/620KAeWp8ejlC
 jOZeVzxsLEQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="234616847"
X-IronPort-AV: E=Sophos;i="5.77,475,1596524400"; d="scan'208";a="234616847"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2020 03:17:48 -0800
IronPort-SDR: j8GKooFgdV/6APq4Ddy/XtdPXdyMOe8YuNzuHRp2Fgp8OoVzNsmtL5qcLi/5A6RgTfb1/TE21a
 qxWXfkTFMCGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,475,1596524400"; d="scan'208";a="357472987"
Received: from irsmsx604.ger.corp.intel.com ([163.33.146.137])
 by fmsmga004.fm.intel.com with ESMTP; 13 Nov 2020 03:17:46 -0800
Received: from irsmsx601.ger.corp.intel.com (163.33.146.7) by
 IRSMSX604.ger.corp.intel.com (163.33.146.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 13 Nov 2020 11:17:45 +0000
Received: from irsmsx601.ger.corp.intel.com ([163.33.146.7]) by
 irsmsx601.ger.corp.intel.com ([163.33.146.7]) with mapi id 15.01.1713.004;
 Fri, 13 Nov 2020 11:17:45 +0000
From: "Rojewski, Cezary" <cezary.rojewski@intel.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: RE: [PATCH 01/14] ASoC: Intel: broadwell: add missing pm_ops
Thread-Topic: [PATCH 01/14] ASoC: Intel: broadwell: add missing pm_ops
Thread-Index: AQHWuUSYySxhDIRYoEmmmcstYp6nnqnF6jmg
Date: Fri, 13 Nov 2020 11:17:45 +0000
Message-ID: <4ed0a22a0b4f4ac5aa732868770d0c1f@intel.com>
References: <20201112223825.39765-1-pierre-louis.bossart@linux.intel.com>
 <20201112223825.39765-2-pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20201112223825.39765-2-pierre-louis.bossart@linux.intel.com>
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
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 "tiwai@suse.de" <tiwai@suse.de>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, "broonie@kernel.org" <broonie@kernel.org>,
 Rander Wang <rander.wang@linux.intel.com>
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

On 2020-11-12 11:38 PM, Pierre-Louis Bossart wrote:
> For some reason this ops is missing in 2 out of the 3 broadwell
> drivers. Add to make sure ASoC takes care of power management.
>=20

Changes provided with this patch are not connected to the overall idea
behind your patchset. I suggest splitting pm-changes into a separate
one.

The very first sentence in commit message isn't providing any value,
guess one-liner will suffice.

> Tested-by: Cezary Rojewski <cezary.rojewski@intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com=
>
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
> Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com=
>
> ---
>   sound/soc/intel/boards/broadwell.c | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/sound/soc/intel/boards/broadwell.c b/sound/soc/intel/boards/=
broadwell.c
> index 77c85f17aca6..69e0b13b47f4 100644
> --- a/sound/soc/intel/boards/broadwell.c
> +++ b/sound/soc/intel/boards/broadwell.c
> @@ -318,6 +318,7 @@ static struct platform_driver broadwell_audio =3D {
>   	.remove =3D broadwell_audio_remove,
>   	.driver =3D {
>   		.name =3D "broadwell-audio",
> +		.pm =3D &snd_soc_pm_ops
>   	},
>   };
>  =20
>
