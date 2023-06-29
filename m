Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D3EEB64D9
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Jun 2023 10:23:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 60699826;
	Thu, 29 Jun 2023 12:23:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 60699826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1688034235;
	bh=ubbdZrkR1m8m25/YQmJ+IW/nRiNZQBP85iqZpBa5pS4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=K/XSz/CvdiDwcz+9U2zdXpUENnwBJQ0+P56BQ8fmE7aucGX/oOROdd7jL2YnIRxIn
	 /vCJZnk0aeHIMOt3fvVeSKLgFg00ToZi2iGN8JocyB1lQcIFyMG1I68rXaAK8mYSNz
	 FoojZ7MUezyk4H4JCAXnZC7nf/AQer/v37HxvGqo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B825AF80535; Thu, 29 Jun 2023 12:22:36 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 47E03F8051E;
	Thu, 29 Jun 2023 12:22:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 030A8F80246; Thu, 29 Jun 2023 12:22:32 +0200 (CEST)
Received: from eu-smtp-delivery-151.mimecast.com
 (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9A29DF800E3
	for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2023 12:22:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A29DF800E3
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-156-pPX-EROVOembC7vWITh1PA-1; Thu, 29 Jun 2023 11:22:15 +0100
X-MC-Unique: pPX-EROVOembC7vWITh1PA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 29 Jun
 2023 11:21:06 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 29 Jun 2023 11:21:06 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Mark Brown' <broonie@kernel.org>
CC: 'Sameer Pujar' <spujar@nvidia.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, "lgirdwood@gmail.com"
	<lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com"
	<tiwai@suse.com>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"mkumard@nvidia.com" <mkumard@nvidia.com>, "sheetal@nvidia.com"
	<sheetal@nvidia.com>, "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Oder Chiou <oder_chiou@realtek.com>
Subject: RE: [PATCH v2 3/5] ASoC: rt5640: Fix sleep in atomic context
Thread-Topic: [PATCH v2 3/5] ASoC: rt5640: Fix sleep in atomic context
Thread-Index: AQHZqkh8hA8hSCOxA0KruUap8XcLma+hdFowgAAKboCAABMH0A==
Date: Thu, 29 Jun 2023 10:21:06 +0000
Message-ID: <953c899d04e543f681e44daad4ec2ff7@AcuMS.aculab.com>
References: <1688015537-31682-1-git-send-email-spujar@nvidia.com>
 <1688015537-31682-4-git-send-email-spujar@nvidia.com>
 <bae9f041867e4625ad293d284566bb4f@AcuMS.aculab.com>
 <550e5c8f-0bfb-4ffc-9a43-1ecb153c6a02@sirena.org.uk>
In-Reply-To: <550e5c8f-0bfb-4ffc-9a43-1ecb153c6a02@sirena.org.uk>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: LDPSH7YNN7NA3Q4NGZ5XMHP5LWJNMI3Y
X-Message-ID-Hash: LDPSH7YNN7NA3Q4NGZ5XMHP5LWJNMI3Y
X-MailFrom: david.laight@aculab.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LDPSH7YNN7NA3Q4NGZ5XMHP5LWJNMI3Y/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Mark Brown
> Sent: 29 June 2023 11:11
>=20
> On Thu, Jun 29, 2023 at 08:38:09AM +0000, David Laight wrote:
> > From: Sameer Pujar
>=20
> > > Following prints are observed while testing audio on Jetson AGX Orin =
which
> > > has onboard RT5640 audio codec:
> > >
> > >   BUG: sleeping function called from invalid context at kernel/workqu=
eue.c:3027
> > >   in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 0, name: s=
wapper/0
>=20
> > My 'gut feel' is that this will just move the problem elsewhere.
>=20
> > If the ISR is responsible for adding audio buffers (etc) then it is
> > also not unlikely that the scheduling delays in running a threaded ISR
> > will cause audio glitches if the system is busy.
>=20
> What makes you think this is anything to do with audio glitches?  The
> bug is literally what is described, it is not valid to sleep in atomic
> contexts and if we ever actually try things are likely to go badly.

What I mean is that deferring the ISR to process context
is likely to generate audio glitches on a busy system.

I realise that sleeping in an ISR goes badly wrong.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

