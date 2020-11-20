Return-Path: <SRS0=4V3b=E2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F13C2D0E4
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 21:03:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0A2F22253
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 21:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="no9LWa7Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A2F22253
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4374116A0;
	Fri, 20 Nov 2020 22:02:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4374116A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605906209;
	bh=F9iuLwZkjDBFobq/tBos9IspKBRZOm1VjZQlm/mIeAs=;
	h=From:To:Subject:Date:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=no9LWa7Quav9yywI+GDmi0pBsFK5IigYXsi7iNYLDQMy/JhKsOYWKZ9nZI+PKId1n
	 XUlMiIyunp9kd+oTxQiYlQN5FmrwRbRHyPeEecoqoMJfe04Lntcv0HXq2GsowqyeTP
	 N6Geve7hLCu7J4MGUD+Lii/XTl44NIPNYjY3qOuw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B3F46F80168;
	Fri, 20 Nov 2020 22:02:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6C11EF8016C; Fri, 20 Nov 2020 22:02:37 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9AF51F80166
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2020 22:02:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9AF51F80166
IronPort-SDR: Xx6Xm9pM40dzSKfOqWIUm+l4nOBR3zuxvVeqruiPyPC1jp79YFo4THvDht/qAZDRFeggJ2oVVe
 YTZx1qqL1Sew==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="171640513"
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; d="scan'208";a="171640513"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2020 13:02:26 -0800
IronPort-SDR: 8d2gUmny6z4nUA+8eqS6SpB4Afm0/av8coB4+yLDoogSvgz/rEHwMAAG84WJ6EK7Ush9ZgphFM
 wclwdu2WudQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; d="scan'208";a="431690016"
Received: from irsmsx601.ger.corp.intel.com ([163.33.146.7])
 by fmsmga001.fm.intel.com with ESMTP; 20 Nov 2020 13:02:24 -0800
Received: from irsmsx601.ger.corp.intel.com (163.33.146.7) by
 irsmsx601.ger.corp.intel.com (163.33.146.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 20 Nov 2020 21:02:24 +0000
Received: from irsmsx601.ger.corp.intel.com ([163.33.146.7]) by
 irsmsx601.ger.corp.intel.com ([163.33.146.7]) with mapi id 15.01.1713.004;
 Fri, 20 Nov 2020 21:02:24 +0000
From: "Rojewski, Cezary" <cezary.rojewski@intel.com>
To: Mark Brown <broonie@kernel.org>
Subject: RE: [PATCH 00/14] ASoC: Intel/SOF: extend run-time driver selection
 to ACPI devices
Thread-Topic: [PATCH 00/14] ASoC: Intel/SOF: extend run-time driver selection
 to ACPI devices
Thread-Index: AQHWuUTISKj33SVxVku5O7g0f1ygmanF+0XggABMLQCAAASUgIAEnFAQgAAmMgCAAVQSgIAAh8aQgAAL6wCAAWXZUIAAA0eAgALUmaCAABNygIAABbuAgAAQAICAADBe4A==
Date: Fri, 20 Nov 2020 21:02:24 +0000
Message-ID: <c8cd5f98e7c941c1b87aaabb850ece4e@intel.com>
References: <d462c890495e4dda8698b5ba5eb50066@intel.com>
 <f62abcd8-b67f-774b-61b5-e08cfc3d2cc7@linux.intel.com>
 <s5h1rgst6z4.wl-tiwai@suse.de> <0286c6975f24432082f609d45adaa14c@intel.com>
 <0badb36f-3089-dc34-f7b0-75a73b856f0d@linux.intel.com>
 <d57fa3716a974eb9ba585ddd85dbe14c@intel.com>
 <cd8e5c2f-e1c2-7fbb-bee1-cc76ec14a801@linux.intel.com>
 <d94ccf9a3c61460db88f256df1fa3240@intel.com>
 <20201120164841.GF6751@sirena.org.uk>
 <758af664b89545c5be83ca2bc81078fb@intel.com>
 <20201120180627.GI6751@sirena.org.uk>
In-Reply-To: <20201120180627.GI6751@sirena.org.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, Hans de Goede <hdegoede@redhat.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
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

On 2020-11-20 7:06 PM, Mark Brown wrote:
> On Fri, Nov 20, 2020 at 05:10:30PM +0000, Rojewski, Cezary wrote:
>> On 2020-11-20 5:48 PM, Mark Brown wrote:
>=20
>>> People care about any code that's in the kernel, especially people doin=
g
>>> anything treewide.  The fewer configurations people need to build to ge=
t
>>> code coverage the better.
>=20
>> Sure, but in this particular case there really shouldn't be "another
>> option". If catpt is the sole option, why add intel-dsp-config
>> dependency? The alternative shouldn't even exist in the kernel and be
>> instead removed just like /haswell/ and /baytrail/ were.
>=20
> If all the alternatives actually get removed then there'd be no need for
> it, while they're there it is reasonable to have it - it does make it
> easier for people like distros to try converting, it means they can
> deploy the recommended setup without needing to ship new binaries to
> people who run into trouble.  Besides TBH while there's several DSP
> implementations in the tree having the code there makes it obvious that
> this case works the same way as all the others to anyone looking at the
> code.

I can understand that in atom's case. That's why I'm fine with the
section mechanism being applied there. At the beginning I'd thought SOF
is already prepared to take over /atom/. As that's not the case, to ease
the transition, dynamic switch could prove useful.

There are no circumstances under which Intel recommends distros to try
to convert out of catpt though. Don't believe aligning all the drivers
to some general idea just for the sake of aligning is a good move.
That's why drivers have their own specifics in the first place -
their complexity and performance could have been negatively impacted
otherwise.

Czarek

