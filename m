Return-Path: <SRS0=wVxo=FS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C86C4361B
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Dec 2020 16:28:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FA7221534
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Dec 2020 16:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA7221534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DA1E91718;
	Mon, 14 Dec 2020 17:27:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DA1E91718
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607963280;
	bh=KvW17/oTLQ1g9eBPDam8Iy0tCS/Mw8iCsJlALOB2PPU=;
	h=From:To:Subject:Date:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G+3QCQ7yQlEWr67vUPOw00uKyYu8RIQe4mdPpnJRrLTvHhCFhA8BAvDlBpsIQ5wX6
	 4sPjHonooonvJpsewqlHitYSvCBjXkOpl3+SW/jqlkBIXRhr8gYYe1XuweRWgUgn9i
	 /ZN3YXD2jNFKRnirBmTwGnoXI7vLhSCgtwm7bU3M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 59F6FF80171;
	Mon, 14 Dec 2020 17:27:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 836F9F801F7; Mon, 14 Dec 2020 17:27:08 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DC975F800ED
 for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2020 17:27:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DC975F800ED
IronPort-SDR: ekom9xdIvVmgQgTDLa2Gi93FJo2dYS8m92MRonIYNhsWHZPC/fjuEgwXfny5CML5N+y0t9ol6/
 6xxKbjkhgVJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9834"; a="162483501"
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; d="scan'208";a="162483501"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2020 08:26:57 -0800
IronPort-SDR: oPI1I5+5B6J/IWOa+vudSW7fdslTjcnCnsCT94JuJ/GrpKaaCOzSkMix/DVof7boIEfqe70o5c
 ynVqe1rU0Q7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; d="scan'208";a="351403450"
Received: from irsmsx601.ger.corp.intel.com ([163.33.146.7])
 by orsmga002.jf.intel.com with ESMTP; 14 Dec 2020 08:26:55 -0800
Received: from irsmsx601.ger.corp.intel.com (163.33.146.7) by
 irsmsx601.ger.corp.intel.com (163.33.146.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 14 Dec 2020 16:26:55 +0000
Received: from irsmsx601.ger.corp.intel.com ([163.33.146.7]) by
 irsmsx601.ger.corp.intel.com ([163.33.146.7]) with mapi id 15.01.1713.004;
 Mon, 14 Dec 2020 16:26:55 +0000
From: "Rojewski, Cezary" <cezary.rojewski@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: RE: [PATCH v1] catpt: Switch to use list_entry_is_head() helper
Thread-Topic: [PATCH v1] catpt: Switch to use list_entry_is_head() helper
Thread-Index: AQHWzUyfPxOhODz4j0quXnboN7DkTan2WAcwgABrb4CAAAytQA==
Date: Mon, 14 Dec 2020 16:26:55 +0000
Message-ID: <221cc8d271dd41acbea2696261c5ab26@intel.com>
References: <20201208102637.1168-1-andriy.shevchenko@linux.intel.com>
 <7b7ad24505604110aeeebb2a0b30e573@intel.com>
 <20201214153729.GK4077@smile.fi.intel.com>
In-Reply-To: <20201214153729.GK4077@smile.fi.intel.com>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Mark Brown <broonie@kernel.org>, Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

On 2020-12-14 4:37 PM, Andy Shevchenko wrote:
> On Mon, Dec 14, 2020 at 09:14:13AM +0000, Rojewski, Cezary wrote:
>> On 2020-12-08 11:26 AM, Andy Shevchenko wrote:
>>> Since we got list_entry_is_head() helper in the generic header,
>>> we may switch catpt to use it. It removes the need in additional variab=
le.
>>
>> Thanks for the patch, Andy. One nitpick below.

...

>>>    	struct catpt_dev *cdev =3D dev_get_drvdata(dai->dev);
>>>    	struct snd_soc_component *component =3D dai->component;
>>> -	struct snd_kcontrol *pos, *kctl =3D NULL;
>>>    	const char *name;
>>>    	int ret;
>>>    	u32 id =3D stream->info.stream_hw_id;
>>> +	struct snd_kcontrol *pos;
>>
>> Shouldn't structs be declared before any primitive-types?
>=20
> Good question. I consider the length of the line is more important
> (to keep reversed xmas tree order).
>=20
> If you think we should leave as is tell me, I'll send v2.
>=20

I'm not in favor or against either of options: it comes down to the
coding style of the project - sticking to same one makes code
cohesive (by project I mean Linux-kernel).

However, to switch entire catpt to reversed xmas tree, more code changes
are required (even this very function is an example of that). Leaving as
is in this update while considering the subject in other series might be
the better outcome.

Czarek

