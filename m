Return-Path: <SRS0=2KR+=X3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED579C352AA
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Oct 2019 08:21:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22D4E2190F
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Oct 2019 08:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RamSLjp4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22D4E2190F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F25971666;
	Wed,  2 Oct 2019 10:20:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F25971666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570004470;
	bh=pBqdjwmS5VdhfFVX7bmiH3Y++P3bJk7g8d0eoAD+NCo=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RamSLjp4yyaBL/YBbUgmc5+cnInbpOKKQrpQjxBYxSxl/POUQy3v+VBeUJr075xAY
	 DsGc8VkyHhKVHMnJSwgK98mr1c+YMLmQtSbaSfX2xDQGlslrycYd26SWMWOlbMbl4k
	 Bw5zbGEDDJ1ItZ/38ZoryNK7TtOTCF1d2TMqklIM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 75252F8016F;
	Wed,  2 Oct 2019 10:20:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4F44BF80391; Wed,  2 Oct 2019 10:20:18 +0200 (CEST)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E5A93F8016F
 for <alsa-devel@alsa-project.org>; Wed,  2 Oct 2019 10:20:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E5A93F8016F
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id EA74CACC6;
 Wed,  2 Oct 2019 08:20:14 +0000 (UTC)
Date: Wed, 2 Oct 2019 10:20:06 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Vinod Koul <vkoul@kernel.org>
Message-ID: <20191002081717.GA4015@kitsune.suse.cz>
References: <20190830185212.25144-1-msuchanek@suse.de>
 <f8c58d45-e641-5071-33bf-2927a61cb419@infradead.org>
 <20190904093052.GQ2672@vkoul-mobl> <20190904124803.1700a65a@naga>
 <20190904114059.GU2672@vkoul-mobl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190904114059.GU2672@vkoul-mobl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Randy Dunlap <rdunlap@infradead.org>, Sanyog Kale <sanyog.r.kale@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] soundwire: slave: Fix unused function
	warning on !ACPI
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

T24gV2VkLCBTZXAgMDQsIDIwMTkgYXQgMDU6MTA6NTlQTSArMDUzMCwgVmlub2QgS291bCB3cm90
ZToKPiBPbiAwNC0wOS0xOSwgMTI6NDgsIE1pY2hhbCBTdWNow6FuZWsgd3JvdGU6Cj4gPiBPbiBX
ZWQsIDQgU2VwIDIwMTkgMTU6MDA6NTIgKzA1MzAKPiA+IFZpbm9kIEtvdWwgPHZrb3VsQGtlcm5l
bC5vcmc+IHdyb3RlOgo+ID4gCj4gPiA+IE9uIDMwLTA4LTE5LCAxMTo1NiwgUmFuZHkgRHVubGFw
IHdyb3RlOgo+ID4gPiA+IE9uIDgvMzAvMTkgMTE6NTIgQU0sIE1pY2hhbCBTdWNoYW5layB3cm90
ZTogIAo+ID4gPiA+ID4gRml4ZXMgdGhlIGZvbGxvd2luZyB3YXJuaW5nIG9uICFBQ1BJIHN5c3Rl
bXM6Cj4gPiA+ID4gPiAKPiA+ID4gPiA+IGRyaXZlcnMvc291bmR3aXJlL3NsYXZlLmM6MTY6MTI6
IHdhcm5pbmc6IOKAmHNkd19zbGF2ZV9hZGTigJkgZGVmaW5lZCBidXQKPiA+ID4gPiA+IG5vdCB1
c2VkIFstV3VudXNlZC1mdW5jdGlvbl0KPiA+ID4gPiA+ICBzdGF0aWMgaW50IHNkd19zbGF2ZV9h
ZGQoc3RydWN0IHNkd19idXMgKmJ1cywKPiA+ID4gPiA+ICAgICAgICAgICAgIF5+fn5+fn5+fn5+
fn4KPiA+ID4gPiA+IAo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTWljaGFsIFN1Y2hhbmVrIDxt
c3VjaGFuZWtAc3VzZS5kZT4gIAo+ID4gPiA+IAo+ID4gPiA+IEFja2VkLWJ5OiBSYW5keSBEdW5s
YXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4KPiA+ID4gPiAKPiA+ID4gPiBJIHdhcyBhYm91dCB0
byBzZW5kIHRoZSBzYW1lIHBhdGNoLiAgCj4gPiA+IAo+ID4gPiBTbyBJIGhhdmUgYXBwbGllZCBT
cmluaSdzIHBhdGNoZXMgd2hpY2ggYWRkIERUIHN1cHBvcnQgYW5kIHRoZXkgdXNlCj4gPiA+IHNk
d19zbGF2ZV9hZGQoKS4gU28gbmV4dCB0b21vcnJvdyBzaG91bGQgbm90IHNlZSB0aGlzIGVycm9y
IGFzIGl0IGlzIG5vdwo+ID4gPiB1c2VkIGJ5IERUIHBhcnRzIGFzIHdlbGwuCj4gPiA+IAo+ID4g
PiBTbyBkcm9wcGluZyB0aGlzIHBhdGNoCj4gPiA+IAo+ID4gCj4gPiBUaGF0IHNob3VsZCBmaXgg
dGhlIGlzc3VlIGZvciBtZS4gSSB3b25kZXIgaWYgIUFDUEkgIURUIHBsYXRmb3JtcyBhcmUKPiA+
IHN0aWxsIGEgdGhpbmcuCj4gCj4gSGVoIHRoYXQgc2hvdWxkIHRyaWdnZXIgdGhpcyBpZiB3ZSBo
YXZlIG9uZSA6RCBzbyBzaG91bGQgYSBsb3QgbW9yZQo+IHdoaWNoIGRlcGVuZCBvbiBzb21lIGZp
cm13YXJlIQoKQWN0dWFsbHkgczM5MHggaXMgYnVpbHQgd2l0aCAhQUNQSSBhbmQgIU9GLiBXaGls
ZSBpdCBzdXBwb3J0cyBQQ0kgYW4KdmlydGlvIGluIHByYWN0aWNlIG9ubHkgc291bmQgZGV2aWNl
cyBlbXVsYXRlZCBieSBxZW11IGFyZSBhdmFpbGFibGUuCkFsc28gQUZBSUNUIHRoZSBzb3Vud2ly
ZSBkcml2ZXIgaXMgdXNlbGVzcyB3aXRob3V0IEFDUEkgb3IgT0Ygc28gaXQKc2hvdWxkIGRlcGVu
ZCBvbiB0aGVtLgoKVGhhbmtzCgpNaWNoYWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNh
LXByb2plY3Qub3JnCmh0dHBzOi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlz
dGluZm8vYWxzYS1kZXZlbAo=
