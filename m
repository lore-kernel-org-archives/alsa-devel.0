Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1F0C43458
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jul 2026 06:26:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BC51E601CE;
	Sun,  5 Jul 2026 08:25:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BC51E601CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783232763;
	bh=YuCAjO7qoGxoZqOoQEUxk3TvhLczYOLJ+qt/EYDKt90=;
	h=From:Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Wfclpl4+chOjEmfcfq7iaC6044msMYfjeTPwKnf2gdjs3zxiV0SoqSgugoAF55DOr
	 P/OA7sxczAe6p8FmuCrN456f4iFkrQNw+G1wCFwCBabL83bjWdQTjaniFlLyJItoYd
	 uqL4UC3IXcadTLwodQClTtgcBIpz2hxz4SMo1ftM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4BE5CF80588; Sun,  5 Jul 2026 08:25:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0EF5FF805F9;
	Sun,  5 Jul 2026 08:25:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 66B52F80526; Sun,  5 Jul 2026 08:25:22 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=95.217.203.20
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783232721;
	b=fzJofEfWwEOPKeem+CWcWedpMEcgUF3fYaTY+9bRMOymHp+7SF66AbNZz2E957Ro6KkC
	 FzmKCvD3qenzwfJC3ugD46pgoTOYPy316u/i7xsGgHckeNMZJeFehk+wJH0wdCOjU7zPg
	 jQw8izEXKIk3Q2R+0GRcm10hGgKKRjC5I7nCJVW29JsOxOYpiseI+udfuNKP4/yNXbdg2
	 DFHeW2OjmNzPg+Ye+QAUmd4hxVMmHvPt9sVSqnTf6xq2IWZ5kM0FJDyveGfTzTBkJ6JB2
	 ti1WEtieRV+x4+gPuLzIzR5BsREYT2xoyxV/dm2MLVIXjduq8K1YjZgtxzxUTWqplYw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783232721;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=/TIHg2fJXDJMSoygFdRfoQJwc1DM2u4XWJRDQvuEikk=;
	b=URJ/iNv8EvYgp2VUhQ/ad/W1ZbKowKFfozPP2mjbQamUKkfTIx4epW494Kq7ltxdzoJb
	 svnEK7wjGpiP53kshxmzIfc/WntWt3K7DrQax+6GlsxG4q4jtPuwNd7bpcMxlXrInUtA2
	 M/tokgn8XGpOgXQoGbGhEVVZHf1Rcgmy7CZxlLyzsio3t4EKzHxlxZAksltC8OPnjgWGu
	 Or0iwHQTFjeSGFpI7eqBie0smtLHdTbOLv2tSIiOBSHXL3K4ZBYNPCKHnqkhECDMf/rZx
	 DIz1koo6aVMXcCXETGuRt7eK9MOFRiWrlzoU1f33f9oIsyAF9TXjVKW3F0McqHsiXqg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=waqaraziz.com header.i=@waqaraziz.com header.a=rsa-sha256
 header.s=default header.b=oIu1skc6;
	arc=none smtp.remote-ip=95.217.203.20
