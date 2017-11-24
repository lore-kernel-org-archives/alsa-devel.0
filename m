From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: ASoC: da7218: Use common error handling code in
 da7218_of_to_pdata()
Date: Fri, 24 Nov 2017 13:50:21 +0100
Message-ID: <badb0c28-818b-2c71-e4f2-088e6ca0fb6f@users.sourceforge.net>
References: <07c631e4-e2df-7ae2-ea31-9430c89dc8e3@users.sourceforge.net>
 <32a4c9e8-2030-c4e8-eb54-9ce6712ef0cd@users.sourceforge.net>
 <2E89032DDAA8B9408CB92943514A0337014C1B11E5@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 947AB267962
 for <alsa-devel@alsa-project.org>; Fri, 24 Nov 2017 13:51:20 +0100 (CET)
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337014C1B11E5@SW-EX-MBX01.diasemi.com>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, support.opensource@diasemi.com
Cc: Liam Girdwood <lgirdwood@gmail.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Pj4gQWRkIGEganVtcCB0YXJnZXQgc28gdGhhdCBhIGJpdCBvZiBleGNlcHRpb24gaGFuZGxpbmcg
Y2FuIGJlIGJldHRlciByZXVzZWQKPj4gaW4gYW4gaWYgYnJhbmNoIG9mIHRoaXMgZnVuY3Rpb24u
CuKApgo+IEhtbS4gRG9lc24ndCByZWFsbHkgZ2FpbiBhbiBhd2Z1bCBsb3QgdGhpcy4KCkkgc2hv
dyBqdXN0IGFub3RoZXIgc21hbGwgY2hhbmdlIHBvc3NpYmlsaXR5LgoKCj4gV291bGQgdW5kZXJz
dGFuZCBpZiB0aGVyZSB3ZXJlIG11bHRpcGxlIHJldHVybiBwYXRocywKPiBidXQgaW4gdGhhdCBj
YXNlIEknZCBoYXZlIGltcGxlbWVudGVkIHNvbWV0aGluZyBsaWtlIHRoaXMgYW55d2F5LgoKV2hl
cmU/CgpDYW4gdGhlIHN1Z2dlc3RlZCBzb2Z0d2FyZSByZWZhY3RvcmluZyBiZWNvbWUgdXNlZnVs
IGFsc28gZm9yIHRoaXMKZnVuY3Rpb24gaW1wbGVtZW50YXRpb24/CgoKPiBBbHNvIHlvdXIgcGF0
Y2ggZGVzY3JpcHRpb24gaXNuJ3QgcmVhbGx5IGNvcnJlY3QuCgpXaGljaCB3b3JkaW5nIHdvdWxk
IHlvdSBmaW5kIG1vcmUgYXBwcm9wcmlhdGU/CgoKPiBZb3UncmUgcmUtdXNpbmcgY29kZSBmcm9t
IHRoZSBzdW5ueSBkYXkgc2NlbmFyaW8gdG8gaGFuZGxlIGFuIGV4Y2VwdGlvbi4KCkNhbiB0aGlz
IGRldGFpbCBiZSBiZXR0ZXI/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1k
ZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
