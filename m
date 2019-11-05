Return-Path: <SRS0=4Snk=Y5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D80C5DF60
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:14:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5724E214D8
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fvQ+YMIT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5724E214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8D85216E9;
	Tue,  5 Nov 2019 16:13:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8D85216E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572966846;
	bh=l2tn7kJeB+ABBLjEb4YFnbQLyt1TQC9ey+K9PLXpbdo=;
	h=From:To:Date:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fvQ+YMIT9sNY1g76S8Q9jyDTrdZdCpaizi2UBBx78LLeH93lfg3C/zG/e8PsEKJ+E
	 0AJpQi7wOsYhR6Y3k7qoJngGiHB73txBiMheLoauaKVGyRPXU0nkB+Ui/yCmrqtlUS
	 qHuCT6nt1irJwMrElmjiRtaEXJB2VgvbdTwv7BoM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 61BBAF80642;
	Tue,  5 Nov 2019 16:09:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DB613F8049B; Tue,  5 Nov 2019 16:06:55 +0100 (CET)
Received: from mailgate1.rohmeurope.com (mailgate1.rohmeurope.com
 [178.15.145.194])
 by alsa1.perex.cz (Postfix) with ESMTP id 8392AF800F3
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 16:06:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8392AF800F3
X-AuditID: c0a8fbf4-199ff70000001fa6-fa-5dc19009d42a
Received: from smtp.reu.rohmeu.com (will-cas002.reu.rohmeu.com
 [192.168.251.178])
 by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id
 EF.F6.08102.90091CD5; Tue,  5 Nov 2019 16:06:49 +0100 (CET)
Received: from WILL-MAIL002.REu.RohmEu.com ([fe80::e0c3:e88c:5f22:d174]) by
 WILL-CAS002.REu.RohmEu.com ([fe80::fc24:4cbc:e287:8659%12]) with mapi id
 14.03.0439.000; Tue, 5 Nov 2019 16:06:42 +0100
From: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To: "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
Thread-Topic: [PATCH 00/62] Add definition for GPIO direction
Thread-Index: AQHVk8EYmzhgkSAfS0Ot5MRDeZesqad8bpwAgAAJlQCAAAReAIAABYEAgAABmgCAAAa5gIAAEKoAgAAB+IA=
Date: Tue, 5 Nov 2019 15:06:42 +0000
Message-ID: <be58a14237f8195f00a459e8b06876fe37d1b836.camel@fi.rohmeurope.com>
References: <cover.1572875541.git.matti.vaittinen@fi.rohmeurope.com>
 <20191105122042.GO32742@smile.fi.intel.com>
 <4e6fa62d7022c7b1426477a150a93c899725f5b0.camel@fi.rohmeurope.com>
 <20191105131038.duol3rwwkbuvgvwv@pengutronix.de>
 <938a5ec7b41ae9ce7b0de83764d6b774cfdaa781.camel@fi.rohmeurope.com>
 <20191105133604.d2xcasxw7pwzwvh7@pengutronix.de>
 <a967c764d135ab0f96f6b1df62ac91426c935b44.camel@fi.rohmeurope.com>
 <20191105145946.2ye6ujvqzn2d6fqd@pengutronix.de>
