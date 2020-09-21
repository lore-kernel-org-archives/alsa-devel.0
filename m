Return-Path: <SRS0=AR4N=C6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B468EC4363A
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 18:15:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01C4020888
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 18:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eoUZ3CxB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C4020888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2208E16B6;
	Mon, 21 Sep 2020 20:14:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2208E16B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600712110;
	bh=bQVnXIgQl34f+1seNeIuFR9lTtwvZhgsJb2ZLjiMJ1A=;
	h=From:To:Subject:Date:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eoUZ3CxBUjQFao10ZZWunsTpL0om/eyiIipJTZkXkV5Xa0oH1Cu1YAQRjk05ZUZ+n
	 6nRGbPLVQHDhYDu6gGZh9SnsnXjSo0L4a1A4p0DEJk3Iu448fC/ApCEopyMHMphaKs
	 2LQ3NGRjH+HwuPyB9DdwaDYRc9hUtWwiFpjGQN7Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A9140F80161;
	Mon, 21 Sep 2020 20:14:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1F1E2F80162; Mon, 21 Sep 2020 20:14:18 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8C8F8F8015F
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2020 20:14:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8C8F8F8015F
IronPort-SDR: bw1bppI8fs+/arwsHzm91/YELKM0CM12M2vMa6epK/T/Py/hHz6M+LWIYWBDo7TfF4/5ouinRP
 lZXCED5wlG1g==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="224600363"
X-IronPort-AV: E=Sophos;i="5.77,287,1596524400"; d="scan'208";a="224600363"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2020 11:14:03 -0700
IronPort-SDR: U9dRfcQ1gmB8aXDcwVkptqhPkzEMGMXOVKH9HLEkQER4Ed/f7zb9U5AYCJMWrFPvKb2FCYDBUL
 tGZLHnFJ0zzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,287,1596524400"; d="scan'208";a="304631722"
Received: from irsmsx602.ger.corp.intel.com ([163.33.146.8])
 by orsmga003.jf.intel.com with ESMTP; 21 Sep 2020 11:14:01 -0700
Received: from irsmsx601.ger.corp.intel.com (163.33.146.7) by
 irsmsx602.ger.corp.intel.com (163.33.146.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 21 Sep 2020 19:14:00 +0100
Received: from irsmsx601.ger.corp.intel.com ([163.33.146.7]) by
 irsmsx601.ger.corp.intel.com ([163.33.146.7]) with mapi id 15.01.1713.004;
 Mon, 21 Sep 2020 19:13:59 +0100
From: "Rojewski, Cezary" <cezary.rojewski@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: RE: [PATCH v7 03/14] ASoC: Intel: catpt: Add IPC message handlers
Thread-Topic: [PATCH v7 03/14] ASoC: Intel: catpt: Add IPC message handlers
Thread-Index: AQHWkA4pBFUDuLKjeUm4qjF+MvEK1aly/TsAgABnvpA=
Date: Mon, 21 Sep 2020 18:13:59 +0000
Message-ID: <55266617b42843839fb85309d3097fd6@intel.com>
References: <20200921115424.4105-1-cezary.rojewski@intel.com>
 <20200921115424.4105-4-cezary.rojewski@intel.com>
 <20200921125934.GT3956970@smile.fi.intel.com>
In-Reply-To: <20200921125934.GT3956970@smile.fi.intel.com>
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

On 2020-09-21 2:59 PM, Andy Shevchenko wrote:
> On Mon, Sep 21, 2020 at 01:54:13PM +0200, Cezary Rojewski wrote:
>> Declare global and stream IPC message handlers for all known message
>> types.
...

>> +int catpt_coredump(struct catpt_dev *cdev)
>> +{
>> +	struct catpt_dump_section_hdr *hdr;
>> +	size_t dump_size, regs_size;
>> +	u8 *dump, *pos;
>> +	int i, j;
>> +
>> +	regs_size =3D CATPT_SHIM_REGS_SIZE;
>> +	regs_size +=3D CATPT_DMA_COUNT * CATPT_DMA_REGS_SIZE;
>> +	regs_size +=3D CATPT_SSP_COUNT * CATPT_SSP_REGS_SIZE;
>> +	dump_size =3D resource_size(&cdev->dram);
>> +	dump_size +=3D resource_size(&cdev->iram);
>> +	dump_size +=3D regs_size;
>=20
>> +	dump_size +=3D 4 * sizeof(*hdr) + 20; /* hdrs and fw hash */
>=20
> Function is full of hard coded 20s. Can you provide descriptive macro?
>=20

Will declare CATPT_DUMP_HASH_SIZE instead of hardcodes, sure.

>> +	dump =3D vzalloc(dump_size);
>> +	if (!dump)
>> +		return -ENOMEM;
>> +
>> +	pos =3D dump;
>> +
>> +	hdr =3D (struct catpt_dump_section_hdr *)pos;
>> +	hdr->magic =3D CATPT_DUMP_MAGIC;
>> +	hdr->core_id =3D cdev->spec->core_id;
>> +	hdr->section_id =3D CATPT_DUMP_SECTION_ID_FILE;
>> +	hdr->size =3D dump_size - sizeof(*hdr);
>> +	pos +=3D sizeof(*hdr);
>> +
>> +	for (i =3D j =3D 0; i < FW_INFO_SIZE_MAX; i++)
>> +		if (cdev->ipc.config.fw_info[i] =3D=3D ' ')
>> +			if (++j =3D=3D 4)
>> +				break;
>=20
>> +	for (j =3D ++i; j < FW_INFO_SIZE_MAX && j - i < 20; j++) {
>=20
> This should have static_assert() at the place where you define both const=
ants
> (2nd is mentioned above 20).
>=20
>> +		if (cdev->ipc.config.fw_info[j] =3D=3D ' ')
>> +			break;
>> +		*(pos + j - i) =3D cdev->ipc.config.fw_info[j];
>> +	}
>> +	pos +=3D 20;
>=20
> These two for-loops should have some comment to explain what's going on.
>=20

Actually, after poking my FW friends again I realized that it's just
dumping 20chars from "hash" segment of fw_info (struct catpt_fw_ready,
field: fw_info[]).

So, this could be replaced by:

	/* navigate to fifth info segment (fw hash) */
	for (i =3D j =3D 0; i < FW_INFO_SIZE_MAX; i++)
		/* info segments are separated by space each */
		if (cdev->ipc.config.fw_info[i] =3D=3D ' ')
			if (++j =3D=3D 4)
				break;

	memcpy(pos, &cdev->ipc.config.fw_info[++i], CATPT_DUMP_HASH_SIZE);
	pos +=3D CATPT_DUMP_HASH_SIZE;


Existing for-loops were based on internal solution. Half of the code
isn't needed afterall..

Czarek

