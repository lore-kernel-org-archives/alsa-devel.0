Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9626C5B567
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Aug 2026 19:33:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0F50B60200;
	Mon, 10 Aug 2026 21:33:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0F50B60200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786390402;
	bh=SkzHmdL7s7747iJKmrhIAoO0993oH45iWa4SKbGKCDM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=GycH2FMyFKMROM441Z2QDn/oTqW0i7uyvjbkVDp+YNh1No/vPX6F74Xt7f6FbEubF
	 ZRu5RSVhuKOvM1jOSOwJliw7ykdwdUg/IaEAdMF4ai6Q6zVQunlNfRkT2rtY80Hcv6
	 BzKktshYj4fOWMOlFPT09c+YjFJtnrIUqt5okOCQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5D426F80600; Mon, 10 Aug 2026 21:32:46 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1245DF8010B;
	Mon, 10 Aug 2026 21:32:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 40A13F8051F; Mon, 10 Aug 2026 21:32:40 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786390356;
	b=lmsXEMQUqWxTGkU1+fsCDFcU+l8zsMzUlK7ztAKeoWPsGRCEqeN5f91/kQHCOx8Xwe/v
	 uOXud5tK2s3dPzfF1PaBg1Z9majhx06RyzAjhbQnWJLtUXaBp883gfH5yH7z4bxQLLkBy
	 kmTMB/rhC3/PmcMCprceMA9TzeKAwtVRf9RZdLkvH/CXoAyZSiV80lAlG7dy5Cbpado2M
	 GclDXB/Z2VlSAvBL3l8vd78HqJO1xI/xziKr4q/svJzG+iCgj4JKvoEYrpxGb7Fr/8mU3
	 +13zGmD6Xe0kXTR4847NW+tc4/ZcLJg5LyC0VcztF/ZDgImiPNrreUO9cWZHcZnx5Ag==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786390356;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=SkzHmdL7s7747iJKmrhIAoO0993oH45iWa4SKbGKCDM=;
	b=VSh1oy3P87eOOTmyuu3MeN94xlBmkijY26Dyo3hpCuovQ9KTTEGDTTlI266W4H+CIwZE
	 lSdyC6LegUPQP178youpkd+Q1oDdv5bH3OTov2bv9PWptvzyZFkqX4uZpgMbt76+bWmKQ
	 2kzAgyiR0iSY9wZRl0eYqnSzuugTMEL/x557tfjo37CV9jNNsN7OHF/H5caA4Ud4jjdU9
	 mR/0nH/GGsJwuCNatheoUj+exaRmpEMgDjAbaPg0yqxPbxQO1iqAcGFoumLWR4TWWp0eZ
	 zwLJzCbJvEcufvnTVamfH2sbAtL4XaG+rcEt1C7f2sswcMFCmbdnK/Y7C2T2dWHHQ0w==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id DF73FF800BD
	for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2026 21:32:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DF73FF800BD
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18ca88900f4c2500-webhooks-bot@alsa-project.org>
In-Reply-To: <18ca88900f246a00-webhooks-bot@alsa-project.org>
References: <18ca88900f246a00-webhooks-bot@alsa-project.org>
Subject: Missing UCM profile for Realtek ALC4082 USB Audio (26ce:0a08) causing
 whole-card dropout