In-Reply-To: <20191105145946.2ye6ujvqzn2d6fqd@pengutronix.de>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [176.93.201.147]
Content-ID: <6D5D437184F57F40A974F8CC692726E2@de.rohmeurope.com>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUwbdRjH/d1dr0e34lFg/GDwBx2J0WSbmLk86pyb2eLNLTqifxCV4BVu
 lKwUci0K/jGRsRDKCixiYBUYIlUK4qTdgut47dDBpiLhZRIGswEUiLxM2JSXbt5RN/jn7pvn
 +3ye73PJcwypOctEMKlGsyAaeYOWVlEddavOnQElnQnPWr99EpombiIY6PMQ4O5nwJpbRkDh
 QhkJjdYfKFiqvEHBwBkngnbrNRJW5rqU4B18ExylFAx/cpWA1V4fCXm2GgrqP7tCwaRrnIDS
 ta8JcI4PKeB0wy8kuC6sIbCsOEjod1fQ8HltMQWjo/UILk/PEWAZmlBAwZKNhqnGWwrorr2H
 wOuooKDC3k1Bla9RAXPT8dDm+omAxfl2BXT+OUtBX3kvCZPnXTT4mp0U5DsGpLaGCQS/Lg8T
 MHUpDG67XAoo/+YqgmV3FQUj5z5FYJ2309A6togOPMcN5ruV3HeLuTQ3/9sZJWe78zPNla/W
 UJy7I4IrXPSQ3BXbqJLru/sjyTnrC2ju9lALzVX1xHGu2o+53vIvEFeyMCuV/7Wj45HvbNmn
 480fvJWaYty9//0t+msWnyJjSpVl/2p/DupSWVAAg9k9uKVoAclaww4iPFSx14JUkr6OcGvT
 fcqCGIZm92HLsFKWIexhnHd3vYVkZ0Oxra5ZKbPBUsvN03Xrc0LYl3HDHRft1zpcVjtOyZpi
 Y3C/r3pdq9k38NTwdcKf6yXxyIXnZR0gsXkLfes9iI3CBTlz6z0kG4adf/yj8O/M4tqWXtKv
 Q/H0+IP/61rcsvwlIe9Jsk/ji+7dfnkAX+4W/VOicWmhV+nfIAj3nJ+gStA226YA2wZs24Bt
 m2DbJrgaKeoRTuNTDSm8WYjdJQqZu8R0fZr0SkpPcyL/XS99jx56jngQwSAPCmcIbaj69dTO
 BE2gLj05W8+b9IlipkEweRBmSG2I+r0iyVMn89kfCWL6I2s7Q2nD1E95zyVoWDnrpCBkCOIj
 N5JhtFjdYJXAIFFIEbJOpBrMGzbBBMjDVREhJsGYLIh8plmfKJ9Gokm6DdnaKuV2FMu5pgw+
 Tar60RsolimZrqwhma5Ku/S8Nd9qJzWUMd0oRISpk2SAlQF9pvFx3AwKY5A2WN0uf8ZW6Rd/
 PG1GCiKkoGPjbXKQmd+wInKQw5H1YOmg4W3Nu0mvBd0v71lu/Xsseij+w3uccPTSybHgqEOJ
 gW3GspiLvz9Ur+m3vdCVf+SJvyZnssOP7RUmVqjivmlDsdobdUpF7gzOPdERdKizuulgEWd2
 vxR+/PDRs7rI3Lhocs+LkzvEqe7RV3QjeHL7q0WBczFt8SOnZuOad2gpk56PfYYUTfx/DcuQ
 hZ8EAAA=
X-Mailman-Approved-At: Tue, 05 Nov 2019 16:08:56 +0100
Cc: "semi.malinen@ge.com" <semi.malinen@ge.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 "david.daney@cavium.com" <david.daney@cavium.com>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "sathyanarayanan.kuppuswamy@linux.intel.com"
 <sathyanarayanan.kuppuswamy@linux.intel.com>,
 "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
 "ptyser@xes-inc.com" <ptyser@xes-inc.com>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 "marek.behun@nic.cz" <marek.behun@nic.cz>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
 "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
 "khilman@kernel.org" <khilman@kernel.org>,
 "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
 "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
 "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
 "ludovic.desroches@microchip.com" <ludovic.desroches@microchip.com>,
 "bamv2005@gmail.com" <bamv2005@gmail.com>,
 "linux-imx@nxp.com" <linux-imx@nxp.com>,
 "nandor.han@ge.com" <nandor.han@ge.com>,
 "bcm-kernel-feedback-list@broadcom.com"
 <bcm-kernel-feedback-list@broadcom.com>, "joel@jms.id.au" <joel@jms.id.au>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
 "grygorii.strashko@ti.com" <grygorii.strashko@ti.com>,
 "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
 "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
 "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
 "rjui@broadcom.com" <rjui@broadcom.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "vilhelm.gray@gmail.com" <vilhelm.gray@gmail.com>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "rf@opensource.cirrus.com" <rf@opensource.cirrus.com>,
 "ssantosh@kernel.org" <ssantosh@kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "sbranden@broadcom.com" <sbranden@broadcom.com>,
 "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
 "andrew@aj.id.au" <andrew@aj.id.au>, "info@metux.net" <info@metux.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "t.scherer@eckelmann.de" <t.scherer@eckelmann.de>,
 "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
 "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: Re: [alsa-devel] [PATCH 00/62] Add definition for GPIO direction
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

