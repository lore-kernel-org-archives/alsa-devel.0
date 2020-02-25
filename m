Return-Path: <SRS0=Ovzg=4N=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD1CC35DEE
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Feb 2020 02:56:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0034124650
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Feb 2020 02:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="t79dDWxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0034124650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3F61C1668;
	Tue, 25 Feb 2020 03:55:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3F61C1668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582599377;
	bh=bJaeFM1e42RY4iyMWgtUBJWakIbV6ofaTg3clze8ZCs=;
	h=From:To:Subject:Date:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t79dDWxJxAZD13LRjYxFlxjgI3r0AKe4StHlLRnH5QG4QKnnYMZmDubMEahZAJusP
	 /wkqm9gxIkiOXblan5/hmo9oshsitPV9nkfbMmawjNcEiUjpF3NT83duwcet9yRFTf
	 TD1FApt0Xm2KJKAhOytWpoe247+GCFbts7h3v0H8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B0DAAF8013E;
	Tue, 25 Feb 2020 03:55:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BF18FF80142; Tue, 25 Feb 2020 03:55:24 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 19F79F80096
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2020 03:55:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 19F79F80096
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Feb 2020 18:55:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,482,1574150400"; d="scan'208";a="410085247"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga005.jf.intel.com with ESMTP; 24 Feb 2020 18:55:16 -0800
Received: from shsmsx603.ccr.corp.intel.com (10.109.6.143) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 24 Feb 2020 18:55:16 -0800
Received: from shsmsx606.ccr.corp.intel.com (10.109.6.216) by
 SHSMSX603.ccr.corp.intel.com (10.109.6.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 25 Feb 2020 10:54:41 +0800
Received: from shsmsx606.ccr.corp.intel.com ([10.109.6.216]) by
 SHSMSX606.ccr.corp.intel.com ([10.109.6.216]) with mapi id 15.01.1713.004;
 Tue, 25 Feb 2020 10:54:41 +0800
From: "Liao, Bard" <bard.liao@intel.com>
To: Mark Brown <broonie@kernel.org>, Bard Liao
 <yung-chuan.liao@linux.intel.com>
Subject: RE: [PATCH RFC v4 0/6] ASoC: Add Multi CPU DAI support
Thread-Topic: [PATCH RFC v4 0/6] ASoC: Add Multi CPU DAI support
Thread-Index: AQHVz/myiSuEvK8oHku0EJ5CjUUF56gq16kAgACWBJA=
Date: Tue, 25 Feb 2020 02:54:41 +0000
Message-ID: <9dafc59401fd414baccd88e2fa53e511@intel.com>
References: <20200120132928.25257-1-yung-chuan.liao@linux.intel.com>
 <20200225015658.GB21366@sirena.org.uk>
In-Reply-To: <20200225015658.GB21366@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-reaction: no-action
dlp-product: dlpe-windows
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Cc: "tiwai@suse.de" <tiwai@suse.de>,
 "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>,
 "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>
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


> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Tuesday, February 25, 2020 9:57 AM
> To: Bard Liao <yung-chuan.liao@linux.intel.com>
> Cc: tiwai@suse.de; alsa-devel@alsa-project.org;
> liam.r.girdwood@linux.intel.com; pierre-louis.bossart@linux.intel.com;
> kuninori.morimoto.gx@renesas.com; Liao, Bard <bard.liao@intel.com>
> Subject: Re: [PATCH RFC v4 0/6] ASoC: Add Multi CPU DAI support
>=20
> On Mon, Jan 20, 2020 at 09:29:22PM +0800, Bard Liao wrote:
> > As discussed in [1], ASoC core supports multi codec DAIs on a DAI
> > link. However it does not do so for CPU DAIs.
>=20
> Sorry, I didn't apply this at -rc1 like I intended to and now it needs so=
me rebasing
> - can you resend please?  My mistake, sorry.

Sure, I will do it soon.
