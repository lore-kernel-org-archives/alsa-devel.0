Return-Path: <SRS0=fcCl=2X=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68DFC2D0DC
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jan 2020 21:20:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 572CD21D7D
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jan 2020 21:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cPJE7/j2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 572CD21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 82E6F16B8;
	Thu,  2 Jan 2020 22:19:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 82E6F16B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578000027;
	bh=ITQKkaYWVbhISu1qiETmWz1z7zIX7xSDdfhgI4cPWMc=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cPJE7/j2ww/HIRv9qCf5hv6iOA6Ve9KQ/vNV2cEPePSb9abF9o91h84kXw2sDIlJy
	 MsUpYNnrbRZgtd7aQZwUjb2nxJdKcSA9O5UODtfBvAp1g/deBBWAkoD+99viCTenDb
	 cWaiWIkpXDeJNuYMYogThvd7bvq07DbHnU0beVoU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3ED23F80273;
	Thu,  2 Jan 2020 22:18:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8DBA7F80157; Thu,  2 Jan 2020 22:18:35 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F162AF80157
 for <alsa-devel@alsa-project.org>; Thu,  2 Jan 2020 22:18:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F162AF80157
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 02 Jan 2020 13:18:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,388,1571727600"; d="scan'208";a="224819832"
Received: from ybabin-mobl1.amr.corp.intel.com (HELO [10.252.139.105])
 ([10.252.139.105])
 by fmsmga001.fm.intel.com with ESMTP; 02 Jan 2020 13:18:28 -0800
To: Jaroslav Kysela <perex@perex.cz>,
 ALSA development <alsa-devel@alsa-project.org>
References: <2cae9b3c-8634-7aff-3d76-7a16b1807abf@perex.cz>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <3f231650-094d-e755-b686-c3f8650dda84@linux.intel.com>
Date: Thu, 2 Jan 2020 11:53:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <2cae9b3c-8634-7aff-3d76-7a16b1807abf@perex.cz>
Content-Language: en-US
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>,
 Jie Yang <yang.jie@linux.intel.com>,
 Mengdong Lin <mengdong.lin@linux.intel.com>,
 Pan Xiuli <xiuli.pan@linux.intel.com>
Subject: Re: [alsa-devel] topology file broadwell.conf
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

Cj4gIMKgwqDCoMKgSSBhbSB3b3JraW5nIG9uIHNvbWUgKG1ham9yKSBjbGVhbnVwcyBmb3IgdGhl
IHRvcG9sb2d5IGxpYnJhcnkgYW5kIAo+IEkgaGl0IHRoZSBpc3N1ZSB3aXRoIHRoZSB0b3BvbG9n
eSBmaWxlIGJyb2Fkd2VsbC5jb25mIGluIHVwc3RyZWFtLiBJdCAKPiBjYW5ub3QgYmUgY29tcGls
ZWQgd2l0aCB0aGUgbGF0ZXN0IGFsc2F0cGxnIC8gbGliYXRvcG9sb2d5LCBiZWNhdXNlIHRoZSAK
PiBTZWN0aW9uUENNQ29uZmlnIHdhcyByZW1vdmVkIGluIGNvbW1pdCAKPiAzNjhlNGYyYTg5N2I1
NTAwNTczYTJlZTUyNWY1NTA0YzEzNWNmY2EyIGluIGFsc2EtbGliLgo+ICDCoMKgwqDCoFdoaWNo
IGRyaXZlciBpcyB1c2luZyB0aGlzIHRvcG9sb2d5IGluIHRoZSBjdXJyZW50IGxpbnV4IGtlcm5l
bD8KCklJUkMsIHRoZSBicm9hZHdlbGwvU1NUIGRyaXZlciBkb2VzIG5vdCB1c2UgdGhlIHRvcG9s
b2d5L0RQQ00gcGFydHMgc28gCml0J3MgbGlrZWx5IHRoZXJlIGlzIG5vIHVzZXIgZm9yIHRoaXMg
dG9wb2xvZ3kgZmlsZS4gS2V5b24vTGlhbSwgY2FuIHlvdSAKY29uZmlybT8KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBs
aXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwczovL21haWxtYW4uYWxzYS1wcm9q
ZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
