Return-Path: <SRS0=zeHb=W7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F921C3A5A7
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Sep 2019 10:49:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ECF322DBF
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Sep 2019 10:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mjXYhTqb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ECF322DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 983E31693;
	Wed,  4 Sep 2019 12:48:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 983E31693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567594143;
	bh=W+vNZYTnG64d8citSJ6Quiu3/dQhUT+zCnlJFXB/Qvk=;
	h=Date:From:To:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mjXYhTqbtGlOimWMr5LL82DAumXgEqKzVK3i0E9qOJijNMQDcxmpwuVYNYRHgGmVc
	 NEcffODj6c/ocqawvY7Y3pORCB6FCW4mAePH5Eofj0FujAxU+o5d7VcDFa7MvWQotB
	 VDZ+LN7xnMLY5OYxsIf674skDZkLbvPqIdh7ql+4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D7BEBF80394;
	Wed,  4 Sep 2019 12:48:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 127B5F803A6; Wed,  4 Sep 2019 12:48:11 +0200 (CEST)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 69ED1F80171
 for <alsa-devel@alsa-project.org>; Wed,  4 Sep 2019 12:48:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 69ED1F80171
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id BF4C4AD94;
 Wed,  4 Sep 2019 10:48:05 +0000 (UTC)
Date: Wed, 4 Sep 2019 12:48:03 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Vinod Koul <vkoul@kernel.org>
Message-ID: <20190904124803.1700a65a@naga>
In-Reply-To: <20190904093052.GQ2672@vkoul-mobl>
References: <20190830185212.25144-1-msuchanek@suse.de>
 <f8c58d45-e641-5071-33bf-2927a61cb419@infradead.org>
 <20190904093052.GQ2672@vkoul-mobl>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
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

T24gV2VkLCA0IFNlcCAyMDE5IDE1OjAwOjUyICswNTMwClZpbm9kIEtvdWwgPHZrb3VsQGtlcm5l
bC5vcmc+IHdyb3RlOgoKPiBPbiAzMC0wOC0xOSwgMTE6NTYsIFJhbmR5IER1bmxhcCB3cm90ZToK
PiA+IE9uIDgvMzAvMTkgMTE6NTIgQU0sIE1pY2hhbCBTdWNoYW5layB3cm90ZTogIAo+ID4gPiBG
aXhlcyB0aGUgZm9sbG93aW5nIHdhcm5pbmcgb24gIUFDUEkgc3lzdGVtczoKPiA+ID4gCj4gPiA+
IGRyaXZlcnMvc291bmR3aXJlL3NsYXZlLmM6MTY6MTI6IHdhcm5pbmc6IOKAmHNkd19zbGF2ZV9h
ZGTigJkgZGVmaW5lZCBidXQKPiA+ID4gbm90IHVzZWQgWy1XdW51c2VkLWZ1bmN0aW9uXQo+ID4g
PiAgc3RhdGljIGludCBzZHdfc2xhdmVfYWRkKHN0cnVjdCBzZHdfYnVzICpidXMsCj4gPiA+ICAg
ICAgICAgICAgIF5+fn5+fn5+fn5+fn4KPiA+ID4gCj4gPiA+IFNpZ25lZC1vZmYtYnk6IE1pY2hh
bCBTdWNoYW5layA8bXN1Y2hhbmVrQHN1c2UuZGU+ICAKPiA+IAo+ID4gQWNrZWQtYnk6IFJhbmR5
IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPgo+ID4gCj4gPiBJIHdhcyBhYm91dCB0byBz
ZW5kIHRoZSBzYW1lIHBhdGNoLiAgCj4gCj4gU28gSSBoYXZlIGFwcGxpZWQgU3JpbmkncyBwYXRj
aGVzIHdoaWNoIGFkZCBEVCBzdXBwb3J0IGFuZCB0aGV5IHVzZQo+IHNkd19zbGF2ZV9hZGQoKS4g
U28gbmV4dCB0b21vcnJvdyBzaG91bGQgbm90IHNlZSB0aGlzIGVycm9yIGFzIGl0IGlzIG5vdwo+
IHVzZWQgYnkgRFQgcGFydHMgYXMgd2VsbC4KPiAKPiBTbyBkcm9wcGluZyB0aGlzIHBhdGNoCj4g
CgpUaGF0IHNob3VsZCBmaXggdGhlIGlzc3VlIGZvciBtZS4gSSB3b25kZXIgaWYgIUFDUEkgIURU
IHBsYXRmb3JtcyBhcmUKc3RpbGwgYSB0aGluZy4KClRoYW5rcwoKTWljaGFsCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBs
aXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwczovL21haWxtYW4uYWxzYS1wcm9q
ZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
