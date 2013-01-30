From: =?utf-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit.thebaudeau@advansee.com>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Fix mono
Date: Wed, 30 Jan 2013 12:17:28 +0100 (CET)
Message-ID: <582284253.632588.1359544648766.JavaMail.root@advansee.com>
References: <1359134360-25482-1-git-send-email-benoit.thebaudeau@advansee.com>
 <20130126085512.GC30594@opensource.wolfsonmicro.com>
 <1343658253.242147.1359209821129.JavaMail.root@advansee.com>
 <20130127025844.GC4650@opensource.wolfsonmicro.com>
 <1064296906.226931.1359407020092.JavaMail.root@advansee.com>
 <20130129020128.GE4748@opensource.wolfsonmicro.com>
 <832331151.478537.1359492018900.JavaMail.root@advansee.com>
 <20130130021143.GC4945@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from zose-mta13.web4all.fr (zose-mta13.web4all.fr [178.33.204.91])
 by alsa0.perex.cz (Postfix) with ESMTP id 08FA0264EBE
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2013 12:17:29 +0100 (CET)
In-Reply-To: <20130130021143.GC4945@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

T24gV2VkbmVzZGF5LCBKYW51YXJ5IDMwLCAyMDEzIDM6MTE6NDUgQU0sIE1hcmsgQnJvd24gd3Jv
dGU6Cj4gT24gVHVlLCBKYW4gMjksIDIwMTMgYXQgMDk6NDA6MThQTSArMDEwMCwgQmVub8OudCBU
aMOpYmF1ZGVhdSB3cm90ZToKPiA+IE9uIFR1ZXNkYXksIEphbnVhcnkgMjksIDIwMTMgMzowMToz
MiBBTSwgTWFyayBCcm93biB3cm90ZToKPiAKPiA+ID4gV2h5IGFyZSB5b3UgaGF2aW5nIHRvIGNh
bGwgdGhpcyBpbiB0aGUgZmlyc3QgcGxhY2U/Cj4gCj4gPiBGb3IgScKyUywgYmVjYXVzZSB0aGUg
cmVmZXJlbmNlIG1hbnVhbCBvZiB0aGUgaS5NWDI1IHNheXMgdGhhdCBTU0kuU1RDQ1IuREMKPiA+
IHNob3VsZCBiZSBzZXQgdG8gMSAoaS5lLiAyIGNoYW5uZWxzKSBpbiB0aGlzIG1vZGUuIFRoaXMg
YWxzbyBhbGxvd2VkIHRvCj4gPiB0ZXN0Cj4gPiBzZXZlcmFsIHNldHRpbmdzIGZvciBtb25vLgo+
IAo+ID4gRm9yIERTUCBtb2RlcywgYmVjYXVzZSBzdGVyZW8gZG9lc24ndCB3b3JrIHdpdGhvdXQg
dGhpcyBjYWxsIChyaWdodCBjaGFubmVsCj4gPiBtaXNzaW5nKS4KPiAKPiBTbyB3aHkgZG9lcyB0
aGUgZHJpdmVyIG5vdCBqdXN0IGRvIHRoaXMgYXV0b21hdGljYWxseT8KCkkgZG9uJ3Qga25vdy4g
SSBhZGQgRmFiaW8gYW5kIFNhc2NoYSB0byBDYyBpbiBjYXNlIHRoZXkga25vdy4KCkkgdGhpbmsg
dGhhdCBpdCdzIGVpdGhlciB0byBsZXQgdGhlIHVzZXJzIG9mIGlteC1zc2kgZG8gd2VpcmQgdGhp
bmdzIGlmIHRoZXkKaGF2ZSB0byAoYnV0IGltcGxlbWVudGluZyBhIGRlZmF1bHQgc2V0dXAgd291
bGQgbm90IHByZXZlbnQgdXNlcnMgdG8gY2hhbmdlIGl0CmJ5IGNhbGxpbmcgc25kX3NvY19kYWlf
c2V0X3RkbV9zbG90KCksIHNvLi4uKSwgb3IgcmF0aGVyIGJlY2F1c2Ugbm9ib2R5IGhhZAplbm91
Z2ggdGltZSBvciBhbGwgdGhlIHRlc3QgY29uZmlndXJhdGlvbnMgdG8gd29yayBvbiB0aGlzIHNv
IGZhci4gSXQncyBtYXJrZWQKYXMgVE9ETyBpbiBzb3VuZC9zb2MvZnNsL3dtMTEzMy1ldjEuYy4K
CkJlc3QgcmVnYXJkcywKQmVub8OudApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJv
amVjdC5vcmcKaHR0cDovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2Fsc2EtZGV2ZWwK
