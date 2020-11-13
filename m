Return-Path: <SRS0=KFnC=ET=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70825C388F7
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Nov 2020 11:20:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21CAD2137B
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Nov 2020 11:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Sj8KB3jZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21CAD2137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 51CEC185A;
	Fri, 13 Nov 2020 12:19:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 51CEC185A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605266412;
	bh=xD2oRurBn/pTryRbMFV8Oi2fiGjKqWz/aV9kj/C0gR0=;
	h=From:To:Subject:Date:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sj8KB3jZKoE4YB5woclLp+8q8zB7qIvnjXqHtipgi/w++Rhu1+CUayfAybfpC0UGD
	 LyFLla0Pu9J1vuYiCv/nnskfrbU97+kYdKUqvG0MVTx6S9xBoCinXp9gtb3mqG+ZQo
	 LkJO2dyy9Ai6Ja3U0AADFNZqm7tIOmEeGA4AbnxY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DC760F801F5;
	Fri, 13 Nov 2020 12:19:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 19E77F8022D; Fri, 13 Nov 2020 12:19:20 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E6359F801F5
 for <alsa-devel@alsa-project.org>; Fri, 13 Nov 2020 12:19:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E6359F801F5
IronPort-SDR: yCEdCjsIY1yXgT7Lx+uL+ydtEAMTjy0tFg10knV2GJoUHmn7jjOD7T2Dgyl4PYC3TTV/4VMxyS
 qX/IYGdxUmGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="170628018"
X-IronPort-AV: E=Sophos;i="5.77,475,1596524400"; d="scan'208";a="170628018"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2020 03:19:12 -0800
IronPort-SDR: xc1ts53i8f52ywQb6/n5b3bOqjhc8l7xRSSqL7hFD78GI6fmtulgruGVF/RqgItC1xEiYgBEbA
 lpiVQ3fWcMHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,475,1596524400"; d="scan'208";a="328845009"
Received: from irsmsx605.ger.corp.intel.com ([163.33.146.138])
 by orsmga006.jf.intel.com with ESMTP; 13 Nov 2020 03:19:10 -0800
Received: from irsmsx601.ger.corp.intel.com (163.33.146.7) by
 IRSMSX605.ger.corp.intel.com (163.33.146.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 13 Nov 2020 11:19:09 +0000
Received: from irsmsx601.ger.corp.intel.com ([163.33.146.7]) by
 irsmsx601.ger.corp.intel.com ([163.33.146.7]) with mapi id 15.01.1713.004;
 Fri, 13 Nov 2020 11:19:09 +0000
From: "Rojewski, Cezary" <cezary.rojewski@intel.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: RE: [PATCH 02/14] ASoC: Intel: bdw-rt5677: add missing pm_ops
Thread-Topic: [PATCH 02/14] ASoC: Intel: bdw-rt5677: add missing pm_ops
Thread-Index: AQHWuUSY1Ut8W7t87EqHvHGUYkdwYKnF6uhg
Date: Fri, 13 Nov 2020 11:19:09 +0000
Message-ID: <7940c5426da6419b8017dca2e379ca0c@intel.com>
References: <20201112223825.39765-1-pierre-louis.bossart@linux.intel.com>
 <20201112223825.39765-3-pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20201112223825.39765-3-pierre-louis.bossart@linux.intel.com>
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
>   sound/soc/intel/boards/bdw-rt5677.c | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/sound/soc/intel/boards/bdw-rt5677.c b/sound/soc/intel/boards=
/bdw-rt5677.c
> index 7a3e773d0a1c..9cdd4164e1fb 100644
> --- a/sound/soc/intel/boards/bdw-rt5677.c
> +++ b/sound/soc/intel/boards/bdw-rt5677.c
> @@ -446,6 +446,7 @@ static struct platform_driver bdw_rt5677_audio =3D {
>   	.probe =3D bdw_rt5677_probe,
>   	.driver =3D {
>   		.name =3D "bdw-rt5677",
> +		.pm =3D &snd_soc_pm_ops
>   	},
>   };
>  =20
>
