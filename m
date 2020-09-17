Return-Path: <SRS0=Aorx=C2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BC0C433E2
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:38:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD02622208
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gghxLBtT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD02622208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EB2B916A4;
	Thu, 17 Sep 2020 17:37:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EB2B916A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600357101;
	bh=9pD7T0wWwFDzTQ+7Gon+CBp9IrRpe5p1vuB8saUExHo=;
	h=From:To:Subject:Date:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gghxLBtTcw9BwEgZkyfGmi7XdG64VHcBuCCDv6faViBJqqgGUmj+Fc9EediTubxvV
	 yJcHioR6zTM5EgAZFxTttrB0W5PM/ZaFefj6JdOP2v9D2BpMTSdIAXvZkz11ZlXFoD
	 jhMk9Siig7aJpU+kmEX/4hAWcpwLB6v8W7v4jBMQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6D2CAF801EC;
	Thu, 17 Sep 2020 17:37:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 56CBBF80212; Thu, 17 Sep 2020 17:37:29 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C6DB1F800E8
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2020 17:37:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C6DB1F800E8
IronPort-SDR: OrgHkIWumajCGYeg36dMiZ/iAIj2pt9gLmIalF/gzK+8FHFR5pO/uscu1bjFDTndItOxvVfRmm
 UqbXo4s0V5jA==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="139226057"
X-IronPort-AV: E=Sophos;i="5.77,271,1596524400"; d="scan'208";a="139226057"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2020 08:37:18 -0700
IronPort-SDR: xkFSC5Yzvo8LO759bqSuNotNYxM+qHb5zsT7vxkN/2dvpu7koTnGwSO3r8Bn/2KXJTq/J5ICfh
 Eb77Bc0mhtEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,271,1596524400"; d="scan'208";a="346663023"
Received: from irsmsx604.ger.corp.intel.com ([163.33.146.137])
 by orsmga007.jf.intel.com with ESMTP; 17 Sep 2020 08:37:16 -0700
Received: from irsmsx601.ger.corp.intel.com (163.33.146.7) by
 IRSMSX604.ger.corp.intel.com (163.33.146.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 17 Sep 2020 16:37:14 +0100
Received: from irsmsx601.ger.corp.intel.com ([163.33.146.7]) by
 irsmsx601.ger.corp.intel.com ([163.33.146.7]) with mapi id 15.01.1713.004;
 Thu, 17 Sep 2020 16:37:14 +0100
From: "Rojewski, Cezary" <cezary.rojewski@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: RE: [PATCH v5 08/13] ASoC: Intel: catpt: Simple sysfs attributes
Thread-Topic: [PATCH v5 08/13] ASoC: Intel: catpt: Simple sysfs attributes
Thread-Index: AQHWi32XKUkpEgdTq0a2Ese22IEsialraz2AgAGN7BA=
Date: Thu, 17 Sep 2020 15:37:14 +0000
Message-ID: <004cfc8add4346c3b745e7d755dc9b1c@intel.com>
References: <20200915162944.16241-1-cezary.rojewski@intel.com>
 <20200915162944.16241-9-cezary.rojewski@intel.com>
 <20200916165033.GB3956970@smile.fi.intel.com>
In-Reply-To: <20200916165033.GB3956970@smile.fi.intel.com>
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
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Kaczmarski,
 Filip" <filip.kaczmarski@intel.com>, "N,
 Harshapriya" <harshapriya.n@intel.com>, "Barlik,
 Marcin" <marcin.barlik@intel.com>, "zwisler@google.com" <zwisler@google.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "tiwai@suse.com" <tiwai@suse.com>,
 "Proborszcz, Filip" <filip.proborszcz@intel.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "amadeuszx.slawinski@linux.intel.com" <amadeuszx.slawinski@linux.intel.com>,
 "Wasko, Michal" <michal.wasko@intel.com>,
 "cujomalainey@chromium.org" <cujomalainey@chromium.org>, "Hejmowski,
 Krzysztof" <krzysztof.hejmowski@intel.com>, "Papierkowski,
 Piotr \(Habana\)" <ppapierkowski@habana.ai>, "Gopal, 
 Vamshi Krishna" <vamshi.krishna.gopal@intel.com>
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

On 2020-09-16 6:50 PM, Andy Shevchenko wrote:
> On Tue, Sep 15, 2020 at 06:29:39PM +0200, Cezary Rojewski wrote:
>> Add sysfs entries for displaying version of FW currently in use as well
>> as binary dump of entire version info, including build and log providers
>> hashes.
>=20
> Something tells me that this might go a bit different direction. Can you
> achieve Greg KH's review on this?
>=20

This sounds as if I had any control whether Greg KH would review my
changes or not. Do you want me to CC + mention him in v6 version of this
patch?

Czarek

