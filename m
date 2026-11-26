Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF640606A31C
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=Zlr1b/1J
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2D63D60227;
	Thu, 26 Nov 2026 15:07:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2D63D60227
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1795702055;
	bh=m4zb4dG7/TZV/8Zv47gZbTfYlq1EG+l9uvQvEi2Hfv8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Zlr1b/1J09tKxjzhI31fHDlVhv2zZhUr9pu33ETuEbaQm+klusLv9Jvmq/C7Nzc80
	 XWwdeti154hoMf1EEPltqaaLeI9PfM6VCI+d7nLrqg6rxpOPaqlAYHj1EnDbC1W5yu
	 pujcPMCblm6j3Ztpn+N9SBkQOkNYrNI9UTn+N7Vs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AC2E3F805F9; Thu, 26 Nov 2026 15:06:59 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 63CC7F805FF;
	Thu, 26 Nov 2026 15:06:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2A56EF8051E; Thu, 26 Nov 2026 15:06:54 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1795702013;
	b=RaQTJAtGzShh+kCHj6LW6MR02kndTlZF8S5G182O00maDp8GM6HgPHVKl9UYuXllB9SN
	 4F+Tt+HecWiScgsfLhg6s8kXwto7QAOpjjJsQCteXDqPGUyrxI+2WqUIHoEusGwr8UaNu
	 SBsYSNUizntAkV+voUE6Ln6jsPwBeLYjoCpY9gAT+35+oC6rBivNvAMPeARfe5xNA05sk
	 +JthLjgCH0DGr2LEYxpTQYPI6bYw+ZJ/W1ySFoPSWnCehf5FURL85LA9O6dAha6dgR9a0
	 LVHOjtNUcLdhQPk5LE2drI9HgID7qB4DJGVsAezQkIsnEOqeqQZFwiDPs7AJesnzegw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1795702013;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=m4zb4dG7/TZV/8Zv47gZbTfYlq1EG+l9uvQvEi2Hfv8=;
	b=AA3/LtW4v1uB3cZxN4zc8Ba3djy+hD+fSrmE4ptED75E29lRmBtwhOuEA6IyJEeI/nkG
	 3WeXmlqdgjpq11tfRCnHqFe5KOkcCwD0PVbFk1Fa9HkKenBR5tb179tRxuS6HAQaPKf91
	 7mYsj/1eeJxLudrhB4pcXdbVBp9sFMwj6u+tCfnhlzgMI2Xe2EsLj662Xp+3pba2+L+LD
	 xBu9/lqHx16DC3EU1KMcXnFnrQcq0Mg4LjjDByHsSRtLQkcuDuc7sX8pjlBAcj7z5eRfW
	 snKr4fl7DXFpfzXdY/8FJPmvXVMVEDr+U8vz6k0nNxwb9rZ02qFsJ7LQvOTV2yQu/yg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 6266AF80100
	for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2026 15:06:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6266AF80100
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18eb9d772624a400-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/914@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/914@alsa-project.org>
Subject: sof-soundwire: es9356: expose the DMIC hardware gain
Date: Thu, 26 Nov 2026 15:06:54 +0100 (CET)
Message-ID-Hash: 4EP33GNO6OQDWAMYFXBKL7QLOU5TDOVH
X-Message-ID-Hash: 4EP33GNO6OQDWAMYFXBKL7QLOU5TDOVH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4EP33GNO6OQDWAMYFXBKL7QLOU5TDOVH/>
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
