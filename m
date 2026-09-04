Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA2F6C79F80
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Sep 2026 04:13:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D983560203;
	Fri,  4 Sep 2026 06:13:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D983560203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788495192;
	bh=W659inFGjrpNsi+ri39kE7NdfSm7Le+K/lpL7xI0Yek=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=S27IOq+c9hAZMK1a0isC5e6c0xd4g47IqFVI424ROMbiLO40iH23Dm0e8uITmCtHY
	 qY4zcuGPAzZHhr88Sw6OIhpXrUo5HZSjK7XAo2ZKANI3urXrjcH6BE6zfetA2qL0q+
	 U0AoI0sh7hZsTIt8aDxTfBWsHjWicxjqnKRTT9cQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2CA31F805F0; Fri,  4 Sep 2026 06:12:39 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8DEE1F80601;
	Fri,  4 Sep 2026 06:12:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 83892F8049C; Fri,  4 Sep 2026 06:12:32 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788495151;
	b=X65H2IVMLfVaPhs214zh8h8lkVY1Ywf3cU0+5NJ/M4Tf+9cqnpAZzgwIg2lcEtVIpWD9
	 p9bJR8LrLY16lOFZ2qaUxBR7HQoOM6Ae3cnqbs2sVV0z/M1Se+Bp31s19Fso1kB3p/5mG
	 1V1pNfVir9r9H/VEyH+9FLHSCY0NUeS6S0iCv+gJrqLJZKKwgcU0uB+g71rd3CAc2ELPu
	 hzsst+t9CoK5v/DD80dJX7THbEF6JsP2UU6E9By8seJp2VUSWZCXY37u26Btbi1APGlk8
	 B3ixGWYfOn9Rr9bzWRmpwB0BJUQ7EehAmSwQPpu7nVtSomRxe/yegOP4TBOwhJOL6+Q==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788495151;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=W659inFGjrpNsi+ri39kE7NdfSm7Le+K/lpL7xI0Yek=;
	b=WGtR2f9CxXfbFnnVdhqeBUbs+o11JN6BospthyMF0hngdGKsGzYqFVJWNsDpEDpoqK8M
	 Irt41Fjinb57y8xWPU8Y6rhNECBm3uwnSzysFv+leEM0iEKBpksxugBphbsMZthd37Lw9
	 XJkirTg0X3vJnM9mzIvzYls67tEoeHIH95quJ2UyWC4YmfJs46Ng1Oz1t4hESEDWh3qvI
	 dGUm883Otcq7tXVz/s/3iSS3HcFCsbn9Rrriuh/DMU6QEMaajNsWLMaNHJLP9cPUakSHM
	 UpzccuyrWaYhi+Iy5IOdwLgDhFYrvnobhjLmV6Dm8BJbsX/OZNEseeEFsUz/4AybU1A==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 3B130F80185
	for <alsa-devel@alsa-project.org>; Fri,  4 Sep 2026 06:12:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3B130F80185
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18d202dce490e000-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/849@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/849@alsa-project.org>
Subject: ucm2: sof-soundwire: add Senary SN624x SDCA support
Date: Fri,  4 Sep 2026 06:12:32 +0200 (CEST)
Message-ID-Hash: 7Z3DUU72QL7KBLE24BMZ65LMLCMM6APD
X-Message-ID-Hash: 7Z3DUU72QL7KBLE24BMZ65LMLCMM6APD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7Z3DUU72QL7KBLE24BMZ65LMLCMM6APD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgcHVsbCByZXF1ZXN0ICM4NDkgd2FzIG9wZW5lZCBm
cm9tIHdhbmd4aWFvaHUyMDI2OgoKIyMgU3VtbWFyeQ0KQWRkIHNvZi1zb3VuZHdpcmUgVUNNIGZv
ciBTZW5hcnkgU042MjR4IFNEQ0EgKGphY2sgLyBzcGVha2VyIC8gZG1pYykuDQoNCktlcm5lbCBg
Q2FyZENvbXBvbmVudHNgIGV4YW1wbGU6DQpgaHM6c242MjR4LXNkY2Egc3BrOnNuNjI0eCBtaWM6
c242MjR4LWRtaWNgDQoNCkZpbGVzIGFkZGVkIHVuZGVyIGB1Y20yL3NvZi1zb3VuZHdpcmUvYDoN
Ci0gYHNuNjI0eC5jb25mYCDigJQgU3BlYWtlcg0KLSBgc242MjR4LXNkY2EuY29uZmAg4oCUIEhl
YWRwaG9uZXMgLyBIZWFkc2V0IE1pYw0KLSBgc242MjR4LWRtaWMuY29uZmAg4oCUIERNSUMNCg0K
Tm90ZTogZXhpc3RpbmcgYHNuNjI0MipgIFVDTSBlbnRyaWVzIGNhbm5vdCBzdWJzdGl0dXRlIHRo
ZXNlIG5hbWVzLg0KDQojIyBIYXJkd2FyZQ0KLSBQbGF0Zm9ybTogSW50ZWwgUGFudGhlciBMYWtl
IC8gV2lsZGNhdCBMYWtlIChgc29mLXNvdW5kd2lyZWApDQotIENvZGVjOiBTZW5hcnkgU042MjR4
IFNEQ0EgU291bmRXaXJlIChlLmcuIHBhcnRfaWQgYDB4NjI0NGApDQotIEtlcm5lbDogQVNvQyBT
TjYyNHggc2VyaWVzIGluIGJyb29uaWUvc291bmQgYGZvci03LjRgDQoNCiMjIFRlc3QNCi0gSGlG
aSBwcm9maWxlIGV4cG9zZXMgU3BlYWtlciAvIERtaWMgLyBIZWFkcGhvbmVzIC8gTWljcm9waG9u
ZXMNCi0gYGFsc2F1Y20gLWMgc29mLXNvdW5kd2lyZSBkdW1wIHRleHRgIHNob3dzIHRoZSBjb3Jy
ZXNwb25kaW5nIGRldmljZXMNCg0KIyMgYWxzYS1pbmZvDQpTZWUgYXR0YWNoZWQgYGFsc2EtaW5m
by1zbjYyNHgtMjAyNjA4MjUudHh0YC4NClthbHNhLWluZm8tc242MjR4LTIwMjYwODI1LnR4dF0o
aHR0cHM6Ly9naXRodWIuY29tL3VzZXItYXR0YWNobWVudHMvZmlsZXMvMzE4MTg3NjcvYWxzYS1p
bmZvLXNuNjI0eC0yMDI2MDgyNS50eHQpCgpSZXF1ZXN0IFVSTCAgIDogaHR0cHM6Ly9naXRodWIu
Y29tL2Fsc2EtcHJvamVjdC9hbHNhLXVjbS1jb25mL3B1bGwvODQ5ClBhdGNoIFVSTCAgICAgOiBo
dHRwczovL2dpdGh1Yi5jb20vYWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYvcHVsbC84NDkucGF0
Y2gKUmVwb3NpdG9yeSBVUkw6IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS11
Y20tY29uZgo=
