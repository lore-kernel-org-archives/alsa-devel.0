Return-Path: <SRS0=GKc0=DA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B90C4727F
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Sep 2020 19:34:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF06B221EF
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Sep 2020 19:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OE6a01DM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF06B221EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 353781797;
	Wed, 23 Sep 2020 21:33:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 353781797
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600889672;
	bh=T77+MwvHnb4tnIyKC9DuDkwS+Kt4h6wrR2DnvGi/m9g=;
	h=From:To:Subject:Date:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OE6a01DM57q3er7xhSXtcNOfWZKI8+6WSyB88/dYYyLq8L13NS8wpJ95b1WBkhbfg
	 eX+/Dx32kjBjXRpwLwhEwjG+73i6CZV8c9VMq3sSpZikWf9u6U5/GSlmDJLEUr+T/9
	 JyZ76axPX2KjB6P5QL02V56iugLb6XUpFMgaNJ7s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BC1E7F80162;
	Wed, 23 Sep 2020 21:33:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DA659F80171; Wed, 23 Sep 2020 21:33:39 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E5580F8010A
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2020 21:33:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E5580F8010A
IronPort-SDR: EIuiQTtHCJSH50sIQ7DJ7GdMZRS5K2O6ey81UFWGIVQivXHPCEFsAedF5XV931592eIwVKdh5J
 7Ke/LEam2Gow==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="140466535"
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; d="scan'208";a="140466535"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2020 12:33:26 -0700
IronPort-SDR: Xn6xJ9Jofg5bSOKGQFNBGvngqBcYiDINR+S3SNNhYhTzxCjm4plhsAaYPLQazHbIz1UwpOt1tL
 pF2Yk23/dpyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; d="scan'208";a="347474770"
Received: from irsmsx601.ger.corp.intel.com ([163.33.146.7])
 by FMSMGA003.fm.intel.com with ESMTP; 23 Sep 2020 12:33:24 -0700
Received: from irsmsx601.ger.corp.intel.com (163.33.146.7) by
 irsmsx601.ger.corp.intel.com (163.33.146.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 23 Sep 2020 20:33:23 +0100
Received: from irsmsx601.ger.corp.intel.com ([163.33.146.7]) by
 irsmsx601.ger.corp.intel.com ([163.33.146.7]) with mapi id 15.01.1713.004;
 Wed, 23 Sep 2020 20:33:23 +0100
From: "Rojewski, Cezary" <cezary.rojewski@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: RE: [PATCH v8 02/14] ASoC: Intel: catpt: Implement IPC protocol
Thread-Topic: [PATCH v8 02/14] ASoC: Intel: catpt: Implement IPC protocol
Thread-Index: AQHWkaS0J+WhWsgCJEmY/BXBACbAu6l2I7uAgAB2RmCAAAM2wA==
Date: Wed, 23 Sep 2020 19:33:23 +0000
Message-ID: <e6f4354189ac4ed8bf453d22513fa9b1@intel.com>
References: <20200923122508.3360-1-cezary.rojewski@intel.com>
 <20200923122508.3360-3-cezary.rojewski@intel.com>
 <20200923131731.GE3956970@smile.fi.intel.com>
 <39bfea09d0a54c5dae3930408e45b10d@intel.com>
In-Reply-To: <39bfea09d0a54c5dae3930408e45b10d@intel.com>
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
 Krzysztof" <krzysztof.hejmowski@intel.com>,
 "ppapierkowski@habana.ai" <ppapierkowski@habana.ai>, "Gopal, 
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

On 2020-09-23 9:24 PM, Rojewski, Cezary wrote:
> On 2020-09-23 3:17 PM, Andy Shevchenko wrote:
>> On Wed, Sep 23, 2020 at 02:24:56PM +0200, Cezary Rojewski wrote:
>>> Implement IRQ handlers for immediate and delayed replies and
>>> notifications. Communication is synchronous and allows for serializatio=
n
>>> of maximum one message at a time.
>>>

...

>>> +		if (!ret && reply->data && reply->size)
>>
>>> +			memcpy(reply->data, ipc->rx.data, ipc->rx.size);
>>
>> This I didn't get. You copy data by using source size?!
>>
>>> +	}
>>> +
>>> +	return ret;
>>
>> I guess the above piece may be refactored, but I don't know how until it=
 is
>> clear why it's written like this.
>>
>> ...
>>
>=20
> Well, ipc->rx.size equals reply->size as long as IPC procedure is in
> progress and reply !=3D NULL. So either ipc->rx.size or reply->size
> suffices.
>=20
> IPC protocol is quite simple here (albeit cAVS arguably is even simpler):
>=20
> OUTBOX <channel: request - reply model>
> TX: copy request header to appropriate register, copy payload to outbox
> <IRQ>
> RX: copy reply header, copy returned payload only in successful case
>=20

Forgotten to mention: yes OUTBOX's TX =3D=3D OUTBOX's RX (HOST owns the
space during the request phase and yields the ownership to DSP once
IPCC_BUSY bit is set).

No ownership juggling in INBOX case.

Czarek

