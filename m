Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3D4CD98DA
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Jun 2026 03:17:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 56B22601FD;
	Tue, 16 Jun 2026 05:17:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 56B22601FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781579846;
	bh=DHUomAc72KKStSczHmsvZgox7vZZWIQibkFNSJoLwn0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=nJXTisIbloFUADsOYbAdvoVgH/hADIkwv48HV1fnoffE0RS8xnmaQnenLT28pO2vG
	 dBUCVqhYskJjAkj0zhLzWDVDCQ7px+BLJdZPXlAhFfz7NviRcwYek82Wl3R1yavy2z
	 CzUV8aivyvDo5ot1WKXdBm5+1nuZ30//qgiL1uC8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 322FBF805F6; Tue, 16 Jun 2026 05:16:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 82020F805F6;
	Tue, 16 Jun 2026 05:16:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 06C63F80495; Tue, 16 Jun 2026 05:16:44 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781579803;
	b=e6rDP4oe7t4xWB9+hkjgYUEphZAb5k0K/HH55IfR+KcsUu8+kg2UN9nWsf0/06FIBlg/
	 V4ko7WGC9ZldjSkHlupHaB9p/p84bMxPpe5idlf9Q9UIFkfcn8r22vG5Yk46ikLHjd04i
	 VlSfVXT73NUDDJQW64/FIKYVW2PwaZE2EHus/Zb4khUK56DHu6iFzjJaspmWNAm5unfuj
	 TMPxFDRvist1b9JicpJaQJXJjqUg5P0Jih4LR7oeX72pSttChjpJDO0hm7ifncVLvFeoj
	 MQ0xwCPpggkh+cEGYZKYYPA8HhSWD/9OPMGbbFaJlbX5CerdesyTeK9vyB64OLArm3Q==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781579803;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=DHUomAc72KKStSczHmsvZgox7vZZWIQibkFNSJoLwn0=;
	b=QyA14261358d3uVLBn5P7cr/5625DDRl/mFe+GAOAm7uowiDgP7nrPTRhjwawoHnRGTH
	 +klohsqxEydNal8ycT/dhvju9FUD3+Z/YV5D/t95fapJkfxceHu1mJE6xvMNaEU54qzej
	 Xe5UsMsBaRroHECpgjWXHviYqjTlHabm/iMD+xNHMvccNSZTCpwmngb7CTW2O7pGMgA4x
	 CWJhTdoard2iqlCzhrWWTIuFUjz+6JbyIRQY5tIEzeOOog0JMOCdZ9pMbn/+jz8fBvtk4
	 VtfhoB9kq1/MvCRrpYkRHe17r5zCO5o8hmMPdtxYVPFywTkSBp4MYcOeWJpx8lpL81w==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 1363AF80038
	for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2026 05:16:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1363AF80038
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b97163ee0fbb00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/792@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/792@alsa-project.org>
Subject: HDA: Fix internal mic availability for HDA codecs with phantom jack
Date: Tue, 16 Jun 2026 05:16:44 +0200 (CEST)
Message-ID-Hash: RMKDRVMTF6INUWQ5SRJHC47WPWG6DXAQ
X-Message-ID-Hash: RMKDRVMTF6INUWQ5SRJHC47WPWG6DXAQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RMKDRVMTF6INUWQ5SRJHC47WPWG6DXAQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgcHVsbCByZXF1ZXN0ICM3OTIgd2FzIG9wZW5lZCBm
cm9tIHJ3ZWt5ZXM6CgojIyBQcm9ibGVtDQoNCk9uIEhEQSBjb2RlY3MgdGhhdCBoYXZlIGJvdGgg
YSBgTWljIEphY2tgIChleHRlcm5hbCwgdW5wbHVnZ2VkKSBhbmQgYW4gDQpgSW50ZXJuYWwgTWlj
IFBoYW50b20gSmFja2AgKGZpeGVkLCBhbHdheXMtb24pIGNvbnRyb2wsIHRoZSBpbnRlcm5hbCAN
Cm1pY3JvcGhvbmUgZ2V0cyBhc3NpZ25lZCBgTWljIEphY2tgIGFzIGl0cyBKYWNrQ29udHJvbC4g
UGlwZVdpcmUgbW9uaXRvcnMgDQp0aGlzIGNvbnRyb2wgZm9yIGF2YWlsYWJpbGl0eSBhbmQgbWFy
a3MgdGhlIGludGVybmFsIG1pYyBhcyAibm90IGF2YWlsYWJsZSIgDQpzaW5jZSB0aGUgZXh0ZXJu
YWwgamFjayBpcyB1bnBsdWdnZWQsIG1ha2luZyBpdCBpbnZpc2libGUgdG8gYnJvd3NlcnMgYW5k
IA0KYXBwbGljYXRpb25zLg0KDQpDb25maXJtZWQgb246IExlbm92byBJZGVhUGFkIFNsaW0gNSAx
NkFLUDEwIHdpdGggQ29uZXhhbnQgU042MTQwIGNvZGVjIA0KKFBDSSBTU0lEIDE3YWE6MzhiNiku
DQoNCiMjIEZpeA0KDQpBZGQgYSBibG9jayBpbW1lZGlhdGVseSBiZWZvcmUgdGhlIGBIREFDYXB0
dXJlRGV2aWNlYCBtYWNybyBjYWxsIHRoYXQgDQpvdmVycmlkZXMgYERldmljZU1pY0phY2tgIHRv
IHVzZSBgSW50ZXJuYWwgTWljIFBoYW50b20gSmFja2Agd2hlbiB0aGF0IA0KY29udHJvbCBleGlz
dHMuIFNpbmNlIHBoYW50b20gamFja3MgYWx3YXlzIHJlcG9ydCBhcyBjb25uZWN0ZWQsIFBpcGVX
aXJlIA0KY29ycmVjdGx5IG1hcmtzIHRoZSBpbnRlcm5hbCBtaWMgYXMgYXZhaWxhYmxlLg0KDQpU
aGUgY29uZGl0aW9uIGlzIHNhZmUgZm9yIG90aGVyIGhhcmR3YXJlIOKAlCBpZiBubyBgSW50ZXJu
YWwgTWljIFBoYW50b20gSmFja2AgDQpjb250cm9sIGV4aXN0cywgdGhlIGJsb2NrIGhhcyBubyBl
ZmZlY3QuDQoNCiMjIEtub3duIGxpbWl0YXRpb24NCg0KVGhpcyBmaXggcmVxdWlyZXMgVUNNIHRv
IGJlIGxvYWRlZCBmb3IgdGhlIGNhcmQuIE9uIG5vbi1BQ1AgSERBIGNhcmRzLCANCmBIREEtSW50
ZWwuY29uZmAgZG9lcyBub3QgY3VycmVudGx5IGFjdGl2YXRlIFVDTSwgcmVxdWlyaW5nIGEgDQpt
YWNoaW5lLXNwZWNpZmljIHdvcmthcm91bmQuIEEgY29tcGFuaW9uIGZpeCB0byBgSERBLUludGVs
LmNvbmZgIGlzIG5lZWRlZCANCmJ1dCBoYXMgbm90IGJlZW4gdGVzdGVkIGJyb2FkbHkgZW5vdWdo
IHRvIGluY2x1ZGUgaGVyZSDigJQgaW5wdXQgZnJvbSANCm1haW50YWluZXJzIG9uIHRoZSByaWdo
dCBhcHByb2FjaCB3b3VsZCBiZSB3ZWxjb21lLg0KDQojIyBSZWxhdGVkDQoNCkEgY29tcGFuaW9u
IGtlcm5lbCBwYXRjaCBhZGRpbmcgYSBwaW4gY29uZmlnIHF1aXJrIGZvciB0aGUgU042MTQwIG9u
IHRoaXMgDQpoYXJkd2FyZSBoYXMgYmVlbiBzdWJtaXR0ZWQgdG8gYWxzYS1kZXZlbEBhbHNhLXBy
b2plY3Qub3JnLgoKUmVxdWVzdCBVUkwgICA6IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNhLXByb2pl
Y3QvYWxzYS11Y20tY29uZi9wdWxsLzc5MgpQYXRjaCBVUkwgICAgIDogaHR0cHM6Ly9naXRodWIu
Y29tL2Fsc2EtcHJvamVjdC9hbHNhLXVjbS1jb25mL3B1bGwvNzkyLnBhdGNoClJlcG9zaXRvcnkg
VVJMOiBodHRwczovL2dpdGh1Yi5jb20vYWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYK
