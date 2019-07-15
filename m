Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8ADBDF800D8
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2019 08:41:01 +0200 (CEST)
References: <201907150949139435825@zte.com.cn>
From: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <23d82d8b-d600-b28f-9444-65afe04a781a@web.de>
Date: Mon, 15 Jul 2019 08:40:30 +0200
MIME-Version: 1.0
In-Reply-To: <201907150949139435825@zte.com.cn>
Content-Language: en-US
Subject: Re: [alsa-devel] [2/2] ASoC: samsung: odroid: fix a double-free
	issue for cpu_dai
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
To: Wen Yang <wen.yang99@zte.com.cn>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
Cc: Yi Wang <wang.yi59@zte.com.cn>, Xue Zhihong <xue.zhihong@zte.com.cn>, Sangbeom Kim <sbkim73@samsung.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Cheng Shengyu <cheng.shengyu@zte.com.cn>
List-ID: <alsa-devel@alsa-project.org>

PiBUaGVzZSB0d28gdXBkYXRlcyBmaXggdHdvIGRpZmZlcmVudCBidWdzLgoKSSBjYW4gZm9sbG93
IHRoaXMgdmlldyB0byBzb21lIGRlZ3JlZS4KCgo+IGFuZCB0aGUgb3RoZXIgaXMgdGhlIGRvdWJs
ZS1mcmVlIGlzc3VlCgpUaGlzIHByb2dyYW1taW5nIGVycm9yIGFmZmVjdHMgYWxzbyB0aGUgdXNl
IG9mIGRhdGEgc3RydWN0dXJlcyB3aGljaCBiZWNhbWUgaW52YWxpZC4KaHR0cHM6Ly9jd2UubWl0
cmUub3JnL2RhdGEvZGVmaW5pdGlvbnMvNDE1Lmh0bWwjb2NfNDE1X05vdGVzCgoKPiBTbyB3ZSBz
ZW50IHR3byBwYXRjaGVzIHRvIGZpeCB0aGVtIHNlcGFyYXRlbHkuCgpZb3Ugd291bGQgbGlrZSB0
byBmaXggc29tZXRoaW5nIGFjY29yZGluZyB0byB0d28gdmFyaWFibGVzIChvZiB0aGUgZGF0YSB0
eXBlIOKAnGRldmljZV9ub2RlICrigJ0pCmluIHRoZSBzYW1lIGZ1bmN0aW9uIGltcGxlbWVudGF0
aW9uLgpQbGVhc2UgY29tYmluZSB0aGVzZSBjb3JyZWN0aW9ucyBpbiBhbiB1cGRhdGUgc3RlcCB1
bmRlciBhIHRvcGljIGxpa2UK4oCcQVNvQzogc2Ftc3VuZzogb2Ryb2lkOiBGaXggaGFuZGxpbmcg
b2YgZGV2aWNlIG5vZGUgcmVmZXJlbmNlcyBpbiBvZHJvaWRfYXVkaW9fcHJvYmUoKeKAnS4KKFRo
ZSBwcmV2aW91cyB1cGRhdGUgc3RlcCB3b3VsZCBjb250YWluIHN0aWxsIGEga25vd24gcHJvZ3Jh
bW1pbmcgbWlzdGFrZSBvdGhlcndpc2UsCndvdWxkbid0IGl0PykKClJlZ2FyZHMsCk1hcmt1cwpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVs
IG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cHM6Ly9tYWlsbWFu
LmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
