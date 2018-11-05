From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: linux-4.20-rc1/sound/soc/stm/stm32_sai_sub.c:343:
 Faulty error check
Date: Mon, 5 Nov 2018 15:24:09 +0100
Message-ID: <ccd8a02d-13a0-432a-ecd0-94234a2cfd83@st.com>
References: <VI1PR08MB3342060AF73044939F5273F59CCA0@VI1PR08MB3342.eurprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C0DA2678DA
 for <alsa-devel@alsa-project.org>; Mon,  5 Nov 2018 15:24:17 +0100 (CET)
In-Reply-To: <VI1PR08MB3342060AF73044939F5273F59CCA0@VI1PR08MB3342.eurprd08.prod.outlook.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Binderman <dcb314@hotmail.com>, Olivier MOYSAN <olivier.moysan@st.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

SGVsbG8gRGF2aWQsCgpPbiAxMS81LzE4IDI6MzMgUE0sIERhdmlkIEJpbmRlcm1hbiB3cm90ZToK
PiBIZWxsbyB0aGVyZSwKPiAKPiBsaW51eC00LjIwLXJjMS9zb3VuZC9zb2Mvc3RtL3N0bTMyX3Nh
aV9zdWIuYzozNDNdOiAoc3R5bGUpIENoZWNraW5nIGlmCj4gdW5zaWduZWQgdmFyaWFibGUgJ2Rp
dicgaXMgbGVzcyB0aGFuIHplcm8uCj4gCj4gU291cmNlIGNvZGUgaXMKPiAKPiDCoMKgwqDCoMKg
wqDCoCBkaXYgPSBzdG0zMl9zYWlfZ2V0X2Nsa19kaXYoc2FpLCBwYXJlbnRfcmF0ZSwgcmF0ZSk7
Cj4gwqDCoMKgwqDCoMKgwqAgaWYgKGRpdiA8IDApCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHJldHVybiBkaXY7Cj4gCj4gU3VnZ2VzdCBzdG9yZSByZXR1cm4gdmFsdWUgZnJvbSBm
dW5jdGlvbiBpbiBpbnQgbG9jYWwgdmFyaWFibGUsIHRlc3QgaXQKPiBhbmQgb25seSB0aGVuIGFz
c2lnbiBpdCBpbnRvIGFuIHVuc2lnbmVkIHZhcmlhYmxlLgo+IAo+IFJlZ2FyZHMKPiAKPiBEYXZp
ZCBCaW5kZXJtYW4KClRoYW5rcyBmb3IgeW91ciBmZWVkYmFjaywgYSBwYXRjaCBoYXMgYWxyZWFk
eSBiZWVuIHNlbnQgYW5kIGFwcGxpZWQgdG8KZml4IHRoaXMgd2FybmluZzogaHR0cHM6Ly9sa21s
Lm9yZy9sa21sLzIwMTgvMTEvNS81MTAuCgpSZWdhcmRzLApBcm5hdWQKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QK
QWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
