Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE12FF6E9F
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Mar 2026 23:53:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 91E11601FD;
	Wed, 18 Mar 2026 00:52:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 91E11601FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1773791588;
	bh=sPTJcv70Yp5OCzmWytDDdwUqj00PxHRHYiuVhoGJFps=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=FpHMc1vzhR8U4+EWwdYHhVWqiDxB9sOZAdXIAAFngvifccuXxz4PDW0Q20/1uD+qL
	 ga262BxS22kFx6KmO/vgO+4VVhVJYW4oEp7HKJYQixAgZiJgyd76kBOzykZP1G0d/O
	 6d5Kgt3d9UEM2XhOD+BIpEQXwL+VyV7VcHJ5ki9g=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F0346F805F8; Wed, 18 Mar 2026 00:52:31 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5C048F805F4;
	Wed, 18 Mar 2026 00:52:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A6771F80553; Wed, 18 Mar 2026 00:52:22 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id E8296F8001F
	for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2026 00:52:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E8296F8001F
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <189dc602196b7000-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/725@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/725@alsa-project.org>
Subject: ucm2: Qualcomm: add ASUS Vivobook 14 (X1407QA) to x1e80100 DMI match
Date: Wed, 18 Mar 2026 00:52:22 +0100 (CET)
Message-ID-Hash: FQWGHDRC5NWHWEKFQYHQHJSRNTJRF2RX
X-Message-ID-Hash: FQWGHDRC5NWHWEKFQYHQHJSRNTJRF2RX
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FQWGHDRC5NWHWEKFQYHQHJSRNTJRF2RX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgcHVsbCByZXF1ZXN0ICM3MjUgd2FzIG9wZW5lZCBm
cm9tIHBpcjBjMHB0ZXIwOgoKVGhlIEFTVVMgVml2b2Jvb2sgMTQgWDE0MDdRQSAoU25hcGRyYWdv
biBYIFgxLTI2LTEwMCwgeDFwNDIxMDAgIlB1cndhIiBkaWUpCnJlcG9ydHMgYHByb2R1Y3RfZmFt
aWx5YCBhcyBgQVNVUyBWaXZvYm9vayAxNGAgYnV0IHdhcyBub3QgbWF0Y2hlZCBieSB0aGUKZXhp
c3RpbmcgcmVnZXggaW4gYHgxZTgwMTAwLmNvbmZgLCBsZWF2aW5nIGF1ZGlvIG5vbi1mdW5jdGlv
bmFsIG9uIHRoaXMgZGV2aWNlLgoKVGhlIGF1ZGlvIGhhcmR3YXJlIGlzIGlkZW50aWNhbCB0byB0
aGUgb3RoZXIgQVNVUyBTbmFwZHJhZ29uIFggZGV2aWNlcyBhbHJlYWR5Cm1hdGNoZWQgYnkgdGhl
IGBMRU5PVk9UMTRzYCBibG9jazogV0NEOTM4NSBjb2RlYyArIDLDlyBXU0E4ODR4IHNwZWFrZXJz
IHZpYQpTb3VuZFdpcmUsIGRyaXZlbiBieSB0aGUgQURTUCBRNkFQTSBzdWJzeXN0ZW0uIFRoZSBl
eGlzdGluZyBMRU5PVk8tVDE0cy5jb25mCmNvbmZpZ3VyYXRpb24gd29ya3MgY29ycmVjdGx5IG9u
Y2UgdGhlIGRldmljZSBpcyBtYXRjaGVkLgoKKipETUkgc3RyaW5ncyByZXBvcnRlZCBieSB0aGUg
ZGV2aWNlOioqCmBgYApib2FyZF92ZW5kb3I6ICAgQVNVU1RlSyBDT01QVVRFUiBJTkMuCmJvYXJk
X25hbWU6ICAgICBYMTQwN1FBCnByb2R1Y3RfZmFtaWx5OiBBU1VTIFZpdm9ib29rIDE0CnByb2R1
Y3RfbmFtZTogICBBU1VTIFZpdm9ib29rIDE0IFgxNDA3UUFfWDE0MDdRQQpgYGAKCioqQ2hhbmdl
OioqIGFkZCBgVml2b2Jvb2sgMTRgIHRvIHRoZSBBU1VTIGFsdGVybmF0aW9uIGdyb3VwIGFsb25n
c2lkZQpgWmVuYm9vayBBMTRgLCBgVml2b2Jvb2sgUyAxNWAsIGFuZCBgVml2b2Jvb2sgMTZgLgoK
VGVzdGVkIG9uIEZlZG9yYSA0NCBhYXJjaDY0LCBrZXJuZWwgNi4xMiwgYWxzYS1saWIgMS4yLngu
CgpSZXF1ZXN0IFVSTCAgIDogaHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJvamVjdC9hbHNhLXVj
bS1jb25mL3B1bGwvNzI1ClBhdGNoIFVSTCAgICAgOiBodHRwczovL2dpdGh1Yi5jb20vYWxzYS1w
cm9qZWN0L2Fsc2EtdWNtLWNvbmYvcHVsbC83MjUucGF0Y2gKUmVwb3NpdG9yeSBVUkw6IGh0dHBz
Oi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS11Y20tY29uZgo=
