From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCH v3 2/2] ASoC: kirkwood: fix loss of
 external clock at probe time
Date: Mon, 21 Oct 2013 09:24:34 +0200
Message-ID: <20131021092434.02966f5e@armhf>
References: <20131018203555.4d974251@armhf>
 <20131020163819.GO2443@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
 by alsa0.perex.cz (Postfix) with ESMTP id CB8E72655D6
 for <alsa-devel@alsa-project.org>; Mon, 21 Oct 2013 09:24:24 +0200 (CEST)
In-Reply-To: <20131020163819.GO2443@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org

T24gU3VuLCAyMCBPY3QgMjAxMyAxNzozODoxOSArMDEwMApNYXJrIEJyb3duIDxicm9vbmllQGtl
cm5lbC5vcmc+IHdyb3RlOgoKPiBPbiBGcmksIE9jdCAxOCwgMjAxMyBhdCAwODozNTo1NVBNICsw
MjAwLCBKZWFuLUZyYW5jb2lzIE1vaW5lIHdyb3RlOgo+ID4gQXQgcHJvYmUgdGltZSwgd2hlbiB0
aGUgY2xvY2sgZHJpdmVyIGlzIG5vdCB5ZXQgaW5pdGlhbGl6ZWQsIHRoZQo+ID4gZXh0ZXJuYWwg
Y2xvY2sgb2YgdGhlIGtpcmt3b29kIHNvdW5kIGRldmljZSB3aWxsIG5vdCBiZSB1c2FibGUuICAK
PiAKPiBUaGlzIGRvZXNuJ3QgYXBwbHkgYWdhaW5zdCAtbmV4dCwgY291bGQgeW91IHBsZWFzZSBj
aGVjayBhbmQgcmVzZW5kPwo+IAo+ICAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51
eC9rZXJuZWwvZ2l0L2Jyb29uZS9zb3VuZC5naXQgdG9waWMva2lya3dvb2QKPiAKPiBvciB0aGUg
Zm9yLW5leHQgYnJhbmNoLgoKTm90IGVhc3kgdG8gZmluZCA6KQoKPiA+IEl0IGFsc28gcmVtb3Zl
cyB0aGUgdGVzdCBhYm91dCBzYW1lIGludGVybmFsIGFuZCBleHRlcm5hbCBjbG9ja3Mgd2hpY2gK
PiA+IGNhbiBuZXZlciBvY2N1ci4KPiAKPiBJdCBzZWVtcyBsaWtlIHJlYXNvbmFibGUgZGVmZW5z
aXZlbmVzcyB0byBoYXZlIHRoZSB0ZXN0IHRoZXJlIGluIGNhc2UKPiBzb21lb25lIGhhcyBhIGJy
b2tlbiBEVCwgdGhvdWdoIGl0J2QgYmUgYmV0dGVyIHRvIGNvbXBsYWluIGFib3V0IHRoZSBEVC4K
ClRoZSByZW1vdmVkIHRlc3QgcnVuIGludG86CgoJY2xvY2tzID0gPCZzaTUzNTEgMj4sIDwmc2k1
MzUxIDI+OwoJY2xvY2stbmFtZXMgPSAiaW50ZXJuYWwiLCAiZXh0Y2xrIjsKCndoZXJlIGl0IHNl
ZW1zIHRoYXQgdGhlIHVzZXIgcmVhbGx5IHdhbnRlZCB0byBtYWtlIGEgbWlzdGFrZS4KVGhlbiwg
dGhlIGFjdHVhbCBjb2RlIGp1c3Qgd2FudHMgdGhlIHNpNTM1MSAyIHRvIHdvcmsgYXMgdGhlIGlu
dGVybmFsCmNsb2NrLCBhbmQgdGhhdCBjYW5ub3QgYmUuCgpBbHNvLCBhYm91dCBlcnJvcnMsIHlv
dSBtYXkgc2VlIHRoYXQgYSBgbm9ybWFsYCBlcnJvciBhczoKCgljbG9ja3MgPSA8JnNpNTM1MSAy
PiwgPCZnYXRlX2NsayAxMz47CgljbG9jay1uYW1lcyA9ICJpbnRlcm5hbCIsICJleHRjbGsiOwoK
aS5lLiBpbnZlcnNpb24gb2YgdGhlIGludGVybmFsIGFuZCBleHRlcm5hbCBjbG9jayBwaGFuZGxl
J3MsIGNhbm5vdCBiZQpkZXRlY3RlZC4uLgoKU28sIGl0IGlzIGJldHRlciB0byByZW1vdmUgdGhl
IHVzZWxlc3MgdGVzdC4KCi0tIApLZW4gYXIgYydoZW50YcOxCXwJICAgICAgKiogQnJlaXpoIGhh
IExpbnV4IGF0YXYhICoqCkplZgkJfAkJaHR0cDovL21vaW5lamYuZnJlZS5mci8KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxzYS1kZXZlbCBtYWlsaW5n
IGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9tYWlsbWFuLmFsc2EtcHJv
amVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
