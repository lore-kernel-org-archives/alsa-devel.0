Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314B8F531F4
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2026 06:44:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BDFB4601CC;
	Tue, 14 Apr 2026 08:44:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BDFB4601CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1776149097;
	bh=K4VOqbnlrdVjgIxsZqmBtjeY4oCuHOchMp+q9xr5Uxc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=VMA3B5g+GdS/6PJUmwYUFATY9IPSbXlT4tveGkKvQ3cr0h6kxhrOVwpPw/jG7OXyL
	 2LlIZRjQtfEOd6Sc5I99J7eBXgqk6B2DFZ4v4NLY3wbC4hjBQBy9iYOFs8VEjBfaAO
	 mcxqnJJ3u20SxS/Vs+bBZnt3Chh2m9eXIviu39xE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A39DAF805E4; Tue, 14 Apr 2026 08:44:23 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C11A2F805F1;
	Tue, 14 Apr 2026 08:44:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 603E3F80510; Tue, 14 Apr 2026 08:44:13 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 98D85F800C1
	for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2026 08:44:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 98D85F800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=P9d7EWFn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63E6hwxD71533778,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776149038; bh=m2rZ6Thlz7ys1m+FUoEL3uymyXMeq2xO32LyF7hqZNM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version;
	b=P9d7EWFnLOSFkcTGipZIG+PQlsO2tHYfX42WI7TzFXNfrVQHvJTRAW/VJ+fkfIVkw
	 ffDhyqiR7RDEWEOdiDXBJanV2keHMVNYKzCY0cZwQTQMYhg1dojzmNUI/GkoukTXA9
	 jkp1P3kfNFlX+n+ckBIPLT9wAjs04l6OuJekE41pdcd7FnXxyNvqSnmjN8eMwyfCKD
	 wSuRnuIFvHQNM0tITQuLBCKBSDmA6y7TrDYt5QYy7sP9VE9t8s2fSMZ6d1x0lhBzSA
	 fNnJJ/VUlN6sqI6QJu46Vy7jO3OqlZurYCeDAOSBCxSWR2qsqSxdMure1bzI1kuFuJ
	 gxy46z2Y+NO/Q==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63E6hwxD71533778
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 14:43:58 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 14 Apr 2026 14:43:58 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::ed72:3015:2840:4458%10]) with mapi id
 15.02.1748.010; Tue, 14 Apr 2026 14:43:58 +0800
From: Kailang <kailang@realtek.com>
To: =?utf-8?B?SsOpcsOpbXkgQmV0aG1vbnQ=?= <jeremy.bethmont@gmail.com>
CC: Takashi Iwai <tiwai@suse.de>,
        "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>,
        "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>,
        "regressions@leemhuis.info"
	<regressions@leemhuis.info>
Subject: RE: [REGRESSION] Audio popping on ThinkPad X1 Carbon Gen 12 (ALC287)
 after commit d2e01e0c5e94
Thread-Topic: [REGRESSION] Audio popping on ThinkPad X1 Carbon Gen 12 (ALC287)
 after commit d2e01e0c5e94
Thread-Index: 
 AQHcsCEJ0ioheXDhmUiIGGE8KvE4VLWmzTwAgAAbEQCAAAJMAIA2AOEQgADgZoCAAIeEwA==
Date: Tue, 14 Apr 2026 06:43:56 +0000
Message-ID: <658f53ada52f4de9a0c852dd56554a2a@realtek.com>
References: 
 <CAC88DfsHrhyhy0Pn1O-z9egBvMYu=6NYgcvcC6KCgwh_-Ldkxg@mail.gmail.com>
 <87a4wgrxil.wl-tiwai@suse.de>
 <CAC88DfvjQvZvdvGdZ00woMymE2tUWk=2Dbqi3EzuzSHxGjEnzw@mail.gmail.com>
 <871phsrsnf.wl-tiwai@suse.de> <f59a70ca796b4d09822f514e7f25ac5c@realtek.com>
 <CAC88DftEBEEEvODGUZzkry+kgAm=SfH=PAsxwu+SABMBMRMs=Q@mail.gmail.com>