Date: Mon, 10 Aug 2026 21:32:40 +0200 (CEST)
Message-ID-Hash: NEJBYWOXNPIUN66Z5OCRPERGDDCEC7IB
X-Message-ID-Hash: NEJBYWOXNPIUN66Z5OCRPERGDDCEC7IB
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NEJBYWOXNPIUN66Z5OCRPERGDDCEC7IB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgaXNzdWUgIzgyOSB3YXMgb3BlbmVkIGZyb20gVElC
SUxMOgoKKipEZXZpY2U6KiogUmVhbHRlayBBTEM0MDgyIFVTQiBBdWRpbyBjb2RlYywgVVNCIElE
IDI2Y2U6MGEwOAoqKk1vdGhlcmJvYXJkOioqIEFTUm9jayBYODcwIFN0ZWVsIExlZ2VuZCBXaUZp
CioqRGlzdHJvOioqIENhY2h5T1MgKEFyY2gtYmFzZWQpLCBrZXJuZWwgNy4wLngKKiphbHNhLXVj
bS1jb25mIHZlcnNpb246KiogMS4yLjE2LTIKKipQaXBlV2lyZToqKiAxLjYuNiwgV2lyZVBsdW1i
ZXIgMC41LjE0CgoqKlByb2JsZW06KioKTm8gVUNNIHByb2ZpbGUgZXhpc3RzIGZvciAyNmNlOjBh
MDguIFRoZSBkZXZpY2UgZmFsbHMgYmFjayB0byBhIGdlbmVyaWMgbXVsdGktZGV2aWNlIHByb2Zp
bGUgZXhwb3NpbmcgNCBzZXBhcmF0ZSBQQ00gcGxheWJhY2sgZGV2aWNlcyAoU1BESUYsIFNwZWFr
ZXIgOGNoLCBIZWFkcGhvbmVzLCBNaWMpLCBzaG93biBhcyBzcGxpdCBzaW5rcyAoSGlGaV83XzFf
X1NQRElGX19zaW5rLCBIaUZpXzdfMV9fU3BlYWtlcl9fc2luaywgSGlGaV83XzFfX0hlYWRwaG9u
ZXNfX3NpbmspIGluc3RlYWQgb2Ygb25lIGNsZWFuIGNhcmQgcHJvZmlsZS4KCk9ubHkgb25lIFBD
TSAoZGV2aWNlIDMsIFMvUERJRiBvdXRwdXQpIGlzIGFjdHVhbGx5IHVzZWQuIFRoZSBtaXhlciBj
b25maXJtcyBvbmx5IG9uZSBQQ00gUGxheWJhY2sgU3dpdGNoIGlzIGVuYWJsZWQ6ClBDTSBQbGF5
YmFjayBTd2l0Y2ggOiBvZmYKUENNIFBsYXliYWNrIFN3aXRjaCxpbmRleD0xIDogb2ZmClBDTSBQ
bGF5YmFjayBTd2l0Y2gsaW5kZXg9MiA6IG9uIDwtIHRoZSBvbmUgaW4gdXNlIChTL1BESUYpCgoq
KlN5bXB0b206KioKVW5kZXIgbm9ybWFsIHVzZSAoYnJvd3NlciB2aWRlbywgZXNwZWNpYWxseSB0
cmFuc2l0aW9uaW5nIGJldHdlZW4gdmlkZW9zL2VwaXNvZGVzIG9uIHN0cmVhbWluZyBzaXRlcyks
IHRoZSBjYXJkIGludGVybWl0dGVudGx5IGdldHMgYWJhbmRvbmVkIGJ5IFBpcGVXaXJlIGFuZCBm
YWxscyBiYWNrIHRvIGF1dG9fbnVsbC4gQ29uZmlybWVkIE5PVCBhIGhhcmR3YXJlL1VTQiBkaXNj
b25uZWN0IOKAlCBkbWVzZyBzaG93cyBubyBkaXNjb25uZWN0IGV2ZW50IGZvciB0aGlzIGRldmlj
ZSBkdXJpbmcgdGhlIGZyZWV6ZS4gTG9ncyBhdCB0aGUgZnJlZXplIG1vbWVudCBzaG93OgpbRVJS
T1I6Y2hyb21pdW0vbWVkaWEvYXVkaW8vcHVsc2UvcHVsc2VfdXRpbC5jYzozODRdIHBhX29wZXJh
dGlvbiBpcyBudWxscHRyLgpbRVJST1I6Y2hyb21pdW0vc2VydmljZXMvYXVkaW8vb3V0cHV0X2Rl
dmljZV9taXhlcl9pbXBsLmNjOjE3M10gTWl4YWJsZU91dHB1dFN0cmVhbTogRXJyb3IgZHVyaW5n
IGluZGVwZW5kZW50IHBsYXliYWNrCgpmb2xsb3dlZCBieSBLREUgY29tcG9uZW50cyByZXBvcnRp
bmcgYE5vIG9iamVjdCBmb3IgbmFtZSAiYXV0b19udWxsImAuCgpPbmx5IGZpeCBpcyBhIGZ1bGwg
UGlwZVdpcmUvV2lyZVBsdW1iZXIgcmVzdGFydCAoYHN5c3RlbWN0bCAtLXVzZXIgcmVzdGFydCBw
aXBld2lyZSBwaXBld2lyZS1wdWxzZSB3aXJlcGx1bWJlcmApLCB3aGljaCByZWNvdmVycyBpdCBl
dmVyeSB0aW1lLgoKQXR0ZW1wdGluZyBgYXBpLmFsc2EudXNlLXVjbSA9IGZhbHNlYCAoZGlzYWJs
aW5nIFVDTSBlbnRpcmVseSkgcmVzdWx0cyBpbiBjb21wbGV0ZSBsb3NzIG9mIFMvUERJRiBvdXRw
dXQg4oCUIHNvIHRoZSBkZXZpY2UgcmVxdWlyZXMgU09NRSBVQ00gcHJvZmlsZSB0byBmdW5jdGlv
biBhdCBhbGwsIGJ1dCB0aGUgY3VycmVudCBnZW5lcmljIGZhbGxiYWNrIGFwcGVhcnMgdW5zdGFi
bGUsIGxpa2VseSBiZWNhdXNlIFBpcGVXaXJlIGFiYW5kb25zIHRoZSB3aG9sZSBjYXJkIHdoZW4g
b25lIG9mIHRoZSAzIHVudXNlZCBQQ00gZW5kcG9pbnRzIGZhaWxzIHRvIHByZXBhcmUgKHBvc3Np
Ymx5IHJlbGF0ZWQgdG8gUGlwZVdpcmUgaXNzdWUgIzQ5MzgpLgoKKipSZXF1ZXN0OioqIGEgcHJv
cGVyIFVDTSBwcm9maWxlIGZvciAyNmNlOjBhMDggdGhhdCBvbmx5IGV4cG9zZXMgdGhlIHdvcmtp
bmcgUENNIGRldmljZSAoZGV2aWNlIDMgLyBTL1BESUYpLCBzbyB0aGUgdW51c2VkIFNwZWFrZXIv
SGVhZHBob25lcy9NaWMgZW5kcG9pbnRzIGFyZW4ndCBwcm9iZWQgYW5kIGNhbid0IHRha2UgdGhl
IHdob2xlIGNhcmQgZG93bi4KCioqYWxzYS1pbmZvLnNoIG91dHB1dDoqKiBbaHR0cHM6Ly90ZXJt
YmluLmNvbS9jcGRuc10KCklzc3VlIFVSTCAgICAgOiBodHRwczovL2dpdGh1Yi5jb20vYWxzYS1w
cm9qZWN0L2Fsc2EtdWNtLWNvbmYvaXNzdWVzLzgyOQpSZXBvc2l0b3J5IFVSTDogaHR0cHM6Ly9n
aXRodWIuY29tL2Fsc2EtcHJvamVjdC9hbHNhLXVjbS1jb25mCg==
