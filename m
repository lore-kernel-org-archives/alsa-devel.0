From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 2/2] ASoC: wm8904: implement input mode
	select as a mux
Date: Tue, 20 Aug 2019 10:50:33 +0000
Message-ID: <20190820105033.GG10308@ediswmail.ad.cirrus.com>
References: <f95ae1085f9f3c137a122c4d95728711613c15f7.1566297120.git.mirq-linux@rere.qmqm.pl>
 <17f8556414a0e5352dc570fa16d50bd1bc2b4b0a.1566297120.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 281BCF800BF
 for <alsa-devel@alsa-project.org>; Tue, 20 Aug 2019 12:50:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <17f8556414a0e5352dc570fa16d50bd1bc2b4b0a.1566297120.git.mirq-linux@rere.qmqm.pl>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Allison Randal <allison@lohutok.net>, patches@opensource.cirrus.com, Thomas Gleixner <tglx@linutronix.de>, zhong jiang <zhongjiang@huawei.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

T24gVHVlLCBBdWcgMjAsIDIwMTkgYXQgMTI6MzM6MzNQTSArMDIwMCwgTWljaGHFgiBNaXJvc8WC
YXcgd3JvdGU6Cj4gTWFrZSAnKiBDYXB0dXJlIE1vZGUnIGEgbXV4LiBUaGlzIG1ha2VzIERBUE0g
a25vdyB0aGF0IGluIHNpbmdsZS1lbmRlZAo+IG1vZGUgb25seSBpbnZlcnRpbmcgbXV4IHBhdGhz
IG5lZWQgdG8gYmUgZW5hYmxlZC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYcWCIE1pcm9zxYJh
dyA8bWlycS1saW51eEByZXJlLnFtcW0ucGw+Cj4gLS0tCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qg
c25kX2tjb250cm9sX25ldyByaW5fbW9kZSA9Cj4gKwlTT0NfREFQTV9FTlVNKCJyaWdodCBDYXB0
dXJlIE1vZGUiLCByaW5fbW9kZV9lbnVtKTsKCk1pbm9yIG5pdCBtaXNzaW5nIGEgY2FwdGlhbCBv
biB0aGUgcmlnaHQgaGVyZS4KCk90aGVyd2lzZSBsb29rcyBnb29kOgoKQWNrZWQtYnk6IENoYXJs
ZXMgS2VlcGF4IDxja2VlcGF4QG9wZW5zb3VyY2UuY2lycnVzLmNvbT4KClRoYW5rcywKQ2hhcmxl
cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRl
dmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cHM6Ly9tYWls
bWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
