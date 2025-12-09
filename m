Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E7CD3B98A
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Dec 2025 18:33:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 55620601F9;
	Tue,  9 Dec 2025 19:33:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 55620601F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1765305236;
	bh=WzHtJbzTxMlkFLadEZaQCXNXNIKeRHvcjxfiuUWKeZ4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=CI0NaDXrRfHekP0XdI52/YQGYbl904qc8onluu4Tmth+wIOlnx0ef455nsfl0/3jb
	 CqOabP35NY0KYv59wyQ5NQV05IEwsKhCVoCI8dl/CCHC/ENpe4FEEa+ulWo7hVR7UB
	 cA4WQfpaUlcjJv00+lETys9kZwMT4J2aMxaG1ySs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 13E31F805D9; Tue,  9 Dec 2025 19:33:20 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A1926F805D2;
	Tue,  9 Dec 2025 19:33:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AB680F8028B; Tue,  9 Dec 2025 19:33:14 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 07F02F800B8
	for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2025 19:33:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 07F02F800B8
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <187f9fb84506e700-webhooks-bot@alsa-project.org>
In-Reply-To: <187f9fb844944100-webhooks-bot@alsa-project.org>
References: <187f9fb844944100-webhooks-bot@alsa-project.org>
Subject: alsa-lib-1.2.15: no sound
Date: Tue,  9 Dec 2025 19:33:14 +0100 (CET)
Message-ID-Hash: I77V4VQ6WDIEU2WGCEJC2QNF3ON6TL6C
X-Message-ID-Hash: I77V4VQ6WDIEU2WGCEJC2QNF3ON6TL6C
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/I77V4VQ6WDIEU2WGCEJC2QNF3ON6TL6C/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtbGliIGlzc3VlICM0ODggd2FzIG9wZW5lZCBmcm9tIGFuZHJleWdy
b3ppbjoKCkFmdGVyIHVwZ3JhZGluZyBhbHNhLWxpYiB0byAxLjIuMTUgSSBnZXQKCmdyb3ppbkBs
b2NhbGhvc3QgL2hvbWUvTXVzaWMgJCBxbW1wIDxzb25nPi5tcDMKQUxTQSBsaWIgL3Zhci90bXAv
cG9ydGFnZS9tZWRpYS1saWJzL2Fsc2EtbGliLTEuMi4xNS93b3JrL2Fsc2EtbGliLTEuMi4xNS9z
cmMvcGNtL3BjbS5jOjI3MjI6KHNuZF9wY21fb3Blbl9ub3VwZGF0ZSkgW2Vycm9yLnBjbV0gVW5r
bm93biBQQ00gY2FyZHMucGNtLmRlZmF1bHQKT3V0cHV0QUxTQTo6aW5pdGlhbGl6ZTogZXJyb3Ig
b3BlbmluZyBQQ00gZGV2aWNlIGRlZmF1bHQKT3V0cHV0V3JpdGVyOjppbml0aWFsaXplOiB1bmFi
bGUgdG8gaW5pdGlhbGl6ZSBvdXRwdXQKCmFuZCBubyBzb3VuZC4gU2ltaWxhcmx5LAoKZ3Jvemlu
QGxvY2FsaG9zdCAvaG9tZS9NdXNpYyAkIG1wdiA8c29uZz4ubXAzCltmZm1wZWcvZGVtdXhlcl0g
bXAzOiBFc3RpbWF0aW5nIGR1cmF0aW9uIGZyb20gYml0cmF0ZSwgdGhpcyBtYXkgYmUgaW5hY2N1
cmF0ZQril48gQXVkaW8gIC0tYWlkPTEgIChtcDMgMmNoIDQ0MTAwIEh6IDE5MiBrYnBzKQpGaWxl
IHRhZ3M6CiBHZW5yZTogT3RoZXIKQUxTQSBsaWIgL3Zhci90bXAvcG9ydGFnZS9tZWRpYS1saWJz
L2Fsc2EtbGliLTEuMi4xNS93b3JrL2Fsc2EtbGliLTEuMi4xNS9zcmMvcGNtL3BjbS5jOjI3MjI6
KHNuZF9wY21fb3Blbl9ub3VwZGF0ZSkgW2Vycm9yLnBjbV0gVW5rbm93biBQQ00gY2FyZHMucGNt
LmRlZmF1bHQKW2FvL2Fsc2FdIFBsYXliYWNrIG9wZW4gZXJyb3I6IE5vIHN1Y2ggZmlsZSBvciBk
aXJlY3RvcnkKW2FvXSBGYWlsZWQgdG8gaW5pdGlhbGl6ZSBhdWRpbyBkcml2ZXIgJ2Fsc2EnCgpD
b3VsZCBub3Qgb3Blbi9pbml0aWFsaXplIGF1ZGlvIGRldmljZSAtPiBubyBzb3VuZC4KCkF1ZGlv
OiBubyBhdWRpbwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKRXhpdGluZy4uLiAoRXJyb3JzIHdoZW4g
bG9hZGluZyBmaWxlKQoKQWZ0ZXIgZG93bmdyYWRpbmcgYWxzYS1saWIgdG8gMS4yLjE0IGV2ZXJ5
dGhpbmcgd29ya3MgZmluZSBhZ2Fpbi4gVGhpcyBpcyBvbiBHZW50b28gTGludXgsIHNlZSB0aGUg
R2VudG9vIGJ1ZyBodHRwczovL2J1Z3MuZ2VudG9vLm9yZy85NjcyNjQKCklzc3VlIFVSTCAgICAg
OiBodHRwczovL2dpdGh1Yi5jb20vYWxzYS1wcm9qZWN0L2Fsc2EtbGliL2lzc3Vlcy80ODgKUmVw
b3NpdG9yeSBVUkw6IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS1saWIK