In-Reply-To: 
 <CAC88DftEBEEEvODGUZzkry+kgAm=SfH=PAsxwu+SABMBMRMs=Q@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: yes
x-originating-ip: [172.21.6.42]
Content-Type: multipart/mixed;
	boundary="_002_658f53ada52f4de9a0c852dd56554a2arealtekcom_"
MIME-Version: 1.0
Message-ID-Hash: F5BCU44F6JQPVQFMOEHFUTZ72LB5C7BN
X-Message-ID-Hash: F5BCU44F6JQPVQFMOEHFUTZ72LB5C7BN
X-MailFrom: kailang@realtek.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/F5BCU44F6JQPVQFMOEHFUTZ72LB5C7BN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

--_002_658f53ada52f4de9a0c852dd56554a2arealtekcom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

U29ycnkhISBBdHRhY2hlZCB3cm9uZyBmaWxlLg0KQXR0YWNoZWQgYWdhaW4uDQoNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBKw6lyw6lteSBCZXRobW9udCA8amVyZW15LmJldGht
b250QGdtYWlsLmNvbT4gDQpTZW50OiBUdWVzZGF5LCBBcHJpbCAxNCwgMjAyNiAyOjM3IFBNDQpU
bzogS2FpbGFuZyA8a2FpbGFuZ0ByZWFsdGVrLmNvbT4NCkNjOiBUYWthc2hpIEl3YWkgPHRpd2Fp
QHN1c2UuZGU+OyBhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmc7IHJlZ3Jlc3Npb25zQGxpc3Rz
LmxpbnV4LmRldjsgcmVncmVzc2lvbnNAbGVlbWh1aXMuaW5mbw0KU3ViamVjdDogUmU6IFtSRUdS
RVNTSU9OXSBBdWRpbyBwb3BwaW5nIG9uIFRoaW5rUGFkIFgxIENhcmJvbiBHZW4gMTIgKEFMQzI4
NykgYWZ0ZXIgY29tbWl0IGQyZTAxZTBjNWU5NA0KDQoNCkV4dGVybmFsIG1haWwgOiBUaGlzIGVt
YWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIHRoZSBvcmdhbml6YXRpb24uIERvIG5vdCByZXBs
eSwgY2xpY2sgbGlua3MsIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUg
dGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KDQoNCg0KSGkgS2FpbGFu
ZywNCg0KVGhhbmsgeW91IGZvciB0aGUgcGF0Y2guIEhvd2V2ZXIsIEkgYmVsaWV2ZSB5b3UgbWF5
IGhhdmUgYXR0YWNoZWQgdGhlIHdyb25nIGZpbGUgYnkgbWlzdGFrZS4NCg0KVGhlIGF0dGFjaGVk
IHBhdGNoICgiMDAwMC14MS1nZW4xMi1zcGVha2VyLnBhdGNoIikgaXMgZGF0ZWQgTm92ZW1iZXIg
MTIsIDIwMjQuIEl0cyBjb21taXQgbWVzc2FnZSBtZW50aW9ucyBmaXhpbmcgYW4gaXNzdWUgd2l0
aCBvbGRlciBCSU9TIHZlcnNpb25zLg0KDQpDb3VsZCB5b3UgcGxlYXNlIGRvdWJsZS1jaGVjaz8N
Cg0KQmVzdCByZWdhcmRzLA0KSmVyZW15DQoNCk9uIE1vbiwgMTMgQXByIDIwMjYgYXQgMTY6MTYs
IEthaWxhbmcgPGthaWxhbmdAcmVhbHRlay5jb20+IHdyb3RlOg0KPg0KPiBIaSBKZXJlbXksDQo+
DQo+IFlvdSBjYW4gdGVzdCBhdHRhY2ggcGF0Y2guDQo+DQo+IEJSLA0KPiBLYWlsYW5nDQo+DQo+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFRha2FzaGkgSXdhaSA8dGl3YWlA
c3VzZS5kZT4NCj4gU2VudDogVHVlc2RheSwgTWFyY2ggMTAsIDIwMjYgNDozMyBQTQ0KPiBUbzog
SsOpcsOpbXkgQmV0aG1vbnQgPGplcmVteS5iZXRobW9udEBnbWFpbC5jb20+DQo+IENjOiBLYWls
YW5nIDxrYWlsYW5nQHJlYWx0ZWsuY29tPjsgYWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnOyAN
Cj4gcmVncmVzc2lvbnNAbGlzdHMubGludXguZGV2OyByZWdyZXNzaW9uc0BsZWVtaHVpcy5pbmZv
DQo+IFN1YmplY3Q6IFJlOiBbUkVHUkVTU0lPTl0gQXVkaW8gcG9wcGluZyBvbiBUaGlua1BhZCBY
MSBDYXJib24gR2VuIDEyIA0KPiAoQUxDMjg3KSBhZnRlciBjb21taXQgZDJlMDFlMGM1ZTk0DQo+
DQo+DQo+IEV4dGVybmFsIG1haWwgOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRl
IHRoZSBvcmdhbml6YXRpb24uIERvIG5vdCByZXBseSwgY2xpY2sgbGlua3MsIG9yIG9wZW4gYXR0
YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29u
dGVudCBpcyBzYWZlLg0KPg0KPg0KPg0KPiBPbiBUdWUsIDEwIE1hciAyMDI2IDA5OjI0OjM4ICsw
MTAwLA0KPiBKw6lyw6lteSBCZXRobW9udCB3cm90ZToNCj4gPg0KPiA+IEhpIFRha2FzaGksDQo+
ID4NCj4gPiBUaGFuayB5b3UgZm9yIGxvb2tpbmcgaW50byB0aGlzIHNvIHF1aWNrbHkuDQo+ID4N
Cj4gPiBBcyByZXF1ZXN0ZWQsIEkgaGF2ZSBhdHRhY2hlZCB0aGUgb3V0cHV0IG9mIGBhbHNhLWlu
Zm8uc2ggDQo+ID4gLS1uby11cGxvYWRgIGZyb20gbXkgbWFjaGluZS4NCj4gPg0KPiA+IFBsZWFz
ZSBsZXQgbWUga25vdyBpZiB5b3UgaGF2ZSBhIHByb3Bvc2VkIHBhdGNoIHlvdSB3b3VsZCBsaWtl
IG1lIHRvIA0KPiA+IHRlc3QuIEkgYW0gaGFwcHkgdG8gYnVpbGQgaXQgYW5kIHZlcmlmeSBpZiBp
dCByZXNvbHZlcyB0aGUgcG9wcGluZyANCj4gPiBvbiBteSBoYXJkd2FyZS4NCj4NCj4gSSBndWVz
cyBkcm9wcGluZyB0aGUgYWxjX3Byb2Nlc3NfY29lZl9mdyhjb2RlYywgZW5fY29lZnMpIGNhbGwg
YXQgY2xvc2luZyB3b3VsZCBmaXggeW91ciBwcm9ibGVtIHdoaWxlIGtlZXBpbmcgdGhlIG9uZSBh
dCBvcGVuLg0KPiBCdXQgSSdtIG5vdCBzdXJlIGFib3V0IGFueSBzaWRlLWVmZmVjdCBieSB0aGF0
Lg0KPiBLYWlsYW5nLCBjb3VsZCB5b3UgY2hlY2sgdGhpcz8NCj4NCj4gQlRXLCB3aGVuIHlvdSBk
aXNhYmxlIHJ1bnRpbWUgUE0sIGRvZXMgdGhlIHBvcCBub2lzZSBzdGlsbCBhcHBlYXJzPw0KPg0K
Pg0KPiB0aGFua3MsDQo+DQo+IFRha2FzaGkNCj4NCj4gPg0KPiA+IEJlc3QgcmVnYXJkcywNCj4g
PiBKZXJlbXkNCj4gPg0KPiA+IE9uIFR1ZSwgMTAgTWFyIDIwMjYgYXQgMTM6NDcsIFRha2FzaGkg
SXdhaSA8dGl3YWlAc3VzZS5kZT4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gT24gVHVlLCAxMCBNYXIg
MjAyNiAwMTowMToxMSArMDEwMCwgSsOpcsOpbXkgQmV0aG1vbnQgd3JvdGU6DQo+ID4gPiA+DQo+
ID4gPiA+IEhpIFRha2FzaGksIEthaWxhbmcsDQo+ID4gPiA+DQo+ID4gPiA+IEkgYW0gcmVwb3J0
aW5nIGFuIGF1ZGlvIHJlZ3Jlc3Npb24gaW50cm9kdWNlZCBpbiBrZXJuZWwgNi4xOC4xMyANCj4g
PiA+ID4gb24gdGhlIExlbm92byBUaGlua1BhZCBYMSBDYXJib24gR2VuIDEyIChNZXRlb3IgTGFr
ZSwgUmVhbHRlayANCj4gPiA+ID4gQUxDMjg3IGNvZGVjLA0KPiA+ID4gPiBTU0lEOiAweDE3YWEy
MzFlKS4NCj4gPiA+ID4NCj4gPiA+ID4gU2luY2UgdGhpcyB1cGRhdGUsIHRoZSBsYXB0b3AgZW1p
dHMgYSBzaG9ydCwgbm90aWNlYWJsZSBoYXJkd2FyZSANCj4gPiA+ID4gcG9wL2JsaXAgZnJvbSB0
aGUgc3BlYWtlcnMgZXhhY3RseSB3aGVuIGFuIGF1ZGlvIHN0cmVhbSBjbG9zZXMgDQo+ID4gPiA+
IGFuZCB0aGUgUENNIHN0YXRlIHN1c3BlbmRzLiBJdCBoYXBwZW5zIGNvbnNpc3RlbnRseSBhIGZl
dyANCj4gPiA+ID4gc2Vjb25kcyBhZnRlciBwbGF5YmFjayBmaW5pc2hlcyAoZS5nLiwgYWZ0ZXIg
YSBzeXN0ZW0gDQo+ID4gPiA+IG5vdGlmaWNhdGlvbiBvciB0ZXJtaW5hbCBiZWxsKS4NCj4gPiA+
ID4NCj4gPiA+ID4gSSBoYXZlIHRyYWNrZWQgdGhlIHJlZ3Jlc3Npb24gZG93biB0byB0aGUgZm9s
bG93aW5nIGNvbW1pdDoNCj4gPiA+ID4gZDJlMDFlMGM1ZTk0N2RhMGI1MDA1Y2E4OWVmYTgyYmFl
YjIzMmFkYyAoIkFMU0E6IGhkYS9yZWFsdGVrIC0gDQo+ID4gPiA+IGZpeGVkIHNwZWFrZXIgbm8g
c291bmQiKQ0KPiA+ID4gPg0KPiA+ID4gPiAjcmVnemJvdCBpbnRyb2R1Y2VkOiBkMmUwMWUwYzVl
OTQ3ZGEwYjUwMDVjYTg5ZWZhODJiYWViMjMyYWRjDQo+ID4gPiA+DQo+ID4gPiA+IFJvb3QgY2F1
c2UgYW5hbHlzaXM6DQo+ID4gPiA+IFRoZSBjb21taXQgbW9kaWZpZXMgdGhlIGBhbGMyODdfYWxj
MTMxOF9wbGF5YmFja19wY21faG9va2ANCj4gPiA+ID4gZnVuY3Rpb24sIGFkZGluZyByYXcgQ09F
RiB3cml0ZXMgdG8gZGlzYWJsZS9lbmFibGUgQU1QIHNpbGVuY2UgDQo+ID4gPiA+IGRldGVjdGlv
biBvbiBIREFfR0VOX1BDTV9BQ1RfT1BFTiBhbmQgSERBX0dFTl9QQ01fQUNUX0NMT1NFLg0KPiA+
ID4gPg0KPiA+ID4gPiBCZWNhdXNlIGBhbGMyODdfYWxjMTMxOF9wbGF5YmFja19wY21faG9va2Ag
aXMgYSBzaGFyZWQgaG9vayB1c2VkIA0KPiA+ID4gPiBieSBtdWx0aXBsZSBMZW5vdm8gQUxDMjg3
L0FMQzEzMTggZGV2aWNlcywgdGhlc2UgdW5jb25kaXRpb25hbCANCj4gPiA+ID4gYFdSSVRFX0NP
RUZgIGluc3RydWN0aW9ucyBhcmUgYmVpbmcgc2VudCB0byBoYXJkd2FyZSB0aGF0IGRvZXMgDQo+
ID4gPiA+IG5vdCBuZWVkIHRoZSBzaWxlbmNlIGRldGVjdGlvbiBmaXguIE9uIHRoZSBYMSBDYXJi
b24gR2VuIDEyLCANCj4gPiA+ID4gZXhlY3V0aW5nIGBhbGNfcHJvY2Vzc19jb2VmX2Z3KGNvZGVj
LCBlbl9jb2VmcylgIHVwb24gc3RyZWFtIA0KPiA+ID4gPiBjbG9zZSB0cmlnZ2VycyBhbiBpbW1l
ZGlhdGUgZWxlY3RyaWNhbCBwb3AuIE1vbml0b3Jpbmcgd2l0aCANCj4gPiA+ID4gYHB3LW1vbmAg
Y29uZmlybXMgdGhlIGhhcmR3YXJlIHBvcCBjb2luY2lkZXMgcGVyZmVjdGx5IHdpdGggdGhlIA0K
PiA+ID4gPiBtb25pdG9yX0ZSIC8gbW9uaXRvcl9GTCBwb3J0cyBnb2luZyBpZGxlL3N1c3BlbmRl
ZC4NCj4gPiA+ID4NCj4gPiA+ID4gUHJvcG9zZWQgc29sdXRpb246DQo+ID4gPiA+IENvdWxkIHdl
IHJldmVydCB0aGlzIGNvbW1pdCwgb3IgYWx0ZXJuYXRpdmVseSwgd3JhcCB0aGVzZSANCj4gPiA+
ID4gc3BlY2lmaWMgc2lsZW5jZS1kZXRlY3Rpb24gQ09FRiB3cml0ZXMgaW4gYSB0YXJnZXRlZCAN
Cj4gPiA+ID4gYEFMQzI4N19GSVhVUGAgcXVpcmsgbWF0Y2hlZCB2aWEgU1NJRC9ETUksIHJhdGhl
ciB0aGFuIGV4ZWN1dGluZyANCj4gPiA+ID4gdGhlbSBnbG9iYWxseSBpbiB0aGUgc2hhcmVkIHBs
YXliYWNrIGhvb2s/DQo+ID4gPg0KPiA+ID4gQ291bGQgeW91IGdpdmUgYWxzYS1pbmZvLnNoIG91
dHB1dD8gIFJ1biB0aGUgc2NyaXB0IHdpdGggDQo+ID4gPiAtLW5vLXVwbG9hZCBvcHRpb24gYW5k
IGF0dGFjaCB0aGUgb3V0cHV0Lg0KPiA+ID4NCj4gPiA+IEkgZ3Vlc3MgdGhlIGJ1ZyBtaWdodCBu
b3QgYmUgc3BlY2lmaWMgdG8geW91ciBkZXZpY2UgYnV0IGhhcHBlbmluZyANCj4gPiA+IGluIGdl
bmVyYWwgd2l0aCBhbGwgbWF0Y2hpbmcgb25lcy4gIEFzIGEgd29ya2Fyb3VuZCBmb3Igc3VjaCBh
IHBvcCANCj4gPiA+IG5vaXNlLCB3ZSBvZnRlbiBuZWVkIHRvIHJlb3JkZXIgdmVyYnMgb3IgcHV0
IHNvbWUgZGVsYXkgYmV0d2VlbiB2ZXJicy4NCj4gPiA+DQo+ID4gPg0KPiA+ID4gVGFrYXNoaQ0K
PiA+DQo+ID4NCj4gPg0KPiA+IC0tDQo+ID4gSsOpcsOpbXkgQmV0aG1vbnQNCj4gPg0KDQoNCg0K
LS0NCkrDqXLDqW15IEJldGhtb250DQo=

