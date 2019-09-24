Return-Path: <SRS0=SJ4a=XT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E83BC432C1
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Sep 2019 08:00:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A27B321655
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Sep 2019 07:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mQT8tA2v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A27B321655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9794B1671;
	Tue, 24 Sep 2019 09:59:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9794B1671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569311997;
	bh=k/UIWWkyaqdrKFKDIwgn1zU00+Uxe58hMTHykzMuYO0=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mQT8tA2vH7mezVxo640LYyExGhpVQFf0CKnYK8IIUHJshgTmKn26qMSTTXkNxZ37m
	 Rbaww8biTrhRpzZhEmGZfKqUeNqC+VUpuHQUywmMKfS9Z2ATz/O/dv98ksLY9+4M/G
	 a++XYKX+E/Str1AaQHTCv/lsicgCFYfZwycioFK8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 21E59F802BD;
	Tue, 24 Sep 2019 09:59:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 85F53F8045F; Tue, 24 Sep 2019 09:59:05 +0200 (CEST)
Received: from imap1.codethink.co.uk (imap1.codethink.co.uk [176.9.8.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 26D0EF802BD
 for <alsa-devel@alsa-project.org>; Tue, 24 Sep 2019 09:59:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 26D0EF802BD
Received: from [167.98.27.226] (helo=[10.35.6.110])
 by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
 id 1iCfii-0005zt-9b; Tue, 24 Sep 2019 08:58:48 +0100
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>
References: <20190923162026.14882-1-ben.dooks@codethink.co.uk>
 <20190923162026.14882-3-ben.dooks@codethink.co.uk>
 <ef013678-01b7-cae6-72f4-a619be428ad5@linux.intel.com>
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <024eefe9-d20d-1282-4d4d-4e3fe52728d4@codethink.co.uk>
Date: Tue, 24 Sep 2019 08:58:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ef013678-01b7-cae6-72f4-a619be428ad5@linux.intel.com>
Content-Language: en-GB
Cc: linux-kernel@lists.codethink.co.uk,
 Edward Cragg <edward.cragg@codethink.co.uk>
Subject: Re: [alsa-devel] [PATCH v2 2/7] ASoC: tegra: Allow 24bit and 32bit
 samples
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

T24gMjMvMDkvMjAxOSAxNzozNywgUGllcnJlLUxvdWlzIEJvc3NhcnQgd3JvdGU6Cj4gCj4+IEBA
IC0yODMsNiArMjk0LDcgQEAgc3RhdGljIGludCB0ZWdyYTMwX2kyc19zZXRfdGRtKHN0cnVjdCBz
bmRfc29jX2RhaSAKPj4gKmRhaSwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgICgxIC0gMSkgPDwgVEVH
UkEzMF9JMlNfQ0hfQ1RSTF9GU1lOQ19XSURUSF9TSElGVCk7Cj4+IMKgwqDCoMKgwqAgcG1fcnVu
dGltZV9wdXQoZGFpLT5kZXYpOwo+PiArwqDCoMKgIHBtX3J1bnRpbWVfcHV0KGRhaS0+ZGV2KTsK
Pj4gwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4gwqAgfQo+IAo+IGdpdCBzcXVhc2gvbWVyZ2UgaXNz
dWUgaGVyZT8KCnllcywgdGhhbmtzIGZvciBzcG90dGluZy4KCgotLSAKQmVuIERvb2tzCQkJCWh0
dHA6Ly93d3cuY29kZXRoaW5rLmNvLnVrLwpTZW5pb3IgRW5naW5lZXIJCQkJQ29kZXRoaW5rIC0g
UHJvdmlkaW5nIEdlbml1cwoKaHR0cHM6Ly93d3cuY29kZXRoaW5rLmNvLnVrL3ByaXZhY3kuaHRt
bApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRl
dmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cHM6Ly9tYWls
bWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
