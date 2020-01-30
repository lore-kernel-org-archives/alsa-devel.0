Return-Path: <SRS0=xcY/=3T=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E800C33C9E
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jan 2020 09:32:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 763A52082E
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jan 2020 09:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="caslIQuk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763A52082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ladisch.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A3F141614;
	Thu, 30 Jan 2020 10:31:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A3F141614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580376750;
	bh=02V2HiMTFJed+ZtsZy5G3jC0aiTtP3UMsvlBZZ5Xypg=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=caslIQuk0Nnb+/yv+inp63KJHyq08n5W2AuB+9bDEwZ4A2BuidEPuDwhLuYVfraeE
	 wYode+T5qIPEmjo3s5A0C49nNH/thDN/TZ09ZKu/7O/s+Okw/veAuaZyzRQ3e2/mHZ
	 PujZmXFRjdKM2WnMkFTkF3ePo/EWjw2nuFrHCvjE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 23F93F8014B;
	Thu, 30 Jan 2020 10:31:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9D4C7F80150; Thu, 30 Jan 2020 10:31:37 +0100 (CET)
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [IPv6:2a01:4f8:212:88::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1E4A5F800F1
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2020 10:31:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1E4A5F800F1
Received: from aquila.ladisch.de (x2f7f810.dyn.telefonica.de [2.247.248.16])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id D7696578555E;
 Thu, 30 Jan 2020 10:31:31 +0100 (CET)
To: Ben Dooks <ben.dooks@codethink.co.uk>, Dmitry Osipenko
 <digetx@gmail.com>, Jon Hunter <jonathanh@nvidia.com>,
 Mark Brown <broonie@kernel.org>
References: <29db3df4-6f51-7c0f-1eef-90171f1d233a@codethink.co.uk>
 <9a5447e2-155c-7e6e-b8f1-95523c6f42c6@gmail.com>
 <b4a416fb-f2b1-660d-27e3-aebf602178f9@codethink.co.uk>
 <680e2dfd-6f4f-5c96-63b7-97520961dc82@gmail.com>
 <0e0cd260e39ad293edb881da1c565510@codethink.co.uk>
 <507dcd5a-672b-61ac-aa7f-af5ff01accff@codethink.co.uk>
 <a2744ea0-cf6d-d083-75e6-853746195001@gmail.com>
 <28cafc56-095b-68c6-638d-270608a2983f@codethink.co.uk>
 <3d8544be-af20-f382-85fd-32183365267b@nvidia.com>
 <1b3c2af4-510e-306c-749a-efffc994b20a@gmail.com>
 <20200128121315.GD4689@sirena.org.uk>
 <047c8caa-e715-5295-9794-67ff3e10cea2@gmail.com>
 <70f344bf-f991-606c-55ab-bdadea27d233@nvidia.com>
 <2ff97414-f0a5-7224-0e53-6cad2ed0ccd2@gmail.com>
 <35667c85-67b5-6f6f-ffe8-4fe3455ea4bb@codethink.co.uk>
From: Clemens Ladisch <clemens@ladisch.de>
Message-ID: <96ed04cb-24ab-7e4d-bd44-6a4bb7c046ac@ladisch.de>
Date: Thu, 30 Jan 2020 10:31:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <35667c85-67b5-6f6f-ffe8-4fe3455ea4bb@codethink.co.uk>
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.101.4 at webclient5
X-Virus-Status: Clean
Cc: linux-kernel@lists.codethink.co.uk, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Edward Cragg <edward.cragg@codethink.co.uk>, linux-tegra@vger.kernel.org
Subject: Re: [alsa-devel] (no subject)
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

QmVuIERvb2tzIHdyb3RlOgo+IE9uIDI5LzAxLzIwMjAgMDA6MTcsIERtaXRyeSBPc2lwZW5rbyB3
cm90ZToKPj4gMjguMDEuMjAyMCAyMToxOSwgSm9uIEh1bnRlciDQv9C40YjQtdGCOgo+Pj4gT24g
MjgvMDEvMjAyMCAxNzo0MiwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+Pj4+IDI4LjAxLjIwMjAg
MTU6MTMsIE1hcmsgQnJvd24g0L/QuNGI0LXRgjoKPj4+Pj4gT24gTW9uLCBKYW4gMjcsIDIwMjAg
YXQgMTA6MjA6MjVQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+Pj4+Pj4gMjQuMDEu
MjAyMCAxOTo1MCwgSm9uIEh1bnRlciDQv9C40YjQtdGCOgo+Pj4+Pgo+Pj4+Pj4+ICAgICAgICAg
ICAgICAgICAgLnJhdGVzID0gU05EUlZfUENNX1JBVEVfODAwMF85NjAwMCwKPj4+Pj4+PiAgICAg
ICAgICAgICAgICAgIC5mb3JtYXRzID0gU05EUlZfUENNX0ZNVEJJVF9TMzJfTEUgfAo+Pj4+Pj4+
IC0gICAgICAgICAgICAgICAgICAgICAgICAgIFNORFJWX1BDTV9GTVRCSVRfUzI0X0xFIHwKPj4+
Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICBTTkRSVl9QQ01fRk1UQklUX1MyNF8zTEUg
fAo+Pj4+Pgo+Pj4+Pj4gSXQgc2hvdWxkIHNvbHZlIHRoZSBwcm9ibGVtIGluIG15IHBhcnRpY3Vs
YXIgY2FzZSwgYnV0IEknbSBub3Qgc3VyZSB0aGF0Cj4+Pj4+PiB0aGUgc29sdXRpb24gaXMgY29y
cmVjdC4KPj4+Pj4KPj4+Pj4gSWYgdGhlIGZvcm1hdCBpbXBsZW1lbnRlZCBieSB0aGUgZHJpdmVy
IGlzIFMyNF8zTEUgdGhlIGRyaXZlciBzaG91bGQKPj4+Pj4gYWR2ZXJ0aXNlIFMyNF8zTEUuCj4+
Pj4KPj4+PiBJdCBzaG91bGQgYmUgUzI0X0xFLCBidXQgc2VlbXMgd2Ugc3RpbGwgZG9uJ3Qga25v
dyBmb3Igc3VyZS4KPj4+Cj4+PiBXaHk/Cj4+IC9JIHRoaW5rLyBzb3VuZCBzaG91bGQgYmUgbXVj
aCBtb3JlIGRpc3RvcnRlZCBpZiBpdCB3YXMgUzI0XzNMRSwgYnV0Cj4+IG1heWJlIEknbSB3cm9u
Zy4KPgo+IFMyNF8zTEUgaXMgSUlDQyB0aGUgd3JvbmcgdGhpbmcgYW5kIHdlIGNhbid0IHN1cHBv
cnQgaXQgb24gdGhlIHRlZ3JhMwoKVGhlcmUgYXJlIHRocmVlIHdheXMgb2YgYXJyYW5naW5nIDI0
LWJpdCBzYW1wbGVzIGluIG1lbW9yeToKClMyNF8zTEU6IDI0LWJpdCBzYW1wbGVzIGluIDI0LWJp
dCB3b3JkcyB3aXRob3V0IHBhZGRpbmcKUzI0X0xFOiAgMjQtYml0IHNhbXBsZXMgaW4gMzItYml0
IHdvcmRzLCBhbGlnbmVkIHRvIHRoZSBMU0IKUzMyX0xFOiAgMjQtYml0IHNhbXBsZXMgaW4gMzIt
Yml0IHdvcmRzLCBhbGlnbmVkIHRvIHRoZSBNU0IKCkl0IGlzIHZlcnkgdW5saWtlbHkgdGhhdCB5
b3VyIGhhcmR3YXJlIGltcGxlbWVudHMgUzI0X0xFLgoKSWYgYSBTMzJfTEUgZHJpdmVyIHdhbnRz
IHRvIGRlc2NyaWJlIGhvdyBtYW55IGJpdHMgYXJlIGFjdHVhbGx5IHVzZWQsIGl0CnNob3VsZCBp
bnN0YWxsIGEgbXNiaXRzIGNvbnN0cmFpbnQgKHNuZF9wY21faHdfY29uc3RyYWludF9tc2JpdHMo
KSkuCgoKUmVnYXJkcywKQ2xlbWVucwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJv
amVjdC5vcmcKaHR0cHM6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbHNhLWRldmVsCg==
