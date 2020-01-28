Return-Path: <SRS0=GCF0=3R=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8A6C33C9E
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Jan 2020 10:52:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAB3B2467B
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Jan 2020 10:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KtUTSUS0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB3B2467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DEB681677;
	Tue, 28 Jan 2020 11:51:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DEB681677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580208753;
	bh=mNBJy7VjT+BFKYX7sakJM7HYFPFMtbXbRugxlYqonPg=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KtUTSUS0RCfuRenD/EG2QzyPF4CXyNJYEvLBvuVoRZcKfcD/4qscuYyQhxdtv5PHp
	 l+w0+TaTKdeW+2Q2+Km0JoLwfIygNI6lwcCE8ENXO7mETgpZk5rWkrXoewYpvbUy/B
	 4SWUkalV1kEhzQIOvHjdbXZ3g2wUvskjRiFCwlCo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9CA50F8014B;
	Tue, 28 Jan 2020 11:48:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BAD62F80150; Tue, 28 Jan 2020 11:48:02 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 47346F800FF
 for <alsa-devel@alsa-project.org>; Tue, 28 Jan 2020 11:47:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 47346F800FF
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Jan 2020 02:47:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,373,1574150400"; d="scan'208";a="231879496"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.237.137.172])
 ([10.237.137.172])
 by orsmga006.jf.intel.com with ESMTP; 28 Jan 2020 02:47:50 -0800
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
References: <20200127121243.15813-1-cezary.rojewski@intel.com>
 <20200127121243.15813-8-cezary.rojewski@intel.com>
 <3e8dcf78-4413-b752-c574-c5c64f7d0fe8@linux.intel.com>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <b133ce83-97f3-59ff-1425-9671f8628751@intel.com>
Date: Tue, 28 Jan 2020 11:47:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <3e8dcf78-4413-b752-c574-c5c64f7d0fe8@linux.intel.com>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.com,
 lgirdwood@gmail.com
Subject: Re: [alsa-devel] [PATCH v2 07/11] ASoC: SOF: Implement Probe IPC API
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

T24gMjAyMC0wMS0yNyAyMTo1NywgUGllcnJlLUxvdWlzIEJvc3NhcnQgd3JvdGU6Cj4gCj4+ICtF
WFBPUlRfU1lNQk9MKHNvZl9pcGNfcHJvYmVfZGVpbml0KTsKPj4gKwo+PiArc3RhdGljIGludCBz
b2ZfaXBjX3Byb2JlX2luZm8oc3RydWN0IHNuZF9zb2ZfZGV2ICpzZGV2LCB1bnNpZ25lZCBpbnQg
Cj4+IGNtZCwKPj4gK8KgwqDCoMKgwqDCoMKgIHZvaWQgKipwYXJhbXMsIHNpemVfdCAqbnVtX3Bh
cmFtcykKPj4gK3sKPj4gK8KgwqDCoCBzdHJ1Y3Qgc29mX2lwY19wcm9iZV9pbmZvX3BhcmFtcyBt
c2cgPSB7MH07Cj4gCj4gVGhpcyBnZW5lcmF0ZXMgYSBzcGFyc2Ugd2FybmluZyAobWFrZSBDPTIp
Cj4gCj4gc291bmQvc29jL3NvZi9wcm9iZS5jOjc1OjQ5OiB3YXJuaW5nOiBtaXNzaW5nIGJyYWNl
cyBhcm91bmQgaW5pdGlhbGl6ZXIKPiAKPiBDYW4geW91IHBsZWFzZSBtYWtlIGl0IGdvIGF3YXk/
CgpJIGNhbi4gQW5kIEkgZGlkIGluIHYzLiBUaGFua3MhCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2
ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwczovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWls
bWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