DQpPbiBUdWUsIDIwMTktMTEtMDUgYXQgMTU6NTkgKzAxMDAsIFV3ZSBLbGVpbmUtS8O2bmlnIHdy
b3RlOg0KPiBIZWxsbyBNYXR0aSwNCj4gDQo+IE9uIFR1ZSwgTm92IDA1LCAyMDE5IGF0IDAyOjAw
OjAyUE0gKzAwMDAsIFZhaXR0aW5lbiwgTWF0dGkgd3JvdGU6DQo+ID4gT24gVHVlLCAyMDE5LTEx
LTA1IGF0IDE0OjM2ICswMTAwLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90ZToNCj4gPiBUaGFua3Mg
VXdlISBUaGF0IHdhcyBraW5kISBJJ20gb24gRmVkb3JhIGJ1dCBJIGd1ZXNzIEkgY2FuIGZpbmQg
dGhlDQo+ID4gbXVsdGlhcmNoIGJpbnV0aWxzIDopIEknbGwgdHJ5IHRoYXQgdG9tb3Jyb3cgd2hl
biBJJ20gYmFjayBhdCB0aGUNCj4gPiBvZmZpY2UuIExldCdzIHNlZSB3aGF0IGtpbmQgb2YgcmVz
dWx0cyBJIGNhbiBnZXQgZnJvbSBpdC4NCj4gPiANCj4gPiBVbmZvcnR1bmF0ZWx5IGJ1bmNoIG9m
IHRoZSBHUElPcyBkZXBlbmQgb24geDg2IC0gc28gSSBuZWVkIHRvIHNlZQ0KPiA+IHdoYXQNCj4g
PiBJIGNhbiBjb21waWxlIGluIHdpdGggZGVjZW50IGVmZm9ydC4gRm9yIG15IGNvbXBpbGUgdGVz
dCBJIGp1c3QNCj4gPiBoYWNrZWQNCj4gPiB0aGUgTWFrZWZpbGUgdG8gZm9yY2UgYWxsIGluIGFu
ZCBhZGRlZCBzb21lIGR1bW15IG1hY3JvcyB0byBmaXggZmV3DQo+ID4gbWlzc2luZyBmdW5jdGlv
bnMgOnwgQnV0IEkgZ3Vlc3MgSSBjYW4gZ2V0IHNvbWUgcmVzdWx0cy4NCj4gDQo+IEVuYWJsZSBD
T05GSUdfQ09NUElMRV9URVNUIGFuZCB0aGVuIHlvdSBzaG91bGQgYmUgYWJsZSB0byBjb21waWxl
DQo+IG1vc3QNCj4gZHJpdmVycyBhbHNvIG9uIHRoZSB3cm9uZyBhcmNoaXRlY3R1cmUuDQoNClJp
Z2h0LiBUaGF0IHdhcyB0aGUgZmlyc3QgdGhpbmcgSSB0cmllZCBvdXQuIFVuZm9ydHVuYXRlbHkg
YnVuY2ggb2YgdGhlDQpncGlvLWRyaXZlcnMgd29uJ3QgY2FyZSBhYm91dCBDT05GSUdfQ09NUElM
RV9URVNULiBUaGFua3MgYW55d2F5cyA6KQ0KDQpCciwNCglNYXR0aQ0KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QK
QWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHBzOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qu
b3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
