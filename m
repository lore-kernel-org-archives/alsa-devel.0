Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2060A606A31E
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=S6XSrdsM
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DBA916021D;
	Thu, 26 Nov 2026 15:06:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DBA916021D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1795701987;
	bh=m4zb4dG7/TZV/8Zv47gZbTfYlq1EG+l9uvQvEi2Hfv8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=S6XSrdsMFfw0XHJE7liqznU5Toz5k/B7aUY9lbjmn+csiHGvfjSmKmgzrwWZFccnh
	 yJZyeggoh7J4EZW8nmBPO2zGQOrxIUBn4/DVRi35Zx+5XfV+ucdojrPrZKb9BW0FBo
	 dwKtwZ/xpxBuv3XM1y1eSJ5r2MmL9qTJsNWI1tCA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 042E7F80601; Thu, 26 Nov 2026 15:05:54 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5D1FCF805F4;
	Thu, 26 Nov 2026 15:05:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 962F2F8051E; Thu, 26 Nov 2026 15:05:46 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1795701945;
	b=XeQOhSJzzmeOtVaONsSuDKllNjBLLj2IKlzFyClHXDN+sTNdjTp+U7KkoGnjC+E/WKTj
	 0WUkZIG2s3y1ATcbbI3k+wd9qliB8Tf3j2nLe49YEViXt2LiFPYz59uzjRprp4AKGpkCt
	 +73z/DdoRkBYxexamWnZHB/NETd/A5lyE35ltrdnjaRJmihsNo/pdjKrR5+aWEDWvSB8o
	 DqW/8jTIyWjejKWRPf72EwVdWiAjHPgGnJlApC3fp18WXqcD59rUT5dqjYwxnj1v//qaE
	 QkO5xRBruu5Tv+axVzJbxHMZF873Lt8Uc/LMOrSMDSenEt90QhkdDqY2U4H50GsC0BQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1795701945;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=m4zb4dG7/TZV/8Zv47gZbTfYlq1EG+l9uvQvEi2Hfv8=;
	b=dcNYLpt6BIBpWpIOUcVNZGroCxa0O7u6SYma/u5aZ5CXz3jOi9KXE7pKGBxY6KiBHLXT
	 RvnNA2LwrCdKgZdNGsKr1H8PSpE8SaPtiQi6T71dqlFu+ONBLi9+RP3U4rRUjA6UbNgUO
	 mv+TZOP18OIH/iy+7lvExUM1vrC65YCvRK8bcduxbEj05uOaz+wFg88EVb4DxsfoTi/pW
	 vuzvJsD0wA4RBXtXN6fvjfvChsYq1EXFWvl/YpZIjEJvzG0q10vEy0JiFT+qXlSxPpB3m
	 +Giu0e1EuuIVW+Lu815+620OnK8cKrxafAO5ibjZ7WYyhz0tnK6n/qJQsPhGMuy+Wlg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 31A88F80100
	for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2026 15:05:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 31A88F80100
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18eb9d65100a4200-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/914@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/914@alsa-project.org>
Subject: sof-soundwire: es9356: default the DMIC gain to +12 dB
Date: Thu, 26 Nov 2026 15:05:46 +0100 (CET)
Message-ID-Hash: 5VI5KTU4VDE3J27MU7Z5O2EPCCU3UYAR
X-Message-ID-Hash: 5VI5KTU4VDE3J27MU7Z5O2EPCCU3UYAR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5VI5KTU4VDE3J27MU7Z5O2EPCCU3UYAR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgcHVsbCByZXF1ZXN0ICM5MTQgd2FzIGVkaXRlZCBm
cm9tIGthbm5veTIwMjQ6CgpQb2ludCB0aGUgRVM5MzU2IGludGVybmFsIG1pY3JvcGhvbmUgYXQg
aXRzIGhhcmR3YXJlIGNhcHR1cmUgZ2Fpbi4NCg0KIyMjIFByb2JsZW0NCg0KVGhlIEVTOTM1NiBE
TUlDIGdhaW4gY29udHJvbCAoYGVzOTM1NiBGVTExIENhcHR1cmUgVm9sdW1lYCkgaGFzIGZvdXIg
NiBkQg0Kc3RlcHMgKDAvNi8xMi8xOCBkQikgYW5kIGlzIGxlZnQgYXQgMCBkQiwgd2hpY2ggaXMg
dG9vIHF1aWV0IGZvciBub3JtYWwNCnJlY29yZGluZ3M6IHRoZSByZWNvcmRlZCB2b2ljZSBzaXRz
IHdlbGwgYmVsb3cgdGhlIG5vaXNlIGZsb29yLCBhbmQgdGhlDQppbnRlcm5hbCBtaWNyb3Bob25l
IGlzIHVudXNhYmxlIHVudGlsIHRoZSBtaXhlciBpcyBhZGp1c3RlZCBieSBoYW5kLg0KDQojIyMg
Q2hhbmdlDQoNCkFkZCBgQ2FwdHVyZU1peGVyRWxlbWAgdG8gdGhlIGBNaWNgIGRldmljZSBpbiBg
c29mLXNvdW5kd2lyZS9lczkzNTYuY29uZmAsIHNvDQpQaXBlV2lyZSBjYW4gY29udHJvbCB0aGUg
aGFyZHdhcmUgY2FwdHVyZSBnYWluIGRpcmVjdGx5IGluc3RlYWQgb2YgVUNNDQp3cml0aW5nIGEg
Zml4ZWQgdmFsdWUuICBUaGlzIGZvbGxvd3MgdGhlIHBhdHRlcm4gdXNlZCBieSBvdGhlciBjb2Rl
Y3MgKGZvcg0KZXhhbXBsZSBgY29kZWNzL2NzNDJsNDMtZG1pYy5jb25mYCB1c2VzIGBDYXB0dXJl
TWl4ZXJFbGVtICJjczQybDQzIE1pY3JvcGhvbmUiYCkuDQoNCnwgZmlsZSB8IGNoYW5nZSB8DQp8
LS0tfC0tLXwNCnwgYHVjbTIvc29mLXNvdW5kd2lyZS9lczkzNTYuY29uZmAgfCBgTWljYDogYWRk
IGBDYXB0dXJlTWl4ZXJFbGVtICJlczkzNTYgRlUxMSJgIHwNCg0KIyMjIFRlc3RpbmcNCg0KTUVD
SFJFVk8gV1VKSUUgMTRTQUggKEFNRCBBQ1A2LjMsIEVTOTM1NiBvbiBTb3VuZFdpcmUgbGluayAw
KSwga2VybmVsIDcuMi45Og0KDQotIGB3cGN0bCBzZXQtdm9sdW1lIEBERUZBVUxUX0FVRElPX1NP
VVJDRUAgMS4wMGAg4oaSIGBhbWl4ZXIgLWMgMSBjZ2V0IG51bWlkPTEwYCDihpIgYDogdmFsdWVz
PTNgIChtYXggZ2FpbikNCi0gYHdwY3RsIHNldC12b2x1bWUgQERFRkFVTFRfQVVESU9fU09VUkNF
QCAwLjMwYCDihpIgYDogdmFsdWVzPTBgDQoNClNvIHRoZSBoYXJkd2FyZSBjb250cm9sIGZvbGxv
d3MgdGhlIFBpcGVXaXJlIHZvbHVtZS4gIFRoZSBjb2Fyc2UgbWFwcGluZyByaWdodA0Kbm93IGlz
IGJlY2F1c2UgdGhpcyB0cmVlIHN0aWxsIGhhcyB0aGUgb2xkIFRMViBzdGVwICgwLjA2IGRCIGlu
c3RlYWQgb2YgNiBkQik7DQp3aXRoIGA0MTJhMDYxZWJmOGNgICgiZml4IHRoZSBjYXB0dXJlIGdh
aW4gZEIgc2NhbGUiLCBpbiA3LjQgYW5kIHF1ZXVlZCBmb3INCjcuMy1zdGFibGUpIHRoZSBwZXJj
ZW50YWdlcyBtYXAgcHJvcG9ydGlvbmFsbHkuICBSZWNvcmRpbmcgc3RpbGwgd29ya3MuDQoNClJl
bGF0ZWQ6IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvYnJvb25pZS9zb3VuZC9jLzQxMmEwNjFlYmY4
Yw0KDQpTaWduZWQtb2ZmLWJ5OiBaYWNoYXJ5IEh1YW5nIDx6dXpoZW5odWFuZzM2NUBnbWFpbC5j
b20+CgpSZXF1ZXN0IFVSTCAgIDogaHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJvamVjdC9hbHNh
LXVjbS1jb25mL3B1bGwvOTE0ClBhdGNoIFVSTCAgICAgOiBodHRwczovL2dpdGh1Yi5jb20vYWxz
YS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYvcHVsbC85MTQucGF0Y2gKUmVwb3NpdG9yeSBVUkw6IGh0
dHBzOi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS11Y20tY29uZgo=