--_002_658f53ada52f4de9a0c852dd56554a2arealtekcom_
Content-Type: application/octet-stream;
	name="0000-x1-gen12-speaker-pop.patch"
Content-Description: 0000-x1-gen12-speaker-pop.patch
Content-Disposition: attachment; filename="0000-x1-gen12-speaker-pop.patch";
	size=1934; creation-date="Mon, 13 Apr 2026 09:14:30 GMT";
	modification-date="Mon, 13 Apr 2026 09:05:39 GMT"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3NvdW5kL2hkYS9jb2RlY3MvcmVhbHRlay9hbGMyNjkuYyBiL3NvdW5kL2hk
YS9jb2RlY3MvcmVhbHRlay9hbGMyNjkuYwppbmRleCAyY2YxY2MzY2I5MWMuLjcyZDE5ZjE4MDg4
MSAxMDA2NDQKLS0tIGEvc291bmQvaGRhL2NvZGVjcy9yZWFsdGVrL2FsYzI2OS5jCisrKyBiL3Nv
dW5kL2hkYS9jb2RlY3MvcmVhbHRlay9hbGMyNjkuYwpAQCAtMzY1NCwyMiArMzY1NCwxMSBAQCBz
dGF0aWMgdm9pZCBhbGMyODdfYWxjMTMxOF9wbGF5YmFja19wY21faG9vayhzdHJ1Y3QgaGRhX3Bj
bV9zdHJlYW0gKmhpbmZvLAogCQkJCSAgIHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3Ry
ZWFtLAogCQkJCSAgIGludCBhY3Rpb24pCiB7Ci0Jc3RhdGljIGNvbnN0IHN0cnVjdCBjb2VmX2Z3
IGRpc19jb2Vmc1tdID0gewotCQlXUklURV9DT0VGKDB4MjQsIDB4MDAxMyksIFdSSVRFX0NPRUYo
MHgyNSwgMHgwMDAwKSwgV1JJVEVfQ09FRigweDI2LCAweEMyMDMpLAotCQlXUklURV9DT0VGKDB4
MjgsIDB4MDAwNCksIFdSSVRFX0NPRUYoMHgyOSwgMHhiMDIzKSwKLQl9OyAvKiBEaXNhYmxlIEFN
UCBzaWxlbmNlIGRldGVjdGlvbiAqLwotCXN0YXRpYyBjb25zdCBzdHJ1Y3QgY29lZl9mdyBlbl9j
b2Vmc1tdID0gewotCQlXUklURV9DT0VGKDB4MjQsIDB4MDAxMyksIFdSSVRFX0NPRUYoMHgyNSwg
MHgwMDAwKSwgV1JJVEVfQ09FRigweDI2LCAweEMyMDMpLAotCQlXUklURV9DT0VGKDB4MjgsIDB4
MDA4NCksIFdSSVRFX0NPRUYoMHgyOSwgMHhiMDIzKSwKLQl9OyAvKiBFbmFibGUgQU1QIHNpbGVu
Y2UgZGV0ZWN0aW9uICovCi0KIAlzd2l0Y2ggKGFjdGlvbikgewogCWNhc2UgSERBX0dFTl9QQ01f
QUNUX09QRU46Ci0JCWFsY19wcm9jZXNzX2NvZWZfZncoY29kZWMsIGRpc19jb2Vmcyk7CiAJCWFs
Y193cml0ZV9jb2VmZXhfaWR4KGNvZGVjLCAweDVhLCAweDAwLCAweDk1NGYpOyAvKiB3cml0ZSBn
cGlvMyB0byBoaWdoICovCiAJCWJyZWFrOwogCWNhc2UgSERBX0dFTl9QQ01fQUNUX0NMT1NFOgot
CQlhbGNfcHJvY2Vzc19jb2VmX2Z3KGNvZGVjLCBlbl9jb2Vmcyk7CiAJCWFsY193cml0ZV9jb2Vm
ZXhfaWR4KGNvZGVjLCAweDVhLCAweDAwLCAweDU1NGYpOyAvKiB3cml0ZSBncGlvMyBhcyBkZWZh
dWx0IHZhbHVlICovCiAJCWJyZWFrOwogCX0KQEAgLTM2OTIsMTAgKzM2ODEsMTUgQEAgc3RhdGlj
IHZvaWQgYWxjMjg3X2ZpeHVwX2xlbm92b190aGlua3BhZF93aXRoX2FsYzEzMTgoc3RydWN0IGhk
YV9jb2RlYyAqY29kZWMsCiAJCVdSSVRFX0NPRUYoMHgyNCwgMHgwMDEzKSwgV1JJVEVfQ09FRigw
eDI1LCAweDAwMDApLCBXUklURV9DT0VGKDB4MjYsIDB4QzMwMSksCiAJCVdSSVRFX0NPRUYoMHgy
OCwgMHgwMDAxKSwgV1JJVEVfQ09FRigweDI5LCAweGIwMjMpLAogCX07CisJc3RhdGljIGNvbnN0
IHN0cnVjdCBjb2VmX2Z3IGRpc19jb2Vmc1tdID0geworCQlXUklURV9DT0VGKDB4MjQsIDB4MDAx
MyksIFdSSVRFX0NPRUYoMHgyNSwgMHgwMDAwKSwgV1JJVEVfQ09FRigweDI2LCAweEMyMDMpLAor
CQlXUklURV9DT0VGKDB4MjgsIDB4MDAwNCksIFdSSVRFX0NPRUYoMHgyOSwgMHhiMDIzKSwKKwl9
OyAvKiBEaXNhYmxlIEFNUCBzaWxlbmNlIGRldGVjdGlvbiAqLwogCiAJaWYgKGFjdGlvbiAhPSBI
REFfRklYVVBfQUNUX1BSRV9QUk9CRSkKIAkJcmV0dXJuOwogCWFsY191cGRhdGVfY29lZl9pZHgo
Y29kZWMsIDB4MTAsIDE8PDExLCAxPDwxMSk7CisJYWxjX3Byb2Nlc3NfY29lZl9mdyhjb2RlYywg
ZGlzX2NvZWZzKTsKIAlhbGNfcHJvY2Vzc19jb2VmX2Z3KGNvZGVjLCBjb2Vmcyk7CiAJc3BlYy0+
cG93ZXJfaG9vayA9IGFsYzI4N19zNF9wb3dlcl9ncGlvM19kZWZhdWx0OwogCXNwZWMtPmdlbi5w
Y21fcGxheWJhY2tfaG9vayA9IGFsYzI4N19hbGMxMzE4X3BsYXliYWNrX3BjbV9ob29rOwo=

--_002_658f53ada52f4de9a0c852dd56554a2arealtekcom_--
