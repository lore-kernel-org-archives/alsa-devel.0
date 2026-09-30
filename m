Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CECCA5FC4
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Sep 2026 19:00:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 722866026C;
	Wed, 30 Sep 2026 21:00:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 722866026C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790794820;
	bh=MIqnukO7yMniWeSvG44oIUlc+vFXD94F6Y39TJsDiNw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=hVeUlZK/W0g7/9zpFoUYvAJKtna8c3kwP0LdW+W3ql9IXYUwTnPTc0Gvde57TTwh3
	 W0d3eubGSLEyGwUHGN9go8ZmjUzNsGYFaUwYNKHgynyWcen7PdvnPvwr1G90Bqvy/h
	 /VOjaKAIKxgmxSAYZLeYSfG4DWuu7NbMQy/WQyWY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B97C7F805FB; Wed, 30 Sep 2026 20:59:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E597F805FD;
	Wed, 30 Sep 2026 20:59:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E733AF80542; Wed, 30 Sep 2026 20:59:38 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790794778;
	b=IJSiO9meobibWiJVqlbluDEfBnBI9FtXlteOickChaTwdNze+gUnk/Ag6gh7CfsUguM7
	 TX+pFNWcD1sNJbh5BH2gG40EqcbJDJun4qQlztcESV4Bf4sAdlaV0f5rNH5s06D1Jej0T
	 yibFlXBs7NZoXZj5l+I59BumP9y4kFUWvZu8KQS8yBhm93HAVY+00OEvUaety25nk3jB6
	 N/QtbE92pX8HrImOusHlB7/BQqeOaXYkjj/ZNbXiytLmE/DbKYEk9NiaSylt8FFa16Unt
	 rV3axv+XQRDiXoNxctjRneTBsTVj8pUy7ipLlzrX5Z+tuY3axbydLI0F/nIjDKSeD6w==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790794778;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=MIqnukO7yMniWeSvG44oIUlc+vFXD94F6Y39TJsDiNw=;
	b=F+THmkzOZ63UMk9ihKW39m+fSBVCL8Ol/KEX2eYwfpQDcnZHvT0ypVYj0Hc4V9LmOlTN
	 9Xh1vUMuW1hmfO2GvQQSu4o3VSNDix7D7a94TRopXq5Jm3jQ7CgcdC3Q9jvMZ9Jfqk73+
	 j38YirxATQ7y4lPNb7szlqPmjGA1nppqAGAbmZ+KjuuL2cS0nb788aeNQ3b+Hct8kT7uX
	 TTlqkgTun3i5EmGO3AvumjdaY7LYSUrIvlwOplT863G2HUvMNIjp6LD4NZ1ud7YVimamk
	 a3EYNxz2dneQTZLuSruIJ9LmGDaiO2MIFgWD6qupIjDzWCGObsFk3cMnqcCO956ZbLg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id E9F3FF80496
	for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2026 20:59:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E9F3FF80496
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub pull_request - reopened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18da2e5c767cd000-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-lib/pr/527@alsa-project.org>
References: <alsa-project/alsa-lib/pr/527@alsa-project.org>
Subject: 
 =?utf-8?q?alsa-lib=3A_security_hardening_=E2=80=94_UCM=2C_conf_parser=2C_topology=2C_PCM_plugins_=286_findings=29?=
