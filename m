Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4F2CD3447
	for <alsa-devel@archiver.kernel.org>; Sat,  9 May 2026 08:20:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B2E1160222;
	Sat,  9 May 2026 10:20:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B2E1160222
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778314845;
	bh=nZTlKrF0MKyU2AaCj+L9UqQF4E8gnWVJpt0MkRk6c3k=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=qHJblX4J11e4m3VtfBV6i4KSML8vVtyteg1jb0lViY7FAEEP9NBTDbVIHu8KGM1a2
	 HmVDL0sdQunZeCCslnUYx0M2sm+1cdo5fgfwNKeWxs2dYCwpS1vRWPZG8wWXvuD3So
	 XKQB/oG53paF4ivm7j3iIMDZtQJN347io1h0SU/4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0C673F805F6; Sat,  9 May 2026 10:20:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 57DECF805F2;
	Sat,  9 May 2026 10:20:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6FFD7F80544; Sat,  9 May 2026 10:19:59 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 9F2BBF800FE
	for <alsa-devel@alsa-project.org>; Sat,  9 May 2026 10:19:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9F2BBF800FE
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18add7e2d42a0000-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/759@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/759@alsa-project.org>
Subject: ucm2/conf.d: add sof_sdw symlink for sof-soundwire driver rename
Date: Sat,  9 May 2026 10:19:59 +0200 (CEST)
Message-ID-Hash: 2NXBWTLCUECJBFLY6D6LSJMDGH7FNTUO
X-Message-ID-Hash: 2NXBWTLCUECJBFLY6D6LSJMDGH7FNTUO
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2NXBWTLCUECJBFLY6D6LSJMDGH7FNTUO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgcHVsbCByZXF1ZXN0ICM3NTkgd2FzIG9wZW5lZCBm
cm9tIFB5b2h3YW46CgojIyBTdW1tYXJ5CgpUaGUga2VybmVsIEFTb0MgbWFjaGluZSBkcml2ZXIg
Zm9yIFNvdW5kV2lyZS1iYXNlZCBTT0Ygc3lzdGVtcyB3YXMgaGlzdG9yaWNhbGx5IG5hbWVkIGBz
b2Ytc291bmR3aXJlYCBhbmQgaXMgbm93IG5hbWVkIGBzb2Zfc2R3YC4gVUNNIGxvb2t1cCB1c2Vz
IGBcJHt2YXI6RHJpdmVyfWAgZnJvbSBgL3N5cy9jbGFzcy9zb3VuZC9jYXJkTi9kZXZpY2UvZHJp
dmVyYCwgc28gb24gY3VycmVudCBrZXJuZWxzIHRoZSBleGlzdGluZyBgY29uZi5kL3NvZi1zb3Vu
ZHdpcmUvYCBkaXJlY3RvcnkgaXMgbmV2ZXIgbWF0Y2hlZCBhbmQgVUNNIGlzIG5vdCBsb2FkZWQu
CgpUaGlzIGFkZHMgYSBzeW1saW5rIHVuZGVyIGBjb25mLmQvc29mX3Nkdy9gIHBvaW50aW5nIGF0
IHRoZSBleGlzdGluZyBgY29uZi5kL3NvZi1zb3VuZHdpcmUvc29mLXNvdW5kd2lyZS5jb25mYCwg
bWlycm9yaW5nIHRoZSBwcmVjZWRlbnQgc2V0IGJ5IFBSICM0MjggZm9yIHRoZSBgYXBxODA5NmAg
LyBgREI4MjBjYCByZW5hbWUuCgojIyBXaHkKCldpdGhvdXQgVUNNLCBQaXBlV2lyZSBBQ1AgZmFs
bHMgYmFjayB0byB0aGUgYHByby1hdWRpb2AgcHJvZmlsZSB3aGljaCBleHBvc2VzIGNoYW5uZWxz
IGFzIGBBVVgwYC9gQVVYMWAgaW5zdGVhZCBvZiBgRkxgL2BGUmAsIHNvIHN0ZXJlbyBjb250ZW50
IGlzIGRvd25taXhlZCB0byBvbmUgc3BlYWtlciBhbmQgdGhlIEdOT01FIFNvdW5kIHBhbmVsIGRv
ZXMgbm90IHNob3cgc2VwYXJhdGUgU3BlYWtlci9IZWFkcGhvbmVzL0hETUkgb3B0aW9ucy4KCldp
dGggdGhpcyBzeW1saW5rLCBVQ00gZGV0ZWN0cyB0aGUgYEhpRmlgIHByb2ZpbGUsIGFsc2EtY2Fy
ZC1wcm9maWxlIGNyZWF0ZXMgcHJvcGVyIHNpbmtzL3NvdXJjZXMsIGphY2sgYXV0by1yb3V0aW5n
IHdvcmtzLCBhbmQgdGhlIEdOT01FIFNvdW5kIHBhbmVsIGV4cG9zZXMgdGhlIHJpZ2h0IG91dHB1
dCBjaG9pY2VzLgoKIyMgQWZmZWN0ZWQgaGFyZHdhcmUgKHZlcmlmaWVkKQoKLSBMZW5vdm8gWW9n
YSBTbGltIDcgMTRJTEwxMCAoY3M0Mmw0Mykg4oCUIGlzc3VlICM2NDUKLSBMRyBHcmFtIFBybyAy
MDI2ICgxNlo5MFUtS1U3QkssIFJUNzEzICsgUlQxMzIwKSwgVWJ1bnR1IDI2LjA0LCBrZXJuZWwg
Ny4wLjAtMTUKCiMjIFRlc3QgcGxhbgoKLSBbeF0gXGBhbHNhdWNtIC1jIGh3OjAgbGlzdCBfdmVy
YnNcYCByZXR1cm5zIFxgSGlGaVxgIChwcmV2aW91c2x5IGVtcHR5IC8gbm8gVUNNKQotIFt4XSBQ
aXBlV2lyZSBIaUZpIHByb2ZpbGUgYXV0by1hY3RpdmF0ZXMgd2l0aCBwcm9wZXIgXGBmcm9udC1s
ZWZ0LGZyb250LXJpZ2h0XGAgY2hhbm5lbCBtYXBwaW5nCi0gW3hdIFNwZWFrZXJzIHBsYXkgc3Rl
cmVvIGNvcnJlY3RseQotIFt4XSBIZWFkcGhvbmUgamFjayBhdXRvLXJvdXRlcyBvbiBwbHVnCi0g
W3hdIEhETUkgLyBidWlsdC1pbiBtaWMgLyBoZWFkc2V0IG1pYyBhbGwgZXhwb3NlIHByb3BlciBz
aW5rcy9zb3VyY2VzCi0gW3hdIE5vIHJlZ3Jlc3Npb25zIG9uIGNhcmRzIHN0aWxsIHVzaW5nIFxg
c29mLXNvdW5kd2lyZVxgIGRyaXZlciBuYW1lIChzeW1saW5rLCBub3QgcmVuYW1lKQoKUmVxdWVz
dCBVUkwgICA6IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS11Y20tY29uZi9w
dWxsLzc1OQpQYXRjaCBVUkwgICAgIDogaHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJvamVjdC9h
bHNhLXVjbS1jb25mL3B1bGwvNzU5LnBhdGNoClJlcG9zaXRvcnkgVVJMOiBodHRwczovL2dpdGh1
Yi5jb20vYWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYK
