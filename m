Return-Path: <SRS0=GNy4=BY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C37BC433E1
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:30:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D77CA207DA
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="STDeeMOb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="a7TbNjMc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D77CA207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 664B8847;
	Fri, 14 Aug 2020 12:29:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 664B8847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597401007;
	bh=QnqghtOzbq3KGlzZDOOFuPYaiWSDiIunS5SQtsQzX8E=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=STDeeMObXdmUCOSlASWlP562NFWAImejwCUdRbBEmhGhSttWjHHGUXhsPyK7AoIFZ
	 EgKOnssdHNIFRqBIdRIm9oLWP+O8ByIZom+rBvi1wI6fquX8hLLnq/PPWfSE21ozc0
	 LjYulYOii5IapTG6iAgsCtFdA1wwiVbi+KFG2aIQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BC60EF800D3;
	Fri, 14 Aug 2020 12:29:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E2F48F8022B; Fri, 14 Aug 2020 12:29:07 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
 by alsa1.perex.cz (Postfix) with ESMTP id 3836FF80146
 for <alsa-devel@alsa-project.org>; Fri, 14 Aug 2020 12:28:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3836FF80146
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com
 header.b="a7TbNjMc"
X-UUID: 6b7a5e71e5e34529bbf93979937f85a4-20200814
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=QnqghtOzbq3KGlzZDOOFuPYaiWSDiIunS5SQtsQzX8E=; 
 b=a7TbNjMcTwoef52DCAiq4qvog2xbhC6tzdCcQbHOFRcnYrQTNlhi9LIw7JdXWlCKaQ7PboJ3kXUxcWuqtqFhQ5ajaZWOUSW2Mr+1XQtJz0YmRSGVLXzCS8bVPDUDwuA1eKW4AB27gH/4mGEIXCDkBx8eJBELr34iQH+2lPhrFaw=;
