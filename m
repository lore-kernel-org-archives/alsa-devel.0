Return-Path: <SRS0=bNm3=2P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1752DC2D0C3
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Dec 2019 01:47:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B208206B7
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Dec 2019 01:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VFMvU3vq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B208206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=richtek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0554116B6;
	Wed, 25 Dec 2019 02:46:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0554116B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1577238463;
	bh=Ep+Cbk5BU2u8kNjHju82C6aO6OC+vSq5G8nDfrHs5Ss=;
	h=From:To:Date:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VFMvU3vqMGhgImhAoGu4Y0v4aZ7+HJob3S4VOVrtJjljmRw68xCLWSx1ezOlTKFNM
	 Q8XIvPkUkGDEUa1R/5KyJPRTBtqTbREHZNhkcaEMABtA5XNx45vkKmXQkCSNccnWF9
	 /6+giI4UerliUc75CqR0I4k8vR79LzKiiyIyaMgY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A5F2F80136;
	Wed, 25 Dec 2019 02:46:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 264B7F80138; Wed, 25 Dec 2019 02:46:50 +0100 (CET)
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
 by alsa1.perex.cz (Postfix) with ESMTP id 414C8F800E8
 for <alsa-devel@alsa-project.org>; Wed, 25 Dec 2019 02:46:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 414C8F800E8
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
 LIVER,40,3)
Received: from 192.168.8.45
 by mg.richtek.com with MailGates ESMTP Server V5.0(11229:0:AUTH_RELAY)
 (envelope-from <jeff_chang@richtek.com>); Wed, 25 Dec 2019 09:45:44 +0800 (CST)
Received: from ex1.rt.l (192.168.8.44) by ex2.rt.l (192.168.8.45) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 25 Dec 2019 09:45:43 +0800
Received: from ex1.rt.l ([fe80::557d:30f0:a3f8:3efc]) by ex1.rt.l
 ([fe80::557d:30f0:a3f8:3efc%15]) with mapi id 15.00.1497.000; Wed, 25 Dec
 2019 09:45:43 +0800
From: =?utf-8?B?amVmZl9jaGFuZyjlvLXkuJbkvbMp?= <jeff_chang@richtek.com>
To: Mark Brown <broonie@kernel.org>
Thread-Topic: [PATCH] ASoC: Add MediaTek MT6660 Speaker Amp Driver
Thread-Index: AQHVtx5xY4OlmY1OS02nOllbj/O4KqfCaPoAgAST0kCAAnkNgIAApP4g
Date: Wed, 25 Dec 2019 01:45:43 +0000
Message-ID: <938f562e322849328d5a7782b2c1de97@ex1.rt.l>
References: <1576836934-5370-1-git-send-email-richtek.jeff.chang@gmail.com>
 <20191220121152.GC4790@sirena.org.uk>
 <7a9bcf5d414c4a74ae8e101c54c9e46f@ex1.rt.l>
 <20191224235145.GA27497@sirena.org.uk>
In-Reply-To: <20191224235145.GA27497@sirena.org.uk>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.95.168]
MIME-Version: 1.0
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 Jeff Chang <richtek.jeff.chang@gmail.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: Add MediaTek MT6660 Speaker Amp
	Driver
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

