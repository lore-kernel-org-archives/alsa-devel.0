Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE6AFCCFA13
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Nov 2025 10:37:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E75A260207;
	Mon, 10 Nov 2025 11:37:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E75A260207
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1762771037;
	bh=LnJC7dR3ZpyTnlkBCXWUDIbX45jXlXJN9eWUYaP4/N8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=CdJEEozmUtvCf7H8zcJvsH6CZeyFBNt8DvGMzw5Pf1HdcgPCTDtgupy3oK/P1vNy/
	 kXG0iIYgHMoL9xFho8jwrlERPPhgd7US8j16r/cFx1fIVGZ49YOKtf0Lv7YcJ4ye0a
	 YO8rmgQAneDJrVgHXnZ5Ty8T3qPwAA5XW+G1a0wQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8FC90F805CB; Mon, 10 Nov 2025 11:36:41 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 41CA2F805B3;
	Mon, 10 Nov 2025 11:36:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9CAFFF80254; Mon, 10 Nov 2025 11:36:01 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id DBB62F800E4
	for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2025 11:35:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DBB62F800E4
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18769ed7cf2e2600-webhooks-bot@alsa-project.org>
In-Reply-To: <18769ed7b4994800-webhooks-bot@alsa-project.org>
References: <18769ed7b4994800-webhooks-bot@alsa-project.org>
Subject: PreSonus revelator io44 reports [ALSA UCM error]
Date: Mon, 10 Nov 2025 11:36:01 +0100 (CET)
Message-ID-Hash: FMZESYWEU3USRMPXRLYB3HPOOUPIHI6C
X-Message-ID-Hash: FMZESYWEU3USRMPXRLYB3HPOOUPIHI6C
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FMZESYWEU3USRMPXRLYB3HPOOUPIHI6C/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgaXNzdWUgIzY0MCB3YXMgb3BlbmVkIGZyb20gdGFp
d2FuZXNlLWVpcmluOgoKYHdwY3RsIHN0YXR1c2Agc2hvd3MgbWVzc2FnZXMgbGlrZToKCmBgYApB
dWRpbwog4pSc4pSAIERldmljZXM6CiDilIIgICAgICA0My4gQnVpbHQtaW4gQXVkaW8gICAgICAg
ICAgICAgICAgICAgICAgW2Fsc2FdCiDilIIgICAgICA1OC4gUmV2ZWxhdG9yIElPIDQ0IFtBTFNB
IFVDTSBlcnJvcl0gICAgW2Fsc2FdCmBgYAoKU28gZmFyIHRoZSBwbGF5YmFjayBzZWVtcyB0byBi
ZSB3b3JraW5nLiBOb3QgeWV0IHRlc3RlZCB0aGUgcmVjb3JkaW5nLgoKQXR0YWNoZWQgYGFsc2Et
aW5mby5zaGAgb3V0cHV0IGZvciBtb3JlIGRldGFpbHM6IFthbHNhLWluZm8udHh0XShodHRwczov
L2dpdGh1Yi5jb20vdXNlci1hdHRhY2htZW50cy9maWxlcy8yMzQ1MTY5Mi9hbHNhLWluZm8udHh0
KQoKSXNzdWUgVVJMICAgICA6IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS11
Y20tY29uZi9pc3N1ZXMvNjQwClJlcG9zaXRvcnkgVVJMOiBodHRwczovL2dpdGh1Yi5jb20vYWxz
YS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYK
