Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7319DEDB7CC
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Apr 2026 09:09:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A06506020E;
	Tue,  7 Apr 2026 11:09:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A06506020E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775552990;
	bh=iuC+PcmBu/ZnaYob7LHOQ8gLXFFxsEIW7J3w3ajRbgk=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=lr64jV6RiEhBQdHSKXUGVygoU6E6LvEc5Hv3wrl3QFp5MROIbC1Gr7MS4xoxFwnNR
	 WrtEA892Nd5LPNkBEOy46MD8aRWkIC1kBUH8Ewi4v/ncXI+//+T4dIix60xSM3f3i2
	 mKR8OnDRBOFeAy8ZGaTUU5CC+hW3hpFICmlAU/P8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 55B65F805FA; Tue,  7 Apr 2026 11:09:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9AFF1F805F7;
	Tue,  7 Apr 2026 11:09:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E484BF8059F; Sat,  4 Apr 2026 08:42:15 +0200 (CEST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AFBEFF80424
	for <alsa-devel@alsa-project.org>; Sat,  4 Apr 2026 08:42:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AFBEFF80424
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=TDvCjzWq
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-66bf6aa4858so4505465a12.2
        for <alsa-devel@alsa-project.org>;
 Fri, 03 Apr 2026 23:42:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775284931; cv=none;
        d=google.com; s=arc-20240605;
        b=gucjRkN2oyqpnfYDT5sT7XeVLBIiBpRIR2TlnKPhXWuKM2blPgZ9RizwF+L05ppIVQ
         TSSx5SWQ2hyIqZkhMtKrC4hA7ehL7UXiDYq4PLKuz/ZJbskvqy5lWjAYqEHPb6rfjrIv
         NR10rAQ6OXFIzRzoaf3Zm7yvY7qT5sam/FG1AruJv9NbDaRmv7aGI+CvIPL37ZfrPNrZ
         JrZmST+SJkoEzYWnh0K5SiZxqK+n1j+XENEyHCCpdMls6IMXSkIrpHHcjmH2IGvG8oek
         VHk5BMwnL8QpcvBOxgnf3OrXY5dhPwxy890P9SpGBtpfcNoZTPC2LJdsJIuehgWN3UPJ
         R5RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=aqEdIUz/QddnXo6a9VNk8mV9vCvbUdn2v8/ZP9BqNz0=;
        fh=oRoccz0oVvJhemgmWN+IP2Bi1QJUdh52KSJ0uqPpbZw=;
        b=RTDu7JRHxv/UJclp8EM7fWqAnUsq3YSqjHrGh1zvnO/0Z20qA1PKkmBNJHUVSGcyyP
         ugGQc5COvn2ucQ7rJ8QPqxPxFOG8CIMxa4n7ROrhGxT46iIY4RF/DJ6YC9WXVIjakBsy
         zE+r7Wf+Tpq80LzZs5bDwLn/CwU5E116mge0RoQIe3jgi8kvsPQCYWkZXl/ZE5A1lQ35
         c7eSi39pA1NhQZtUCbu1LbnnSWehYBMxVhNoSRCam6be0z/Blr4A/88Qi+5hKdBBAgny
         uGfqU3viavpPEtRKVvY1mebTvO31lINw3Ic6vss6XvmzQjI1Lu8Q3nHjQIlPW8bCfjYe
         5eOg==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775284931; x=1775889731;
 darn=alsa-project.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aqEdIUz/QddnXo6a9VNk8mV9vCvbUdn2v8/ZP9BqNz0=;
        b=TDvCjzWqAbBfxDAcpfBlCWwnUHxRZIX4LDx8+77nqJGU6IB+ZuLtLpufUKei6w6fjz
         22Mofi8f7O4Hn96pquqmJXgXcU+jjYTK4t2c9iq865mz+2ehzq+PZZQyTqBfjVNjgIUT
         eceEK5wMMGvyxzVVWAPyBMyCNN4/jJG9ow5HrTfdaSimkc8VdJVBn59y3A1KrYPyhJgY
         8aIfZWrsEK3mbQYltPwfRd0BVmEvnHrdgfi4tHa5zd/lXMyN+y+mz0F0ELiRMeSLh3P0
         C6z2lw7Up3aY2UMs8ZUDiQLdw0N7Ne9TxzxZv5OOg8KPN+3fD1kty+1v3n6crX5OfXF1
         7uMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775284931; x=1775889731;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aqEdIUz/QddnXo6a9VNk8mV9vCvbUdn2v8/ZP9BqNz0=;
        b=qV3x5WbDgJM6H8NGCknUMIQqGP2j+aGzcHkBLg6u/5Qbrq9FivDJJMVCpY98cSFtR8
         RGcWTQafpiEtJmTJEBYGfzTwptPrv1ECCqGZ7EVhUHPjiEtYlK5e4MZSzbxOBe5UvKx1
         OMy/hkot8ElPAxDZIe+SaYEy+J22K5AaomVKP21r8K6VdABlUdT+SLla0rbkl57KhGP2
         gfV8BprM+mTmq3Mg08XWb7MkbZ65t4/0sM+N/6AoJU/PXRupDf80v0zcn3q5zmmk+IhD
         Pz0w6+Euu7SVl7ydzFl04nkSlAFlrOrFi+T8/Px1mQhP8stW0pLH54uQMjJsQyRB1I3M
         Cw7Q==
X-Gm-Message-State: AOJu0Yzga+YV7aL19FBwcNKtaAIBO9gLVrdspGjURLKQF6NJIDk89b4H
	O4AuyP6mHn2FKIepliwnDfT33XbNPJgPJdBXP+YA7jzA/T/QTzBdvx3WlgnppgAt3+yICgv9xF3
	NbiKAMNwihhlAJaRZ1rZDywcxPzCCrJo=
X-Gm-Gg: AeBDietA7i+zxz9DVCdwrZJVtmVdXpMQBKyBH64PV40mgmnzmLoJTWDi9T0Kc2wabMw
	oy++uNZLSgOd/Ayr3IJCCbkHYbXDUBlDD4YUzxflqaIkNEYMnD2DsPh/o2nldGUvsw7lCj3bU33
	yJ2zBnvUKENQetkQAcr1jupOKWkxrvUXdgA0L/jcZ2+nLV99eN3TNnB973Pcvzs8w50eL9WrOH2
	y7quhs8L0cGiz74m+tM6DmDE5AYdRus2QSqbPOM3JG5274gB0UZjW6jLVPJJjMD/PZX3PdElyrq
	00SFSBPsK96fxzvI9A==
X-Received: by 2002:a17:907:894f:b0:b98:5648:e68a with SMTP id
 a640c23a62f3a-b9c679b35d8mr280294866b.36.1775284930480; Fri, 03 Apr 2026
 23:42:10 -0700 (PDT)
MIME-Version: 1.0
From: wbw <wbw2494@gmail.com>
Date: Sat, 4 Apr 2026 15:41:59 +0900
X-Gm-Features: AQROBzDsu8nu0JuB3zzFrZjoxttkvizm26lE3uBgrTQWqxNvv1QnhsxYZA-sbK8
Message-ID: 
 <CAM6MnuXW4n=xGxMjPfm8BGCKQOwVps_-Ky6fHNb4SwdCdS3gtQ@mail.gmail.com>
Subject: [BUG] ALC274 codec apparently suspends itself, causing lags
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org
X-MailFrom: wbw2494@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: G5L6PUH2IEL5H4GP4XDCSKAOJIVLCAYY
X-Message-ID-Hash: G5L6PUH2IEL5H4GP4XDCSKAOJIVLCAYY
X-Mailman-Approved-At: Tue, 07 Apr 2026 09:09:19 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/G5L6PUH2IEL5H4GP4XDCSKAOJIVLCAYY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGksDQpJIGVuY291bnRlcmVkIHByb2JsZW1zIHdpdGggUmVhbHRlayBjb2RlY3MuDQoNCkhhcmR3
YXJlOg0KTUVDSFJFVk8gKGFrYS4gVE9OR0ZBTkcpIENBTkdMT05HIFNlcmllcy1YNnhSNTV4WQ0K
DQpLZXJuZWw6DQo2LjE4LjkrZGViMTMtYW1kNjQgKGRlYmlhbiAxMyAndHJpeGllJykNCg0KUHJv
YmxlbToNClRoZSBzcGVha2VyIHdvcmtzLCBidXQgaGFzIGxhZ3MuIFRoZSBmaXJzdCBvbmUgc2Vj
b25kIG9mIGFuIGF1ZGlvIGlzDQpzaWxlbmNlZC4NCg0KU3RlcHMgdG8gcmVwcm9kdWNlOg0KLSBi
b290IHRoZSBtYWNoaW5lLg0KLSBwbGF5IHNvbWUgYXVkaW8gKHdpdGggYXBsYXksbXB2LGZpcmVm
b3gsZXRjLikNCi0gcGF1c2UgZm9yIGFib3V0IDMgc2Vjb25kcyBhbmQgcmVzdW1lIChvciBpZiBh
dWRpbyBjb250YWlucyBzaWxlbmNlIG9mDQpzaW1pbGFyIGxlbmd0aCkNCg0KRXhwZWN0ZWQgYmVo
YXZpb3VyOg0KQXVkaW8gcGxheXMgbm9ybWFsbHkuDQoNCkFjdHVhbCBiZWhhdmlvdXI6DQpBdWRp
byBpcyBsYWdnZWQuIEFib3V0IG9uZSBzZWNvbmQgb2YgYXVkaW8gYWZ0ZXIgcmVzdW1pbmcgaXMg
c2lsZW5jZWQuDQooRm9yIGV4YW1wbGUsICJIZWxsbywgSG93IGFyZSB5b3U/IChzaWxlbmNlKSBJ
J20gZmluZS4iDQp3b3VsZCBwbGF5IGFzICJIZWxsbywgSG93IGFyZSB5b3U/IChzaWxlbmNlKSBm
aW5lLiIsIGRyb3BwaW5nIHRoZSAiSSdtIikNCg0KDQpkbWVzZzoNClsgICAgMS44ODUzMDhdIHNu
ZF9oZGFfY29kZWNfYWxjMjY5IGhkYXVkaW9DMkQwOiBBTEMyNzQ6IHBpY2tlZCBmaXh1cCAgZm9y
DQpQQ0kgU1NJRCAxZDA1OjMwMTkNClsgICAgMS44ODYwMTZdIHNuZF9oZGFfY29kZWNfYWxjMjY5
IGhkYXVkaW9DMkQwOiBhdXRvY29uZmlnIGZvciBBTEMyNzQ6DQpsaW5lX291dHM9MSAoMHgxNy8w
eDAvMHgwLzB4MC8weDApIHR5cGU6c3BlYWtlcg0KWyAgICAxLjg4NjAzMF0gc25kX2hkYV9jb2Rl
Y19hbGMyNjkgaGRhdWRpb0MyRDA6ICAgIHNwZWFrZXJfb3V0cz0wDQooMHgwLzB4MC8weDAvMHgw
LzB4MCkNClsgICAgMS44ODYwMzddIHNuZF9oZGFfY29kZWNfYWxjMjY5IGhkYXVkaW9DMkQwOiAg
ICBocF9vdXRzPTENCigweDIxLzB4MC8weDAvMHgwLzB4MCkNClsgICAgMS44ODYwNDVdIHNuZF9o
ZGFfY29kZWNfYWxjMjY5IGhkYXVkaW9DMkQwOiAgICBtb25vOiBtb25vX291dD0weDANClsgICAg
MS44ODYwNTFdIHNuZF9oZGFfY29kZWNfYWxjMjY5IGhkYXVkaW9DMkQwOiAgICBpbnB1dHM6DQpb
ICAgIDEuODg2MDU3XSBzbmRfaGRhX2NvZGVjX2FsYzI2OSBoZGF1ZGlvQzJEMDogICAgICBJbnRl
cm5hbCBNaWM9MHgxMg0KWyAgICAxLjg4NjA2M10gc25kX2hkYV9jb2RlY19hbGMyNjkgaGRhdWRp
b0MyRDA6ICAgICAgSGVhZHNldCBNaWM9MHgxOQ0KDQpsc2h3IG91dHB1dDoNCiotbXVsdGltZWRp
YToyDQogICAgICAgICAgICAgICAgZGVzY3JpcHRpb246IEF1ZGlvIGRldmljZQ0KICAgICAgICAg
ICAgICAgIHByb2R1Y3Q6IEZhbWlseSAxN2gvMTloLzFhaCBIRCBBdWRpbyBDb250cm9sbGVyDQog
ICAgICAgICAgICAgICAgdmVuZG9yOiBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMuIFtBTURd
DQogICAgICAgICAgICAgICAgcGh5c2ljYWwgaWQ6IDAuNg0KICAgICAgICAgICAgICAgIGJ1cyBp
bmZvOiBwY2lAMDAwMDowNTowMC42DQogICAgICAgICAgICAgICAgbG9naWNhbCBuYW1lOiBjYXJk
Mg0KICAgICAgICAgICAgICAgIGxvZ2ljYWwgbmFtZTogL2Rldi9zbmQvY29udHJvbEMyDQogICAg
ICAgICAgICAgICAgbG9naWNhbCBuYW1lOiAvZGV2L3NuZC9od0MyRDANCiAgICAgICAgICAgICAg
ICBsb2dpY2FsIG5hbWU6IC9kZXYvc25kL3BjbUMyRDBjDQogICAgICAgICAgICAgICAgbG9naWNh
bCBuYW1lOiAvZGV2L3NuZC9wY21DMkQwcA0KICAgICAgICAgICAgICAgIHZlcnNpb246IDAwDQog
ICAgICAgICAgICAgICAgd2lkdGg6IDMyIGJpdHMNCiAgICAgICAgICAgICAgICBjbG9jazogMzNN
SHoNCiAgICAgICAgICAgICAgICBjYXBhYmlsaXRpZXM6IHBtIHBjaWV4cHJlc3MgbXNpIGJ1c19t
YXN0ZXIgY2FwX2xpc3QNCiAgICAgICAgICAgICAgICBjb25maWd1cmF0aW9uOiBkcml2ZXI9c25k
X2hkYV9pbnRlbCBsYXRlbmN5PTANCiAgICAgICAgICAgICAgICByZXNvdXJjZXM6IGlycTo5NSBt
ZW1vcnk6ZmM1YzAwMDAtZmM1YzdmZmYNCg0KbHNwY2kgLXZ2IG91dHB1dDoNCg0KMDU6MDAuNiBB
dWRpbyBkZXZpY2U6IEFkdmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4gW0FNRF0gRmFtaWx5IDE3
aC8xOWgvMWFoDQpIRCBBdWRpbyBDb250cm9sbGVyDQpEZXZpY2VOYW1lOiBSZWFsdGVrIEFMQzI0
NQ0KU3Vic3lzdGVtOiBBSXN0b25lIEdsb2JhbCBMaW1pdGVkIERldmljZSAzMDE5DQpDb250cm9s
OiBJL08tIE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJF
cnItDQpTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlzSU5UeCsNClN0YXR1czogQ2FwKyA2Nk1I
ei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNFTD1mYXN0ID5UQWJvcnQtIDxUQWJvcnQtDQo8
TUFib3J0LSA+U0VSUi0gPFBFUlItIElOVHgtDQpMYXRlbmN5OiAwLCBDYWNoZSBMaW5lIFNpemU6
IDY0IGJ5dGVzDQpJbnRlcnJ1cHQ6IHBpbiBDIHJvdXRlZCB0byBJUlEgOTUNCklPTU1VIGdyb3Vw
OiAyMw0KUmVnaW9uIDA6IE1lbW9yeSBhdCBmYzVjMDAwMCAoMzItYml0LCBub24tcHJlZmV0Y2hh
YmxlKSBbc2l6ZT0zMktdDQpDYXBhYmlsaXRpZXM6IFs0OF0gVmVuZG9yIFNwZWNpZmljIEluZm9y
bWF0aW9uOiBMZW49MDggPD8+DQpDYXBhYmlsaXRpZXM6IFs1MF0gUG93ZXIgTWFuYWdlbWVudCB2
ZXJzaW9uIDMNCkZsYWdzOiBQTUVDbGstIERTSS0gRDEtIEQyLSBBdXhDdXJyZW50PTBtQSBQTUUo
RDArLEQxLSxEMi0sRDNob3QrLEQzY29sZCspDQpTdGF0dXM6IEQzIE5vU29mdFJzdCsgUE1FLUVu
YWJsZSsgRFNlbD0wIERTY2FsZT0wIFBNRS0NCkNhcGFiaWxpdGllczogWzY0XSBFeHByZXNzICh2
MikgRW5kcG9pbnQsIEludE1zZ051bSAwDQpEZXZDYXA6IE1heFBheWxvYWQgMjU2IGJ5dGVzLCBQ
aGFudEZ1bmMgMCwgTGF0ZW5jeSBMMHMgPDR1cywgTDEgdW5saW1pdGVkDQpFeHRUYWcrIEF0dG5C
dG4tIEF0dG5JbmQtIFB3ckluZC0gUkJFKyBGTFJlc2V0LSBTbG90UG93ZXJMaW1pdCAwVyBURUUt
SU8tDQpEZXZDdGw6IENvcnJFcnItIE5vbkZhdGFsRXJyLSBGYXRhbEVyci0gVW5zdXBSZXEtDQpS
bHhkT3JkKyBFeHRUYWcrIFBoYW50RnVuYy0gQXV4UHdyLSBOb1Nub29wKw0KTWF4UGF5bG9hZCAy
NTYgYnl0ZXMsIE1heFJlYWRSZXEgNTEyIGJ5dGVzDQpEZXZTdGE6IENvcnJFcnItIE5vbkZhdGFs
RXJyLSBGYXRhbEVyci0gVW5zdXBSZXEtIEF1eFB3ci0gVHJhbnNQZW5kLQ0KTG5rQ2FwOiBQb3J0
ICMwLCBTcGVlZCAxNkdUL3MsIFdpZHRoIHgxNiwgQVNQTSBMMHMgTDEsIEV4aXQgTGF0ZW5jeSBM
MHMNCjw2NG5zLCBMMSA8MXVzDQpDbG9ja1BNLSBTdXJwcmlzZS0gTExBY3RSZXAtIEJ3Tm90LSBB
U1BNT3B0Q29tcCsNCkxua0N0bDogQVNQTSBEaXNhYmxlZDsgUkNCIDY0IGJ5dGVzLCBMbmtEaXNh
YmxlLSBDb21tQ2xrKw0KRXh0U3luY2gtIENsb2NrUE0tIEF1dFdpZERpcy0gQldJbnQtIEF1dEJX
SW50LQ0KTG5rU3RhOiBTcGVlZCAxNkdUL3MsIFdpZHRoIHgxNg0KVHJFcnItIFRyYWluLSBTbG90
Q2xrKyBETEFjdGl2ZS0gQldNZ210LSBBQldNZ210LQ0KRGV2Q2FwMjogQ29tcGxldGlvbiBUaW1l
b3V0OiBSYW5nZSBBQkNELCBUaW1lb3V0RGlzKyBOUk9QclByUC0gTFRSLQ0KMTBCaXRUYWdDb21w
KyAxMEJpdFRhZ1JlcS0gT0JGRiBOb3QgU3VwcG9ydGVkLCBFeHRGbXQrIEVFVExQUHJlZml4KywN
Ck1heEVFVExQUHJlZml4ZXMgMQ0KRW1lcmdlbmN5UG93ZXJSZWR1Y3Rpb24gTm90IFN1cHBvcnRl
ZCwgRW1lcmdlbmN5UG93ZXJSZWR1Y3Rpb25Jbml0LQ0KRlJTLSBUUEhDb21wLSBFeHRUUEhDb21w
LQ0KQXRvbWljT3BzQ2FwOiAzMmJpdC0gNjRiaXQtIDEyOGJpdENBUy0NCkRldkN0bDI6IENvbXBs
ZXRpb24gVGltZW91dDogNTB1cyB0byA1MG1zLCBUaW1lb3V0RGlzLQ0KQXRvbWljT3BzQ3RsOiBS
ZXFFbi0NCklET1JlcS0gSURPQ29tcGwtIExUUi0gRW1lcmdlbmN5UG93ZXJSZWR1Y3Rpb25SZXEt
DQoxMEJpdFRhZ1JlcS0gT0JGRiBEaXNhYmxlZCwgRUVUTFBQcmVmaXhCbGstDQpMbmtTdGEyOiBD
dXJyZW50IERlLWVtcGhhc2lzIExldmVsOiAtMy41ZEIsIEVxdWFsaXphdGlvbkNvbXBsZXRlLQ0K
RXF1YWxpemF0aW9uUGhhc2UxLQ0KRXF1YWxpemF0aW9uUGhhc2UyLSBFcXVhbGl6YXRpb25QaGFz
ZTMtIExpbmtFcXVhbGl6YXRpb25SZXF1ZXN0LQ0KUmV0aW1lci0gMlJldGltZXJzLSBDcm9zc2xp
bmtSZXM6IHVuc3VwcG9ydGVkDQpDYXBhYmlsaXRpZXM6IFthMF0gTVNJOiBFbmFibGUrIENvdW50
PTEvMSBNYXNrYWJsZS0gNjRiaXQrDQpBZGRyZXNzOiAwMDAwMDAwMGZlZTAwMDAwICBEYXRhOiAw
MDAwDQpDYXBhYmlsaXRpZXM6IFsxMDAgdjFdIFZlbmRvciBTcGVjaWZpYyBJbmZvcm1hdGlvbjog
SUQ9MDAwMSBSZXY9MSBMZW49MDEwDQo8Pz4NCkNhcGFiaWxpdGllczogWzJhMCB2MV0gQWNjZXNz
IENvbnRyb2wgU2VydmljZXMNCkFDU0NhcDogU3JjVmFsaWQtIFRyYW5zQmxrLSBSZXFSZWRpci0g
Q21wbHRSZWRpci0gVXBzdHJlYW1Gd2QtIEVncmVzc0N0cmwtDQpEaXJlY3RUcmFucy0NCkFDU0N0
bDogU3JjVmFsaWQtIFRyYW5zQmxrLSBSZXFSZWRpci0gQ21wbHRSZWRpci0gVXBzdHJlYW1Gd2Qt
IEVncmVzc0N0cmwtDQpEaXJlY3RUcmFucy0NCktlcm5lbCBkcml2ZXIgaW4gdXNlOiBzbmRfaGRh
X2ludGVsDQpLZXJuZWwgbW9kdWxlczogc25kX2hkYV9pbnRlbA0KDQphdHRlbXB0ZWQgZml4ZXMg
KGRvZXNuJ3Qgc2VlbSB0byB3b3JrKToNCnR3ZWFraW5nIHBpcGV3aXJlLCBzdWNoIGFzIHNlc3Np
b24uc3VzcGVuZC10aW1lb3V0LXNlY29uZHMNCnNldHRpbmcgc25kX2hkYV9pbnRlbCBwb3dlcl9z
YXZlPTAgb3IgcG93ZXJfc2F2ZV9jb250cm9sbGVyPU4NCnR3ZWFraW5nIHN5c2ZzIHN1Y2ggYXMN
Ci9zeXMvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MDguMS8wMDAwOjA1OjAwLjYvcG93ZXIv
DQoNCldvcmtpbmcgd29ya2Fyb3VuZDoNCmBmZnBsYXkgLWxvZ2xldmVsIDE2IC1ub2Rpc3AgLXZv
bHVtZSAxMCAtbG9vcCAtMQ0KL3Vzci9zaGFyZS9zb3VuZHMvYWxzYS9Ob2lzZS53YXZgDQpUaGlz
IHdvcmtzIGJ5IHBsYXlpbmcgYSBuZWFyLXNpbGVudCBub2lzZSBpbiBiYWNrZ3JvdW5kLg0KDQpI
b3dldmVyLCBJIGRvIG5vdGljZSBzZXR0aW5nIHNuZF9oZGFfaW50ZWwgcG93ZXJfc2F2ZT0xIGZp
eGVzIHRoZSBpc3N1ZQ0Kd2l0aCBvbmUtb2ZmIGF1ZGlvIHBsYXlpbmcgKHN1Y2ggYXMgYGFwbGF5
DQovdXNyL3NoYXJlL3NvdW5kcy9hbHNhL0Zyb250X0NlbnRlci53YXZgKQ0KDQpJdCBzZWVtcyB0
aGUgZGV2aWNlIHN1c3BlbmRzIGl0c2VsZiBpbiBhYm91dCAxLjUgc2VjIG9mIG5vIHNvdW5kIHBs
YXllZA0KKGV2ZW4gaWYgdGhlIG91dHB1dCBzdHJlYW0gc2hvdWxkIHN0aWxsIGJlIG9wZW4pLCBh
bmQgdGhlIGRyaXZlciBkb2VzIG5vdA0KY29ycmVjdGx5IHJlZ2lzdGVyIHRoZSBhdXRvLXN1c3Bl
bmQuDQoNCkZvciBvbmUtb2ZmIGF1ZGlvIHRoZSBzdXNwZW5kIGlzIGVuZm9yY2VkIGJ5IHNvZnR3
YXJlIChzbmRfaGRhX2ludGVsDQpwb3dlcl9zYXZlKSwgYnV0IGZvciBjb250aW51b3VzIGF1ZGlv
IChzdWNoIGFzIHlvdXR1YmUpLCB0aGUgZHJpdmVyIGRvZXMNCm5vdCBzdXNwZW5kIHRoZSBkZXZp
Y2UsIGNhdXNpbmcgdGhlIHByb2JsZW0gdG8gcGVyc2lzdC4gSG93ZXZlciwgVGhlIGRyaXZlcg0K
Y29ycmVjdGx5IHN1c3BlbmRzIGFmdGVyIGFib3V0IDcgc2Vjb25kcykNCg0Kc2V0dGluZyBzbmRf
aGRhX2ludGVsIHBvd2VyX3NhdmU9MCBtYWtlcyBpdCB3b3JzZSBiZWNhdXNlIHNvZnR3YXJlIGRv
ZXMgbm90DQpyZWdpc3RlciBzdXNwZW5kIGF0IGFsbC4NCg0KQWxzbywgb24gV2luZG93cyAoYm9v
dGVkIGZyb20gaW5zdGFsbGF0aW9uIG9uIGFuIGV4dGVybmFsIGRpc2spIHRoaXMgaXMNCmFsc28g
YSBwcm9ibGVtLCBidXQgY2FuIGJlIGZpeGVkIGJ5IGluc3RhbGxpbmcgYSBSZWFsdGVrIGRyaXZl
ci4NCg0KVGhhbmtzLg0K
