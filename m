Return-Path: <SRS0=qF1Q=23=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA9DC33C8C
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:02:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E77412072C
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kEujZYCW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E77412072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 60BA916F2;
	Mon,  6 Jan 2020 20:01:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 60BA916F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578337337;
	bh=2kqPv24aoMVgiYuLkbEEfFe1KCqVGXJzoOS+paJ2Img=;
	h=From:To:References:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kEujZYCWR44uKUI+4OmRrauPtli0h4Bnw+eU+TaSR57Jj72MtuPEuDprZrQ2Imsna
	 5mVtrXRcWNS6I+3OHggVMqbMgZqIt+zNemkZ6XJF9sj6ktIK2mP6U/p8RFFD3yXrxp
	 A0se32JkFIbkxopkqKgeXPF2apfOVIrkkzB5ifuE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C32C0F8010C;
	Mon,  6 Jan 2020 20:01:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 07F33F8010C; Mon,  6 Jan 2020 20:01:25 +0100 (CET)
Received: from imap2.colo.codethink.co.uk (imap2.colo.codethink.co.uk
 [78.40.148.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D1502F8010C
 for <alsa-devel@alsa-project.org>; Mon,  6 Jan 2020 20:01:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D1502F8010C
Received: from [167.98.27.226] (helo=[10.35.5.173])
 by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
 id 1ioXca-0002ox-LX; Mon, 06 Jan 2020 19:01:00 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: Dmitry Osipenko <digetx@gmail.com>
References: <20191018154833.7560-1-ben.dooks@codethink.co.uk>
 <20191018154833.7560-3-ben.dooks@codethink.co.uk>
 <d2110a1f-c1de-e2c5-a1ff-5eb4c5d3e1da@gmail.com>
 <b4e2ec44-bc89-b5ca-cfa7-a6d5c45a9c94@codethink.co.uk>
 <a11ba33e-5ffb-c5c6-04f5-0e031877c55f@gmail.com>
 <621fa27d-9259-2949-9cf5-d2eda5cb0677@gmail.com>
 <a0f027d9-e9e0-d76c-1e40-002fdc37eb5f@nvidia.com>
 <d43d518d-9336-a011-2a69-3f9331f6d0b4@codethink.co.uk>
 <aba4edd6-0ea5-5e95-c5a0-9e749587c763@nvidia.com>
 <449bdc3c-bf82-7cc4-6704-440dd100ca3a@gmail.com>
 <5d3ae629-5d30-0930-5dd1-15161e64926e@codethink.co.uk>
 <9daeeb94-2b90-18b8-2e1e-daae5acf079d@gmail.com>
 <fd73f68c-80f5-ac80-f6e4-42256d3df76d@codethink.co.uk>
 <37beb96a-a525-c72f-a7e1-e9ef5d61f3b2@gmail.com>
 <29db3df4-6f51-7c0f-1eef-90171f1d233a@codethink.co.uk>
 <9a5447e2-155c-7e6e-b8f1-95523c6f42c6@gmail.com>
 <b4a416fb-f2b1-660d-27e3-aebf602178f9@codethink.co.uk>
 <680e2dfd-6f4f-5c96-63b7-97520961dc82@gmail.com>
 <0e0cd260e39ad293edb881da1c565510@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <507dcd5a-672b-61ac-aa7f-af5ff01accff@codethink.co.uk>
Date: Mon, 6 Jan 2020 19:00:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0e0cd260e39ad293edb881da1c565510@codethink.co.uk>
Content-Language: en-GB
Cc: linux-kernel@lists.codethink.co.uk, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Edward Cragg <edward.cragg@codethink.co.uk>, linux-tegra@vger.kernel.org,
 Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [alsa-devel] [Linux-kernel] [PATCH v5 2/7] ASoC: tegra: Allow
 24bit and 32bit samples
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

T24gMDUvMDEvMjAyMCAxMDo1MywgQmVuIERvb2tzIHdyb3RlOgo+IAo+IAo+IE9uIDIwMjAtMDEt
MDUgMDE6NDgsIERtaXRyeSBPc2lwZW5rbyB3cm90ZToKPj4gMDUuMDEuMjAyMCAwMzowNCwgQmVu
IERvb2tzINC/0LjRiNC10YI6Cj4+PiBbc25pcF0KPj4+Cj4+PiBJJ3ZlIGp1c3QgZ29uZSB0aHJv
dWdoIHRlc3RpbmcuCj4+Pgo+Pj4gU29tZSBzaW1wbGUgZGF0YSB0ZXN0cyBzaG93IDE2IGFuZCAz
Mi1iaXRzIHdvcmsuCj4+Pgo+Pj4gVGhlIDI0IGJpdCBjYXNlIHNlZW1zIHRvIGJlIHdlaXJkLCBp
dCBsb29rcyBsaWtlIHRoZSAyNC1iaXQgZXhwZWN0cwo+Pj4gMjQgYml0IHNhbXBsZXMgaW4gMzIg
Yml0IHdvcmRzLiBJIGNhbid0IHNlZSBhbnkgcGFja2luZyBvcHRpb25zIHRvCj4+PiBkbyAyNCBi
aXQgaW4gMjQgYml0LCBzbyB3ZSBtYXkgaGF2ZSB0byByZW1vdmUgMjQgYml0IHNhbXBsZSBzdXBw
b3J0Cj4+PiAod2hpY2ggaXMgYSBzaGFtZSkKPj4+Cj4+PiBNeSBwcmVmZXJlbmNlIGlzIHRvIHJl
bW92ZSB0aGUgMjQtYml0IHN1cHBvcnQgYW5kIGtlZXAgdGhlIDMyIGJpdCBpbi4KPj4+Cj4+Cj4+
IEludGVyZXN0aW5nLi4gSm9uLCBjb3VsZCB5b3UgcGxlYXNlIGNvbmZpcm0gdGhhdCAyNGJpdCBm
b3JtYXQgaXNuJ3QKPj4gdXNhYmxlIG9uIFQzMD8KPiAKPiBJZiB0aGVyZSBpcyBhbiBvcHRpb24g
b2YgMjQgcGFja2VkIGludG8gMzIsIHRoZW4gSSB0aGluayB0aGF0IHdvdWxkIHdvcmsuCj4gCj4g
SSBjYW4gdHJ5IHRlc3RpbmcgdGhhdCB3aXRoIHJhdyBkYXRhIG9uIE1vbmRheS4KCkkgbmVlZCB0
byBjaGVjayBzb21lIHRoaW5ncywgSSBhc3N1bWVkIDI0IHdhcyAyNCBwYWNrZWQgYml0cywgaXQg
bG9va3MKbGlrZSB0aGUgZGVmYXVsdCBpcyAyNCBpbiAzMiBiaXRzIHNvIHdlIG1heSBiZSBvay4g
SG93ZXZlciBJIG5lZWQgdG8KcmUtd3JpdGUgbXkgdGVzdCBjYXNlIHdoaWNoIGFzc3VtZWQgaXQg
d2FzIDI0Yml0cyBpbiAzIGJ5dGVzIChTMjRfM0xFKS4KCkknbGwgZm9sbG93IHVwIGxhdGVyLAoK
CgotLSAKQmVuIERvb2tzCQkJCWh0dHA6Ly93d3cuY29kZXRoaW5rLmNvLnVrLwpTZW5pb3IgRW5n
aW5lZXIJCQkJQ29kZXRoaW5rIC0gUHJvdmlkaW5nIEdlbml1cwoKaHR0cHM6Ly93d3cuY29kZXRo
aW5rLmNvLnVrL3ByaXZhY3kuaHRtbApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJv
amVjdC5vcmcKaHR0cHM6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbHNhLWRldmVsCg==
