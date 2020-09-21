Return-Path: <SRS0=AR4N=C6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAB6C35257
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 20:49:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A027C21D7A
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 20:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="m/ezBQ+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A027C21D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C304116AC;
	Mon, 21 Sep 2020 22:48:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C304116AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600721360;
	bh=PiNV68RAJyggeoZ450uekMfKAMdgDaBQfVkrduBUkiE=;
	h=From:To:Subject:Date:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m/ezBQ+VdSNwIEfhfGW6YIsYY7TTGedBp6Vkvvkyg4/TOUAj+klXzyv86pJjSH0db
	 S15SrIx1yRB4tDat+l1hF7Db+wmnqaQpG7Vuq7gOmBVMDo/e9FBB1l6DcIa9SuTWqU
	 h79TE08psrWpsSKnhppAq/orMYdt3nyLG7BsI2Vk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4356BF80161;
	Mon, 21 Sep 2020 22:48:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AD50FF80162; Mon, 21 Sep 2020 22:48:28 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C06EBF800B2
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2020 22:48:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C06EBF800B2
IronPort-SDR: OrNV2i8dGMQVFa4rQKfSirNJ5DO7l/oJqdm7EFHZE+4Xuog7/WWXshuY7KP8ZEvwfWQKhFUbWv
 3gvQxt3Ig1iQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="161399810"
X-IronPort-AV: E=Sophos;i="5.77,288,1596524400"; d="scan'208";a="161399810"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2020 13:48:15 -0700
IronPort-SDR: gnJxuO1ck3VFnfBaWcOCeWdCfj6Xf/757OTxHs/ATCUTPIvC1uIeq+M9Df5WUApbvYwOdj1OLC
 NlWysQV0iB9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,288,1596524400"; d="scan'208";a="382097963"
Received: from irsmsx604.ger.corp.intel.com ([163.33.146.137])
 by orsmga001.jf.intel.com with ESMTP; 21 Sep 2020 13:48:14 -0700
Received: from irsmsx601.ger.corp.intel.com (163.33.146.7) by
 IRSMSX604.ger.corp.intel.com (163.33.146.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 21 Sep 2020 21:48:12 +0100
Received: from irsmsx601.ger.corp.intel.com ([163.33.146.7]) by
 irsmsx601.ger.corp.intel.com ([163.33.146.7]) with mapi id 15.01.1713.004;
 Mon, 21 Sep 2020 21:48:12 +0100
From: "Rojewski, Cezary" <cezary.rojewski@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: RE: [PATCH v7 03/14] ASoC: Intel: catpt: Add IPC message handlers
Thread-Topic: [PATCH v7 03/14] ASoC: Intel: catpt: Add IPC message handlers
Thread-Index: AQHWkA4pBFUDuLKjeUm4qjF+MvEK1aly/TsAgABnvpD///fKgIAAMnCA
Date: Mon, 21 Sep 2020 20:48:12 +0000
Message-ID: <191afe965b1e46799bf776be3254d28f@intel.com>
References: <20200921115424.4105-1-cezary.rojewski@intel.com>
 <20200921115424.4105-4-cezary.rojewski@intel.com>
 <20200921125934.GT3956970@smile.fi.intel.com>
 <55266617b42843839fb85309d3097fd6@intel.com>
 <20200921184129.GH3956970@smile.fi.intel.com>
In-Reply-To: <20200921184129.GH3956970@smile.fi.intel.com>
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
 Harshapriya" <harshapriya.n@intel.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Barlik,
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

On 2020-09-21 8:41 PM, Andy Shevchenko wrote:> On Mon, Sep 21, 2020 at 06:1=
3:59PM +0000, Rojewski, Cezary wrote:
>> On 2020-09-21 2:59 PM, Andy Shevchenko wrote:
>>> On Mon, Sep 21, 2020 at 01:54:13PM +0200, Cezary Rojewski wrote:
...

>>>> +	for (i =3D j =3D 0; i < FW_INFO_SIZE_MAX; i++)
>>>> +		if (cdev->ipc.config.fw_info[i] =3D=3D ' ')
>>>> +			if (++j =3D=3D 4)
>>>> +				break;
>>>
>>>> +	for (j =3D ++i; j < FW_INFO_SIZE_MAX && j - i < 20; j++) {
>>>
>>> This should have static_assert() at the place where you define both con=
stants
>>> (2nd is mentioned above 20).
>>>
>>>> +		if (cdev->ipc.config.fw_info[j] =3D=3D ' ')
>>>> +			break;
>>>> +		*(pos + j - i) =3D cdev->ipc.config.fw_info[j];
>>>> +	}
>>>> +	pos +=3D 20;
>>>
>>> These two for-loops should have some comment to explain what's going on=
.
>>>
>>
>> Actually, after poking my FW friends again I realized that it's just
>> dumping 20chars from "hash" segment of fw_info (struct catpt_fw_ready,
>> field: fw_info[]).
>>
>> So, this could be replaced by:
>>
>=20
>> 	/* navigate to fifth info segment (fw hash) */
>> 	for (i =3D j =3D 0; i < FW_INFO_SIZE_MAX; i++)
>> 		/* info segments are separated by space each */
>> 		if (cdev->ipc.config.fw_info[i] =3D=3D ' ')
>> 			if (++j =3D=3D 4)
>> 				break;
>=20
> ...and this is repeating strnchr() / strnchrnul().
>=20

Indeed, will incorporate into above.

> With the questions "what if...":
>   - nul in the middle of this?
>   - less than 4 spaces found?
>=20

While this should never happen (means user is somehow not making use of
officially released firmware binary), coredumps are useful only if you
have access to debug tools. In cases you'd mentioned, invalid hash would
have been dumped to coredump and crash reader simply wouldn't have been
able to navigate to actual build for it. The rest of the coredump is still
vital though.

memcpy() could be gated behind an 'if' for safety if needed:

	info =3D cdev->ipc.config.fw_info;
	eof =3D info + FW_INFO_SIZE_MAX;
	/* navigate to fifth info segment (fw hash) */
	for (i =3D 0; i < 4 && info < eof; i++, info++)
		/* info segments are separated by space each */
		if ((info =3D strnchr(info, eof - info, ' ')) =3D=3D NULL)
			break;

	if (i =3D=3D 4 && info < eof)
		memcpy(pos, info, min(eof - info, CATPT_DUMP_HASH_SIZE));

Didn't compile this, some typecheck fixes might be in order and so on.

>> 	memcpy(pos, &cdev->ipc.config.fw_info[++i], CATPT_DUMP_HASH_SIZE);
>> 	pos +=3D CATPT_DUMP_HASH_SIZE;
>>
>>
>> Existing for-loops were based on internal solution. Half of the code
>> isn't needed afterall..
>
