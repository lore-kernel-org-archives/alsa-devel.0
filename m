Return-Path: <SRS0=6EJT=2K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A663C43603
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Dec 2019 09:06:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A921D2467F
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Dec 2019 09:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RQ+JKqf2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CIUaRvlD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A921D2467F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5F5CF852;
	Fri, 20 Dec 2019 10:06:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5F5CF852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576832810;
	bh=b4HUA/h5g4B/XghL9wXrtTrbFcAGz+P2vU/EijuUfGg=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RQ+JKqf2daVm/d4YzOF60C4Mp2Dgz0kw2QF2rwN9P+XKDDZjAdlXtUpADJNx1HaWw
	 jKBETBfatu8tpX1DsqOhPbEebTyVjEqHXu/x7xaSwU3VgqKw8hKSFnEPKl5jVuyiqC
	 ba2VB8ul7dJ4fqoRALiemQBZcmWaHGtHLoidpUyU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CE418F80059;
	Fri, 20 Dec 2019 10:05:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D6793F8015A; Fri, 20 Dec 2019 10:05:58 +0100 (CET)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 697BDF80059
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2019 10:05:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 697BDF80059
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com
 header.b="CIUaRvlD"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20191220090554euoutp0164dc2a1f6f407797229c93823c5f5d8d~iCQkSo1L22753027530euoutp01Z
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2019 09:05:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20191220090554euoutp0164dc2a1f6f407797229c93823c5f5d8d~iCQkSo1L22753027530euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1576832754;
 bh=R2bgtkgulgLFXURJ0yIdQR36/mmA0eJITa3gfcBwFBU=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=CIUaRvlDyWsvugmboYhvy/hkMAlBQ6NLvtNl3j0iekKMzDEJTHYr5TLYG/KlHu6Yp
 e5WxBSidxLjRfVZe8C5cEIOaTLkKOPK4Be0QQlV/ew4NKD8Vjlsjwzthb4yBWc2jUf
 e4dQcRTN/lkNyv4AFj6jPoXZywR3DuwDa5zS03xE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20191220090553eucas1p23497d5516afb1908daa96969be52f7fc~iCQkCvZcG2796027960eucas1p2E;
 Fri, 20 Dec 2019 09:05:53 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 17.48.60698.1FE8CFD5; Fri, 20
 Dec 2019 09:05:53 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20191220090553eucas1p241dffa7822c1560e0f56446f0737719f~iCQjnU-bP2802528025eucas1p23;
 Fri, 20 Dec 2019 09:05:53 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20191220090553eusmtrp1e2bedaedba67d92eaa195ba7c8fd8873~iCQjmoh9f1076610766eusmtrp1O;
 Fri, 20 Dec 2019 09:05:53 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-79-5dfc8ef16cae
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 7F.31.08375.1FE8CFD5; Fri, 20
 Dec 2019 09:05:53 +0000 (GMT)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20191220090552eusmtip24959773e9f273d073d1b11432cee0737~iCQjJlEC31122811228eusmtip23;
 Fri, 20 Dec 2019 09:05:52 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Mark Brown <broonie@kernel.org>
