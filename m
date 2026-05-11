Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5523CD37AC
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2026 14:31:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BD117601B8;
	Mon, 11 May 2026 16:30:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BD117601B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778509865;
	bh=gUkjD07W3msSgiVaV+tx9QrCDgJAo1jjIL0uYvPZYgw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=laliRkgoZfyTSry1g3xJcsPHPMgygRU2M6yfPQngAlndk/YPaMUPjB2K3pxPFjyn0
	 2ZqEzBQo89ZfACE3Ww2Vr2LqxFWwyek/a+Vp7hrlZW1W8qCzRvHRmGa09635BbcCJZ
	 Bdw5R+UJrDByoCWFj+lBuMUCouTMbC2bbNMU9yxQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A1711F805F3; Mon, 11 May 2026 16:30:32 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 28047F805EA;
	Mon, 11 May 2026 16:30:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D7939F80535; Mon, 11 May 2026 16:30:24 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id E8032F80171
	for <alsa-devel@alsa-project.org>; Mon, 11 May 2026 16:30:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E8032F80171
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18ae8942af8dbf00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/759@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/759@alsa-project.org>
Subject: ucm2/conf.d: add sof_sdw symlink for sof-soundwire driver rename
Date: Mon, 11 May 2026 16:30:24 +0200 (CEST)
Message-ID-Hash: MDEEV5UGT6XFTDWUEM3SDI7TYCEC4OJ7
X-Message-ID-Hash: MDEEV5UGT6XFTDWUEM3SDI7TYCEC4OJ7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MDEEV5UGT6XFTDWUEM3SDI7TYCEC4OJ7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgcHVsbCByZXF1ZXN0ICM3NTkgd2FzIGVkaXRlZCBm
cm9tIFB5b2h3YW46CgojIyBTdW1tYXJ5DQoNClRoZSBrZXJuZWwgQVNvQyBtYWNoaW5lIGRyaXZl
ciBmb3IgU291bmRXaXJlLWJhc2VkIFNPRiBzeXN0ZW1zIHdhcyBoaXN0b3JpY2FsbHkgbmFtZWQg
YHNvZi1zb3VuZHdpcmVgIGFuZCBpcyBub3cgbmFtZWQgYHNvZl9zZHdgLiBVQ00gbG9va3VwIHVz
ZXMgYFwke3ZhcjpEcml2ZXJ9YCBmcm9tIGAvc3lzL2NsYXNzL3NvdW5kL2NhcmROL2RldmljZS9k
cml2ZXJgLCBzbyBvbiBjdXJyZW50IGtlcm5lbHMgdGhlIGV4aXN0aW5nIGBjb25mLmQvc29mLXNv
dW5kd2lyZS9gIGRpcmVjdG9yeSBpcyBuZXZlciBtYXRjaGVkIGFuZCBVQ00gaXMgbm90IGxvYWRl
ZC4NCg0KVGhpcyBhZGRzIGEgc3ltbGluayB1bmRlciBgY29uZi5kL3NvZl9zZHcvYCBwb2ludGlu
ZyBhdCB0aGUgZXhpc3RpbmcgYGNvbmYuZC9zb2Ytc291bmR3aXJlL3NvZi1zb3VuZHdpcmUuY29u
ZmAsIG1pcnJvcmluZyB0aGUgcHJlY2VkZW50IHNldCBieSBQUiAjNDI4IGZvciB0aGUgYGFwcTgw
OTZgIC8gYERCODIwY2AgcmVuYW1lLg0KDQojIyBXaHkNCg0KV2l0aG91dCBVQ00sIFBpcGVXaXJl
IEFDUCBmYWxscyBiYWNrIHRvIHRoZSBgcHJvLWF1ZGlvYCBwcm9maWxlIHdoaWNoIGV4cG9zZXMg
Y2hhbm5lbHMgYXMgYEFVWDBgL2BBVVgxYCBpbnN0ZWFkIG9mIGBGTGAvYEZSYCwgc28gc3RlcmVv
IGNvbnRlbnQgaXMgZG93bm1peGVkIHRvIG9uZSBzcGVha2VyIGFuZCB0aGUgR05PTUUgU291bmQg
cGFuZWwgZG9lcyBub3Qgc2hvdyBzZXBhcmF0ZSBTcGVha2VyL0hlYWRwaG9uZXMvSERNSSBvcHRp
b25zLg0KDQpXaXRoIHRoaXMgc3ltbGluaywgVUNNIGRldGVjdHMgdGhlIGBIaUZpYCBwcm9maWxl
LCBhbHNhLWNhcmQtcHJvZmlsZSBjcmVhdGVzIHByb3BlciBzaW5rcy9zb3VyY2VzLCBqYWNrIGF1
dG8tcm91dGluZyB3b3JrcywgYW5kIHRoZSBHTk9NRSBTb3VuZCBwYW5lbCBleHBvc2VzIHRoZSBy
aWdodCBvdXRwdXQgY2hvaWNlcy4NCg0KIyMgQWZmZWN0ZWQgaGFyZHdhcmUgKHZlcmlmaWVkKQ0K
DQotIExlbm92byBZb2dhIFNsaW0gNyAxNElMTDEwIChjczQybDQzKSDigJQgaXNzdWUgIzY0NQ0K
LSBMRyBHcmFtIFBybyAyMDI2ICgxNlo5MFUtS1U3QkssIFJUNzEzICsgUlQxMzIwKSwgVWJ1bnR1
IDI2LjA0LCBrZXJuZWwgNy4wLjAtMTUNCg0KIyMgVGVzdCBwbGFuDQoNCi0gW3hdIGBhbHNhdWNt
IC1jIGh3OjAgbGlzdCBfdmVyYnNgIHJldHVybnMgYEhpRmlgIChwcmV2aW91c2x5IGVtcHR5IC8g
bm8gVUNNKQ0KLSBbeF0gUGlwZVdpcmUgSGlGaSBwcm9maWxlIGF1dG8tYWN0aXZhdGVzIHdpdGgg
cHJvcGVyIGBmcm9udC1sZWZ0LGZyb250LXJpZ2h0YCBjaGFubmVsIG1hcHBpbmcNCi0gW3hdIFNw
ZWFrZXJzIHBsYXkgc3RlcmVvIGNvcnJlY3RseQ0KLSBbeF0gSGVhZHBob25lIGphY2sgYXV0by1y
b3V0ZXMgb24gcGx1Zw0KLSBbeF0gSERNSSAvIGJ1aWx0LWluIG1pYyAvIGhlYWRzZXQgbWljIGFs
bCBleHBvc2UgcHJvcGVyIHNpbmtzL3NvdXJjZXMNCi0gW3hdIE5vIHJlZ3Jlc3Npb25zIG9uIGNh
cmRzIHN0aWxsIHVzaW5nIGBzb2Ytc291bmR3aXJlYCBkcml2ZXIgbmFtZSAoc3ltbGluaywgbm90
IHJlbmFtZSkKClJlcXVlc3QgVVJMICAgOiBodHRwczovL2dpdGh1Yi5jb20vYWxzYS1wcm9qZWN0
L2Fsc2EtdWNtLWNvbmYvcHVsbC83NTkKUGF0Y2ggVVJMICAgICA6IGh0dHBzOi8vZ2l0aHViLmNv
bS9hbHNhLXByb2plY3QvYWxzYS11Y20tY29uZi9wdWxsLzc1OS5wYXRjaApSZXBvc2l0b3J5IFVS
TDogaHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJvamVjdC9hbHNhLXVjbS1jb25mCg==
