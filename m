Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC53ECCF9E3
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Nov 2025 14:46:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ED7E560288;
	Mon, 10 Nov 2025 15:46:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ED7E560288
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1762785987;
	bh=Rz6YWE7fBi49tvybRC4BXcciVfBmIgWSm3ITZR89n20=;
	h=Date:To:From:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=XN+JjNMRTJWXSJRu5f9D0Va8fh9f853z6BkwsY8yBR0Vd42uzo5CvHNcZAc1EiXf2
	 ginIga+3MY6EnDKDMiwwkhX77BKiJwmR7rjTuzQRejemJ5JpsrVonDvUYFVkJmGiMv
	 xCkmMLQdtJ4I0Px2Ho8dqGozLrCbEScQkxpntJy4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BBA88F896EC; Mon, 10 Nov 2025 15:41:22 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E7787F896CC;
	Mon, 10 Nov 2025 15:41:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 03B41F80301; Sun, 14 Sep 2025 14:12:37 +0200 (CEST)
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch
 [109.224.244.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0AA06F8013D
	for <alsa-devel@alsa-project.org>; Sun, 14 Sep 2025 14:12:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0AA06F8013D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=oX+LH0sT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1757851950; x=1758111150;
	bh=Rz6YWE7fBi49tvybRC4BXcciVfBmIgWSm3ITZR89n20=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=oX+LH0sTLrZRpWFMpKac+S8Q125sJFcxDzYUBeISnua6L14sFDSb0FQzViEbcebXl
	 +HJUfSuz2yiVmTA9ypwtQ+10KOw5PxiQVxC172TjOxQc1/azg8DChn7j1IYTs1+5Sj
	 SLM4B9+qCIjC/MGdLtaa8wjM9TZdcRKAD7ayzfUdP1Qydgo+GM5F1AcXx8ie4C1ZoX
	 o0d1Tz3YJ6i2sesbtesNvPHjTNM89vn0OBbUBi7AH40948VRpgb6Hp6Mfy+8s5PQ2h
	 Vk70l7K5qAqjyjzcdQnFAyw2ClyUEJ4GYOH+EiPmBIfWf58VumS8fBGGY8D1/oTZ6N
	 9660XPIkFdAbQ==
Date: Sun, 14 Sep 2025 12:12:26 +0000
To: alsa-devel@alsa-project.org
From: Nicholas Kreimeyer <keridos@protonmail.com>
Subject: Bug with USB Audio sound card (alsa-info provided)
Message-ID: <d62ff80e-3bae-4eb7-8257-ed41a9fbe091@protonmail.com>
Feedback-ID: 7702641:user:proton
X-Pm-Message-ID: 6013769f79c08373036905c79d5a679d96004cd9
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha256;
 boundary="------251906c27b9ca126e253564e30f13484bd27bcbe572f57f3e27c7db3daab20c7";
 charset=utf-8
X-MailFrom: keridos@protonmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 7MXXKH5WN4L7RUSTVX5RHDCZWSCGMRMJ
X-Message-ID-Hash: 7MXXKH5WN4L7RUSTVX5RHDCZWSCGMRMJ
X-Mailman-Approved-At: Mon, 10 Nov 2025 14:39:56 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7MXXKH5WN4L7RUSTVX5RHDCZWSCGMRMJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------251906c27b9ca126e253564e30f13484bd27bcbe572f57f3e27c7db3daab20c7
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-ID: <d62ff80e-3bae-4eb7-8257-ed41a9fbe091@protonmail.com>
Date: Sun, 14 Sep 2025 14:12:23 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Content-Language: de-DE, en-US
To: alsa-devel@alsa-project.org
From: Nicholas Kreimeyer <keridos@protonmail.com>
Subject: Bug with USB Audio sound card (alsa-info provided)
Autocrypt: addr=nico@familie-kreimeyer.de; keydata=
 xjMEaC0cChYJKwYBBAHaRw8BAQdAnoOgRQ9mWtETjHXKxS+QVRANOZw4xY7gi3ChwOruGG3N
 Lk5pY2hvbGFzIEtyZWltZXllciA8bmljb0BmYW1pbGllLWtyZWltZXllci5kZT7CmQQTFgoA
 QRYhBGL/6f+aNms1ErRHq3XsSf/CV11hBQJoLRwKAhsDBQkFpXQWBQsJCAcCAiICBhUKCQgL
 AgQWAgMBAh4HAheAAAoJEHXsSf/CV11h1twBAKYFCdxAMF38Jd/Q1jWfnGhHp4h0KRq1nbzE
 EJ6YXv+zAQDfhaXQ0REmdpUYu2Ht30S8fImlWzNNJ+AvKcyPUJAbBc44BGgtHAoSCisGAQQB
 l1UBBQEBB0CtSSIahyesriGqqaK1ndJkol1+lXLxyKkfkJaHW34NbQMBCAfCfgQYFgoAJhYh
 BGL/6f+aNms1ErRHq3XsSf/CV11hBQJoLRwKAhsMBQkFpXQWAAoJEHXsSf/CV11hZGsA/RVm
 DUS2XEQmmYLZRSeLBkTOidLotyS+SCqpCsqkFitsAQCtLGv7srm+2UCJGRzJ+MROAi882Le2
 BJ/EdQ55RtD+Dg==

SGVsbG8gZGVhciBBbHNhIGRldnMsDQoNCkkgaGF2ZSBhbiBBcnlsaWMgQjUwIFNFIFVTQiAoYW5k
IEJUKSBBdWRpbyBpbnRlcmZhY2UgZm9yIGRyaXZpbmcgbXkgDQpzcGVha2Vycy4NCkl0IHdvcmtz
IGZpbmUgZXhjZXB0IHRoYXQgdGhlIHZvbHVtZSBjb250cm9sIHNlZW1zIHRvIGJlIGJ1Z2dlZC4N
CldpdGggYWxzYW1peGVyIEkgY2FuIHNldCB0aGUgdm9sdW1lIG9mIHRoZSBkZXZpY2UgZnJvbSAw
LTEwMCBidXQgdGhlIA0KbWFzdGVyIGxldmVsICh3aGVuIGl0cyBtYWluIGRldmljZSkgb25seSBj
aGFuZ2VzIGZyb20gNTAtMTAwLiBBbGwgdmFsdWVzIA0KYmVsb3cgNTAgYXJlIGNvbXBsZXRlbHkg
c2lsZW50Lg0KDQpJIGhhdmUgcHJvdmlkZWQgYWxzYS1pbmZvIGFib3V0IG15IHN5c3RlbSBoZXJl
OiANCmh0dHBzOi8vYWxzYS1wcm9qZWN0Lm9yZy9kYi8/Zj1kZjBiNGU4ODEwM2UzMmRlNWJlOTQ3
NDE5ZTczNGJhMmNlNTVhZjFiDQpUaGUgVVNCIHNvdW5kIGNhcmQgaXMgSUQgMyAiQXJ5bGljIFVw
MlN0cmVhbSBVU0IgQXVkaW8gYXQgDQp1c2ItMDAwMDoxMDowMC4wLTYsIGZ1bGwgc3BlZWQiDQoN
CkRtZXNnIG91dHB1dCB3aGVuIGNvbm5lY3RpbmcgdGhlIGRldmljZToNClvCoCA2ODkuNzU4NDA2
XSB1c2IgMS02OiBuZXcgZnVsbC1zcGVlZCBVU0IgZGV2aWNlIG51bWJlciAxNiB1c2luZyB4aGNp
X2hjZA0KW8KgIDY5MC4wMjgzMTJdIHVzYiAxLTY6IG5vdCBydW5uaW5nIGF0IHRvcCBzcGVlZDsg
Y29ubmVjdCB0byBhIGhpZ2ggDQpzcGVlZCBodWINClvCoCA2OTAuMDQ4Mjg3XSB1c2IgMS02OiBO
ZXcgVVNCIGRldmljZSBmb3VuZCwgaWRWZW5kb3I9ODg4OCwgDQppZFByb2R1Y3Q9MTcxNywgYmNk
RGV2aWNlPSAxLjAwDQpbwqAgNjkwLjA0ODI5MF0gdXNiIDEtNjogTmV3IFVTQiBkZXZpY2Ugc3Ry
aW5nczogTWZyPTEsIFByb2R1Y3Q9MiwgDQpTZXJpYWxOdW1iZXI9Mw0KW8KgIDY5MC4wNDgyOTJd
IHVzYiAxLTY6IFByb2R1Y3Q6IFVwMlN0cmVhbSBVU0IgQXVkaW8NClvCoCA2OTAuMDQ4MjkzXSB1
c2IgMS02OiBNYW51ZmFjdHVyZXI6IEFyeWxpYw0KW8KgIDY5MC4wNDgyOTRdIHVzYiAxLTY6IFNl
cmlhbE51bWJlcjogMjAxOTA4MDgNClvCoCA2OTAuMTMyMDE0XSB1c2IgMS02OiBXYXJuaW5nISBV
bmxpa2VseSBiaWcgdm9sdW1lIHJhbmdlICg9NDA5NiksIA0KY3ZhbC0+cmVzIGlzIHByb2JhYmx5
IHdyb25nLg0KW8KgIDY5MC4xMzIwMThdIHVzYiAxLTY6IFsyXSBGVSBbUENNIFBsYXliYWNrIFZv
bHVtZV0gY2ggPSAyLCB2YWwgPSAwLzQwOTYvMQ0KW8KgIDY5MC4xNDEyMTBdIGlucHV0OiBBcnls
aWMgVXAyU3RyZWFtIFVTQiBBdWRpbyBhcyANCi9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDow
Mi4xLzAwMDA6MDU6MDAuMC8wMDAwOjA2OjA4LjAvMDAwMDowODowMC4wLzAwMDA6MDk6MGMuMC8w
MDAwOjEwOjAwLjAvdXNiMS8xLTYvMS02OjEuMi8wMDAzOjg4ODg6MTcxNy4wMDEzL2lucHV0L2lu
cHV0MzMNClvCoCA2OTAuMTkxNDU5XSBoaWQtZ2VuZXJpYyAwMDAzOjg4ODg6MTcxNy4wMDEzOiBp
bnB1dCxoaWRyYXcxMzogVVNCIEhJRCANCnYyLjAxIERldmljZSBbQXJ5bGljIFVwMlN0cmVhbSBV
U0IgQXVkaW9dIG9uIHVzYi0wMDAwOjEwOjAwLjAtNi9pbnB1dDINClvCoCA2OTAuMTkxNjE1XSB1
c2JoaWQgMS02OjEuMzogY291bGRuJ3QgZmluZCBhbiBpbnB1dCBpbnRlcnJ1cHQgZW5kcG9pbnQN
Cg0KDQoNCklmIHBvc3NpYmxlLCBjYW4gdGhhdCBidWcgd2l0aCB0aGUgdm9sdW1lIGNvbnRyb2xz
IGJlIGZpeGVkPw0KSWYgaXQgaXMgYSByYXRoZXIgZWFzeSBmaXggSSBjYW4gcHJvYmFibHkgY29k
ZSBpdCBteXNlbGYgaWYgZ2l2ZW4gYSBmZXcgDQpwb2ludGVycyBvZiB3aGVyZSB0byBzdGFydC4N
Cg0KSWYgeW91IG5lZWQgYWRkaXRpb25hbCBpbmZvIGZyb20gbWUsIHBsZWFzZSBkb24ndCBoZXNp
dGF0ZSB0byBhc2suDQoNCg0KVGhhbmsgeW91IGZvciB5b3VyIHdvcmsgb24gQUxTQSBhbmQgd2l0
aCByZWdhcmRzDQpOaWNvIEtyZWltZXllcg0KDQo=
--------251906c27b9ca126e253564e30f13484bd27bcbe572f57f3e27c7db3daab20c7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0FgmjGsSoJkLy4miqiKRiMNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmf8G2XHi4wd7LOOMBC0WNgnFiEEm4FWHH1fts5x
o3HDvLiaKqIpGIwAAG3kAQDpFbCz79xgDRtnnCziB9M2xva/dc4E6G62atJK
SoD2agEAtMICbZ7MWs2uI4JisQR1M2afVIUqiOtduG7leYaV+gk=
=Om5P
-----END PGP SIGNATURE-----


--------251906c27b9ca126e253564e30f13484bd27bcbe572f57f3e27c7db3daab20c7--