Received: from cp1.mywebsitebox.com (cp1.mywebsitebox.com [95.217.203.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F0C60F8051E
	for <alsa-devel@alsa-project.org>; Sun,  5 Jul 2026 08:25:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F0C60F8051E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=waqaraziz.com header.i=@waqaraziz.com
 header.a=rsa-sha256 header.s=default header.b=oIu1skc6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=waqaraziz.com; s=default; h=Content-Type:To:Subject:Message-ID:Date:From:
	MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yec0R06VdLac18Bjx5hE8Tl7MlsgixFDvHgZHlcVVtk=; b=oIu1skc6HATwVeU3jtnrI6h/MI
	QzYJe6U4uchoz+dCjmxtr7dAnf4Z4/sr9xA3pHoMsAEZ9L2FVgURapGiz0dqG8GIKYjz7rKX7or7c
	/Nc6J2KrkeDDHTml8S8UbsKu+0bboov0DrnPGb1ry0Xbv4jMzZ77Y4w/PnivDyq5tv6K5gUK4X2r5
	XZqhnuHCWkR1Fen2uuxdN64FLXgImmlhuygkhPnaeK+CGAbCk64CswkJdDn9NqoGfhL73SZZA0pKV
	W5jXFnKv/Kn/9Rlc4qTVJRMPBrPcUL0kwFkYeFp4rRpLWdmccOh2gNEfLpWOZpE9BDkFjvofMNjBB
	S03zyX0Q==;
Received: from mail-qk1-f178.google.com ([209.85.222.178]:55540)
	by cp1.mywebsitebox.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.4)
	(envelope-from <hello@waqaraziz.com>)
	id 1wgGHZ-0000000692i-09aY
	for alsa-devel@alsa-project.org;
	Sun, 05 Jul 2026 11:24:49 +0500
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-9204711e831so159156385a.2
        for <alsa-devel@alsa-project.org>;
 Sat, 04 Jul 2026 23:25:16 -0700 (PDT)
X-Gm-Message-State: AOJu0YxQ5T0cZPpqjPIqUW9tTxzwN5cbvddIH/Vtzxuz0aqsMVKAzgyb
	od1KbUcGCVyRX6Pka9oUcgMf/eMndiolbV2a9PV3PO1sYiWiCRoW6kAFRZn/HIAxkfvEGemk0bM
	AfC9ub4FAVpavAUQBUTX4bTBAMO8zEw==
X-Received: by 2002:a05:6214:2604:b0:8ea:47d7:5e3d with SMTP id
 6a1803df08f44-8f74c8a3ce7mr92361916d6.45.1783232714893; Sat, 04 Jul 2026
 23:25:14 -0700 (PDT)
MIME-Version: 1.0
From: Waqar Aziz <hello@waqaraziz.com>
Date: Sun, 5 Jul 2026 11:25:03 +0500
X-Gmail-Original-Message-ID: 
 <CAC74gjdgvjnLLX30nGoTqCXhapk+ukPp_fPG0w1ykLbgEu_RfQ@mail.gmail.com>
X-Gm-Features: AVVi8CdYQMoWalowEG-sZR_zk-yuzOZiR2s2g1WI5pR6CT_kUs8mI_dGjBjXOko
Message-ID: 
 <CAC74gjdgvjnLLX30nGoTqCXhapk+ukPp_fPG0w1ykLbgEu_RfQ@mail.gmail.com>
Subject: [usb-audio] Medeli 0a67:d156 mic: usb_set_interface failed (-19),
 unstable enumeration on xHCI
To: alsa-devel@alsa-project.org
X-Hostbreak-MailScanner-Information: Please contact the ISP for more
 information
X-Hostbreak-MailScanner-ID: 1wgGHZ-0000000692i-09aY
X-Hostbreak-MailScanner: Found to be clean
X-Hostbreak-MailScanner-SpamCheck: 
X-Hostbreak-MailScanner-From: hello@waqaraziz.com
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp1.mywebsitebox.com
X-AntiAbuse: Original Domain - alsa-project.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - waqaraziz.com
X-Get-Message-Sender-Via: cp1.mywebsitebox.com: authenticated_id:
 hello@waqaraziz.com
X-Authenticated-Sender: cp1.mywebsitebox.com: hello@waqaraziz.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, already matched
Message-ID-Hash: ZVWQA4FCZZORALY4VIJDVWUMUB3W3D6Q
X-Message-ID-Hash: ZVWQA4FCZZORALY4VIJDVWUMUB3W3D6Q
X-MailFrom: hello@waqaraziz.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZVWQA4FCZZORALY4VIJDVWUMUB3W3D6Q/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGVsbG8sDQoNCkkgaGF2ZSBhIFVTQiBtaWNyb3Bob25lIChzb2xkIGFzICJKbWFyeSBNQy1QVzEw
IjsgdGhlIGNoaXAgcmVwb3J0cyBhcw0KTWVkZWxpLCBVU0IgSUQgMGE2NzpkMTU2KSB0aGF0IHdv
cmtzIGNvcnJlY3RseSBvbiBXaW5kb3dzIGFuZCBBbmRyb2lkDQpidXQgZmFpbHMgb24gTGludXgu
IEknbSBob3BpbmcgdGhlcmUgaXMgYSBzbmRfdXNiX2F1ZGlvIHF1aXJrX2ZsYWdzIG9yDQp1c2Jj
b3JlLnF1aXJrcyB2YWx1ZSB0aGF0IHdvdWxkIG1ha2UgaXQgd29yaywgb3IgdGhhdCB0aGlzIGRl
dmljZSBtYXkgYmUNCmEgY2FuZGlkYXRlIGZvciBhIHF1aXJrIGVudHJ5Lg0KDQpTeXN0ZW06DQot
IExpbnV4IE1pbnQgMjIuMywga2VybmVsIDYuMTcuMC0zNS1nZW5lcmljDQotIEludGVsIHhIQ0kg
aG9zdCBjb250cm9sbGVyICgwMDAwOjAwOjE0LjApDQotIFBpcGVXaXJlDQotIENvbm5lY3RlZCB2
aWEgVVNCLUEgKHRoZSBtaWMgc2hpcHMgd2l0aCBhIFVTQi1DLXRvLVVTQi1BIGFkYXB0ZXI7IHRo
ZQ0KICBsYXB0b3AncyBVU0ItQyBwb3J0IGlzIGRlYWQsIHNvIGEgZGlyZWN0IFVTQi1DIHRlc3Qg
aXMgbm90IHBvc3NpYmxlKS4NCiAgVGhlIHNhbWUgY2FibGUvYWRhcHRlciBpbnRvIGEgVVNCLUEg
cG9ydCB3b3JrcyBmbGF3bGVzc2x5IG9uIGEgV2luZG93cw0KICBQQywgc28gdGhlIHBoeXNpY2Fs
IGNvbm5lY3Rpb24gaXMgbm90IHRoZSB2YXJpYWJsZS4NCg0KRGV2aWNlOg0KLSBpZFZlbmRvcj0w
YTY3IGlkUHJvZHVjdD1kMTU2LCAiTUMtUFcxMCIgLyAiSmluLUF1ZGlvIiwgYmNkRGV2aWNlIDAu
MDINCi0gVVNCIDIuMCBmdWxsLXNwZWVkLCBidXMtcG93ZXJlZCwgTWF4UG93ZXIgMTAwIG1BDQot
IFVBQzEsIDQ4MDAwIEh6LCAxNi1iaXQgYW5kIDI0LWJpdCBQQ00sIGlzb2Nocm9ub3VzIGVuZHBv
aW50cw0KLSBIYXMgYSBoYXJkd2FyZSBidXR0b24gdGhhdCBjeWNsZXMgb25ib2FyZCBtb2RlcyAo
cG9wL3N0dWRpby9ldGMpLg0KDQpUd28gZmFpbHVyZSBzaWduYXR1cmVzOg0KDQooMSkgRW51bWVy
YXRlcywgdGhlbiBkaXNjb25uZWN0cyBhdCByZXN0LCBvZnRlbiB3aXRoaW4gfjEgc2Vjb25kLg0K
U29tZXRpbWVzIGNsZWFuIChubyBlcnJvciksIHNvbWV0aW1lcyB3aXRoIGVycm9yIC03MSAvIC0z
MjoNCg0KICB1c2IgMS0yLjEuMzogbmV3IGZ1bGwtc3BlZWQgVVNCIGRldmljZSBudW1iZXIgMTEg
dXNpbmcgeGhjaV9oY2QNCiAgdXNiIDEtMi4xLjM6IE5ldyBVU0IgZGV2aWNlIGZvdW5kLCBpZFZl
bmRvcj0wYTY3LCBpZFByb2R1Y3Q9ZDE1NiwNCmJjZERldmljZT0gMC4wMg0KICB1c2IgMS0yLjEu
MzogUHJvZHVjdDogTUMtUFcxMA0KICB1c2IgMS0yLjEuMzogTWFudWZhY3R1cmVyOiBKaW4tQXVk
aW8NCiAgdXNiIDEtMi4xLjM6IFdhcm5pbmchIFVubGlrZWx5IGJpZyB2b2x1bWUgcmFuZ2UgKD0y
NDU3NiksIGN2YWwtPnJlcyBpcw0KcHJvYmFibHkgd3JvbmcuDQogIHVzYiAxLTIuMS4zOiBVU0Ig
ZGlzY29ubmVjdCwgZGV2aWNlIG51bWJlciAxMQ0KDQogIChvdGhlciBjeWNsZXM6KQ0KICB1c2I6
IGRldmljZSBkZXNjcmlwdG9yIHJlYWQvYWxsLCBlcnJvciAtMzINCiAgdXNiOiBjYW4ndCBzZXQg
Y29uZmlnICMxLCBlcnJvciAtNzENCiAgdXNiOiBkZXZpY2Ugbm90IGFjY2VwdGluZyBhZGRyZXNz
LCBlcnJvciAtNzENCiAgdXNiaGlkIDEtMToxLjM6IGNhbid0IGFkZCBoaWQgZGV2aWNlOiAtNzEN
CiAgdXNiaGlkIDEtMToxLjM6IHByb2JlIHdpdGggZHJpdmVyIHVzYmhpZCBmYWlsZWQgd2l0aCBl
cnJvciAtNzENCg0KKDIpIFByZXNzaW5nIHRoZSBoYXJkd2FyZSBtb2RlIGJ1dHRvbiAod2hpY2gg
cmVjb25maWd1cmVzIHRoZSBzdHJlYW1pbmcNCmludGVyZmFjZSkgcmVsaWFibHkgZGlzY29ubmVj
dHMgaXQgd2l0aDoNCg0KICB1c2I6IDI6MTogdXNiX3NldF9pbnRlcmZhY2UgZmFpbGVkICgtMTkp
DQoNCldoZW4gaXQgZG9lcyBzdGF5IGNvbm5lY3RlZCBpdCB3b3JrcyBmdWxseTogaXQgYXBwZWFy
cyBhcyBhIGNhcmQgaW4NCmFyZWNvcmQgLWwgYW5kIGFzIGEgMjQtYml0LzQ4a0h6IHNvdXJjZSBp
biBQaXBlV2lyZSwgYW5kIHJlY29yZHMNCmNvcnJlY3RseS4gU28gdGhlIGF1ZGlvIHBhdGggaXMg
ZmluZTsgdGhlIHByb2JsZW0gaXMgKDEpIHN0YXlpbmcNCmVudW1lcmF0ZWQgYW5kICgyKSBzdXJ2
aXZpbmcgdGhlIGludGVyZmFjZSBjaGFuZ2Ugb24gbW9kZS1zd2l0Y2guDQoNCkFscmVhZHkgdHJp
ZWQgKG5vIHN1Y2Nlc3MpOg0KLSB1c2Jjb3JlLnF1aXJrcz0wYTY3OmQxNTY6Z2kgIC0+IHN0aWxs
IGRldGVjdHMgYnV0IGRyb3BzDQotIHVzYmNvcmUucXVpcmtzPTBhNjc6ZDE1NjpnaWsgLT4gc3Rv
cHMgZGV0ZWN0aW5nIGVudGlyZWx5DQotIHNuZF91c2JfYXVkaW8gcXVpcmtfZmxhZ3M9MHgwMiBh
bmQgMHgyMDAgLT4gaW5jb25jbHVzaXZlOyB0aGUgZGV2aWNlDQogIGlzIG9mdGVuIHRvbyB1bnN0
YWJsZSB0byBob2xkIGEgY29ubmVjdGlvbiBsb25nIGVub3VnaCB0byBqdWRnZSB0aGUNCiAgbW9k
ZS1zd2l0Y2ggYmVoYXZpb3INCi0gdXNiY29yZSBhdXRvc3VzcGVuZCBkaXNhYmxlZCBnbG9iYWxs
eSAtPiBubyBjaGFuZ2UNCi0gcG93ZXJlZCBodWIgLyBleHRlcm5hbCA1ViAtPiBubyBjaGFuZ2Ug
KGRldmljZSByZXF1ZXN0cyBvbmx5IDEwMCBtQSkNCg0KUXVlc3Rpb25zOg0KMS4gSXMgdGhlcmUg
YSBzbmRfdXNiX2F1ZGlvIHF1aXJrX2ZsYWdzIHZhbHVlIHlvdSB3b3VsZCByZWNvbW1lbmQgZm9y
IGENCiAgIGRldmljZSB0aGF0IGZhaWxzIHNldF9pbnRlcmZhY2UgKC0xOSkgb24gYW4gYWx0c2V0
dGluZyBjaGFuZ2U/DQoyLiBXb3VsZCBhIHF1aXJrIGVudHJ5IGZvciAwYTY3OmQxNTYgYmUgYXBw
cm9wcmlhdGUsIGFuZCB3aGF0DQogICBpbmZvcm1hdGlvbiB3b3VsZCB5b3UgbmVlZCB0byBhZGQg
b25lPw0KMy4gQW55IHN1Z2dlc3Rpb24gZm9yIHRoZSBpbnRlcm1pdHRlbnQgLTcxIGVudW1lcmF0
aW9uIGZhaWx1cmVzIG9uIHhIQ0kNCiAgIChzaG9ydCBvZiBmb3JjaW5nIFVTQiAyLjApPw0KDQpJ
IGNhbiBwcm92aWRlIGZ1bGwgbHN1c2IgLXYgb3V0cHV0IGFuZCBhbiBhbHNhLWluZm8uc2ggdXBs
b2FkIG9uIHJlcXVlc3QuDQoNClRoYW5rcyBmb3IgeW91ciB0aW1lLg0KDQpXYXFhcg0K
