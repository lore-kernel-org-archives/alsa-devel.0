Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E191606A31B
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Nov 2026 00:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=XMchmBRm
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8BA936021F;
	Wed,  4 Nov 2026 01:41:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8BA936021F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793752897;
	bh=b56B7gOG5N9Tp/+2MJ1YpvVFtTjwnV1393S5Ab0SG0c=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=XMchmBRmPlZrO8eQNGOe63yIbM9nTc5AdbTWQC22ao5bZoqti3QSd3V91air9QCE7
	 p/ikGkJK0MA1AWVvy6IDSgmhoKMmGaJ4Rb31AEzJFiUlCfxmvQJXNeKAy0PMrTdoPt
	 2GDKwgGwf5xRHsJo68p020hDRFLSfSWx/V+0wKPw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8C1B3F805F0; Wed,  4 Nov 2026 01:41:14 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 614F7F805FA;
	Wed,  4 Nov 2026 01:41:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8DAC5F805AA; Wed,  4 Nov 2026 01:41:08 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793752867;
	b=KPVBix9lzuAbboSuNHAN0oe86M7lgdk+yxMYf7/JSauOJdWJxKd7Qki4NNmHqw6M53Ui
	 oOP6Nm5FPLz6kIYOjs0R4byB5cr3WN6sTGQRf2a8xB7FGClB8+3o1NI1uma82jy8BS/Js
	 c5pxPgdKm39VtOuQwqAuQVQKZme2jumzW4wKFjV4Zyxmwsgj2VqIVL0Hf+fmh2yqQjrNq
	 P2LGU8vVhbLnnLE//XyZyt9+Yp1pmRSAtdDPJ7IBt/m+js3wwSzho0oxXmAhgYQ8Rg+K/
	 U8ieVgcrnRHYKdGt9QhcaWx0MAq60ZafHkf5iz92cm1S2Of8RoE+431gPN5kF8Tp7WQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793752867;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=b56B7gOG5N9Tp/+2MJ1YpvVFtTjwnV1393S5Ab0SG0c=;
	b=kzqZuuxyWiqtTn98+1oZ1MyduICh58Jk+ipvEityOqOo/+qF3ycCRv0bxPgcyDxa37gd
	 OZA5FkffpqqtkHenQ9JQjyzGWNDc9etUHv9az615Qtc/zMln+z5fIuhgUJdKBH/T/uAc1
	 lhEXEJAud3ZUCWOSecVdeBOlHwb9p1k3zXWGD6rC6BEaZjtDMQqBUCaK6tYhlv5wbP9Ts
	 pt4WPmm/xjA67P6O8lOEiIWZyczWwsK0g35ZxKa0Yi2MnuTvU3vV8vPQwolAoHtmrfwh7
	 IvVRgVmMl4MCucNji0kNXb03pru98X30KtyfCOUecG47CqDjxcrz3C3zkJYjO4CjYgw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C59DF800E4
	for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2026 01:41:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9C59DF800E4
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18e4b0ba60cf1a00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/903@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/903@alsa-project.org>
Subject: ucm2: USB-Audio: Add Yamaha ZG02 profile (0499:1516)
Date: Wed,  4 Nov 2026 01:41:08 +0100 (CET)
Message-ID-Hash: YLOKKAARZOXLGOMILB2KLSKRADBK5UO7
X-Message-ID-Hash: YLOKKAARZOXLGOMILB2KLSKRADBK5UO7
X-MailFrom: github@alsa-project.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YLOKKAARZOXLGOMILB2KLSKRADBK5UO7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgcHVsbCByZXF1ZXN0ICM5MDMgd2FzIG9wZW5lZCBm
cm9tIFozZGFuOgoKQWRkcyBhIFVDTSBwcm9maWxlIGZvciB0aGUgWWFtYWhhIFpHMDIgZ2FtZSBz
dHJlYW1pbmcgbWl4ZXIsIHNwbGl0dGluZyBpdHMKMTAtY2hhbm5lbCBwbGF5YmFjayBhbmQgNC1j
aGFubmVsIGNhcHR1cmUgc3RyZWFtcyBpbnRvIHRoZSBtaXhlcidzIGJ1c2VzOgoKfCBTdHJlYW0g
fCBDaGFubmVscyB8IERldmljZSB8IE5vdGVzIHwKfC0tLXwtLS18LS0tfC0tLXwKfCBQbGF5YmFj
ayB8IDDigJMxIHwgQ2hhdCB8IGZvbGxvd3MgdGhlIHZvaWNlIGNoYXQgbGV2ZWwga25vYiB8Cnwg
UGxheWJhY2sgfCAy4oCTOSB8IEdhbWUgfCA3LjEsIGZvbGxvd3MgdGhlIGdhbWUgc291bmQgbGV2
ZWwga25vYiB8CnwgQ2FwdHVyZSB8IDDigJMxIHwgU3RyZWFtaW5nIE1peCB8IGdhbWUgKyBjaGF0
ICsgbWljLCBmb3Igc3RyZWFtaW5nIHNvZnR3YXJlIHwKfCBDYXB0dXJlIHwgMuKAkzMgfCBNaWNy
b3Bob25lIHwgaGVhZHNldC9taWMgaW5wdXQgb25seSB8CgojIyMgSG93IHRoZSBtYXBwaW5nIHdh
cyB2ZXJpZmllZAoKLSAqKlBsYXliYWNrOioqIHNlbnQgYXVkaW8gdG8gZWFjaCBjaGFubmVsIHBh
aXIgaW4gdHVybiBhbmQgdHVybmVkIGVhY2gga25vYgogIG9uIHRoZSBtaXhlciBkb3duIHRvIHNl
ZSB3aGljaCBwYWlycyBpdCBjb250cm9scy4KLSAqKkNhcHR1cmU6KiogcHJlc3NlZCB0aGUgbWl4
ZXIncyBtaWMgbXV0ZSAoY2FwdHVyZSAy4oCTMyBnbyBkaWdpdGFsbHkgc2lsZW50KQogIHdoaWxl
IHBsYXlpbmcgYXVkaW8gdG8gR2FtZSBhbmQgQ2hhdCAoYm90aCBzaG93IHVwIG9uIGNhcHR1cmUg
MOKAkzEpLgotIFRoZSBwcm9maWxlIHBhcnNlcyB3aXRoIGBhbHNhdWNtIGR1bXBgIGFnYWluc3Qg
dGhlIGRldmljZS4gSXQgaGFzICoqbm90KioKICBiZWVuIHRlc3RlZCBlbmQgdG8gZW5kIGluIFBp
cGVXaXJlIHlldC4KCiMjIyBLZXJuZWwgZGVwZW5kZW5jeQoKVGhlIFpHMDIgbmVlZHMgYSBrZXJu
ZWwgcXVpcmsgdG8gZXhwb3NlIGl0cyBQQ00gc3RyZWFtcyBhdCBhbGw6ICJBTFNBOgp1c2ItYXVk
aW86IEFkZCBxdWlyayBmb3IgWWFtYWhhIFpHMDIiLCBzZW50IHRvIGxpbnV4LXNvdW5kLiBMaW5r
OgpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjExMDQteWFtYWhhLXpnMDItdjEtMS0z
ZmQ2MWI4YzU2NGZAZ21haWwuY29tLwoK8J+kliBHZW5lcmF0ZWQgd2l0aCBbQ2xhdWRlIENvZGVd
KGh0dHBzOi8vY2xhdWRlLmNvbS9jbGF1ZGUtY29kZSkKClJlcXVlc3QgVVJMICAgOiBodHRwczov
L2dpdGh1Yi5jb20vYWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYvcHVsbC85MDMKUGF0Y2ggVVJM
ICAgICA6IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS11Y20tY29uZi9wdWxs
LzkwMy5wYXRjaApSZXBvc2l0b3J5IFVSTDogaHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJvamVj
dC9hbHNhLXVjbS1jb25mCg==