RGVhciBNYXJrOg0KDQpJIG5lZWQgdG8gY29uZmlybSBpdCBhZ2Fpbi4NCg0KVGhpcyBpcyBhZGF1
MTk5NyBkcml2ZXIgb24gdXBzdHJlYW0gYnJhbmNoDQoNCkAgc291bmQvc29jL2NvZGVjcy9hZGF1
MTk5Ny5jDQoNCi8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkNCi8qDQog
KiBBREFVMTk3Ny9BREFVMTk3OC9BREFVMTk3OSBkcml2ZXINCiAqDQogKiBDb3B5cmlnaHQgMjAx
NCBBbmFsb2cgRGV2aWNlcyBJbmMuDQogKiAgQXV0aG9yOiBMYXJzLVBldGVyIENsYXVzZW4gPGxh
cnNAbWV0YWZvby5kZT4NCiAqLw0KDQpAc291bmQvc29jL2NvZGVjcy9hZGF1MTk5Ny5oDQoNCi8q
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkgKi8NCi8qDQogKiBBREFVMTk3
Ny9BREFVMTk3OC9BREFVMTk3OSBkcml2ZXINCiAqDQogKiBDb3B5cmlnaHQgMjAxNCBBbmFsb2cg
RGV2aWNlcyBJbmMuDQogKiAgQXV0aG9yOiBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZv
by5kZT4NCiAqLw0KDQoNCkl0IHNlZW1zIG5vdCB3aG9sZSBjb21tZW50IHVzZSBjKysuIE9ubHkg
Zmlyc3QgbGluZSBhdCBzb3VyY2UgZmlsZSwgUmlnaHQ/DQoNClRoYW5rcyBhIGxvdC4NCg0KDQpU
aGFua3MgJiBCUnMNCkplZmYgQ2hhbmcNClRlbCA4ODYtMy01NTI2Nzg5IEV4dCAyMzU3DQoxNEYs
IE5vLiA4LCBUYWl5dWVuIDFzdCBzdC4sIFpodWJlaSBDaXR5LA0KSHNpbmNodSBDb3VudHksIFRh
aXdhbiAzMDI4OA0KDQoNCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTWFy
ayBCcm93biBbbWFpbHRvOmJyb29uaWVAa2VybmVsLm9yZ10NClNlbnQ6IFdlZG5lc2RheSwgRGVj
ZW1iZXIgMjUsIDIwMTkgNzo1MiBBTQ0KVG86IGplZmZfY2hhbmco5by15LiW5L2zKSA8amVmZl9j
aGFuZ0ByaWNodGVrLmNvbT4NCkNjOiBKZWZmIENoYW5nIDxyaWNodGVrLmplZmYuY2hhbmdAZ21h
aWwuY29tPjsgbGdpcmR3b29kQGdtYWlsLmNvbTsgcGVyZXhAcGVyZXguY3o7IHRpd2FpQHN1c2Uu
Y29tOyBtYXR0aGlhcy5iZ2dAZ21haWwuY29tOyBhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmc7
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0gQVNvQzogQWRkIE1lZGlhVGVrIE1UNjY2
MCBTcGVha2VyIEFtcCBEcml2ZXINCg0KT24gTW9uLCBEZWMgMjMsIDIwMTkgYXQgMDI6MTA6MTJB
TSArMDAwMCwgamVmZl9jaGFuZyjlvLXkuJbkvbMpIHdyb3RlOg0KDQo+IC0tPiBXaGVuIEkgY2hl
Y2sgb3RoZXIgZHJpdmVyIGF0IHNvdW5kL3NvYy9jb2RlY3MvIGZvbGRlciwgSSBqdXN0IGZvbGxv
dyB3aGF0IG90aGVycyBkby4NCj4gSXQgc2VlbXMgaW4gLmggLS0+IC8qIFNQRFgtTGllbmNlc2Ut
SWRlbnRpZmllcjogR1BMLTIuMCAqLw0KPiAgICBJbiAuYyAtLT4gLy8gU1BESy1MaWVuY2VzZS1J
ZGVudGlmaWVyOiBHUEwtMi4wDQoNCj4gSXMgaXQgY29ycmVjdD8NCg0KWWVzLCBoZWFkZXJzIHVz
ZSBDIHN0eWxlIGNvbW1lbnRzIGFuZCBzb3VyY2UgZmlsZXMgdXNlIEMrKyBzdHlsZS4NCioqKioq
KioqKioqKiogRW1haWwgQ29uZmlkZW50aWFsaXR5IE5vdGljZSAqKioqKioqKioqKioqKioqKioq
Kg0KDQpUaGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGluIHRoaXMgZS1tYWlsIG1lc3NhZ2UgKGlu
Y2x1ZGluZyBhbnkgYXR0YWNobWVudHMpIG1heSBiZSBjb25maWRlbnRpYWwsIHByb3ByaWV0YXJ5
LCBwcml2aWxlZ2VkLCBvciBvdGhlcndpc2UgZXhlbXB0IGZyb20gZGlzY2xvc3VyZSB1bmRlciBh
cHBsaWNhYmxlIGxhd3MuIEl0IGlzIGludGVuZGVkIHRvIGJlIGNvbnZleWVkIG9ubHkgdG8gdGhl
IGRlc2lnbmF0ZWQgcmVjaXBpZW50KHMpLiBBbnkgdXNlLCBkaXNzZW1pbmF0aW9uLCBkaXN0cmli
dXRpb24sIHByaW50aW5nLCByZXRhaW5pbmcgb3IgY29weWluZyBvZiB0aGlzIGUtbWFpbCAoaW5j
bHVkaW5nIGl0cyBhdHRhY2htZW50cykgYnkgdW5pbnRlbmRlZCByZWNpcGllbnQocykgaXMgc3Ry
aWN0bHkgcHJvaGliaXRlZCBhbmQgbWF5IGJlIHVubGF3ZnVsLiBJZiB5b3UgYXJlIG5vdCBhbiBp
bnRlbmRlZCByZWNpcGllbnQgb2YgdGhpcyBlLW1haWwsIG9yIGJlbGlldmUgdGhhdCB5b3UgaGF2
ZSByZWNlaXZlZCB0aGlzIGUtbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVy
IGltbWVkaWF0ZWx5IChieSByZXBseWluZyB0byB0aGlzIGUtbWFpbCksIGRlbGV0ZSBhbnkgYW5k
IGFsbCBjb3BpZXMgb2YgdGhpcyBlLW1haWwgKGluY2x1ZGluZyBhbnkgYXR0YWNobWVudHMpIGZy
b20geW91ciBzeXN0ZW0sIGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnQgb2YgdGhpcyBl
LW1haWwgdG8gYW55IG90aGVyIHBlcnNvbi4gVGhhbmsgeW91IQ0KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxz
YS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHBzOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3Jn
L21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