X-UUID: 6b7a5e71e5e34529bbf93979937f85a4-20200814
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
 (envelope-from <jiaxin.yu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 128912685; Fri, 14 Aug 2020 18:28:47 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Fri, 14 Aug 2020 18:28:44 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 14 Aug 2020 18:28:43 +0800
Message-ID: <1597400867.23246.71.camel@mhfsdcap03>
Subject: Re: [PATCH v2 1/2] ASoC: mediatek: mt6359: add codec driver
From: Jiaxin Yu <jiaxin.yu@mediatek.com>
To: Mark Brown <broonie@kernel.org>
Date: Fri, 14 Aug 2020 18:27:47 +0800
In-Reply-To: <20200813154423.GC5541@sirena.org.uk>
References: <1597028754-7732-1-git-send-email-jiaxin.yu@mediatek.com>
 <1597028754-7732-2-git-send-email-jiaxin.yu@mediatek.com>
 <20200810185933.GI6438@sirena.org.uk>
 <1597217353.23246.45.camel@mhfsdcap03>
 <20200812120537.GA5545@sirena.org.uk>
 <1597333200.23246.68.camel@mhfsdcap03>
 <20200813154423.GC5541@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 78896913A2FA040185AB8D0D853821D095A23ADD59ED2AB8C1971EBF0E748D102000:8
X-MTK: N
Content-Transfer-Encoding: base64
Cc: alsa-devel@alsa-project.org, shane.chien@mediatek.com,
 howie.huang@mediatek.com, tiwai@suse.com, linux-kernel@vger.kernel.org,
 tzungbi@google.com, robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 eason.yen@mediatek.com, matthias.bgg@gmail.com,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

T24gVGh1LCAyMDIwLTA4LTEzIGF0IDE2OjQ0ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBUaHUsIEF1ZyAxMywgMjAyMCBhdCAxMTo0MDowMFBNICswODAwLCBKaWF4aW4gWXUgd3JvdGU6
DQo+ID4gT24gV2VkLCAyMDIwLTA4LTEyIGF0IDEzOjA1ICswMTAwLCBNYXJrIEJyb3duIHdyb3Rl
Og0KPiANCj4gPiA+IFRoZXNlIGZ1bmN0aW9ucyBhcmUgZXhwb3J0ZWQgZm9yIG90aGVyIGRyaXZl
cnMgdG8gdXNlIHJhdGhlciB0aGFuDQo+ID4gPiBzb21ldGhpbmcgZG9uZSBpbnRlcm5hbGx5IGJ5
IHRoZSBkcml2ZXIgLSBpZiB0aGlzIHdlcmUgaW50ZXJuYWwgdG8gdGhlDQo+ID4gPiBkcml2ZXIg
aXQnZCBub3QgYmUgYSBiaWcgZGVhbCBidXQgd2hlbiBpdCdzIGZvciB1c2UgYnkgYW5vdGhlciBk
cml2ZXINCj4gPiA+IGl0J2QgYmUgYmV0dGVyIHRvIGdvIHRocm91Z2ggc3RhbmRhcmQgaW50ZXJm
YWNlcy4NCj4gDQo+ID4gQ2FuIHdlIG1vdmUgdGhpcyBwYXJ0IG9mIHRoZSBvcGVyYXRpb24gdG8g
dGhlIGNvZGVjIGRhaSBkcml2ZXIgb3BzLCBzdWNoDQo+ID4gYXMgLnN0YXJ0dXAgYW5kIC5zaHV0
ZG93bj8gQmVjYXVzZSBvcmlnaW5hbGx5IHRoZXNlIGZ1bmN0aW9ucyBhcmUNCj4gPiBleHBvcnRl
ZCB0byBtYWNoaW5lIGRyaXZlcidzIGRhaV9saW5rIC5zdGFydHVwIGFuZCAuc2h1dGRvd24gb3Bz
Lg0KPiANCj4gSWYgaXQncyBpbnRlcm5hbCB0byB0aGUgZHJpdmVyIHN1cmUuDQo+IA0KPiA+ID4g
U28gdGhpcyBuZWVkcyB0aGUgU29DIHRvIGRvIHNvbWV0aGluZyBhcyBwYXJ0IG9mIGNhbGxpYnJh
dGlvbj8NCj4gDQo+ID4gWWVzLCB0aGUgc2lkZSBvZiBNVEtBSUYgaW4gU29DIHBhcnQgbmFtZWQg
YWRkYSwgd2UgbmVlZCBjb25maWcgaXQgYmVmb3JlDQo+ID4gY2FsaWJyYXRpb24uIFdlIHdpbGwg
YWxzbyB1cHN0cmVhbSBtYWNoaW5lL3BsYXRmb3JtIGRyaXZlciB0aGF0IHVzZSB0aGlzDQo+ID4g
Y29kZWMgZHJpdmVyIGxhdGVyLg0KPiANCj4gSXQgd291bGQgcHJvYmFibHkgYmUgYmV0dGVyIHRv
IGp1c3QgbGVhdmUgdGhpcyBvdXQgZm9yIG5vdyB0aGVuIGFkZCB0aGUNCj4gcmVxdWlyZWQgYml0
cyB0byB0aGUgQ09ERUMgZHJpdmVyIGFzIHBhcnQgb2YgYSBwYXRjaCBzZXJpZXMgdGhhdCBhbHNv
DQo+IGFkZHMgdGhlIG1hY2hpbmUgZHJpdmVyIHRoYXQgdXNlcyBpdCBzbyBpdCdzIGNsZWFyIGhv
dyBpdCBhbGwgZml0cw0KPiB0b2dldGhlci4gIEl0IHNvdW5kcyBsaWtlIGl0IHNob3VsZCBiZSBm
aW5lIGJ1dCB0aGlzJ2QgYmUgZWFzaWVyIHRvDQo+IHJldmlldy4NCg0KT2ssIEknbGwgcmVtb3Zl
IHRoZSBmdW5jdGlvbnMgdGhhdCByZWxhdGVkIHRvIHRoZSBjYWxpYnJhdGlvbiwgYW5kDQp1cHN0
cmVhbSB0aGVtIGFnYWluIGFzIHBhcnQgb2YgYSBwYXRjaCBzZXJpZXMgdGhhdCBhZGRzIHRoZSBt
YWNoaW5lDQpkcml2ZXIgbGF0ZXIuDQoNCg==

