Return-Path: <SRS0=4Snk=Y5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8770DC010A2
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 11:59:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82DAC21D71
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 11:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UhavWGtU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82DAC21D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7DF371705;
	Tue,  5 Nov 2019 12:58:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7DF371705
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572955150;
	bh=+7rQqwxS31TctFlNmWMMt5v60Od3VgW68GaCHsTGKIc=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UhavWGtU+kl3GAYATIkNsl3EFgVLEp0ftoAbUpRN5rDG6jl2tSCM5c5vgEEFizNg4
	 glVNJEbEXnNYgMQ29H6MoL2KmLK1YPJfcfkVS8WMiEWjuNExbVxLVfBpsIRelsR0wt
	 xMbZXHw/pU0N3/QB0eAOOPZtPm1e9a7p5mJA6d+o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F26ABF80446;
	Tue,  5 Nov 2019 12:58:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8C632F8049B; Tue,  5 Nov 2019 12:58:18 +0100 (CET)
Received: from imap1.codethink.co.uk (imap1.codethink.co.uk [176.9.8.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 13F77F8015B
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 12:58:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 13F77F8015B
Received: from [167.98.27.226] (helo=[10.35.5.173])
 by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
 id 1iRxTL-0003s9-I6; Tue, 05 Nov 2019 11:58:07 +0000
To: Jon Hunter <jonathanh@nvidia.com>, Dmitry Osipenko <digetx@gmail.com>,
 linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>
References: <20191007153136.4920-1-ben.dooks@codethink.co.uk>
 <20191007153136.4920-4-ben.dooks@codethink.co.uk>
 <cfd308bd-290a-f72f-6876-d94151c09843@gmail.com>
 <16910e8d-4745-4e55-0436-9b3200876037@codethink.co.uk>
 <1e43701b-3627-ba6d-ee19-020e25af3ef1@gmail.com>
 <d03a8fa0-3c62-1e32-9ca6-06d1996da11b@nvidia.com>
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <5d069991-f5c3-ae14-da9c-9b20555be4f6@codethink.co.uk>
Date: Tue, 5 Nov 2019 11:58:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d03a8fa0-3c62-1e32-9ca6-06d1996da11b@nvidia.com>
Content-Language: en-GB
Cc: linux-kernel@lists.codethink.co.uk,
 Edward Cragg <edward.cragg@codethink.co.uk>
Subject: Re: [alsa-devel] [PATCH v4 3/7] ASoC: tegra: i2s: Add support for
 more than 2 channels
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

T24gMjQvMTAvMjAxOSAxNzoxMSwgSm9uIEh1bnRlciB3cm90ZToKPiAKPiBPbiAxNy8xMC8yMDE5
IDE4OjM4LCBEbWl0cnkgT3NpcGVua28gd3JvdGU6Cj4+IDE3LjEwLjIwMTkgMTk6MjMsIEJlbiBE
b29rcyDQv9C40YjQtdGCOgo+Pj4gT24gMDgvMTAvMjAxOSAxNjoyOSwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+Pj4+IEhlbGxvIEJlbiwKPj4gVGFrZSBhIGxvb2sgaGVyZSBmb3IgZXhhbXBsZToK
Pj4KPj4gaHR0cHM6Ly9udi10ZWdyYS5udmlkaWEuY29tL2dpdHdlYi8/cD1saW51eC0zLjEwLmdp
dDthPWNvbW1pdDtoPTQ5ODM0ZWVmOWQ1MWE2ZWZmOTUwZTBmNTJkZGM1MzQzZDk2MDY1MmUKPiAK
PiBUaGF0IHZlcnNpb24gb2YgdGhlIGRyaXZlciBpcyBrbm93biB0byBiZSBidWdneS9pbmNvcnJl
Y3QuIEkgZG9uJ3QgdGhpbmsKPiB3ZSB3YW50IHRvIGRvIHRoYXQuIFdlIHdhbnQgdG8gc2V0IHRo
ZSBwb2xhcml0eSBiYXNlZCB1cG9uIHRoZSBmb3JtYXQKPiBwYXNzZWQgYW5kIG5vdCB0aGUgbW9k
ZSAuLi4KPiAKPiBodHRwczovL252LXRlZ3JhLm52aWRpYS5jb20vZ2l0d2ViLz9wPWxpbnV4LW52
aWRpYS5naXQ7YT1ibG9iO2Y9c291bmQvc29jL3RlZ3JhLWFsdC90ZWdyYTIxMF9pMnNfYWx0LmM7
aD0yNGNmM2I1NTMyNmY2ODdhZGVkMjJiOTExODJkZjQxYzVhZTE4OGFjO2hiPTcwM2FhOTQ4ZDJj
OTJiODdmZDg0ZjM2N2Y0M2EwNzc3OGVkMDk4YjUjbDMzMwoKT2ssIHRoYW5rcy4KClBTIHRoZSBz
ZWN1cml0eSBjZXJ0aWZpY2F0ZSBvbiB0aGF0IHNpdGUgaXMgc3RpbGwgaW52YWxpZCA6LwoKCi0t
IApCZW4gRG9va3MJCQkJaHR0cDovL3d3dy5jb2RldGhpbmsuY28udWsvClNlbmlvciBFbmdpbmVl
cgkJCQlDb2RldGhpbmsgLSBQcm92aWRpbmcgR2VuaXVzCgpodHRwczovL3d3dy5jb2RldGhpbmsu
Y28udWsvcHJpdmFjeS5odG1sCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0
Lm9yZwpodHRwczovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fs
c2EtZGV2ZWwK