Date: Wed, 30 Sep 2026 20:59:38 +0200 (CEST)
Message-ID-Hash: HCWLAI2Y4JJ6LE5DSVCQ5JWZB6N2UPH4
X-Message-ID-Hash: HCWLAI2Y4JJ6LE5DSVCQ5JWZB6N2UPH4
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HCWLAI2Y4JJ6LE5DSVCQ5JWZB6N2UPH4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtbGliIHB1bGwgcmVxdWVzdCAjNTI3IHdhcyByZW9wZW5lZCBmcm9t
IEhhcnNoUmFqU2luZ2hhbmlhOgoKVGhpcyBQUiBhZGRyZXNzZXMgKipzaXggaW5kZXBlbmRlbnRs
eS10cmlnZ2VyZWQgc2VjdXJpdHkgaGFyZGVuaW5nIGlzc3VlcyoqIGZvdW5kIGR1cmluZyBhIHNv
dXJjZSBhdWRpdCBvZiBjb21taXQgYGY4NGNkNGNgLCBhbGwgdmVyaWZpZWQgd2l0aCBwcm9vZi1v
Zi1jb25jZXB0IHByb2dyYW1zLgoKQTMgKGBzaGVsbGAvYHN5c3RlbSgpYCkgYW5kIEE2IChQQ00g
ZmlsZSBgcG9wZW5gKSBhcmUgaW50ZW50aW9uYWwgZmVhdHVyZXMgYW5kIGFyZSBub3QgcGF0Y2hl
ZCBoZXJlIOKAlCBoYXJkZW5pbmcgc3VnZ2VzdGlvbnMgbm90ZWQgaW5saW5lIGZvciBtYWludGFp
bmVyIGNvbnNpZGVyYXRpb24uCgotLS0KCiMjIyBBMSDigJQgVUNNIGBzeXN3YCBwYXRoIHRyYXZl
cnNhbCAoQ1dFLTIyKSDCtyBgc3JjL3VjbS9tYWluLmNgCmBleGVjdXRlX3N5c3coKWAgY29uY2F0
ZW5hdGVzIHRoZSBzeXNmcyByb290IHdpdGggYSBjYWxsZXItc3VwcGxpZWQgc3RyaW5nIHZpYSBg
c25wcmludGYoKWAgd2l0aCBubyBgLi5gIHJlamVjdGlvbiBvciBgcmVhbHBhdGgoKWAgY29uZmlu
ZW1lbnQuIEEgVUNNIHBhdGggbGlrZSBgLi4vLi4vZXRjL2Nyb24uZC94OnZhbHVlYCB3cml0ZXMg
dG8gYW4gYXJiaXRyYXJ5IGZpbGVzeXN0ZW0gbG9jYXRpb24uICoqRml4OioqIGByZWFscGF0aCgp
YCBjb25maW5lbWVudCDigJQgcmVqZWN0IGlmIHJlc29sdmVkIHBhdGggZG9lcyBub3QgcmVtYWlu
IHdpdGhpbiB0aGUgc3lzZnMgcm9vdC4KCiMjIyBBMiDigJQgVUNNIGBjZmctc2F2ZWAgdW5yZXN0
cmljdGVkIHBhdGggKENXRS03MykgwrcgYHNyYy91Y20vbWFpbi5jYApgZXhlY3V0ZV9jZmdzYXZl
KClgIGNhbGxzIGBzbmRfb3V0cHV0X3N0ZGlvX29wZW4oJm91dCwgZmlsZSwgIncrIilgIHdpdGgg
YSByYXcgY2FsbGVyLXN1cHBsaWVkIGBmaWxlYCBhbmQgbm8gcmVzdHJpY3Rpb24uIEFueSB3cml0
YWJsZSBwYXRoIChlLmcuIGB+Ly5zc2gvYXV0aG9yaXplZF9rZXlzYCkgaXMgcmVhY2hhYmxlLiAq
KkZpeDoqKiBgcmVhbHBhdGgoKWAgY2hlY2sg4oCUIGNvbmZpbmUgdG8gYFhER19SVU5USU1FX0RJ
UmAgKGZhbGxiYWNrIGAvdG1wYCkuCgojIyMgQTQg4oCUIENvbmZpZyBwYXJzZXIgYWJzb2x1dGUg
aW5jbHVkZSB0cmF2ZXJzYWwgKENXRS0yMikgwrcgYHNyYy9jb25mLmNgCmBpbnB1dF9zdGRpb19v
cGVuKClgIGltbWVkaWF0ZWx5IG9wZW5zIGFueSBhYnNvbHV0ZSBwYXRoIChgZmlsZVswXT09Jy8n
YCkgd2l0aG91dCBjaGVja2luZyBmb3IgYC4uYCBjb21wb25lbnRzLiBBIHBsYW50ZWQgY29uZmln
IHdpdGggYDwvLi4vLi4vZXRjL3NoYWRvdz5gIGNhbiByZWFkIGFyYml0cmFyeSBmaWxlcy4gKipG
aXg6KiogcmVqZWN0IHBhdGhzIGNvbnRhaW5pbmcgYC8uLi9gLgoKIyMjIEE1IOKAlCBUb3BvbG9n
eSBjb250cm9sIGB1aW50MzJfdGAgaW50ZWdlciBvdmVyZmxvdyAoQ1dFLTE5MCkgwrcgYHNyYy90
b3BvbG9neS9jdGwuY2AKYHNpemUyID0geC0+c2l6ZSArIHgtPnByaXYuc2l6ZWAgaXMgY29tcHV0
ZWQgaW4gMzItYml0IHVuc2lnbmVkIGFyaXRobWV0aWMgYmVmb3JlIGJlaW5nIHdpZGVuZWQgdG8g
YHNpemVfdGAuIE9uIGEgNjQtYml0IGhvc3QsIGAweEZGRkZGRkYwICsgMHgyMCA9IDB4MTBgICh3
cmFwcyksIGJ5cGFzc2luZyB0aGUgc3Vic2VxdWVudCBgc2l6ZTIgPiBzaXplYCBndWFyZC4gVGhy
ZWUgc2l0ZXM6IGB0cGxnX2RlY29kZV9jb250cm9sX21peGVyYCwgYHRwbGdfZGVjb2RlX2NvbnRy
b2xfZW51bWAsIGB0cGxnX2RlY29kZV9jb250cm9sX2J5dGVzYCAoZGlzdGluY3QgZnJvbSBDVkUt
MjAyNi0yNTA2OCB3aGljaCB3YXMgYHRwbGdfZGVjb2RlX2NvbnRyb2xfbWl4ZXIxYCkuICoqRml4
OioqIHByZS1jaGVjayBmb3Igb3ZlcmZsb3csIHRoZW4gYChzaXplX3QpeC0+c2l6ZSArIChzaXpl
X3QpeC0+cHJpdi5zaXplYC4KCiMjIyBBNyDigJQgUENNIGByb3V0ZWAgcGx1Z2luIHVuYm91bmRl
ZCBgdHRhYmxlYCBhbGxvY2F0aW9uIChDV0UtNzcwKSDCtyBgc3JjL3BjbS9wY21fcm91dGUuY2AK
YGNzaXplYC9gc3NpemVgIGdyb3cgZnJvbSBjb25maWctc3VwcGxpZWQgY2hhbm5lbCBpbmRpY2Vz
IHdpdGggbm8gdXBwZXIgYm91bmQgYmVmb3JlIGBtYWxsb2MoY3NpemUgKiBzc2l6ZSAqIHNpemVv
ZihlbnRyeSkpYC4gSW5kZXggYDEwNzM3NDE4MjNgIOKGkiBgbWFsbG9jKDggR0IpYC4gKipGaXg6
KiogY2FwIGJvdGggYXQgMTAyNCAoY29uc2lzdGVudCB3aXRoIGBkbWl4YCwgYHNvZnR2b2xgLCBv
dGhlciBQQ00gcGx1Z2lucykuCgojIyMgQTgg4oCUIFBDTSBgbXVsdGlgIHNwYXJzZSBiaW5kaW5n
cyBPT0IgYXNzZXJ0IChDV0UtNjE3KSDCtyBgc3JjL3BjbS9wY21fbXVsdGkuY2AKU3BhcnNlIGJp
bmRpbmcgbWFwcyBsZWF2ZSBgc2lkeHNbaV0gPT0gLTFgIGZvciBnYXAgaW5kaWNlcy4gYGFzc2Vy
dChzY2hhbm5lbHNbaV0gPCBzY2hhbm5lbHNfY291bnRbc2lkeHNbaV1dKWAgdGhlbiBkZXJlZmVy
ZW5jZXMgYHNjaGFubmVsc19jb3VudFstMV1gIOKGkiBTSUdBQlJUIChkZWJ1ZykgLyBPT0IgcmVh
ZCAoTkRFQlVHKS4gKipGaXg6KiogcmVwbGFjZSBib3RoIGBhc3NlcnQoKWBzIHdpdGggZXhwbGlj
aXQgYC1FSU5WQUxgIHJldHVybnMgd2l0aCBib3VuZHMgYW5kIHNpZ24gY2hlY2tzLgoKLS0tCgoq
KlZlcmlmaWVkOioqIGFsbCBzaXggUG9DIHByb2dyYW1zIGNvbmZpcm1lZCBvbiBgbGliYXNvdW5k
MiAxLjIuMTRgIC8gYGdjYyAxNC4yYCwgY29tbWl0IGBmODRjZDRjYC4KCioqU2lnbmVkLW9mZi1i
eToqKiBIYXJzaCBSYWogU2luZ2hhbmlhIDxyYWouaGFyc2hyYXV0QGdtYWlsLmNvbT4KClJlcXVl
c3QgVVJMICAgOiBodHRwczovL2dpdGh1Yi5jb20vYWxzYS1wcm9qZWN0L2Fsc2EtbGliL3B1bGwv
NTI3ClBhdGNoIFVSTCAgICAgOiBodHRwczovL2dpdGh1Yi5jb20vYWxzYS1wcm9qZWN0L2Fsc2Et
bGliL3B1bGwvNTI3LnBhdGNoClJlcG9zaXRvcnkgVVJMOiBodHRwczovL2dpdGh1Yi5jb20vYWxz
YS1wcm9qZWN0L2Fsc2EtbGliCg==