Message-ID: <31bde14e-1fef-264a-ba1e-fc3051506bf3@samsung.com>
Date: Fri, 20 Dec 2019 10:05:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <b0e57646-8a14-e6c0-9daa-28c353dcb77a@samsung.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SXSxbYRjO13PanjZqnyJ9w36S7ifZsjHj4iQWY5atFy5cbDebxjrOEG1J
 j9qMLKbZlIgwkWolyCIIMQ0miHUU81PzNxvZXEzSRQgX/kaRmfbM5u55n+d58z5P8lKE1M4P
 oFK0GYxOq1LLBWKy46Nr/Mpa8b7y6qT5Mj0zZefR5QtOAT3c/4Kg881GRE9MWIX0cn83oism
 bDy6fyWfTy+1rfDonqllYaRYYd3IEyhqWvWK1sYCgeLXWCmpKG5vRIo2R7Zio/V0rPC++Hoi
 o07JZHTBEQ/Fyd3lVbz0XvHTn4NWlItaqEIkogCHweL0iKAQiSkpbkAwYHHwuWETwYe9ur/K
 BoLdAyt5tLJpKOVxQj2CFuMY4oZVBLM7A0K3yxdroa+2SeDGAhwChauFHuyHz8KX7feke4HA
 xQSMrswdChQlwRGwMx/t9pD4PHSZ1oRu2h8rwVif7KYl2AdGzE5PCBG+AaP12x5M4DNgeFdJ
 cFgG35zVnnCAvwrhx6qN4FLfgqp5G4/DvrA81C7k8ElwlBWR3IIBwcJ4s5AbihB8zqtAnCsc
 5sd3PUEJfBFauoM5Ogp6mvs9QQF7w9yqDxfCG153mAiOloDxlZRzXwDL0Nt/Z/smp4kSJLcc
 q2Y5VsdyrI7l/90aRDYiGaNnNUkMG6plngSxKg2r1yYFJaRpWtHhZzl+D211Itv+IzvCFJJ7
 SSIf7ymlfFUmm6WxI6AIuZ/ku9GllEoSVVnPGF1avE6vZlg7CqRIuUwS+mZJKcVJqgwmlWHS
 Gd2RyqNEAbmou3Y5xhXe1TbkFaefuKkz2XpFBju76KywVVbNop6O6uH16dICYrb3zqAmTRx6
 TXZQVRd1Ike3FXZueNtpG7Sp4u4WBFryd0aN1gRTp7XsQcjky4jbz10NlWs5p4r9zesx8ak+
 Bzmx0XI0fk/NzFTL1IbsgaaRHZ+NkhC/T3KSTVaFXCJ0rOoPTqFnEFUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xe7of+/7EGhw7JGJx5eIhJoupD5+w
 WZw43Mhs0T6zg9Hi/PkN7BavDu9itJhxfh+TxeE37awWLze/YbLYc/EVuwOXx4bPTWweCzaV
 emxa1cnm8e3MRBaPvi2rGD02n672+LxJLoA9Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRS
 z9DYPNbKyFRJ384mJTUnsyy1SN8uQS9j19R5TAUHuCqeHt3A2MC4nqOLkZNDQsBE4kvzRCYQ
 W0hgKaPEldtxEHEZiZPTGlghbGGJP9e62LoYuYBqXjNKXNp+GiwhLJAncXDJajYQm03AUKLr
 bReYLSKgLHH1+14WkAZmgT5miR2X57BCdK9ilTi+bgqQw8HBK2An8eOOM0gDi4CqxM7pH9lB
 bFGBWInvKz8xgti8AoISJ2c+YQGxOQXsJU4t/w5mMwuYSczb/JAZwpaXaN46G8oWl7j1ZD7T
 BEahWUjaZyFpmYWkZRaSlgWMLKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECY3TbsZ+bdzBe
 2hh8iFGAg1GJh/dl8u9YIdbEsuLK3EOMEhzMSiK8tzt+xgrxpiRWVqUW5ccXleakFh9iNAV6
 biKzlGhyPjB95JXEG5oamltYGpobmxubWSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi4JRqYHRL
 eHTBe4GxTM4xkTMd6vsO3f/zu5P3/46fbSxu5wPusPH84ItMumI+/c8biWsW7DZfQ/Ka/C8p
 8JhqhmoF+EhbX0j/NP8pZ0hhxcY8JmG/1qXTDD+s36OTEnV90xKvkl9Vp/+3PNMMqTxg88Xg
 ZJH/t5cfbN4Xb5c2uCH3UD37hFVUaf/lD0osxRmJhlrMRcWJAIKE6rLnAgAA
X-CMS-MailID: 20191220090553eucas1p241dffa7822c1560e0f56446f0737719f
X-Msg-Generator: CA
X-RootMTR: 20191219191651epcas5p2ab8031875093df401d9182e7c491eb3d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191219191651epcas5p2ab8031875093df401d9182e7c491eb3d
References: <8aceb9ec-aa6e-1fa4-cee9-e22084c141e8@samsung.com>
 <CA+Px+wXPa_cwdZUQfCx4jAhhj4Q9b7bNABUGazLKOJ7U5ae-mA@mail.gmail.com>
 <20191218132620.GE3219@sirena.org.uk>
 <f6453e48-cd95-6471-8945-4cc0ab3d04d9@samsung.com>
 <20191218162422.GG3219@sirena.org.uk>
 <ef908cb8-875e-4339-33bd-5997b594f022@samsung.com>
 <20191219123709.GB5047@sirena.org.uk>
 <aba9f63c-d993-e54e-4daa-9dbc35d0683b@samsung.com>
 <20191219130559.GE5047@sirena.org.uk>
 <a10269be-8caf-6e07-71c6-582a1d2c1458@samsung.com>
 <CGME20191219191651epcas5p2ab8031875093df401d9182e7c491eb3d@epcas5p2.samsung.com>
 <20191219191646.GH5047@sirena.org.uk>
 <b0e57646-8a14-e6c0-9daa-28c353dcb77a@samsung.com>
Cc: ALSA development <alsa-devel@alsa-project.org>,
 Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
 Jimmy Cheng-Yi Chiang <cychiang@google.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Takashi Iwai <tiwai@suse.de>, Krzysztof Kozlowski <krzk@kernel.org>,
 Tzung-Bi Shih <tzungbi@google.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>, Dylan Reid <dgreid@google.com>
Subject: Re: [alsa-devel] [PATCH v2] ASoC: max98090: save and restore SHDN
 when changing sensitive registers
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

SGkgQWxsLAoKT24gMjAuMTIuMjAxOSAwOToyOCwgTWFyZWsgU3p5cHJvd3NraSB3cm90ZToKPiBP
biAxOS4xMi4yMDE5IDIwOjE2LCBNYXJrIEJyb3duIHdyb3RlOgo+PiBPbiBUaHUsIERlYyAxOSwg
MjAxOSBhdCAwMjo0MToxN1BNICswMTAwLCBNYXJlayBTenlwcm93c2tpIHdyb3RlOgo+Pj4gT24g
MTkuMTIuMjAxOSAxNDowNSwgTWFyayBCcm93biB3cm90ZToKPj4+PiBZb3UgY2FuJ3QgdHJpZ2dl
ciB0aGlzIHZpYSBhbnkgb3RoZXIgbWVjaGFuaXNtLCBhbGwgdGhlIG90aGVyIGNvbnRyb2xzCj4+
Pj4gYXJlIGZpbmU/wqAgVGhlcmUncyAqY2xlYXJseSogbm8gaXNzdWUgd2l0aCB3aGF0IHRoZSBj
b21taXQgaXMgZG9pbmcsCj4+Pj4gaXQncyBqdXN0IGZsYWdnaW5nIHVwIHRoYXQgdGhlIGNhcmQg
aXMgbm90IHNldC4KPj4+IEkndmUgY2hlcnJ5cGlja2VkIHRoZSAkc3ViamVjdCBjb21taXQgb250
byB2YW5pbGxhIHY1LjUtcmMxIGFuZCB0aGUKPj4+IGlzc3VlIGlzIHNhbWUuCj4+IFllYWgsIHRo
ZXJlIHdlcmUgYSBsb3Qgb2YgcmVmYWN0b3JpbmdzIGluIHRoZSBsYXN0IG1lcmdlIHdpbmRvdyBz
byB0aGF0Cj4+IGRvZXNuJ3QgZW50aXJlbHkgc3VycHJpc2UgbWUuwqAgVGhlIGNvbW1pdCBzaG91
bGQgYmFja3BvcnQgZnV0aGVyIHRoYW4KPj4gdGhhdCBJIHRoaW5rPwo+Cj4gSSd2ZSB0cmllZCBp
bml0aWFsbHkgdG8gY2hlcnJ5LXBpY2sgaXQgdG8gdjUuNCwgYnV0IHRoZSB0aGUgY29kZSAKPiBk
aWRuJ3QgY29tcGlsZSBkdWUgdG8gbGFjayBvZiBzb21lIG1hY3Jvcywgc28gSSd2ZSBnYXZlIHVw
IHRyeWluZy4gSSAKPiB3aWxsIGNoZWNrIHRoYXQgbm93IGFuZCBiYWNrcG9ydCBuZWVkZWQgbWFj
cm9zIHRvbyBpZiB5b3UgdGhpbmsgdGhpcyAKPiB3b3VsZCBoZWxwLgoKU2FtZSBpc3N1ZS4gSSd2
ZSB0cmllZCBiYWNrcG9ydGluZyBpdCB0byBlYWNoIGtlcm5lbCByZWxlYXNlOiA1LjQsIDUuMywg
CjUuMiwgNS4xIGFuZCA1LjAgKHdpdGggYWRkaXRpb25hbCBiYWNrcG9ydGluZyAiQVNvQzogY29y
ZTogYWRkIApTTkRfU09DX0JZVEVTX0UiIGFuZCAiQVNvQzogRGVmaW5lIGEgc2V0IG9mIERBUE0g
cHJlL3Bvc3QtdXAgZXZlbnRzIikuIApJbiBhbGwgY2FzZXMgdGhlIGxvY2tkZXAgd2FybmluZyBh
bmQgb29wcyBpcyB0aGUgc2FtZS4gQmFja3BvcnRpbmcgdG8gCnY0LjkgcmVxdWlyZXMgbW9yZSBj
aGFuZ2VzIHRvIGdldCBpdCBldmVuIGNvbXBpbGVkLCBzbyBJIGdhdmUgdXAuCgpCZXN0IHJlZ2Fy
ZHMKLS0gCk1hcmVrIFN6eXByb3dza2ksIFBoRApTYW1zdW5nIFImRCBJbnN0aXR1dGUgUG9sYW5k
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRl
dmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cHM6Ly9tYWls
bWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
